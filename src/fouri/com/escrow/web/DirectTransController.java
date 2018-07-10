package fouri.com.escrow.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import fouri.com.cpwallet.service.EscrowTrans;
import fouri.com.cpwallet.service.impl.EscrowArticleDAO;
import fouri.com.escrow.service.DirectProduct;
import fouri.com.escrow.service.DirectSale;

@Controller
public class DirectTransController {

	private static final Logger LOGGER = LoggerFactory.getLogger(DirectTransController.class);
	
	@Resource(name = "EscrowArticleDAO")
    private EscrowArticleDAO egovArticleDao;

	// 판매자 거래 리스트
    @RequestMapping("/direct/seller/trans_list.do")
    public String seller_trans_list(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
    	
		List<HashMap> productList = egovArticleDao.selectList("directProductList",escrowBoardVO);
		model.addAttribute("productList",productList);
    	
		return "direct/seller/trans_list";
    }
    
	// 판매자 거래 화면
    @RequestMapping("/direct/seller/trans_board.do")
    public String seller_trans_board(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
    	
		List<HashMap> productList = egovArticleDao.selectList("directProductList",escrowBoardVO);
		model.addAttribute("productList",productList);
    	
		return "direct/seller/trans_board";
    }

	@RequestMapping(value = "/direct/seller/product_insert_proc.do")
	public @ResponseBody String product_insert_proc(HttpServletRequest request,@ModelAttribute("DirectProduct") DirectProduct directProduct, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		egovArticleDao.escrowUpdate("directProductInsert", directProduct);
		
		String result = "success";
		String message = ""; 
		return getResultJsonMessage(result, message);
	}
	
	@RequestMapping(value = "/direct/seller/product_delete_proc.do")
	public @ResponseBody String product_delete_proc(HttpServletRequest request,@ModelAttribute("DirectProduct") DirectProduct directProduct) throws Exception {
		String[] idxs = request.getParameterValues("pidx");
		if(idxs==null || idxs.length==0) {
			String idx = request.getParameter("pidx");
			directProduct.setIdx(Integer.parseInt(idx));
			egovArticleDao.escrowDelete("directProductDelete", directProduct);
		} else {
			for(int i=0; i<idxs.length; i++) {
				directProduct.setIdx(Integer.parseInt(idxs[i]));
				egovArticleDao.escrowDelete("directProductDelete", directProduct);
			}
		}		
		
		String result = "success";
		String message = ""; 
		return getResultJsonMessage(result, message);
	}

	@RequestMapping(value = "/direct/seller/send_order_proc.do")
	public @ResponseBody String send_order_proc(HttpServletRequest request,@ModelAttribute("DirectSale") DirectSale directSale, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String[] SNAME_arr = request.getParameterValues("SNAME");
		int sidx = 0;
		if(SNAME_arr==null || SNAME_arr.length<1) {
			String SNAME = request.getParameter("SNAME");
			if(SNAME!=null && !SNAME.equals("")) {
				String SUNIT = request.getParameter("SUNIT");
				String SCNT = request.getParameter("SCNT");
				String SSUM = request.getParameter("SSUM");
				directSale.setSname(SNAME);
				directSale.setSunit(Integer.parseInt(SUNIT));
				directSale.setScnt(Integer.parseInt(SCNT));
				directSale.setSsum(Integer.parseInt(SSUM));
				sidx = egovArticleDao.selectListCnt("selectMaxSidx", directSale);
				directSale.setSidx(sidx);
				egovArticleDao.escrowInsert("directSaleInsert", directSale);	
				egovArticleDao.escrowInsert("directSalePlistInsert", directSale);	
			}
		} else {
			String[] SUNIT_arr = request.getParameterValues("SUNIT");
			String[] SCNT_arr = request.getParameterValues("SCNT");
			String[] SSUM_arr = request.getParameterValues("SSUM");
			sidx = egovArticleDao.selectListCnt("selectMaxSidx", directSale);
			directSale.setSidx(sidx);
			egovArticleDao.escrowInsert("directSaleInsert", directSale);	
			for(int i=0;i<SNAME_arr.length; i++) {
				directSale.setSname(SNAME_arr[i]);
				directSale.setSunit(Integer.parseInt(SUNIT_arr[i]));
				directSale.setScnt(Integer.parseInt(SCNT_arr[i]));
				directSale.setSsum(Integer.parseInt(SSUM_arr[i]));
				egovArticleDao.escrowInsert("directSalePlistInsert", directSale);	
			}
		}
		
		String result = "success";
		String message = Integer.toString(sidx); 
		return getResultJsonMessage(result, message);
	}

