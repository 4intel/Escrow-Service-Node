<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.Random"%>
<%@ page import="fouri.com.common.util.StringUtil"%>
<%@ page import="fouri.com.common.util.FileUtil"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
	out.clear();
	out.print("{ \"result\":\"ACCEPT\" }");

	String svrCd = StringUtil.nvl(request.getParameter("svrcd"));
	
	String strFail = "{ \"result\":\"FAIL\" }";
	String strOK   = "{ \"result\":\"ACCEPT\" }";
	
	String sroot = application.getRealPath("");
	sroot = sroot.replaceAll("\\\\", "/");

	String strOS = System.getProperty("os.name");
	if(strOS.indexOf("Windows")>-1) {
		if(sroot.indexOf(".metadata")>-1) {	// 개발 로컬일 경우
			sroot = "D:/Git/EscrowWallet-WEB/EscrowWallet/build/classes";
		} else {	// 서버 적용된 경우
			sroot = sroot + "WEB-INF/classes";
		}
	} else if((strOS.trim()).equalsIgnoreCase("Linux")) {
		sroot = sroot + "WEB-INF/classes";
	}

	String str = FileUtil.roadLocalFile(sroot+"/fouri/fouriProps/hosts.properties");
	str = str.replaceAll("\n", ",");
	String[] hosts = null;
	str = str.substring(0,str.length()-1);
	hosts = str.split(",");
	
	out.clear();
	if(svrCd==null || svrCd.equals("")) {
		out.println(strOK.toString());
	} else if(svrCd.equals("cpw_001")) {	// host list
		if(str!=null && str.length()>0) {
			if(hosts.length>1) {
				String returnUrl = "";
				for(int s=0; s<hosts.length; s++) {
					returnUrl+= "\"" + hosts[s].toString() + "\",";
				}
				if(returnUrl.length()>0) returnUrl = returnUrl.substring(0,returnUrl.length()-1);
				out.print("{ \"result\":\"ACCEPT\",\"list\":["+returnUrl+"] }");	
			} else {
				out.println(strOK.toString());	
			}
		} else {
			out.println(strFail.toString());	
		}
		/*
		Random random = new Random();
		int i = random.nextInt(hosts.length);
		out.println("{ \"result\":\"" + hosts[i].toString() +"\" }");
		*/
	} else { 
		out.println(strOK);
		
	}
	
%>
