<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%> 
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.common.util.KeyManager"%>
<%@ page import="fouri.com.common.util.DateUtil"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="fouri.com.cpwallet.web.CPWalletUtil"%>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
String strPID = request.getParameter("pid"); // PID
String strVER = request.getParameter("ver"); // VER
String strSDATE = "2017-12-15"; // 시작일
String strEDATE = DateUtil.getPlusMinusDate(DateUtil.getDate("yyyyMMdd"), 1, "yyyy-MM-dd"); // 종료일
System.out.println(strEDATE);
String strNEWSORT = "Y"; // 최신순
String strRECORDSTARTNUMBER = "0"; // 레코드시작번호
String strRECORDCOUNT = "100"; // 레코드갯수
String strTgwid = request.getParameter("tgwid");

JSONObject joQuery = new JSONObject();
JSONArray jaParam = new JSONArray();

String[] args = null; //{strPID,"10000",strUserWID,sdate,edate,"Y","0","30","","",""}
args = new String[] {"PID","10000",strTgwid,strSDATE,strEDATE,strNEWSORT,strRECORDSTARTNUMBER,strRECORDCOUNT,"","",""};

if(!ApiHelper.putQuerySignature(args,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300))) {
	//return null;
}

joQuery.put("query_type","query");    
joQuery.put("func_name","historyTransE");   // { "query_type": "query", "func_name": "historyTransE" }

String strResult = "";
for( String strArg : args) {
	jaParam.add(strArg);
}
joQuery.put("func_args", jaParam);  

JSONObject joRes = ApiHelper.postJSON(joQuery);
//System.out.println("joRes : "+joRes);
strResult += joRes;

JSONParser parser = new JSONParser();
if(joRes != null) {
	long nCode = (Long)joRes.getOrDefault("ec",-1L);
	if(nCode == 0) {
		String strValue = (String)joRes.getOrDefault("value","{}");
		joRes = (JSONObject)parser.parse(strValue);
		strValue = "";
		if(joRes!=null) {
			strValue = joRes.get("Record").toString();	
		}
		out.clear();
		out.println(strValue.toString());
	} 
}

%>