	@RequestMapping(value="/direct/seller/check_order.do",  produces="text/plain;charset=UTF-8")
	public @ResponseBody String seller_check_order(HttpServletRequest request,@ModelAttribute("DirectSale") DirectSale directSale, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String result = "success";
		String message = ""; 
		String nowSIDX = request.getParameter("nowSIDX");
		
		// 상태 체크
		directSale.setSidx(Integer.parseInt(nowSIDX));
		HashMap map = egovArticleDao.selectView("directSaleInfo",directSale);
		if(map!=null) {
			int sstate = (Integer)map.get("SSTATE");
			String SWID = (String)map.get("SWID");
			int totalpay = (Integer)map.get("TOTALPAY");
			String BWID = (String)map.get("BWID");
			String BWID_NM = (String)map.get("BWID_NM");
			int SEND_COIN = (Integer)map.get("SEND_COIN");
			//System.out.println(BWID_NM);
			message = nowSIDX + "|" + Integer.toString(sstate) + "|" + SWID + "|" + Integer.toString(totalpay) + "|" + (BWID_NM) + "|" + Integer.toString(SEND_COIN);
		}
	
		return getResultJsonMessage(result, message);
	}
	
	
	

	// 판매자 거래 리스트
    @RequestMapping("/direct/buyer/trans_board.do")
    public String buyer_trans_list(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
		return "direct/buyer/trans_board";
    }

	@RequestMapping(value = "/direct/buyer/check_order.do")
	public @ResponseBody String check_order(HttpServletRequest request,@ModelAttribute("DirectSale") DirectSale directSale, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String result = "success";
		String message = ""; 
		String nowSIDX = request.getParameter("nowSIDX");

		if(nowSIDX.equals("0")) {
			int sidx = egovArticleDao.selectListCnt("selectMaxSidxNo", null);	// 가장 최근 거래
			if(sidx>-1) {
				// 상태 체크
				directSale.setSidx(sidx);
				HashMap map = egovArticleDao.selectView("directSaleInfo",directSale);
				if(map!=null) {
					int sstate = (Integer)map.get("SSTATE");
					if(sstate==0) {
						String SWID = (String)map.get("SWID");
						int totalpay = (Integer)map.get("TOTALPAY");
						message = Integer.toString(sidx) + "|" + Integer.toString(sstate) + "|" + SWID + "|" + Integer.toString(totalpay);	
					}
				}
			}	
		} else {
			// 상태 체크
			directSale.setSidx(Integer.parseInt(nowSIDX));
			HashMap map = egovArticleDao.selectView("directSaleInfo",directSale);
			if(map!=null) {
				int sstate = (Integer)map.get("SSTATE");
				String SWID = (String)map.get("SWID");
				int totalpay = (Integer)map.get("TOTALPAY");
				String BWID = (String)map.get("BWID");
				String BWID_NM = (String)map.get("BWID_NM");
				message = nowSIDX + "|" + Integer.toString(sstate) + "|" + SWID + "|" + Integer.toString(totalpay) + "|" + BWID_NM;
			}
		}
		
		return getResultJsonMessage(result, message);
	}
	
	@RequestMapping(value = "/direct/buyer/order_product_list.do")
	public @ResponseBody HashMap<String, Object> order_product_list(HttpServletRequest request, @ModelAttribute("DirectSale") DirectSale directSale, ModelAndView mav) throws Exception {
		String result = "success";
		String message = "";
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();

		resultMap.put("order_list", egovArticleDao.selectList("directSalePlistList", directSale));
		resultMap.put("result", result);
		
		return resultMap;
	}
    

	

	// 에스크로 지갑 앱에서 송금 처리 완료 했을 경우 DB 데이타 update처리
	@RequestMapping(value = "/direct/buyer/send_coin_process.do")
	public @ResponseBody String send_coin_process(HttpServletRequest request,@ModelAttribute("DirectSale") DirectSale directSale, @RequestParam Map<String, Object> param, ModelAndView mav) throws Exception {
		String result = "success";
		String message = ""; 

		String bwid = request.getParameter("bwid");
		String bwid_nm = request.getParameter("bwid_nm");
		String send_coin = request.getParameter("send_coin");
		int sidx = egovArticleDao.selectListCnt("selectMaxSidxNo", null);	// 가장 최근 거래
		directSale.setSidx(sidx);
		directSale.setBwid(bwid);
		directSale.setBwid_nm(bwid_nm);
		directSale.setSend_coin(Integer.parseInt(send_coin));
		
		egovArticleDao.escrowUpdate("updateDirectSaleBuyerInfo", directSale);
		return getResultJsonMessage(result, message);
	}
	
	
	
	
	@SuppressWarnings("unchecked")
	private String getResultJsonMessage(String result, String message) {
		JSONObject ret = new JSONObject();
		ret.put("result", result);
		ret.put("message", message);
		
		return ret.toJSONString();
	}
	
        
}
