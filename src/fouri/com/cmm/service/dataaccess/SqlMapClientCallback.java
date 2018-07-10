package fouri.com.cmm.service.dataaccess;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import java.sql.SQLException;

@Deprecated
public abstract interface SqlMapClientCallback<T>
{
  public abstract T doInSqlMapClient(SqlMapExecutor paramSqlMapExecutor)
    throws SQLException;
}
