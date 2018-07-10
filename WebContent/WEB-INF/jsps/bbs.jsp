<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<title>Escrow Bbs</title>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
</head>
<body>
	<div class="container">
		
		<h3>판매 물품 목록</h3>
		
		<div class="col-lg-4"></div>
		<div class="col-lg-12">
			<div class="jumbotron" style="padding-top: 20px;">

				<div class="row">				    
					<table class="table table-striped" style="text-align: center; border:1px solid #ffffff">
						<thead>
							<tr style="background-color: #337ab7;color:#ffffff;">
								<th width="10%" style="text-align: center;">번호</th>
								<th style="text-align: center;">마켓</th>
								<th style="text-align: center;">상품명</th>
								<th style="text-align: center;">가격</th>
								<th width="10%" style="text-align: center;">작성자</th>
								<th width="10%" style="text-align: center;">판매수</th>
								<th width="20%" style="text-align: center;">작성일</th>
							</tr>						
						</thead>
						<tbody id='id_accountlist_table_tbody'>
						    <c:forEach items="${bbsList}" var="bbsListInfo" varStatus="status">
							<tr style="background-color:#ffffff;">
								<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td><c:out value='${bbsListInfo.BOARD_MARKET}'/></td>
								<td style="text-align:center;vertical-align:middle;word-break:break-all;"><a href="/index.do?curl=/bbsViewArticle.do?boardNum=<c:out value='${bbsListInfo.BOARD_NUM}'/>"><c:out value='${bbsListInfo.BOARD_SUBJECT}'/></a></td>
								<td><fmt:formatNumber value="${bbsListInfo.BOARD_PRICE}" groupingUsed="true" /></td>
								<td><c:out value='${bbsListInfo.BOARD_NAME}'/></td>
								<td><c:out value='${bbsListInfo.BOARD_READCOUNT}'/></td>
								<td><c:out value='${bbsListInfo.BOARD_DATE}'/></td>
							</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!--페이징 시작--> 
					<%
					String p_link_script = "fn_select_list";			// Link URL (한글이 포함된 파라메터가 있는 경우 post 방식으로 사용)
					String p_formObjectId = "frm";						// Form name
					String p_pageObjectId = "pageIndex";				// 페이징 번호 객체
					String p_link_url = "/index.do?curl=/bbs.do";								// Link URL
					String[] p_str = null;								// 파라메터
					%>
					<%@include file="/include/pagebar.jsp" %>
					<!--페이징 끝-->
		
					<a href="/index.do?curl=/bbsWriteArticleView.do" class="btn btn-primary pull-right">신규등록</a>
				</div>
					
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>