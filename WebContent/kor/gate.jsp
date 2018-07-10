<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ include file="lang.jsp" %> 

<%
HttpSession loginsession = request.getSession(true); // true : 없으면 세션 새로 만듦

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

//-------------------------------------
String strRedirectResponse = null;
String strAccountID = EtcUtils.NullS(request.getParameter("aid"));
String strWID = EtcUtils.NullS(request.getParameter("wid"));
String strDID = EtcUtils.NullS(request.getParameter("did"));
String strOS = EtcUtils.NullS(request.getParameter("os"));

loginsession.setAttribute("AID", strAccountID); // 임시 세션을 만들어 주고 
loginsession.setAttribute("WID",strWID); // 임시 세션을 만들어 주고 
loginsession.setAttribute("DID", strDID);	
loginsession.setAttribute("OS", strOS);
	
//strDID.isEmpty() || 
if(strOS.isEmpty()) {
	response.sendRedirect("sorry.jsp");
	return;
}

response.sendRedirect("login.jsp");
%>
