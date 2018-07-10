package fouri.com.cmm.service.dataaccess;

import com.ibatis.sqlmap.client.event.RowHandler;
import java.util.List;
import java.util.Map;
import org.springframework.dao.DataAccessException;

@Deprecated
public abstract interface SqlMapClientOperations {
	public abstract Object queryForObject(String paramString) throws DataAccessException;

	public abstract Object queryForObject(String paramString, Object paramObject) throws DataAccessException;

	public abstract Object queryForObject(String paramString, Object paramObject1, Object paramObject2)
			throws DataAccessException;

	public abstract List queryForList(String paramString) throws DataAccessException;

	public abstract List queryForList(String paramString, Object paramObject) throws DataAccessException;

	public abstract List queryForList(String paramString, int paramInt1, int paramInt2) throws DataAccessException;

	public abstract List queryForList(String paramString, Object paramObject, int paramInt1, int paramInt2)
			throws DataAccessException;

	public abstract void queryWithRowHandler(String paramString, RowHandler paramRowHandler) throws DataAccessException;

	public abstract void queryWithRowHandler(String paramString, Object paramObject, RowHandler paramRowHandler)
			throws DataAccessException;

	public abstract Map queryForMap(String paramString1, Object paramObject, String paramString2)
			throws DataAccessException;

	public abstract Map queryForMap(String paramString1, Object paramObject, String paramString2, String paramString3)
			throws DataAccessException;

	public abstract Object insert(String paramString) throws DataAccessException;

	public abstract Object insert(String paramString, Object paramObject) throws DataAccessException;

	public abstract int update(String paramString) throws DataAccessException;

	public abstract int update(String paramString, Object paramObject) throws DataAccessException;

	public abstract void update(String paramString, Object paramObject, int paramInt) throws DataAccessException;

	public abstract int delete(String paramString) throws DataAccessException;

	public abstract int delete(String paramString, Object paramObject) throws DataAccessException;

	public abstract void delete(String paramString, Object paramObject, int paramInt) throws DataAccessException;
}
