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
<%@ include file="/kor/alertMessage.jsp" %>
<!DOCTYPE html>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<script src="/js/cpwallet/app_interface.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
<script>
var p_sAID = null;
var p_sANM = "";
var p_sCID = null;
var j_curWID = "";
var j_curWNM = "";

// 전송
function FnTransferCoin() {
	userWalletRimitFom.submit();
}
</script>
	<div class="container">
		<div class="col-lg-4"></div>
		<div>
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;padding-bottom:0px;">
				<h2 style="text-align: center;">Remittance</h2>
				<hr/>
			</div>
				<form name="userWalletRimitFom" method="post" action="/escrow/system/trans_proc.do" onsubmit="return false;">
					<input type="hidden" name="pageIndex" id="pageIndex" value="${param.pageIndex }" />
					<input type="hidden" name="sendContents" value="${param.pCONTENTS }"/>
					<input type="hidden" value="escrow" id="id_walletContent2" name="walletContent2" />
					<input type="hidden" value="${param.pSWID }" id="walletName2" name="walletName2" />
					<input type="hidden" value="${param.idx }" id="idx" name="idx" />
					
					  <div class="form-group row">
					    <label for="id_walletContent" class="col-sm-2" style="font-weight:bold;padding-top:7px;">출금지갑</label>
					    <div class="col-sm-10"> 
					      <span id="id_walletlist_selectbox_option">에스크로 시스템 지갑</span>	
					    </div>
					  </div>		
					  <div class="form-group row">
					    <label for="id_walletContent" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금메모</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" id="id_walletContent" placeholder="출금메모" name="walletContent" value="거래완료 입금처리"/>
					    </div>
					  </div>
					  
					  <div class="form-group row">
					    <label for="walletName2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">구매자지갑ID</label>
					    <div class="col-sm-10 form-inline"> 
		  			    	<input type="text" class="form-control" id="buyerWalletId" placeholder="구매자 지갑 ID" name="buyerWalletId" value="${param.pBWID }"/>
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="walletName2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금지갑</label>
					    <div class="col-sm-10 form-inline"> 
		  			    	${param.pSWID_NM }
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="id_walletAmount2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금액</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" placeholder="입금액" id="id_walletAmount2" name="walletAmount2" maxlength="10" value="${param.pPRICE }" />
					    </div>
					  </div>
					
					<div class="form-group" style="text-align:center">
						<input type="submit" class="btn btn-primary pull-center" onclick="FnTransferCoin();" value="송금" />
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();" />
					</div>
				</form>			
		</div>
	</div>
