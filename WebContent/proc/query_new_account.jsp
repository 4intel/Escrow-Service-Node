<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.cpwallet.web.CPWalletUtil"%>
<%
/*
	HttpSession p_Session = request.getSession(false);
	if(p_Session == null)
	{
		out.println("FAIL");
		return;
	}
	String strWID = (String)p_Session.getAttribute("WID");
	if(strWID == null)
	{
		strWID = request.getParameter("wid"); // 세션 유지가 힘들수도...
	}

	if(strWID == null)
	{
		out.println("FAIL");
		return;
	}

*/
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
	String strFAIL = "{ \"result\":\"FAIL\" }";
	String strOK = "{ \"result\":\"OK\" }";
	// 세션없이 저장요청이 있을 수도 있다
	// 원래 허가하면 안되지만 세션유지가 어려울 수도 있으므로...
	// "rid=xxx&wid=xxx&did=xxx&os=android&inf=Samsung S6";
	String strAID=EtcUtils.NullS(request.getParameter("aid"));
	String strWID=EtcUtils.NullS(request.getParameter("wid"));
	int    nCID=EtcUtils.parserInt(request.getParameter("cid"),0);
	String strDID=EtcUtils.NullS(request.getParameter("did"));
	String strPID = EtcUtils.NullS(request.getParameter("pid")); // push id
	String strOS=EtcUtils.NullS(request.getParameter("os"));
	String strComment=EtcUtils.NullS(request.getParameter("inf"));
	String strName=EtcUtils.NullS(request.getParameter("name"),"지갑");

	if(strWID.isEmpty() || strAID.isEmpty()) {
		out.println(strFAIL);
		return;
	}
	//-----------------------------	

	// --- 지갑생성
	JSONObject joResult = null;
	if(strPID.equals("")) strPID = "P001";
	joResult = CPWalletUtil.createWallet(strPID,strWID,Integer.toString(nCID),strName+"");
	System.out.println("joResult : "+joResult.toString());

	long nCode = (Long)joResult.getOrDefault("ec",-1L);
	if(nCode==0) {
		out.println(strOK);
	} else {
		out.println(strFAIL);
	}
%>
