<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>      

<%
//-----------------------------	
// 사이트의 언어지원 접근 URLPATH를 리턴한다.
// 현재는 모두 한글 "kor" 만 지원
    String strLocale = "lang=kor";
	String strLang = EtcUtils.NullS(request.getParameter("locale"),"ko_KR");

    if(strLang.equals("ko_KR"))
    {
        strLocale = "lang=kor";
    }
	out.println(strLocale);
%>
