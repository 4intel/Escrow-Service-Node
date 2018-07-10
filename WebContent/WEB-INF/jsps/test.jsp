<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<title><spring:message code="title.search" /></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>
<body >

	<table>
	<c:forEach items="${noticeList}" var="noticeInfo" varStatus="status">
	<tr>
		<td><c:out value='${noticeInfo.NTT_ID}'/></td>
		<td><c:out value='${noticeInfo.NTT_CN}'/></td>		
	</tr>
	</c:forEach>
	</table>
	
</body>
</html>