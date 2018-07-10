package fouri.com.cmm.service.impl;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;

import fouri.com.cmm.service.dataaccess.FouriAbstractMapper;

public abstract class FouriComAbstractDAO extends FouriAbstractMapper {

	@Resource(name="fouri.sqlSession")
	public void setSqlSessionFactory(SqlSessionFactory sqlSession) {
		super.setSqlSessionFactory(sqlSession);
	}

}
