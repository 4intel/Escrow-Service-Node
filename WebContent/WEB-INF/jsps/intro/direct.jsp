<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="../js/cpwallet/app_interface.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
h5 {
	color:#666;font-size:18px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
h7 {
	color:#0000a6;font-size:18px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
li { list-style:none; }
.p_depth0 {
	padding-left:20px;
}
.p_depth1 {
	padding-left:20px;
}
.menuindex {
	font-size:9pt;
	padding-left:20px;
	color:#0000C9;
}
.imgz {position:relative;width:528px;text-align:center;}
.roundNum {
	position:absolute;
	width:20px;height:20px;
    -webkit-border-radius: 10px;
    -moz-border-radius: 10px;
    -ms-border-radius: 10px;
    -o-border-radius: 10px;
    border-radius: 10px;
    background:#9A0000;
    color:#fff;
    text-align:center;
}
</style>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	
	<script>
	</script>

	<div class="container">
		<h3>직거래 이용 도움말</h3>
		<br/>
		
		<h5>직거래 이용을 위한 준비</h5>
		<br/>
		
		<div class="p_depth0">
			<div class="p_depth1">
				<p>1. 직거래도 에스크로 거래와 마찬가지로 판매자와, 구매자 지갑을 필요로 합니다.</p>
				<p>2. 판매자와 구매자 지갑은 각각 모바일 앱에서 계정 생성을 해야 하며, 지갑 ID는 모바일 앱 [QR코드]메뉴에서 확인 가능합니다. 계정(지갑 ID) 생성은 "에스크로 도움말" 메뉴 참고 </p>
			</div>
		</div>
		<br/>
		
		<h5>직거래 서비스 이용 절차</h5>
		<br/>
		
		<div class="p_depth0">
			<h7>[판매자 상품관리]</h7>
			<p style="clear:both;"></p>
		
			<p style="clear:both;">1. 판매자 거래화면 구조</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_143615.png" style="border:1px solid #ccc;width:528px;"/>
					<div style="position:absolute;left:10px;top:56px;width:497px;height:37px;border:1px solid red;"></div>
					<div style="position:absolute;left:10px;top:95px;width:255px;height:275px;border:1px solid red;"></div>
					<div style="position:absolute;left:271px;top:95px;width:245px;height:275px;border:1px solid red;"></div>
					<div class="roundNum" style="left:418px;top:62px;">1</div>
					<div class="roundNum" style="left:15px;top:100px;">2</div> 
					<div class="roundNum" style="left:495px;top:100px;">3</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>접근경로 : 직거래 > Seller > 판매자 거래화면</p>
					<p>1. 판매자 지갑ID를 입력합니다.</p>
					<p>2. 직거래시 주문서를 추가 하는 부분입니다.</p>
					<p>3. 주문에 필요한 상품을 관리하는 부분입니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
		
			<p style="clear:both;">2. 상품을 추가 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_144503.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:204px;top:318px;">1</div>
					<div class="roundNum" style="left:357px;top:318px;">2</div> 
					<div class="roundNum" style="left:155px;top:368px;">3</div>
					<div class="roundNum" style="left:309px;top:368px;">4</div>
					<div class="roundNum" style="left:215px;top:94px;">5</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 추가할 메뉴명을 입력 합니다.</p>
					<p>2. 추가할 메뉴의 단가를 입력 합니다.</p>
					<p>3. [메뉴추가]버튼 클릭 시 입력한 메뉴를 메뉴 목록에 추가 합니다.</p>
					<p>4. [메뉴삭제]버튼 클릭 시 ⑤번 체크박스에 체크한 상품을 삭제합니다.</p>
					<p>5. 상품을 삭제할때 선택을 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
		
			<h7>[판매자 거래 기능]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 상품을 선택 하여 주문목록에 추가 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_145121.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:278px;top:105px;">1</div>
					<div class="roundNum" style="left:153px;top:153px;">5</div> 
					<div class="roundNum" style="left:137px;top:255px;">2</div>
					<div class="roundNum" style="left:113px;top:272px;">3</div>
					<div class="roundNum" style="left:60px;top:311px;">4</div>
					<div class="roundNum" style="left:60px;top:334px;">6</div>
					<div class="roundNum" style="left:172px;top:334px;">7</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 원하는 상품을 선택 합니다. 선택 하면 왼쪽 ②번에 영역 메뉴명과 단가가 설정 됩니다.</p>
					<p>2. 오른쪽 메뉴 목록에서 선택된 상품이 자동 입력 됩니다.</p>
					<p>3. +, - 키로 상품의 수량을 조정 합니다.</p>
					<p>4. 선택한 메뉴와 수량을 상단 ⑤번 영역에 추가 합니다. 상품은 여러개 선택이 가능합니다.</p>
					<p>5. 상품 목록이 표시 되는 영역 입니다.</p>
					<p>6. [주문서전송]버튼 클릭 시 ⑤번영역에 선택한 상품으로 구매자 화면으로 전송합니다.</p>
					<p>7. [초기화]버튼 클릭 시 주문 진행중이건 모든 건들을 초기화하고 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 주문서 전송</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_150118.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:249px;top:148px;">1</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 구매자가 결제하기를 기다리는 결제 대기 화면 입니다. 구매자가 결제하는 순간 결제 완료 메세지와 함께 거래는 종료 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			<h7>[오프라인 구매자의 결제 진행]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 구매자 화면의 기본 화면</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_150052.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:249px;top:148px;">1</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 구매자가 결제하는 화면입니다. 기본 비어 있지만 판매자가 주문서를 전송하면 자동으로 QR코드와 상품목록이 표시 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 판매자가 주문서 전송</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_150300.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:50px;top:59px;">1</div>
					<div class="roundNum" style="left:335px;top:123px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 전송되온 상품 목록 입니다.</p>
					<p>2. 판매자의 지갑 ID qr 코드 입니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">3. 앱을 실행하고 결제를 진행합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/Screenshot_20180323-150403.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/Screenshot_20180323-150414.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:151px;top:200px;">1</div>
					<div class="roundNum" style="left:387px;top:177px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [주문결제]버튼을 클릭 합니다.</p>
					<p>2. [QR코드]버튼을 클릭 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">4. 구매자 화면의 QR코드를 스캔 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/Screenshot_20180323-150429.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/Screenshot_20180323-150446.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:151px;top:200px;">1</div>
					<div class="roundNum" style="left:317px;top:177px;">2</div>
					<div class="roundNum" style="left:348px;top:271px;">3</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 화면의 QR코드를 스캔합니다.</p>
					<p>2. 스캔이 완료 되고 입금지갑 항목에 입금계좌 이름을 확인 합니다.</p>
					<p>3. [송금]버튼을 클릭 하면 송금이 진행 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">4. 구매자 화면의 QR코드를 스캔 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/Screenshot_20180323-150508.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/Screenshot_20180323-150522.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:84px;top:318px;">1</div>
					<div class="roundNum" style="left:383px;top:88px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 입금 정보를 확인 하고 [보내기] 버튼을 클릭 합니다.</p>
					<p>2. 전송이 완료 되면 성공 메세지와 함께 거래가 종료 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			<h7>[판매자 결제 진행 완료]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 구매자 결제 대기</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_150118.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:249px;top:148px;">1</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 구매자가 결제하기를 기다리는 결제 대기 화면 입니다. 구매자가 결제하는 순간 결제 완료 메세지와 함께 거래는 종료 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 결제 진행 완료</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_150548.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:209px;top:130px;">1</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 결제자가 앱에서 결제를 진행하면 판매자 화면에서 자동으로 화면이 갱신되며, 결제자 이름, 입금 금액이 자동 표시 됩니다. [확인] 버튼 클릭 시 팝업이 닫히며 화면이 초기화 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">3. 판매자 거래내역 확인</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_153021.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:24px;top:72px;">1</div>
					<div class="roundNum" style="left:24px;top:102px;">2</div>
					<div class="roundNum" style="left:275px;top:181px;">3</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>접근경로 : 직거래 > Seller > 거래내역</p>
					<p>1. 판매자의 개인 지갑 ID입력란 입니다.</p>
					<p>2. [거래내역조회]버튼 클릭 시 해당 지갑 ID로 거래내역을 아래 목록으로 조회 합니다.</p>
					<p>3. 해당 거래건을 확인 할 수 있습니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			
		</div>
	
	
	
	
	</div>
