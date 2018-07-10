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

String wid = request.getParameter("wid");

String strPID = "P001";
JSONObject joResult = null;
joResult = CPWalletUtil.getWalletName(strPID,request.getParameter("wid"));

long nCode = (Long)joResult.getOrDefault("ec",-1L);
if(nCode==0) {
	String strValue = "";
	if(joResult!=null) {
		strValue = (String)joResult.getOrDefault("value","{}");	
	}
	out.println(strValue);	
} else {
	out.println("{\"nm\":\"\"}");	
}
%>