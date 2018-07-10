package fouri.com.cop.test.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import fouri.com.cop.test.service.BoardVO;

@Service("TestArticleService")
public class TestArticleService  {

	@Resource(name = "TestArticleDAO")
    private TestArticleDAO testArticleDao;

	public List<HashMap> selectNoticeArticleList(BoardVO boardVO) {
		return testArticleDao.selectNoticeArticleList(boardVO);
	}

}
