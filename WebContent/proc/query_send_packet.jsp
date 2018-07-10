<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%

	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
//------------------------
/*
// 세션없이 허가하면 안되지만 세션유지가 어려울 수도 있으므로...
HttpSession p_Session = request.getSession(false);
if(p_Session == null)
{
	out.println("FAIL");
	return;
}
String strAID = (String)p_Session.getAttribute("ID");
if(strAID == null)
{
	strAID = request.getParameter("id"); // 세션 유지가 힘들수도...
}

if(strAID == null)
{
	out.println("FAIL");
	return;
}
*/
    ByteArrayOutputStream osBuffer = new ByteArrayOutputStream();
    byte[] bytTemp = new byte[2048];
    int nReadBytes = 0;
    ServletInputStream is =  request.getInputStream();
    while((nReadBytes = is.read(bytTemp)) > 0)
    {
    	osBuffer.write(bytTemp,0,nReadBytes);
    }

    byte[] bytQuery = osBuffer.toByteArray();
    String strResponse = "";
    String strContents = new String(bytQuery,"utf8");
    JSONParser jpTemp = new JSONParser();
    JSONObject joReq = (JSONObject)jpTemp.parse(strContents);
    System.out.println(strContents);
    JSONObject joRes =  ApiHelper.postJSON(joReq);
    if(joRes != null)
    	strResponse = joRes.toJSONString();
    else
    	strResponse = "{\"ec\":-1}";
    out.flush();
    out.println(strResponse);
    System.out.println("strResponse : "+strResponse);
%>
