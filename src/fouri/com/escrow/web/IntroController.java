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
public class IntroController {

	private static final Logger LOGGER = LoggerFactory.getLogger(IntroController.class);
	
	// 소개
    @RequestMapping("/intro/intro.do")
    public String intro(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
		return "intro/intro";
    }
	// 에스크로도움말
    @RequestMapping("/intro/escrow.do")
    public String escrow(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
		return "intro/escrow";
    }
	// 직거래도움말
    @RequestMapping("/intro/direct.do")
    public String direct(@ModelAttribute("searchVO") EscrowTrans escrowBoardVO, ModelMap model) throws Exception {
		return "intro/direct";
    }
        
}
