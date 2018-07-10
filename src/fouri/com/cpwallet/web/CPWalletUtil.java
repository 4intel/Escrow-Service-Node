package fouri.com.cpwallet.web;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import fouri.com.common.util.KeyManager;
import fouri.com.cpwallet.biz.ApiHelper;

public class CPWalletUtil {
	public static JSONObject getNHistory(String queryName, String strPID,String strUserWID,int nCount, String sdate, String edate) {
		// CPTrans : { "ver":"10000","tid":"TX_...","ttm":XXXX, "wid":"WA_...","val":xxx,"flg":xxxx,
		//			"amt":xxx,"dmt":xxx,"msg":"....","Memo":"xxx","sig":"xxxx" }
		 
	   // "query_type":"query","func_name":"historyNTrans",
	   // "func_args":["PID","10000","cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP","3","KuRkN1UpGf",
	   // "AN1rKvtHspLUiiH7o4goB3W7r1944cRcGq2FgS27jNeJdk7Qxoh1L6kFY9sLDYPmueoU5tf9v1Kp5k5HL6WHAFiDThd3XUzbt",
	   // "cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP"]}
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		String[] args = null;
		if(queryName.equals("historyNTrans") || queryName.equals("historyNTransE")) {	// 최근 목록
			args = new String[] {strPID,"10000",strUserWID,"" + nCount,"","",""};
		} else if(queryName.equals("historyTrans") || queryName.equals("historyTransE")) {	// 검색목록
			args = new String[] {strPID,"10000",strUserWID,sdate,edate,"Y","0","300","","",""};
		} else {
			args = new String[] {strPID,"10000",strUserWID,"" + nCount,"","",""};
		}
		
		if(!ApiHelper.putQuerySignature(args,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300)))
			return null;
		
		joQuery.put("query_type","query");    
		joQuery.put("func_name",queryName);   // { "query_type": "query", "func_name": "historyNTrans" }

		for( String strArg : args) {
			jaParam.add(strArg);
		}    // jaParam = [ "PID","10000","cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP","3","KuRkN1UpGf",
		   // "AN1rKvtHspLUiiH7o4goB3W7r1944cRcGq2FgS27jNeJdk7Qxoh1L6kFY9sLDYPmueoU5tf9v1Kp5k5HL6WHAFiDThd3XUzbt",
		   // "cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP"]
		joQuery.put("func_args", jaParam);  
		//System.out.println(jaParam);

