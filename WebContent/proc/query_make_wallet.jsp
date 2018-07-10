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

String aid = request.getParameter("aid");
String wid = request.getParameter("wid");
String cid = request.getParameter("cid");
String wname = request.getParameter("wname");
String dinfo = request.getParameter("dinfo");

// --- 지갑생성
String strPID = "P001";
JSONObject joResult = null;
joResult = CPWalletUtil.createWallet(strPID,request.getParameter("wid"),request.getParameter("cid"),request.getParameter("wname"));
System.out.println("makeResult : "+joResult.toString());

long nCode = (Long)joResult.getOrDefault("ec",-1L);
if(nCode==0) {
	JSONObject joR = null;
	joR = new JSONObject();
	joR.put("result","OK");
	joR.put("ref",joResult.get("ref"));
	joR.put("ec",joResult.get("ec"));
	joR.put("Exist","");
	out.clear();
	out.println(joR.toString());
} else {
	JSONObject joR = null;
	joR = new JSONObject();
	joR.put("result","FAIL");
	joR.put("ref",joResult.get("ref"));
	if(((String)joResult.get("ref")).indexOf("Exist wallet already")>-1) joR.put("Exist","Exist wallet already");
	else joR.put("Exist","");
	joR.put("ec",joResult.get("ec"));
	out.clear();
	out.println(joR.toString());
}

%>