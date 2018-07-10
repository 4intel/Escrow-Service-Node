package fouri.com.cpwallet.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import fouri.com.cmm.ui.pagination.PaginationInfo;
import fouri.com.common.util.KeyManager;
import fouri.com.cpwallet.biz.ApiHelper;
import fouri.com.cpwallet.service.EscrowBoardVO;
import fouri.com.cpwallet.service.EscrowTrans;
import fouri.com.cpwallet.service.impl.EscrowArticleDAO;

@Controller
public class EscrowController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EscrowController.class);
	
	@Resource(name = "EscrowArticleDAO")
    private EscrowArticleDAO egovArticleDao;
    
	// 리스트
    @RequestMapping("/bbs.do")
    public String EscrowBbsList(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
		    	
    	escrowBoardVO.setPageUnit(10);
    	escrowBoardVO.setPageSize(10);
    	
		PaginationInfo escrowPageInfo = new PaginationInfo();
		
		escrowPageInfo.setTotalRecordCount(escrowBoardVO.getPageSize()); // 총 카운터		
		escrowPageInfo.setCurrentPageNo(escrowBoardVO.getPageIndex()); // 현재 페이지 값
		escrowPageInfo.setRecordCountPerPage(escrowBoardVO.getPageUnit()); // 페이지갯수
		escrowPageInfo.setPageSize(escrowBoardVO.getPageSize()); // 페이지사이즈
	
		escrowBoardVO.setFirstIndex(escrowPageInfo.getFirstRecordIndex()); // 첫페이지 값
		escrowBoardVO.setLastIndex(escrowPageInfo.getLastRecordIndex()); // 마지막 페이지 값
		escrowBoardVO.setRecordCountPerPage(escrowPageInfo.getRecordCountPerPage());
		
		int BbsListCnt = (Integer) egovArticleDao.selectEscrowBbsArticleListCnt(escrowBoardVO); // 게시물 카운터
		escrowPageInfo.setTotalRecordCount(BbsListCnt);
		
		List<HashMap> escrowBbsList = egovArticleDao.selectEscrowBbsArticleList(escrowBoardVO); //데이터 가져오기
		model.addAttribute("bbsList",escrowBbsList); //데이터 저장하기
		model.addAttribute("resultCnt",escrowBbsList.size()); //데이터 저장하기
		
		/* 페이징처리 */		
		model.addAttribute("pageInfoVO", escrowBoardVO);
		model.addAttribute("pageInfo", escrowPageInfo);
		
		/*
		model.addAttribute("pageUnit",escrowBoardVO.getPageUnit()); //레코드수
		model.addAttribute("pageSize",escrowBoardVO.getPageSize()); //페이징처리
		model.addAttribute("pageIndex",escrowBoardVO.getPageIndex()); //현재페이지
		model.addAttribute("firstIndex",escrowBoardVO.getFirstIndex()); //첫번째페이지
		model.addAttribute("LastIndex",escrowBoardVO.getLastIndex()); //마지막페이지
		*/
		
		return "bbs";
    }    
    
    // 상세페이지
    @RequestMapping("/bbsViewArticle.do")
    public String EscrowBbsView(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {

    	HashMap escrowBbsView = egovArticleDao.selectEscrowBbsArticleView(escrowBoardVO); //데이터 가져오기		
		model.addAttribute("bbsView",escrowBbsView); //데이터 저장하기
		
		return "bbs_view";
    }
    
    // 등록페이지
    @RequestMapping("/bbsWriteArticleView.do")
    public String EscrowBbsWriteView(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
    	
		return "bbs_write";
    }
    
    // 등록쿼리문
    @RequestMapping("/bbsWriteArticle.do")
    public String EscrowBbsWrite(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {

    	egovArticleDao.selectEscrowBbsArticleInsert(escrowBoardVO); //데이터 가져오기
		
		return "forward:/index.do?curl=/bbs.do";
    }
    
    // 수정페이지
    @RequestMapping("/bbsUpdateArticleView.do")
    public String EscrowBbsUpdateView(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
		
    	HashMap escrowBbsView = egovArticleDao.selectEscrowBbsArticleView(escrowBoardVO); //데이터 가져오기	
		model.addAttribute("bbsView",escrowBbsView); //데이터 저장하기
    	
    	return "bbs_update";
    }
    
    // 수정쿼리문
    @RequestMapping("/bbsUpdateArticle.do")
    public String EscrowBbsUpdate(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {

    	egovArticleDao.selectEscrowBbsArticleUpdate(escrowBoardVO); //데이터 가져오기
		
		return "forward:/index.do?curl=/bbs.do";
    }
    
    // 삭제쿼리문
    @RequestMapping("/bbsDeleteArticle.do")
    public String EscrowBbsDelete(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {

    	egovArticleDao.selectEscrowBbsArticleDelete(escrowBoardVO); //데이터 가져오기
    	
		return "forward:/index.do?curl=/bbs.do";
    }
    
    
    
    
    

	// 리스트
    @RequestMapping("/mbbs.do")
    public String mEscrowBbsList(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
		    	
    	escrowBoardVO.setPageUnit(10);
    	escrowBoardVO.setPageSize(10);
    	
		PaginationInfo escrowPageInfo = new PaginationInfo();
		
		escrowPageInfo.setTotalRecordCount(escrowBoardVO.getPageSize()); // 총 카운터		
		escrowPageInfo.setCurrentPageNo(escrowBoardVO.getPageIndex()); // 현재 페이지 값
		escrowPageInfo.setRecordCountPerPage(escrowBoardVO.getPageUnit()); // 페이지갯수
		escrowPageInfo.setPageSize(escrowBoardVO.getPageSize()); // 페이지사이즈
	
		escrowBoardVO.setFirstIndex(escrowPageInfo.getFirstRecordIndex()); // 첫페이지 값
		escrowBoardVO.setLastIndex(escrowPageInfo.getLastRecordIndex()); // 마지막 페이지 값
		escrowBoardVO.setRecordCountPerPage(escrowPageInfo.getRecordCountPerPage());
		
		int BbsListCnt = (Integer) egovArticleDao.selectEscrowBbsArticleListCnt(escrowBoardVO); // 게시물 카운터
		escrowPageInfo.setTotalRecordCount(BbsListCnt);
		
		List<HashMap> escrowBbsList = egovArticleDao.selectEscrowBbsArticleList(escrowBoardVO); //데이터 가져오기
		model.addAttribute("bbsList",escrowBbsList); //데이터 저장하기
		model.addAttribute("resultCnt",escrowBbsList.size()); //데이터 저장하기
		
		/* 페이징처리 */		
		model.addAttribute("pageInfoVO", escrowBoardVO);
		model.addAttribute("pageInfo", escrowPageInfo);
		
		/*
		model.addAttribute("pageUnit",escrowBoardVO.getPageUnit()); //레코드수
		model.addAttribute("pageSize",escrowBoardVO.getPageSize()); //페이징처리
		model.addAttribute("pageIndex",escrowBoardVO.getPageIndex()); //현재페이지
		model.addAttribute("firstIndex",escrowBoardVO.getFirstIndex()); //첫번째페이지
		model.addAttribute("LastIndex",escrowBoardVO.getLastIndex()); //마지막페이지
		*/
		
		return "mobile/bbs";
    }    
    
    // 상세페이지
    @RequestMapping("/mbbsViewArticle.do")
    public String mEscrowBbsView(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
    	HashMap escrowBbsView = egovArticleDao.selectEscrowBbsArticleView(escrowBoardVO); //데이터 가져오기		
		model.addAttribute("bbsView",escrowBbsView);
		
		return "mobile/bbs_view";
    }
    
    // 구매페이지
    @RequestMapping("/mbbsPayment.do")
    public String mbbsPayment(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
    	HashMap escrowBbsView = egovArticleDao.selectEscrowBbsArticleView(escrowBoardVO); //데이터 가져오기		
		model.addAttribute("bbsView",escrowBbsView);
		
		return "mobile/pay";
    }

	@SuppressWarnings("unchecked")
	private String getResultJsonMessage(String result, String message) {
		JSONObject ret = new JSONObject();
		ret.put("result", result);
		ret.put("message", message);
		
		return ret.toJSONString();
	}
	
	@RequestMapping(value = "/mbbsPaymentInsert.do")
	public @ResponseBody String mbbsPaymentInsert(HttpServletRequest request,@ModelAttribute("EscrowTrans") EscrowTrans escrowBoardVO, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String result = "success";
		String message = ""; 
		egovArticleDao.escrowTransInsert(escrowBoardVO);
		return getResultJsonMessage(result, message);
	}
    
    
    
    
    

    
	// 리스트
    @RequestMapping("/escrow.do")
    public String escrow(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
		List<HashMap> escrowBbsList = egovArticleDao.selectEscrowTotalList(escrowBoardVO); //데이터 가져오기
		model.addAttribute("bbsList",escrowBbsList); //데이터 저장하기
		
		/* 페이징처리 */		
		model.addAttribute("pageInfoVO", escrowBoardVO);
		
		return "escrow";
    }    
	// 리스트
    @RequestMapping("/escrow_proc.do")
    public String escrow_proc(HttpServletRequest request, ModelMap model) throws Exception {
    	JSONObject joQuery = new JSONObject();
    	JSONArray jaParam = new JSONArray();

    	String walletName2 = request.getParameter("walletName2");
    	if(walletName2==null) walletName2 = "";
    	String walletAmount2 = request.getParameter("walletAmount2");
    	if(walletAmount2==null) walletAmount2 = "0";
    	String walletContent = request.getParameter("walletContent");	// 입금메모
    	if(walletContent==null) walletContent = "";
    	String sendContents = request.getParameter("sendContents");	// 거래내용
    	if(sendContents==null) sendContents = "";
    	String buyerWalletId = request.getParameter("buyerWalletId");	// 구매자지갑아이디
    	if(buyerWalletId==null) buyerWalletId = "";
    	

    	String[] args2 = null;
    	args2 = new String[] {"PID","10000","cMftYAWS1rZBPqhzq2PWynnb7N8cn8eQWcoSQsrf7QYgDQzXNuct","","",""};
    	if(!ApiHelper.putQuerySignature(args2,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300))) {
    		;
    	}
    	JSONObject joRes_temp = CPWalletUtil.getValue("stateTrans", args2);
    	JSONObject joValue = null;
		String strValue = (String)joRes_temp.getOrDefault("value","{}");
		JSONParser jaTemp = new JSONParser();
		try {
			joValue = (JSONObject)jaTemp.parse(strValue);
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	//System.out.println("(String)(joValue.get(sig)) : "+(String)(joValue.get("sig")));
    	
    	String[] args = null;
    	args = new String[] {"PID","10000", walletName2, "R", walletAmount2, "", "에스크로송금", walletContent, buyerWalletId,"","",""};
    	if(!ApiHelper.putSignatureWithNonce(args, ((String)(joValue.get("sig"))).substring(0, 10),KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emManEscrow))) {
    		//return null;
    	}

    	joQuery.put("query_type","invoke");
    	joQuery.put("func_name","escrowTrans");

    	for( String strArg : args) {
    		jaParam.add(strArg);
    	}
    	//System.out.println("jaParam : "+jaParam);
    	joQuery.put("func_args", jaParam);  

    	JSONObject joRes = ApiHelper.postJSON(joQuery);

		if(joRes != null) {
			long nCode = (Long)joRes.getOrDefault("ec",-1L);
			model.addAttribute("nCode",Long.toString(nCode));
		}
		return "escrow_proc";
    }    
}
