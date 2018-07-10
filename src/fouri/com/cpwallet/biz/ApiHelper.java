package fouri.com.cpwallet.biz;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.logging.Logger;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import fouri.com.cmm.service.FouriProperties;
import fouri.com.common.util.EtcUtils;
import fouri.com.common.util.KeyManager;
import fouri.com.common.util.KeyManager.CPAPI_LEVEL;
import fouri.com.common.util.LogUtil;
import net.fouri.libs.bitutil.crypto.Base58;
import net.fouri.libs.bitutil.crypto.InMemoryPrivateKey;
import net.fouri.libs.bitutil.crypto.PublicKeyHelper;
import net.fouri.libs.bitutil.crypto.Signature;
import net.fouri.libs.bitutil.model.NetConfig;
import net.fouri.libs.bitutil.util.HashUtils;
import net.fouri.libs.bitutil.util.Sha256Hash;

public class ApiHelper {
	
	private static final String sm_strVer = "10000";
	private static Logger sm_Log = Logger.getLogger(ApiHelper.class.getName());
	
	/**
	 * 
	 * @param strUserWID     : Wallet ID
	 * @param strPID         : Protocol ID 
	 * @return 
	 */
	public static JSONObject getBalance(String strUserWID,String strPID)
	{
		// CPTrans : { "ver":"10000","tid":"TX_...","ttm":XXXX, "wid":"WA_...","val":xxx,"flg":xxxx,
		//			"amt":xxx,"dmt":xxx,"msg":"....","Memo":"xxx","sig":"xxxx" }
		 
		// 관리자가 사용자 지갑 잔고 확인 "ver","wid","nonce","sig","man300_pubk"
		// {"query_type":"query","func_name":"stateTrans","func_args":["PID","10000",...]}
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		String[] args = new String[] {
				"PID","10000",strUserWID,"","","" 
			};	
		args[0] = strPID;
		args[1] = sm_strVer;
		joQuery.put("query_type","query");
		joQuery.put("func_name","stateTrans");
		if(!putQuerySignature(args,false,KeyManager.getPrivateKey(CPAPI_LEVEL.emMan300)))
			return null;
		
		for( String strArg : args)
		{
			jaParam.add(strArg);
		}
		joQuery.put("func_args", jaParam);

		JSONObject joValue = null;
		JSONObject joRes = postJSON(joQuery);
		if(joRes != null)
		{
			long nCode = (Long)joRes.getOrDefault("ec",-1L);
			if(nCode == 0)
			{
				String strValue = (String)joRes.getOrDefault("value","{}");
				JSONParser jaTemp = new JSONParser();

				try
				{
					joValue = (JSONObject)jaTemp.parse(strValue);
				} 
				catch (ParseException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		//CPWorkbench.logMessage("getNonce:" + strResponse);
		return joValue;
	}
	
	/**
	 * 
	 * @param strFuncType   : query , invoke
	 * @return
	 */
	public static String getNonce(String strFuncType)
	{
	   // {"query_type":"query","func_name":"getNonce","func_args":["PID","10000","query"]}
		assert(strFuncType.equals("query") || strFuncType.equals("invoke"));
		JSONObject joQuery = new JSONObject();
		JSONArray jaParam = new JSONArray();
		joQuery.put("query_type","query");
		joQuery.put("func_name","getNonce");

		jaParam.add("PID");
		jaParam.add("10000");
		jaParam.add(strFuncType);
		joQuery.put("func_args", jaParam);
		
		String strNonce = "";
		JSONObject joRes = postJSON(joQuery);
		if(joRes != null)
		{
			long nCode = (Long)joRes.getOrDefault("ec",-1);
			if(nCode == 0)
			{
				String strValue = (String)joRes.getOrDefault("value","{}");
				JSONParser jaTemp = new JSONParser();
				JSONObject joNonce = null;
				try
				{
					joNonce = (JSONObject)jaTemp.parse(strValue);
				} 
				catch (ParseException e)
				{
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(joNonce != null)
					strNonce = (String)joNonce.getOrDefault("nonce","");
			}
		}
		// CPWorkbench.logMessage("getNonce:" + strNonce);
		return strNonce;
	}

	public static JSONObject postJSON(JSONObject joQuery)
	{
	    //  {"query_type":"query","func_name":"func_name","func_args":["PID","10000",....]}
		// -------------------
		String strUrl = FouriProperties.getProjectApiHost();
		JSONObject joResponse = null;
		byte[] bytResponse = null;
		HttpClient client = new HttpClient();
		PostMethod method = new PostMethod(strUrl);
		method.setRequestHeader("Content-type", "application/json");
		String strQuery = joQuery.toString();
		method.setRequestEntity( new StringRequestEntity( strQuery ) );
		try
		{
			LogUtil.d(sm_Log,strQuery);
			int statusCode = client.executeMethod(method); // url에 지정한
															// 사이트에 접속함
			if (statusCode == HttpStatus.SC_OK)
			{
				InputStream is = method.getResponseBodyAsStream();
				bytResponse = EtcUtils.readFile(is);
			}
			else
			{
				System.out.println("fail : " + statusCode + " : url : " +  strUrl );
			}
		}
		catch (HttpException e1)
		{
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		catch (IOException e2)
		{
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		finally
		{
			if (method != null)
				method.releaseConnection();
		}
		
//		String strReturn = "";

		if(bytResponse != null)
		{
			try
			{
				String strResponse = new String(bytResponse,"utf-8").trim();
				if(!strResponse.startsWith("{") )
				{  // nodejs query  실패 상황이다.
					strResponse.replace('\"', '\'');
					strResponse = "{ \"ec\":-1,\"value\":\"{}\",\"ref\":\"" + strResponse + "\" }";
				}
				JSONParser paRes = new JSONParser();
				joResponse = (JSONObject) paRes.parse(strResponse);
			}
			catch (UnsupportedEncodingException e)
			{
				e.printStackTrace();
			}
			catch (ParseException e)
			{
				e.printStackTrace();
			}
		}
		return joResponse;
	}
	
	private static SimpleRandomSource sm_rndSource = new SimpleRandomSource();
	public static boolean putInvokeSignature(String[] args, boolean bNeedReqNonce,InMemoryPrivateKey priKey)
	{
		return putSignature(args,bNeedReqNonce,"invoke",priKey);	
	}
	public static boolean putQuerySignature(String[] args, boolean bNeedReqNonce,InMemoryPrivateKey priKey)
	{
		return putSignature(args,bNeedReqNonce,"query",priKey);	
	}

	private static boolean putSignature(String[] args, boolean bNeedReqNonce,String strFuncType,InMemoryPrivateKey priKey)
	{
	
		if(priKey == null)
			return false;
		
		String strNonce = "";
		if(bNeedReqNonce)
		{
			strNonce = getNonce(strFuncType);
			if(strNonce.isEmpty())
				return false;
		}
		else
		{
			strNonce = Base58.encode(sm_rndSource.nextBytes()).substring(0, 10);
		}
		StringBuffer strbContent = new StringBuffer();
		args[args.length-3] = strNonce;
		for(int i = 1; i < args.length-2 ; i ++)
		{
			strbContent.append(args[i]);
		}
	
		Sha256Hash toSign = HashUtils.sha256(strbContent.toString().getBytes());
		Signature sig = priKey.generateSignature(toSign);
		String strSig = Base58.encode(sig.derEncode());
		String strPubK = PublicKeyHelper.getBase58EncodedPublicKey(priKey.getPublicKey(), NetConfig.defaultNet);
		args[args.length-2] = strSig;
		args[args.length-1] = strPubK;
		
		return true;
	}
	
	public static boolean putSignatureWithNonce(String[] args, String strNonce, InMemoryPrivateKey priKey)
	{
	
		if(priKey == null)
			return false;
		
		StringBuffer strbContent = new StringBuffer();
		args[args.length-3] = strNonce;
		for(int i = 1; i < args.length-2 ; i ++)
		{
			strbContent.append(args[i]);
		}
	
		Sha256Hash toSign = HashUtils.sha256(strbContent.toString().getBytes());
		Signature sig = priKey.generateSignature(toSign);
		String strSig = Base58.encode(sig.derEncode());
		String strPubK = PublicKeyHelper.getBase58EncodedPublicKey(priKey.getPublicKey(), NetConfig.defaultNet);
		args[args.length-2] = strSig;
		args[args.length-1] = strPubK;
		
		return true;
	}
	
}
