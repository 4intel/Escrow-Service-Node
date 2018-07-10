package fouri.com.cmm.service.dataaccess;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;

public abstract class FouriAbstractMapper extends SqlSessionDaoSupport {
	@Resource(name = "sqlSession")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}

	public int insert(String queryId) {
		return getSqlSession().insert(queryId);
	}

	public int insert(String queryId, Object parameterObject) {
		return getSqlSession().insert(queryId, parameterObject);
	}

	public int update(String queryId) {
		return getSqlSession().update(queryId);
	}

	public int update(String queryId, Object parameterObject) {
		return getSqlSession().update(queryId, parameterObject);
	}

	public int delete(String queryId) {
		return getSqlSession().delete(queryId);
	}

	public int delete(String queryId, Object parameterObject) {
		return getSqlSession().delete(queryId, parameterObject);
	}

	@Deprecated
	public Object selectByPk(String queryId, Object parameterObject) {
		return getSqlSession().selectOne(queryId, parameterObject);
	}

	public <T> T selectOne(String queryId) {
		return getSqlSession().selectOne(queryId);
	}

	public <T> T selectOne(String queryId, Object parameterObject) {
		return getSqlSession().selectOne(queryId, parameterObject);
	}

	public <K, V> Map<K, V> selectMap(String queryId, String mapKey) {
		return getSqlSession().selectMap(queryId, mapKey);
	}

	public <K, V> Map<K, V> selectMap(String queryId, Object parameterObject, String mapKey) {
		return getSqlSession().selectMap(queryId, parameterObject, mapKey);
	}

	public <K, V> Map<K, V> selectMap(String queryId, Object parameterObject, String mapKey, RowBounds rowBounds) {
		return getSqlSession().selectMap(queryId, parameterObject, mapKey, rowBounds);
	}

	@Deprecated
	public List<?> list(String queryId, Object parameterObject) {
		return getSqlSession().selectList(queryId, parameterObject);
	}

	public <E> List<E> selectList(String queryId) {
		return getSqlSession().selectList(queryId);
	}

	public <E> List<E> selectList(String queryId, Object parameterObject) {
		return getSqlSession().selectList(queryId, parameterObject);
	}

	public <E> List<E> selectList(String queryId, Object parameterObject, RowBounds rowBounds) {
		return getSqlSession().selectList(queryId, parameterObject, rowBounds);
	}

	public List<?> listWithPaging(String queryId, Object parameterObject, int pageIndex, int pageSize) {
		int skipResults = pageIndex * pageSize;

		RowBounds rowBounds = new RowBounds(skipResults, pageSize);

		return getSqlSession().selectList(queryId, parameterObject, rowBounds);
	}

	public void listToOutUsingResultHandler(String queryId, ResultHandler handler) {
		getSqlSession().select(queryId, handler);
	}
}
