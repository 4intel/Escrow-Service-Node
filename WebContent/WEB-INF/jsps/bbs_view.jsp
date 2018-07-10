<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% pageContext.setAttribute("crlf", "\r\n"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>

<script type="text/javascript" src="/js/qr/jquery.qrcode.js"></script>
<script type="text/javascript" src="/js/qr/qrcode.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
<script type="text/javascript">
/* ********************************************************
 * 삭제처리
 ******************************************************** */
 function fn_egov_delete_article(BOARD_NUM){
	if(confirm("삭제하시겠습니까?")){	
		// Delete하기 위한 키값을 셋팅
		// form.submit();
		location.href='/index.do?curl=/bbsDeleteArticle.do?boardNum='+BOARD_NUM;
	}	
}
</script>
</head>
<body>
	<div class="container">
		<h3>판매 물품 목록 > 상세정보</h3>
		
		<div class="col-lg-4"></div>
		<div class="col-lg-12">
			<div class="jumbotron" style="padding-top: 20px;">

				<div class="row">				    
					<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3" style="background-color: #eeeeee; text-align: center;">에스크로 게시판 글 보기</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>작성자</td>
								<td colspan="2" style="text-align: left;"><c:out value='${bbsView.BOARD_NAME}'/></td>
							</tr>
							<tr>
								<td>작성일자</td>
								<td colspan="2" style="text-align: left;"><c:out value='${bbsView.BOARD_DATE}'/></td>
							</tr>
							<tr>
								<td>마켓</td>
								<td colspan="2" style="text-align: left;"><c:out value='${bbsView.BOARD_MARKET}'/></td>
							</tr>
							<tr>
								<td style="width: 20%;">상품명</td>
								<td colspan="2" style="text-align: left;"><c:out value='${bbsView.BOARD_SUBJECT}'/></td>
							</tr>							
							<tr>
								<td>금액</td>
								<td colspan="2" style="text-align: left;"><fmt:formatNumber value="${bbsView.BOARD_PRICE}" groupingUsed="true" /></td>
							</tr>
							<tr>
								<td>설명</td>
								<td colspan="2" style="text-align: left;"><c:out value="${fn:replace(bbsView.BOARD_CONTENT , crlf , '<br/>')}" escapeXml="false" /></td>
							</tr>
						</tbody>					
					</table>
					<div id="qrcodeTable"></div>
										
					<script>
					//jQuery('#qrcodeTable').qrcode({
					//	render	: "table",
					//	text	: "<c:out value='${bbsView.BOARD_WALLETID}'/>"
					//});	
					</script>

					<div style="text-align: center;">
						<a href="/index.do?curl=/bbs.do" class="btn btn-primary">목록</a>
						<a href="/index.do?curl=/bbsUpdateArticleView.do?boardNum=<c:out value='${bbsView.BOARD_NUM}'/>" class="btn btn-primary">수정</a>
						<a href="javascript:onclick=fn_egov_delete_article('<c:out value='${bbsView.BOARD_NUM}'/>');" class="btn btn-primary">삭제</a>
					</div>
				</div>
					
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>