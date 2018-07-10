<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<title>Escrow</title>
		
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="../js/cpwallet/app_interface.js"></script>
		
		<link rel="stylesheet" href="/css/cpwallet/bootstrap.css">
		<link rel="stylesheet" href="/css/menu.css">
		
		<script>
		function productList() {
			if(confirm("구매자 제품목록은 휴대폰 앱에서 실행하는 화면입니다.")) {
				window.open("/mbbs.do","","");
			}			
		}
		</script>
	</head>
	<body>

		<div class='menu'>
			<ul>
				<li>
					<a href='/index.do?curl=/intro/intro.do'>Introduction</a>
					<ul>
						<li class='sub'>
							<a href='/index.do?curl=/intro/intro.do'>소개</a>
						</li>
						<li class='sub'>
							<a href='/index.do?curl=/intro/escrow.do'>에스크로 도움말</a>
						</li>
						<li class='sub'>
							<a href='/index.do?curl=/intro/direct.do'>직거래 도움말</a>
						</li>
					</ul>
				</li>
				<li class='active sub'>
					<a href='/index.do?curl=/bbs.do'>에스크로 거래</a>
					<ul>
						<li class='sub'>
							<a href='/index.do?curl=/bbs.do'>Seller</a>
							<ul>
								<li>
									<a href='/index.do?curl=/bbs.do'>물품 등록관리</a>
								</li>
								<li class='last'>
									<a href='/index.do?curl=/escrow/seller/trans_list.do'>판매 거래내역</a>
								</li>
							</ul>
						</li>
						<li class='sub'>
							<a href='/index.do?curl=/escrow/buyer/trans_list.do'>Buyer</a>
							<ul>
								<li>
									<a href='#none' onclick="javascript:productList();">제품목록</a>
								</li>
								<li class='last'>
									<a href='/index.do?curl=/escrow/buyer/trans_list.do'>구매내역관리</a>
								</li>
							</ul>
						</li>
						<li class='sub'>
							<a href='/index.do?curl=/escrow/system/trans_list.do'>Escrow System</a>
							<ul>
								<li class='last'>
									<a href='/index.do?curl=/escrow/system/trans_list.do'>거래현황</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li class='active sub'>
					<a href='/index.do?curl=/direct/seller/trans_board.do'>직거래</a>
					<ul>
						<li class='sub'>
							<a href='/index.do?curl=/direct/seller/trans_board.do'>Seller</a>
							<ul>
								<li>
									<a href='/index.do?curl=/direct/seller/trans_list.do'>거래내역</a>
								</li>
								<li class='last'>
									<a href='/index.do?curl=/direct/seller/trans_board.do'>판매자 거래화면</a>
								</li>
							</ul>
						</li>
						<li class='sub'>
							<a href='/index.do?curl=/direct/buyer/trans_board.do'>Buyer</a>
							<ul>
								<li class='last'>
									<a href='/index.do?curl=/direct/buyer/trans_board.do'>구매자 거래화면</a>
								</li>
							</ul>
						</li>
					</ul>
				</li>
				<li>
					<a href='http://escrowdev.coinpool.world' target="_blank">API Reference</a>
				</li>
			</ul>
		</div>
		
		<c:if test="${not empty curl && curl!='' }">
				<c:import url="${curl}">
				</c:import>
		</c:if>
				
				
	</body>
</html>