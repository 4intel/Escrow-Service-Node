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
<script src="/js/cpwallet/app_interface.js"></script>

<script type="text/javascript" src="/js/qr/jquery.qrcode.js"></script>
<script type="text/javascript" src="/js/qr/qrcode.js"></script>

<title>Escrow Bbs</title>
<script type="text/javascript">
</script>
</head>
<body style="background-color:#eeeeee;">
	<div class="container">
		<div class="col-lg-12">
			<div class="jumbotron" style="padding-top: 20px;text-align: center;">
				<h3>상품 상세정보</h3>
				
				<div style="background-color:#ffffff;padding:10px 10px 10px 10px;">
					<table class="table" style="text-align: center;width:100%;">
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
								<td style="width: 30%;">상품명</td>
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

					<div style="text-align: center;">
						<a href="/mbbsPayment.do?boardNum=<c:out value='${bbsView.BOARD_NUM}'/>" class="btn btn-primary">구매하기</a>
					</div>
				</div>
					
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>