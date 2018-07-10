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
		<h3>에스크로 거래 이용 도움말</h3>
		<br/>
		
		<h5>에스크로 시스템의 구성</h5>
		<br/> 
		
		<div class="p_depth0">
			<p>1. http://escrow.coinpool.world 사이트</p>
			<div class="p_depth1">
				<p>1. 에스크로 거래(판매자, 구매자)의 관리합니다.</p> 
				<p>2. 오프라인 직거래의 판매자 상품 관리, 구매자 구매 기능을 합니다.</p>
				<p>3. 해당 사이트는 회원제로 이용하지 않습니다. 서비스 시연을 목적으로 운영중입니다.</p>
			</div>
			<br/>
			
			<p>2. CPEscrow 모바일 앱</p>
			<div class="p_depth1">
				<p>1. 사용자간 직접 송금을 합니다.</p>
				<p>2. 에스크로 물품 구매하고 송금을 합니다.</p>
				<p>3. 거래내역 조회 및 개인 QR Code를 조회 합니다.</p>
				<p>※   http://escrowdev.coinpool.world/#overview 참조.</p>
			</div>
			<br/>
		</div>
		
		<h5>에스크로 이용을 위한 준비</h5>
		<br/>
		
		<div class="p_depth0">
			<p>1. 에스크로 사이트 접속 (현재 웹사이트)</p>
			<br/>
			
			<p>2. 앱 다운로드 및 계정 생성</p>
			<div class="p_depth1">
				<p>1. http://escrowdev.coinpool.world/#overview 에 접속합니다.</p>
				<p>2. Android app 사용법에 따라 계정을 생성 합니다.</p>
				<p>3. 계정생성은 본 테스트를 진행할 판매자, 구매자 모두 각각 앱에서 계정생성을 해야 합니다.</p>
				<p>4. 시스템 관리자에게 구매자 지갑으로 구매를 위한 자금을 송금 받습니다.</p>
			</div>
		</div>
		<br/>
		
		<h5>에스크로 서비스 이용 절차</h5>
		<br/>
		
		<div class="p_depth0">
			<h7>[앱 다운로드 및 계정 생성]</h7>
			<p style="clear:both;"></p>
		
			<p style="clear:both;">1. escrow.coinpool.world 사이트에 접속합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_world_20180323_093313.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:465px;top:30px;">1</div>
					<div class="roundNum" style="left:105px;top:116px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 모바일 웹 브라우저에서 http://escrow.coinpool.world/ 사이트에 접속합니다.</p>
					<p>2. [Download APP] 버튼을 클릭 하고 앱을 다운로드 받습니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 앱을 다운로드 받습니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-094308.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-094330.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:190px;top:136px;">1</div>
					<div class="roundNum" style="left:272px;top:90px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [저장]버튼을 클릭 하고 다운로드를 진행 합니다.</p>
					<p>2. 상단 상태바를 ↓ 방향으로 드레그 하여 펼치고, 다운로드 된 파일을 선택 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">3. 설치를 시작합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-094357.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-094412.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:125px;top:116px;">1</div>
					<div class="roundNum" style="left:438px;top:265px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [출처를 알수 없는 앱]메뉴를 클릭 합니다.</p>
					<p>2. [허용]버튼을 클릭 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">4. 설치 완료 후 앱 열기를 실행 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-094443.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-094508.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:204px;top:362px;">1</div>
					<div class="roundNum" style="left:258px;top:10px;">2</div>
					<div class="roundNum" style="left:344px;top:112px;">3</div>
					<div class="roundNum" style="left:346px;top:198px;">4</div>
					<div class="roundNum" style="left:459px;top:10px;">5</div>
					<div class="roundNum" style="left:314px;top:254px;">6</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 설치가 완료된 후 [열기] 버튼을 클릭하여 앱을 실행합니다.</p>
					<p>2. [←]클릭 시 이전 페이지로 이동합니다.</p>
					<p>3. 비밀번호 입력란 입니다. 이 비밀번호는 휴대폰에 설치된 앱에 대한 비밀번호 입니다. 초기 비밀번호 <span style="color:red;">coinpool</span> 을 입력합니다.</p>
					<p>4. [LOGIN]버튼 클릭 시 로그인을 실행합니다.</p>
					<p>5. 단축 메뉴 아이콘을 클릭 시 앱의 메인메뉴가 나타납니다.</p>
					<p>6. 초기 비밀번호 에서 원하는 비밀번호로 변경하는 메뉴 입니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">5. 신규 계정을 생성 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-094619.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-094635.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:47px;top:169px;">1</div>
					<div class="roundNum" style="left:406px;top:135px;">2</div>
					<div class="roundNum" style="left:331px;top:160px;">3</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [계정생성]버튼을 클릭하여 신규 계정 생성 화면으로 이동합니다.</p>
					<p>2. 계정명 입력란 입니다. 원하는 계정명(닉네임)을 입력합니다.</p>
					<p>3. [Create]버튼을 클릭 하여 계정 생성을 완료 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">6. 생성한 계정을 선택합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-094919.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:225px;top:168px;">1</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [Confirm]버튼을 클릭 하여 기본 선택된 계정으로 진입합니다.</p>
					<p>※ 계정은 여러개 만들 수 있습니다. 1계정당 1지갑이 자동 할당되며 지갑은 1개만 생성, 소유할 수 있습니다.</p>
					<p>※ 이 계정은 판매자와 구매자 각각 다른 휴대폰과 다른 계정으로 생성해야 테스트가 가능합니다.</p>
					<p><span style="color:blue;">※ 구매자로 이용할 계정은 시스템 관리자에게 여유 자금을 입금 받아야 합니다.</span></p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			<h7>[판매자 물품 등록]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 판매자가 물품을 등록합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz">
					<img src="/images/help/escrow_1.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:95px;top:117px;">1</div>
					<div class="roundNum" style="left:425px;top:320px;">2</div></td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>http://escrow.coinpool.world 에 접속 합니다.</p>
					<p>접근경로 : 에스크로 거래 > Seller > 물품 등록관리</p>
					<p>1. 등록되 있는 물품 목록입니다. 클릭 시 상세페이지로 이동합니다.</p>
					<p>2. 물품 신규 등록 페이지로 이동합니다.</p></td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 판매자가 등록 페이지에서 새 상품을 등록합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz">
					<img src="/images/help/escrow_2.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:95px;top:190px;">1</div>
					<div class="roundNum" style="left:95px;top:292px;">2</div>
					<div class="roundNum" style="left:208px;top:315px;">3</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 지갑ID는 모바일 앱 > My Wallet List > QR코드 메뉴를 통해 조회가 가능합니다. 조회한 지갑 ID를 정확하게 입력합니다. (모바일 브라우저로 사이트 접속하여 새 상품 등록 시 앱에서의 텍스트를 복사,붙여넣기가 가능합니다.)</p>
					<p>2. 비밀번호는 등록하는 물품의 관리를 위해 필수 입력 입니다.</p>
					<p>3. 등록 버튼 클릭 시 블록체인에 저장 되며, 구매자 상품목록에 노출되게 됩니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			
			<h7>[구매자 물품 구매 및 확인]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 모바일 CPEscrow 앱을 실행합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-094934.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-094950.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:211px;top:4px;">1</div>
					<div class="roundNum" style="left:390px;top:93px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>모바일 앱 CPEscrow 에 접속 합니다.</p>
					<p>1. 단축메뉴를 클릭 합니다.</p>
					<p>2. [에스크로 사이트] 메뉴를 클릭 하여 상품 목록 화면으로 이동합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 원하는 상품을 선택 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-095002.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-095025.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:56px;top:205px;">1</div>
					<div class="roundNum" style="left:342px;top:212px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 원하는 상품을 선택 합니다.</p>
					<p>2. [구매하기] 버튼을 클릭 하고 구매 진행 화면으로 이동합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">3. 원하는 상품을 선택 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-101140.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-101309.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:83px;top:250px;">1</div>
					<div class="roundNum" style="left:317px;top:325px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [송금]버튼을 클릭 하고, 구매 확인 화면으로 이동합니다.</p>
					<p>2. [보내기]버튼을 클릭 하고, 송금(구매) 처리를 완료 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">4. 원하는 상품을 선택 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-101140.jpg" style="border:1px solid #ccc;width:228px;"/>
					>>
					<img src="/images/help/coinpool_20180323-101309.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:83px;top:250px;">1</div>
					<div class="roundNum" style="left:317px;top:325px;">2</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. [송금]버튼을 클릭 하고, 구매 확인 화면으로 이동합니다.</p>
					<p>2. [보내기]버튼을 클릭 하고, 송금(구매) 처리를 완료 합니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">5. 거래완료 메세지를 확인 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/coinpool_20180323-101345.jpg" style="border:1px solid #ccc;width:228px;"/>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">6. 거래내역을 확인 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr><td class="imgz">
					<img src="/images/help/Screenshot_20180323-121121.jpg" style="border:1px solid #ccc;width:228px;"/>
					<span class="glyphicon glyphicon-chevron-right" style="color:#000;"></span>
					<img src="/images/help/Screenshot_20180323-121133.jpg" style="border:1px solid #ccc;width:228px;"/>
					<div class="roundNum" style="left:97px;top:190px;">1</div>
					<div class="roundNum" style="left:313px;top:163px;">2</div>
					<p style="clear:both;"><br/></p>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>모바일 앱 > 단축메뉴 > 지갑관리 로 이동합니다.</p>
					<p>1. [거래내역]버튼을 클릭 하고, 거래내역 목록 화면으로 이동합니다.</p>
					<p>2. 구매 거래 했던 상품명과 거래 금액을 확인합니다.</p>
				</td>
			</tr>
			</table>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz">
					<img src="/images/help/coinpool_world_20180323_133600.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:147px;top:70px;">1</div>
					<p style="clear:both;"><br/></p>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>접근경로 : http://escrow.coinpool.world > 에스크로 거래 > Buyer > 구매내역관리</p>
					<p>1. 구매자 지갑 이름을 선택 합니다.</p>
				</td>
			</tr>
			</table>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz">
					<img src="/images/help/coinpool_world_20180323_134135.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:388px;top:96px;">1</div>
				</td>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 최근 내역에 구매 내역을 확인합니다. 진행상태 부분에 '구매요청 상태', 작업 부분에 '배송준비중...' 이라고 확인할 수 있습니다.</p>
				</td>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			<h7>[판매자 물품 판매 조회 & 관리]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 판매자는 판매 물품을 조회하고 상태 변경을 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz">
					<img src="/images/help/localhost_20180323_134608.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:142px;top:74px;">1</div>
					<p style="clear:both;"><br/></p>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>접근경로 : 에스크로 거래 > Seller > 판매 거래내역</p>
					<p>1. 조회하고자 하는 판매 물품을 선택 합니다.</p>
			</tr>
			</table>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz">
					<img src="/images/help/coinpool_world_20180323_134902.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:364px;top:93px;">1</div>
					<div class="roundNum" style="left:430px;top:123px;">2</div>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 진행상태가 '구매요청'임을 확인 합니다.</p>
					<p>2. [물품 배송 처리]버튼을 클릭 하면 해당 물건의 상태가 배송중으로 변경됩니다.</p>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			<h7>[구매자 상품 수취확인]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 상품의 배송을 확인하고 배송 수취 확인 처리를 합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz"> 
					<img src="/images/help/coinpool_world_20180323_135402.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:364px;top:93px;">1</div>
					<div class="roundNum" style="left:430px;top:123px;">2</div>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>접근경로 : 에스크로 거래 > Buyer > 구매내역관리</p>
					<p>1. 진행상태가 '배송출발'임을 확인 합니다.</p>
					<p>2. [물품 수취 확인]버튼을 클릭 하면 배송 완료 처리를 합니다.</p>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
			<h7>[Escrow System 거래내역 확인 및 관리]</h7>
			<p style="clear:both;"></p>
			
			<p style="clear:both;">1. 에스크로 거래내역을 확인합니다.</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz"> 
					<img src="/images/help/coinpool_world_20180323_140151.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:180px;top:72px;">1</div>
					<div class="roundNum" style="left:430px;top:123px;">2</div>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>접근경로 : 에스크로 거래 > Escrow System > 거래내역</p>
					<p>1. 선택하면 판매자의 물품으로 검색이 가능합니다.</p>
					<p>2. [물품대금 입금처리]버튼을 클릭 하면 거래내역 상세 화면으로 이동합니다.</p>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			<p style="clear:both;">2. 상품 완료 처리 및 판매자 입금 처리</p>
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td class="imgz"> 
					<img src="/images/help/coinpool_world_20180323_140354.png" style="border:1px solid #ccc;width:528px;"/>
					<div class="roundNum" style="left:23px;top:50px;">1</div>
					<div class="roundNum" style="left:227px;top:200px;">2</div>
				<td style="padding:10px 10px 10px 5px;" valign="top">
					<p>1. 판매자 정보를 확인 합니다.</p>
					<p>2. [송금]버튼을 클릭 하면 거래를 완료 시키고, 판매자에게 판매 대금을 입금 처리 합니다.</p>
			</tr>
			</table>
			<p style="clear:both;"><br/></p>
			
			
			
			
		</div>
	
	
	
	
	</div>
