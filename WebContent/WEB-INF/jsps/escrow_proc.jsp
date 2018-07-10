<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="fouri.com.cmm.service.FouriProperties"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="fouri.com.common.util.KeyManager"%>
<%
String nCode = (String)request.getAttribute("nCode");
if(nCode==null) nCode="";
if(nCode.equals("0")) {
	out.print("<script>alert('성공');</script>");
} else {
	out.print("<script>alert('실패 ["+nCode+"]');</script>");
}
%>
<script>
location.href="/escrow.do";
</script>
