package fouri.com.cpwallet;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import fouri.com.common.util.KeyManager;
import fouri.com.cpwallet.biz.ApiHelper;
import fouri.com.cpwallet.web.CPWalletUtil;

@Controller
public class ComIndexController {

	private static final Logger LOGGER = LoggerFactory.getLogger(ComIndexController.class);

	@RequestMapping("/index.do")
	public String index(ModelMap model, HttpServletRequest request) {
		//System.out.println(FouriProperties.getProperty("project_home"));
		String curl = "";
		
    	if (null == request.getParameter("curl")) {
    		model.addAttribute("curl", "/intro/intro.do");
    	} else {
    		model.addAttribute("curl", request.getParameter("curl"));
    	}
		return "index";
	}


    @RequestMapping("/faucet.do")
    public String faucet(ModelMap model) throws Exception {
		return "faucet";
    }        
    
	// 리스트
    @RequestMapping("/faucet_proc.do")
    public String faucet_proc(HttpServletRequest request, ModelMap model) throws Exception {
    	JSONObject joQuery = new JSONObject();
    	JSONArray jaParam = new JSONArray();
    	String walletName2 = request.getParameter("walletName2");
    	if(walletName2==null) walletName2 = "";

    	String[] args2 = null;
    	args2 = new String[] {"PID","10000","cMgqV2GF7nWFkyPb5Yxr9uCSvcg4Eg4YosrsZaSXXE1XvJNEtJGB","","",""};
    	if(!ApiHelper.putQuerySignature(args2,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300))) {
    		;
    	}
    	JSONObject joRes_temp = CPWalletUtil.getValue("stateTrans", args2);
    	JSONObject joValue = null;
		String strValue = joRes_temp.get("value").toString();
		JSONParser jaTemp = new JSONParser();
		try {
			joValue = (JSONObject)jaTemp.parse(strValue);
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	// "PID","10000","cMfgA4EMpLbsqeP9rHaxKcUZPosWaBu9mazGpzNKt55wMoBh7tKn","R","10000","10000","10000","10000","","cMhemRVoMp","381yXZW2B3Kf2TjzhoAszbWfnrTxbeMSF5zrTgtdPZ2YQtDxxhQsKdFZWZm4FL7dMRoq47aJwtugkY1eNTfs7wb2HetnrFAA","cMhbcZ7rzTnVwAtooAz6VGc8qWqwYTCfKCkhNbu3YUwD3cFg8AyP"

    	String[] args = null;
    	args = new String[] {"PID","10000",walletName2,"R","500000","faucet","faucet","faucet","","","",""};
    	if(!ApiHelper.putSignatureWithNonce(args, ((String)(joValue.get("sig"))).substring(0, 10),KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.escrowIssue))) {
    		//return null;
    	}
    	joQuery.put("query_type","invoke");
    	joQuery.put("func_name","createTrans");

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
		return "faucet_proc";
    }    
}
