package fouri.com.cop.test.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import fouri.com.cmm.service.FileMngUtil;
import fouri.com.cmm.service.FileVO;
import fouri.com.cmm.ui.pagination.PaginationInfo;
import fouri.com.cop.test.service.BoardVO;
import fouri.com.cop.test.service.impl.TestArticleDAO;

@Controller
public class TestController2 {

	private static final Logger LOGGER = LoggerFactory.getLogger(TestController2.class);
	
	@Resource(name = "TestArticleDAO")
    private TestArticleDAO egovArticleService;

    @Resource(name = "FileMngUtil")
    private FileMngUtil fileUtil;
    
    //protected Logger log = Logger.getLogger(this.getClass());

    @RequestMapping("/test2.do")
    public String selectArticleList(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		return "test2";
    }
    @RequestMapping("/test2_list.do")
    public String test2_list(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		boardVO.setPageUnit(30);
		boardVO.setPageSize(10);
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<HashMap> noticeList = egovArticleService.selectNoticeArticleList(boardVO);
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("pageIndex",boardVO.getPageIndex());
		
		return "test2_list";
    }

    @RequestMapping("/test_list_json.do")
    public @ResponseBody HashMap<String, Object> test_list_json(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

		boardVO.setPageUnit(30);
		boardVO.setPageSize(10);
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<HashMap> noticeList = egovArticleService.selectNoticeArticleList(boardVO);
		model.addAttribute("noticeList",noticeList);
		model.addAttribute("pageIndex",boardVO.getPageIndex());

		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("noticeList", noticeList);
		resultMap.put("pageIndex", boardVO.getPageIndex());
		
		return resultMap;
		
    }
    

    @RequestMapping("/upload_test.do")
    public String upload_test(@ModelAttribute("searchVO") BoardVO boardVO, ModelMap model) throws Exception {
		//LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		
		return "up_test";
    }
    @RequestMapping("/upload_test_proc.do")
    public String insertArticle(final MultipartHttpServletRequest multiRequest, @ModelAttribute("searchVO") BoardVO boardVO, @ModelAttribute("board") BoardVO board, BindingResult bindingResult, ModelMap model) throws Exception {

	    List<FileVO> result = null;
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
	    }
	    
	    //egovArticleService.insertArticle(board);
	
		return "forward:/upload_test.do";
    }
}