		JSONObject joValue = null;
		JSONObject joRes = ApiHelper.postJSON(joQuery);
		if(joRes != null) {
			long nCode = (Long)joRes.getOrDefault("ec",-1L);
			if(nCode == 0) {
				String strValue = (String)joRes.getOrDefault("value","{}");
				JSONParser jaTemp = new JSONParser();

				try {
					joValue = (JSONObject)jaTemp.parse(strValue);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		//CPWorkbench.logMessage("getNonce:" + strResponse);
		//System.out.println(" joValue : "+joValue);
		return joValue;
		// {"ref":"OK","pid":"PID","value":
		//=> 요거만으로 구성된 JSON 객체 리터  "{ \"total\":3,
		//	\"Record\":[{\"ver\":10000,\"tid\":\"TX_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"ttm\":1512111627,\"wid\":\"WA_cMfqx9WGLBBHnhtyXVN8AYQPirN7L4AozofmjvLU8bPTCXxkSW7n\",\"val\":34185,\"flg\":1,\"amt\":4965815,\"dmt\":34185,\"msg\":\"Pocket money\",\"mno\":\"pay for coffee at the madam wang-shop \",\"sig\":\"AN1rKvtPKaiTuNqZPbZ6\"},\n{\"ver\":10000,\"tid\":\"TX_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"ttm\":1512109613,\"wid\":\"WA_cMfbiiM2LBJBKRQBwTSZNjaWqbgDdsripqQbkqUsKgLsF6hMbhoa\",\"val\":5000000,\"flg\":0,\"amt\":5000000,\"dmt\":0,\"msg\":\"Pocket money\",\"mno\":\"coffee pay\",\"sig\":\"AN1rKvt51oXXnMTKZ88w\"},\n{\"ver\":10000,\"tid\":\"TX_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"ttm\":1512108377,\"wid\":\"WA_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"val\":0,\"flg\":0,\"amt\":0,\"dmt\":0,\"msg\":\"create wallet\",\"mno\":\"\",\"sig\":\"cMhemRVoMp2CJ1HUhpwkzqEu3satuRsdnFfG3zzXwv4hq8Wro1Q3\"}]}"
		// ,"ec":0}
	}
	
	// 코인 목록
	public static JSONObject getCoinHistory(String queryName, String strPID) {
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		String[] args = null;
		args = new String[] {strPID,"10000","100","","","",""};
		
		if(!ApiHelper.putQuerySignature(args,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300)))
			return null;
		
		joQuery.put("query_type","query");    
		joQuery.put("func_name",queryName);   // { "query_type": "query", "func_name": "historyNTrans" }
	
		for( String strArg : args) {
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);  
	
		JSONObject joValue = null;
		JSONObject joRes = ApiHelper.postJSON(joQuery);
		if(joRes != null) {
			long nCode = (Long)joRes.getOrDefault("ec",-1L);
			if(nCode == 0) {
				String strValue = (String)joRes.getOrDefault("value","{}");
				////System.out.println("strValue :"+strValue);
			} 
		}
		return joRes;
	}
	
	// 지갑생성
	public static JSONObject createWallet(String strPID,String wid,String cid,String wname) {
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		String[] args = null;
		args = new String[] {strPID,"10000",wid,cid,wname,"0x03","100000000000","something else","","",""};
		
		if(!ApiHelper.putQuerySignature(args,true,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan200)))
			return null;
		
		joQuery.put("query_type","invoke");
		joQuery.put("func_name","createWallet");

		for( String strArg : args) {
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);  
		//System.out.println("------------------jaParam : "+jaParam);

		JSONObject joRes = ApiHelper.postJSON(joQuery);
		return joRes;
	}

