package fouri.com.cmm.service.dataaccess;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.core.NestedIOException;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.datasource.TransactionAwareDataSourceProxy;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.util.ObjectUtils;

import com.ibatis.common.xml.NodeletException;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.engine.builder.xml.SqlMapConfigParser;
import com.ibatis.sqlmap.engine.builder.xml.SqlMapParser;
import com.ibatis.sqlmap.engine.builder.xml.XmlParserState;
import com.ibatis.sqlmap.engine.impl.ExtendedSqlMapClient;
import com.ibatis.sqlmap.engine.transaction.TransactionConfig;
import com.ibatis.sqlmap.engine.transaction.TransactionManager;
import com.ibatis.sqlmap.engine.transaction.external.ExternalTransactionConfig;

@Deprecated
public class SqlMapClientFactoryBean implements FactoryBean<SqlMapClient>, InitializingBean {
	private static final ThreadLocal<LobHandler> configTimeLobHandlerHolder = new ThreadLocal();
	private Resource[] configLocations;
	private Resource[] mappingLocations;
	private Properties sqlMapClientProperties;
	private DataSource dataSource;
	private boolean useTransactionAwareDataSource = true;

	private Class transactionConfigClass = ExternalTransactionConfig.class;
	private Properties transactionConfigProperties;
	private LobHandler lobHandler;
	private SqlMapClient sqlMapClient;

	public static LobHandler getConfigTimeLobHandler() {
		return (LobHandler) configTimeLobHandlerHolder.get();
	}

	public SqlMapClientFactoryBean() {
		this.transactionConfigProperties = new Properties();
		this.transactionConfigProperties.setProperty("SetAutoCommitAllowed", "false");
	}

	public void setConfigLocation(Resource configLocation) {
		this.configLocations = (configLocation != null ? new Resource[] { configLocation } : null);
	}

	public void setConfigLocations(Resource[] configLocations) {
		this.configLocations = configLocations;
	}

	public void setMappingLocations(Resource[] mappingLocations) {
		this.mappingLocations = mappingLocations;
	}

	public void setSqlMapClientProperties(Properties sqlMapClientProperties) {
		this.sqlMapClientProperties = sqlMapClientProperties;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void setUseTransactionAwareDataSource(boolean useTransactionAwareDataSource) {
		this.useTransactionAwareDataSource = useTransactionAwareDataSource;
	}

	public void setTransactionConfigClass(Class transactionConfigClass) {
		if ((transactionConfigClass == null) || (!TransactionConfig.class.isAssignableFrom(transactionConfigClass))) {
			throw new IllegalArgumentException(
					"Invalid transactionConfigClass: does not implement com.ibatis.sqlmap.engine.transaction.TransactionConfig");
		}

		this.transactionConfigClass = transactionConfigClass;
	}

	public void setTransactionConfigProperties(Properties transactionConfigProperties) {
		this.transactionConfigProperties = transactionConfigProperties;
	}

	public void setLobHandler(LobHandler lobHandler) {
		this.lobHandler = lobHandler;
	}

	public void afterPropertiesSet() throws Exception {
		if (this.lobHandler != null) {
			configTimeLobHandlerHolder.set(this.lobHandler);
		}
		try {
			this.sqlMapClient = buildSqlMapClient(this.configLocations, this.mappingLocations,
					this.sqlMapClientProperties);

			if (this.dataSource != null) {
				TransactionConfig transactionConfig = (TransactionConfig) this.transactionConfigClass.newInstance();
				DataSource dataSourceToUse = this.dataSource;
				if ((this.useTransactionAwareDataSource)
						&& (!(this.dataSource instanceof TransactionAwareDataSourceProxy))) {
					dataSourceToUse = new TransactionAwareDataSourceProxy(this.dataSource);
				}
				transactionConfig.setDataSource(dataSourceToUse);
				transactionConfig.initialize(this.transactionConfigProperties);
				applyTransactionConfig(this.sqlMapClient, transactionConfig);
			}
		} finally {
			if (this.lobHandler != null) {
				configTimeLobHandlerHolder.remove();
			}
		}
	}

	protected SqlMapClient buildSqlMapClient(Resource[] configLocations, Resource[] mappingLocations,
			Properties properties) throws IOException {
		if (ObjectUtils.isEmpty(configLocations)) {
			throw new IllegalArgumentException("At least 1 'configLocation' entry is required");
		}

		SqlMapClient client = null;
		SqlMapConfigParser configParser = new SqlMapConfigParser();
		for (Resource configLocation : configLocations) {
			InputStream is = configLocation.getInputStream();
			try {
				client = configParser.parse(is, properties);
			} catch (RuntimeException ex) {
				throw new NestedIOException("Failed to parse config resource: " + configLocation, ex.getCause());
			}
		}

		if (mappingLocations != null) {
			SqlMapParser mapParser = SqlMapParserFactory.createSqlMapParser(configParser);
			for (Resource mappingLocation : mappingLocations) {
				try {
					mapParser.parse(mappingLocation.getInputStream());
				} catch (NodeletException ex) {
					throw new NestedIOException("Failed to parse mapping resource: " + mappingLocation, ex);
				}
			}
		}

		return client;
	}

	protected void applyTransactionConfig(SqlMapClient sqlMapClient, TransactionConfig transactionConfig) {
		if (!(sqlMapClient instanceof ExtendedSqlMapClient)) {
			throw new IllegalArgumentException(
					"Cannot set TransactionConfig with DataSource for SqlMapClient if not of type ExtendedSqlMapClient: "
							+ sqlMapClient);
		}

		ExtendedSqlMapClient extendedClient = (ExtendedSqlMapClient) sqlMapClient;
		transactionConfig.setMaximumConcurrentTransactions(extendedClient.getDelegate().getMaxTransactions());
		extendedClient.getDelegate().setTxManager(new TransactionManager(transactionConfig));
	}

	public SqlMapClient getObject() {
		return this.sqlMapClient;
	}

	public Class<? extends SqlMapClient> getObjectType() {
		return this.sqlMapClient != null ? this.sqlMapClient.getClass() : SqlMapClient.class;
	}

	public boolean isSingleton() {
		return true;
	}

	private static class SqlMapParserFactory {
		public static SqlMapParser createSqlMapParser(SqlMapConfigParser configParser) {
			XmlParserState state = null;
			try {
				Field stateField = SqlMapConfigParser.class.getDeclaredField("state");
				stateField.setAccessible(true);
				state = (XmlParserState) stateField.get(configParser);
			} catch (Exception ex) {
				throw new IllegalStateException(
						"iBATIS 2.3.2 'state' field not found in SqlMapConfigParser class - please upgrade to IBATIS 2.3.2 or higher in order to use the new 'mappingLocations' feature. "
								+ ex);
			}

			return new SqlMapParser(state);
		}
	}
}
