<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>

	<style>
	h3,h4,h5,h6,h7 {font-weight:bold;}
	h3 {
		color:#545698;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
	}
	
	.depth1 {
		padding-left:15px;
	}
	.depth2 {
		padding-left:30px;
	}
	.depth3 {
		padding-left:45px;
	}
	</style>

	<script>
	</script>

	<div class="container">
	
		<h3>소개 및 개요</h3>
		<h5>과제 개요</h5>
		<p class="depth2"></p>
		<br/>
		
		<p>단계별 기술개발 목표</p>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_1_1.png" style="width:800px;" />
			</div>
		<br/>
		
		
		
		
		<h3>적용 기술</h3>
		Development environment
		<div class="depth1">
			<table width="80%">
			<tr height="30">
				<td width="25%" align="center" style="background:#eee;font-weight:bold;border-bottom:1px solid #ccc;border-top:1px solid #666;"></td>
				<td width="25%" align="center" style="background:#eee;font-weight:bold;border-bottom:1px solid #ccc;border-top:1px solid #666;">Chain Service</td>
				<td width="25%" align="center" style="background:#eee;font-weight:bold;border-bottom:1px solid #ccc;border-top:1px solid #666;">Terminal Service
				</td>
				<td width="25%" align="center" style="background:#eee;font-weight:bold;border-bottom:1px solid #ccc;border-top:1px solid #666;">Web Service</td>
			</tr>
			<tr height="30">
				<td align="center" style="border-bottom:1px solid #ccc;">환경</td>
				<td align="center" style="border-bottom:1px solid #ccc;">Linux<br/>
	Hyperledger Fabric <br/>
	Docker<br/>
	Docker-compose<br/>
	Docker-swarm
				</td>
				<td align="center" style="border-bottom:1px solid #ccc;">Linux<br/>
				Windows<br/>
	Android
				</td>
				<td align="center" style="border-bottom:1px solid #ccc;">Linux<br/>
	Tomcat
				</td>
			</tr>
			<tr height="30">
				<td align="center" style="border-bottom:1px solid #ccc;">도구</td>
				<td align="center" style="border-bottom:1px solid #ccc;">Visual Studio Code<br/>
	Eclipse
				</td>
				<td align="center" style="border-bottom:1px solid #ccc;">Android Studio</td>
				<td align="center" style="border-bottom:1px solid #ccc;">Eclipse</td>
			</tr>
			<tr height="30">
				<td align="center" style="border-bottom:1px solid #666;">언어</td>
				<td align="center" style="border-bottom:1px solid #666;">nodejs<br/>
	go language<br/>
	BASH Shellscript</td>
				<td align="center" style="border-bottom:1px solid #666;">Java</td>
				<td align="center" style="border-bottom:1px solid #666;">java<br/> 
	JSP<br/>
	Java script<br/>  
	Ajax <br/>
	XML <br/>
	JSON</td>
			</tr>
			</table>
		</div>
				<br/>
			<p>Escrow payment system</p>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_1_2.png" style="height:250px;" />
				<img src="/images/intro/intro_1_3.png" style="height:250px;" />
			</div>
			<br/>
			<p>Coin Protocol Design</p>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_1_4.png" style="width:800px;border:1px solid #ccc;" />
			</div>
			<br/>
			<p>createCoin Chaincode 쿼리 예제</p>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_1_5.png" style="width:800px;" />
			</div>
			<br/>
		<br/>
		
		
		
		
		<h3>서비스 장점</h3>
		<h7>개발제품의 특징 및 우수성</h7>
		<div style="width:80%;text-align:center;">
			<img src="/images/intro/intro_3_1.png" style="width:700px;" />
		</div> 
	    <p> - 온라인 전자화폐 기반의 제3자 결제시스템은 환율 수수료, 거래 수수료 등 기존의 주류화폐의 수수료 부담을 없애면서도 빠르게 거래할 수 있는 결제수단</p>
	    <p> - 직구, 역직구 등 CBT(Cross Boader Trade)가 증가함에 따라 신용카드 외에 안전하게 거래와 결제를 할 수 있는 모델이 전무한 실정이라, 관련 상품의 시장 진입은 저가의 수수료와 함께 관련 시장에서 호응도가 높을 것이라고 전망</p> 
	    <p class="depth2">※ 거래 당사자의 신원확인이 어려워, 사기거래 등의 위협수준이 높아지고 있음. 유일한 잠재적 경쟁자인 이베이, 알리페이의 수수료는 주류 은행들과의 연동 및 수수료, 환차리스크로 인해 3%이하의 가맹점 수수료는 달성하기 어려운 실정임</p> 
	    <p> - 이베이(e - Bay)에서 FDS 시스템의 도입으로 발생한 사기문제를 상당부분 해결하고 고객만족의 경험을 달성한 것과 같은 효과를 전자화폐 기반의 본 상용화 결과물에서 기대 예상 </p>
	    <br/>
		<h7>산업적 파급효과</h7>
		<p class="depth2">   (1) 기술적 파급효과</p>
		<p class="depth3">    ◦ 단순히 비트코인과 같은 전자화폐를 결제수단으로 간편결제 서비스를 제공하는 것이 아니라 거래 상대방의 거래이력 정보, 평판 등 복합정보를 기반으로 신뢰 측정결과를 참조하고 안전거래를 위한 에스크로 거래방법을 간편하게 제공</p> 
		<p class="depth3">    ◦ 신뢰도 측정에 활용되는 거래 이력정보는 블록체인에 암호화 되어 등록되고 저장됨. 객관성과 보안성이 담보되며 분쟁 발생시, 객관적인 사실 자료로 활용할 수 있어 플랫폼 사업자의 당해 거래에 대한 책임범위 등 부담이 적음</p>
		<p class="depth2">   (2) 경제적/산업적 창출효과</p>
		<p class="depth3">    ◦ 국내 크라우드 소싱, 아웃소싱의 세계시장 진출을 용이하게 하고 국내 우수인력들의 일자리 창출에 기여</p> 
		<p class="depth3">    ◦ S/W개발, 디자인 용역과 같은 전통적인 아웃소싱 의뢰 뿐만 아니라 퇴역 전문가 인력(실버 전문가)의 자문, 약식 문서 작성 의뢰나 작은 규모의 디지털 콘텐츠 판매 등 새로운 시장창출에 기여</p> 
		<p class="depth3">    ◦ 전자화폐 지갑, 거래소 중심의 편협한 국내 블록체인 산업에 다양한 응용 서비스 모델 발굴 및 촉진 계기를 마련하여 균형있는 국내 블록체인 산업 육성에 기여</p>
		<p class="depth2">   (3) 사회적 창출효과</p>
		<p class="depth3">    ◦전자화폐의 편리한 지불환경을 사회 전반에 정착시키고 거래 상대방을 믿고 신뢰할 수 있는 신용사회의 기술적 토대를 제공</p>
		<p class="depth3">    ◦분쟁이 발생하더라도 블록체인 등록정보를 활용하여, 빠르게 분쟁을 해결할 수 있기 때문에 불필요한 사회적 기회비용의 낭비요소를 줄임</p> 
		<br/>
		
		
		
		
		<h3>사업목표</h3>
		<br/>
		  <p>온‧오프라인(O2O) 상거래 환경에서 거래당사자간 거래 신뢰도를 검증하고 평판정보를 수집할 수 있는 퍼블릭 블록체인 기반의 제3자 결제 시스템 개발</p> 
		<p>  -  온라인 P2P(Peer to Peer)환경에서 거래 당사자간 상호 신뢰하에 거래를 할 수 있도록 신뢰도 정보를 제공하고 에스크로 형태의 결제를 지원하며, 거래에 대한 판매자의 평판정보를 블록체인에 등록하면 에스크로 수수료의 일부를 구매자의 보상으로 지급</p> 
		<p>  -  오프라인 매장에서 사용자가 설치한 지갑앱(App)을 통해 사업자용 결제단말기(결제단말용 App)와 NFC통신방식으로 전자화폐를 지불‧결제하고, 결제완료와 동시에, 판매자의 평판정보를 블록체인에 등록하고 결제비용의 일부를 보상</p>
		<p>  -  제3자 결제서비스에서 수집할 수 있는 데이터를 기반으로 데이터 분석 환경 및 신뢰도 및 평판 모델 </p>
		<p>  -  퍼블릭 블록체인을 등록된 거래정보와 사용 정보를 이용하여 신뢰도 및 평판을 추론할 수 있는 모델을 구축하고 응용 프로그램의 다양한 목적(서비스 이용주체 의 정책결정 및 의사결정 등)을 달성하기 위해 상황과 대응정의 및 이를 위한 신뢰도 결합모델 완성</p>   
			<p></p>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_4_1.png" style="width:600px;" />
			  	<p><서비스 개념도></p>
			</div> 
		<h5> ◦ 거래 당사자의 신뢰성과 평판정보를 기반으로 에스크로 결제가 가능한 온라인 3자 결제 시스템</h5>
		<p class="depth2">     -  블록체인 화폐를 지불수단으로 하는 온라인 안심거래 (Escrow) 서비스 및 S/W 개발 </p>
		<p class="depth2">     -  P2P거래당사자간 거래착수, 진행, 종료 등 거래 및 평판정보를 퍼블릭 블록체인에 등록할 수 있는 메타코인 기술 개발</p>     
		<p class="depth2">     -  ID정보를 토대로 블록체인 UTXO 분석 및 거래이력 추출 기술 개발 </p>
		<p class="depth2">     -  메타코인(Metacoin) 및 ID정보를 기반으로 거래이력 및 평판 정보에 대한 분석 기술 개발</p>
		<p class="depth2">     -  분석결과를 토대로 거래 신뢰도 산정 모델 구현 및 데이터 시각화 인터페이스 구현</p> 
		<p class="depth2">     -  서비스 데모구현을 위한 인터페이스 S/W개발</p>  
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_4_2.png" style="width:600px;" />
			  	<p><서비스 흐름도></p>
			</div> 
			
		  <h5> ◦ 판매자의 평판정보를 수집 ․ 제공하는 오프라인 3자 결제 시스템</h5>
		  <p class="depth2">   -  블록체인 화폐를 지불수단으로 하는 오프라인 결제단말기 S/W 및 지갑 S/W개발</p>
		  <p class="depth3">  ※ 지갑S/W는 온라인 안심거래 결제지갑 S/W와 통합하여 개발 </p>
		  <p class="depth2">   -  블록체인 내 평판정보 등록을 위한 메타코인 기술 개발(온라인 결제 시스템 내용과 동일)</p> 
		  <p class="depth2">   -  메타코인 및 판매자ID정보를 통해 판매자 평판정보 수집/분석 기술 개발</p>
		  <p class="depth2">   -  분석결과를 토대로 평판 모델 구현 및 데이터 시각화 인터페이스 구현</p>
		  <p class="depth2">   -  판매자 판매비용 내 일부 또는 수수료 일부를 구매자에게 보상 지급할 수 있는     다중 디지털서명 및 스마트 컨트랙트 기술 개발</p> 
		  <p class="depth2">   -  평판정보 리포팅 기능이 가능한 테스트베드 관리자도구 S/W 개발  </p>
		   <p class="depth3">  ※ 테스트베드를 제공하는‘찰스김밥’의 사용자 의견을 수렴한 인터페이스 포함</p> 
		  <p class="depth2">   -  서비스 데모구현을 위한 인터페이스 S/W개발(온라인과 통합하여 개발)</p>
					<br/>
		<h5> ◦ 판매자의 평판정보를 수집․제공하는 오프라인 3자 결제 시스템</h5>
		<p class="depth2">   -  NFC무선통신 방식으로 결제단말기와 스마트폰 지갑앱(App)이 결제 정보를 교환할 수 있는 결제단말기 S/W와 지갑앱 S/W</p>
		 <p class="depth3">     ․ 판매자가 결제단말기 S/W를 범용 단말기(태블릿, 스마트폰 등)에 설치가 가능하며, 결제금액을 입력하고 결제를 요청하는 기능 개발</p> 
		 <p class="depth3">      ․ 판매자는 서비스 홈페이지에서 판매자 등록을 하고 본인의 계정과 결제단말기로 사용하려는 단말기 S/W에 계정 코드를 입력하면 결제단말기로 등록되고 전자화폐 결제단말기로 사용 가능</p> 
			<div style="width:80%;text-align:center;">
				<img src="/images/help/Screenshot_20180323-121133.jpg" style="height:450px;border:1px solid #ccc;" />
				<img src="/images/help/coinpool_world_20180323_143615.png" style="height:450px;border:1px solid #ccc;" />
			  	<p><오프라인 결제단말기 & 지갑앱 구현></p>
			</div> 
       
       
       
       
       
		<h3>비지니스 모델</h3>
     <p class="depth2"> -  이전기술은 소셜 네트워크에서 참여자들의 신뢰도를 추출하고 이를 다양한 서비스에 접목할 수 있는 기술임. 이를 블록체인 상에 노드들의 거래이력 정보 및 관계 네트워크에 적용하고 이에 기반하여 산출된 신뢰모델을 전자화폐 제3자 결제 시스템에 적용하는 과제임</p>
     <p class="depth2"> -  전자화폐의 거래는 익명성이 보장되고, 해외 등 역외거래가 활성화 될 예정이기 때문에 기존의 주류화폐나 지불수단에서처럼 거래의 안전성(거래취소, 사기방지 등)을 확보하기 어려움</p>
     <p class="depth2"> -  전자화폐를 사용하면서도 안심하고 거래할 수 있는 전자화폐기반의 제3자 결제 서비스의 필요성이 여기에 있으며, 신뢰도와 같은 거래상대방의 거래 진심성, 신뢰도를 파악하고 이를 반영하는 결제시스템을 구축하는 것이 핵심요소임</p>
     <p class="depth2"> -  기존 주류화폐의 제3자 결제 서비스의 수수료는 3~4%로 현금성 화폐를 취급함에도 불구하고 수수료율이 높은 것이 현실이며, 전자화폐의 낮은 수수료, 즉시성, 간편성은 새로운 결제수단의 활성화를 견인할 것으로 보고 있음(초기에는 온라인 중심으로 시작되고 오프라인으로 점차 확대)</p>   
     <p class="depth2"> -  아울러, 오프라인 결제환경에서 제3자 결제에 대한 필요성이 증가하고 해외여행객의 제3자 결제 서비스에 대한 인식도가 개선되고 있는 분위기이므로, 전자화폐를 지불수단으로 하는 제3자 결제 서비스의 활성화가 예상됨 </p>
     <p class="depth2"> -  서비스 이용자 관점의 수용성</p>
     <p class="depth3">․  오프라인 가맹점 :  낮은 수수료, 결제단말기 설치 간편(S/W타입), 결제 편의성, 고객정보 획득 등</p> 
     <p class="depth3">․  온라인 가맹점 : 고객 안전거래 지원, 환율수수료 절감, 고객에게 낮은 수수료 제시, 결제 편의성 확보 </p>
     <p class="depth3">․  고객(소비자) : 안전한 결제(온라인 거래에서 단순취소, 사기거래 방지 등), 결제 편의성, 환차수수료 절감 등</p>  
      
     <h5> -  온라인 비즈니스 모델</h5>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_biz_1.png" style="width:600px;" />
			</div> 
		<br/>
      <p class="depth2">․  2018년 : 국내 중고거래 200억 시장에서 10%점유율(수익률2%) : 4,000만원</p>
      <p class="depth2">․  2019~20년 : 국내 P2P대출 및 부동산 시장 포함 1조 시장에서 30%점유율(수익률2%) : 연간50억 달성까지</p>   
      <p class="depth2">․  2020년~ : 해외 직구/역직구 포함 800조 이상 시장 5%점유율(수익률2%) : 매년 8000억 달성</p>


     <h5> -  오프라인 비즈니스 모델</h5>
			<div style="width:80%;text-align:center;">
				<img src="/images/intro/intro_biz_2.png" style="width:600px;" />
			</div> 
		<br/>
		
		
		<h3>서비스 구성</h3>
		<div class="depth1">
			<p>Escrow Wallet Mobile App</p>
			<h4>Download the Android distribution </h4>
			<p><a href="http://escrowdev.coinpool.world/app/cpescrow_20180131(1).apk" class="btn btn-primary btn-lg" target="_blank">Download APP (2018-01-31)</a></p>
			<div class="alert alert-info">
			    <strong>Info!</strong> Download it from your mobile browser.
			</div>
				<h4>도움말 사이트</h4>
				<p><a href="http://escrowdev.coinpool.world/" target="_blank" class="btn btn-primary">Link http://escrowdev.coinpool.world/</a></p>
				<p><dl><dd>- 모바일 앱의 소개 및 사용법과 개발 API를 소개하고 있습니다.</dd></dl></p>
				<!-- 
				<h4>에스크로/직거래 데모 사이트</h4>
				<p><a href="http://escrow.coinpool.world" target="_blank" class="btn btn-primary">Link http://escrow.coinpool.world</a></p>
				<p><dl><dd>- 에스크로 거래의 판매자, 구매자, 에스크로 시스템의 거래를 실행해 볼 수 있습니다.</dd></dl></p>
				 -->
				<h4>Testnet Faucet URL</h4>
				<p><a href="http://escrow.coinpool.world/faucet.do" target="_blank" class="btn btn-primary">Link http://escrow.coinpool.world/faucet.do</a></p>
				<p><dl><dd>- 테스트를 위한 수도꼭지 사이트 입니다. 1회 송금량은 500,000PX 입니다.</dd></dl></p>
				
			<br/>
		</div>
		
	</div>