	// 지갑 이름 정보
	public static JSONObject getWalletName(String strPID,String wid) {
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		String[] args = null;
		args = new String[] {strPID,"10000",wid};
		
		joQuery.put("query_type","query");
		joQuery.put("func_name","stateWallet");
	
		for( String strArg : args) {
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);  
		//System.out.println("getWalletName ------------------jaParam : "+jaParam);
	
		JSONObject joRes = ApiHelper.postJSON(joQuery);
		return joRes;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	// ---------------------------------------- Method 정리목적 테스트용 (이기정 17-12-09)
	// Record list
	public static JSONObject getRecordList(String queryName, String[] args) {
		// CPTrans : { "ver":"10000","tid":"TX_...","ttm":XXXX, "wid":"WA_...","val":xxx,"flg":xxxx,
		//			"amt":xxx,"dmt":xxx,"msg":"....","Memo":"xxx","sig":"xxxx" }
		 
		// "query_type":"query","func_name":"historyNTrans",
		// "func_args":["PID","10000","cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP","3","KuRkN1UpGf",
		// "AN1rKvtHspLUiiH7o4goB3W7r1944cRcGq2FgS27jNeJdk7Qxoh1L6kFY9sLDYPmueoU5tf9v1Kp5k5HL6WHAFiDThd3XUzbt",
		// "cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP"]}
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		if(!ApiHelper.putQuerySignature(args,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300)))
			return null;
		
		joQuery.put("query_type","query");    
		joQuery.put("func_name",queryName);   // { "query_type": "query", "func_name": "historyNTrans" }

		for( String strArg : args) {
			jaParam.add(strArg);
		}   
		// jaParam = [
		// "PID","10000","cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP","3","KuRkN1UpGf",
		// "AN1rKvtHspLUiiH7o4goB3W7r1944cRcGq2FgS27jNeJdk7Qxoh1L6kFY9sLDYPmueoU5tf9v1Kp5k5HL6WHAFiDThd3XUzbt",
		// "cMhkeiJnpHNHh1okUh7x7LaX6krxxtVmjrJ9BzACVSnevm5WHtRP"]
		joQuery.put("func_args", jaParam);  
		//System.out.println("getRecordList jaParam : "+jaParam);

		JSONObject joValue = null;
		JSONObject joRes = ApiHelper.postJSON(joQuery);
		if(joRes != null) {
			long nCode = (Long)joRes.getOrDefault("ec",-1L);
			if(nCode == 0) {
				String strValue = (String)joRes.getOrDefault("value","{}");
				JSONParser jaTemp = new JSONParser();

				try {
					joValue = (JSONObject)jaTemp.parse(strValue);
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		//CPWorkbench.logMessage("getNonce:" + strResponse);
		//System.out.println("getRecordList joValue : "+joValue);
		return joValue;
		// {"ref":"OK","pid":"PID","value":
		//=> 요거만으로 구성된 JSON 객체 리터  "{ \"total\":3,
		//	\"Record\":[{\"ver\":10000,\"tid\":\"TX_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"ttm\":1512111627,\"wid\":\"WA_cMfqx9WGLBBHnhtyXVN8AYQPirN7L4AozofmjvLU8bPTCXxkSW7n\",\"val\":34185,\"flg\":1,\"amt\":4965815,\"dmt\":34185,\"msg\":\"Pocket money\",\"mno\":\"pay for coffee at the madam wang-shop \",\"sig\":\"AN1rKvtPKaiTuNqZPbZ6\"},\n{\"ver\":10000,\"tid\":\"TX_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"ttm\":1512109613,\"wid\":\"WA_cMfbiiM2LBJBKRQBwTSZNjaWqbgDdsripqQbkqUsKgLsF6hMbhoa\",\"val\":5000000,\"flg\":0,\"amt\":5000000,\"dmt\":0,\"msg\":\"Pocket money\",\"mno\":\"coffee pay\",\"sig\":\"AN1rKvt51oXXnMTKZ88w\"},\n{\"ver\":10000,\"tid\":\"TX_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"ttm\":1512108377,\"wid\":\"WA_cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v\",\"val\":0,\"flg\":0,\"amt\":0,\"dmt\":0,\"msg\":\"create wallet\",\"mno\":\"\",\"sig\":\"cMhemRVoMp2CJ1HUhpwkzqEu3satuRsdnFfG3zzXwv4hq8Wro1Q3\"}]}"
		// ,"ec":0}
	}
	
	// 단순 목록 조회
	public static JSONObject getList(String queryName, String[] args) {
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		if(!ApiHelper.putQuerySignature(args,true,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emRoot)))
			return null;
		
		joQuery.put("query_type","query");    
		joQuery.put("func_name",queryName);   // { "query_type": "query", "func_name": "historyNTrans" }
	
		for( String strArg : args) {
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);  
	
		JSONObject joValue = null;
		JSONObject joRes = ApiHelper.postJSON(joQuery);
		return joRes;
	}
	
	// get row
	public static JSONObject getValue(String queryName, String[] args) {
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		joQuery.put("query_type","query");
		joQuery.put("func_name",queryName);
	
		for( String strArg : args) {
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);  
		//System.out.println("getValue jaParam : "+jaParam);
	
		JSONObject joRes = ApiHelper.postJSON(joQuery);
		return joRes;
	}
	
	// invoke
	public static JSONObject invokeProc(String queryName, String[] args) {
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		
		if(!ApiHelper.putQuerySignature(args,true,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan200)))
			return null;
		
		joQuery.put("query_type","invoke");
		joQuery.put("func_name",queryName);

		for( String strArg : args) {
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);  
		//System.out.println("invokeProc jaParam : "+jaParam);

		JSONObject joRes = ApiHelper.postJSON(joQuery);
		return joRes;
	}
	// ----------------------------------------
}
