package fouri.com.escrow.web;

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
import fouri.com.cpwallet.web.CPWalletUtil;

@Controller
public class EscrowTransController {

	private static final Logger LOGGER = LoggerFactory.getLogger(EscrowTransController.class);
	
	@Resource(name = "EscrowArticleDAO")
    private EscrowArticleDAO egovArticleDao;

	// 판매자 거래 리스트
    @RequestMapping("/escrow/seller/trans_list.do")
    public String seller_trans_list(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
		    	
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
		
		int BbsListCnt = (Integer) egovArticleDao.selectListCnt("transListCnt",escrowBoardVO);
		escrowPageInfo.setTotalRecordCount(BbsListCnt);
		
		List<HashMap> escrowBbsList = egovArticleDao.selectList("transList",escrowBoardVO);
		model.addAttribute("bbsList",escrowBbsList); //데이터 저장하기
		model.addAttribute("resultCnt",escrowBbsList.size()); //데이터 저장하기
		
		/* 페이징처리 */		
		model.addAttribute("pageInfoVO", escrowBoardVO);
		model.addAttribute("pageInfo", escrowPageInfo);
		
		// 검색조건 판매자 목록
		model.addAttribute("sellerList", egovArticleDao.selectList("escrowBbsTotalList", null));
		
		return "escrow/seller/trans_list";
    }   

	@RequestMapping(value = "/escrow/seller/trans_update.do")
	public @ResponseBody String trans_update(HttpServletRequest request,@ModelAttribute("EscrowTrans") EscrowTrans escrowBoardVO, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String result = "success";
		String message = ""; 
		egovArticleDao.escrowUpdate("escrowTransUpdate", escrowBoardVO);
		return getResultJsonMessage(result, message);
	}

    
    
    
    
    
    
    
	// 구매자 거래 리스트
    @RequestMapping("/escrow/buyer/trans_list.do")
    public String buyer_trans_list(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
		    	
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
		
		if((escrowBoardVO.getSearchId()).equals("")) escrowBoardVO.setSearchId("-1");
			
		int BbsListCnt = (Integer) egovArticleDao.selectListCnt("buyerTransListCnt",escrowBoardVO);
		escrowPageInfo.setTotalRecordCount(BbsListCnt);
		
		List<HashMap> escrowBbsList = egovArticleDao.selectList("buyerTransList",escrowBoardVO);
		model.addAttribute("bbsList",escrowBbsList); //데이터 저장하기
		model.addAttribute("resultCnt",escrowBbsList.size()); //데이터 저장하기
		
		/* 페이징처리 */		
		model.addAttribute("pageInfoVO", escrowBoardVO);
		model.addAttribute("pageInfo", escrowPageInfo);
		
		// 검색조건 판매자 목록
		model.addAttribute("buyerList", egovArticleDao.selectList("buyerList", null));
		
		return "escrow/buyer/trans_list";
    }
	@RequestMapping(value = "/escrow/buyer/trans_update.do")
	public @ResponseBody String buyer_trans_update(HttpServletRequest request,@ModelAttribute("EscrowTrans") EscrowTrans escrowBoardVO, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String result = "success";
		String message = ""; 
		egovArticleDao.escrowUpdate("escrowTransUpdate", escrowBoardVO);
		return getResultJsonMessage(result, message);
	}
    
    
    
	
	

	// 에스크로 시스템 화면 거래내역
    @RequestMapping("/escrow/system/trans_list.do")
    public String system_trans_list(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {

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
		
		int BbsListCnt = (Integer) egovArticleDao.selectListCnt("buyerTransListCnt",escrowBoardVO);
		escrowPageInfo.setTotalRecordCount(BbsListCnt);
		
		List<HashMap> escrowBbsList = egovArticleDao.selectList("buyerTransList",escrowBoardVO);
		model.addAttribute("bbsList",escrowBbsList); //데이터 저장하기
		model.addAttribute("resultCnt",escrowBbsList.size()); //데이터 저장하기

		/* 페이징처리 */		
		model.addAttribute("pageInfoVO", escrowBoardVO);
		model.addAttribute("pageInfo", escrowPageInfo);
		// 검색조건 판매자 목록
		model.addAttribute("sellerList", egovArticleDao.selectList("escrowBbsTotalList", null));

		return "escrow/system/trans_list";
    }

	// 리스트
    @RequestMapping("/escrow/system/trans_view.do")
    public String escrow(@ModelAttribute("searchVO") EscrowBoardVO escrowBoardVO, ModelMap model) throws Exception {
		return "escrow/system/trans_view";
    }    
	// 리스트
    @RequestMapping("/escrow/system/trans_proc.do")
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
		
		
		EscrowTrans escrowBoardVO = new EscrowTrans();
		escrowBoardVO.setIdx(Integer.parseInt((String)request.getParameter("idx")));
		escrowBoardVO.setTstate(4);
		egovArticleDao.escrowUpdate("escrowTransUpdate", escrowBoardVO);
		
		
		return "escrow/system/trans_proc";
    }    
    
    
    

	@SuppressWarnings("unchecked")
	private String getResultJsonMessage(String result, String message) {
		JSONObject ret = new JSONObject();
		ret.put("result", result);
		ret.put("message", message);
		
		return ret.toJSONString();
	}
	
        
}
