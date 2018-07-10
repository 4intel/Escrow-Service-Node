package fouri.com.cop.test.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import fouri.com.cop.test.service.BoardVO;
import fouri.com.cop.test.service.impl.TestArticleService;

@Controller
public class TestController {

	private static final Logger LOGGER = LoggerFactory.getLogger(TestController.class);
	
	@Resource(name = "TestArticleService")
    private TestArticleService egovArticleService;

    //protected Logger log = Logger.getLogger(this.getClass());
    
    @RequestMapping("/test.do")
    public String selectArticleList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		List<HashMap> noticeList = egovArticleService.selectNoticeArticleList(boardVO);
		model.addAttribute("noticeList",noticeList);
		
		return "test";
    }
    
    
}
