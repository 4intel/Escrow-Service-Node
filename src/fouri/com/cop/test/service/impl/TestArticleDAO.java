package fouri.com.cop.test.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import fouri.com.cmm.service.impl.FouriComAbstractDAO;
import fouri.com.cop.test.service.BoardVO;

@Repository("TestArticleDAO")
public class TestArticleDAO extends FouriComAbstractDAO {

	public List<HashMap> selectNoticeArticleList(BoardVO boardVO) {
		return (List<HashMap>) list("BBSArticle.selectArticleList", boardVO);
	}
}
