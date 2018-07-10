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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/cpwallet/view.css" />
<script src="/js/jquery.min.js"></script>
<script src="/js/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/cpwallet/app_interface.js"></script>
<title>Coinpool</title>
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
</head>
<body>
	<div class="container">
		<div class="col-lg-4"></div>
		<div>
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;padding-bottom:0px;">
				<h2 style="text-align: center;">Remittance</h2>
				<hr/>
			</div>

				<form name="userWalletRimitFom" method="post" action="/escrow_proc.do" onsubmit="return false;">
					  <div class="form-group row">
					    <label for="id_walletContent" class="col-sm-2" style="font-weight:bold;padding-top:7px;">출금지갑</label>
					    <div class="col-sm-10"> 
					      <span id="id_walletlist_selectbox_option">에스크로 시스템 지갑</span>	
					    </div>
					  </div>		
					  <div class="form-group row">
					    <label for="id_walletContent" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금메모</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" id="id_walletContent" placeholder="출금메모" name="walletContent" value="물품금액"/>
					    </div>
					  </div>
					      <input type="hidden" name="sendContents" value="<c:out value='${bbsListInfo.BOARD_MARKET}'/> <c:out value='${bbsListInfo.BOARD_SUBJECT}'/>"/>
					  <div class="form-group row">
					    <label for="walletName2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">구매자지갑ID</label>
					    <div class="col-sm-10 form-inline"> 
		  			    	<input type="text" class="form-control" id="buyerWalletId" placeholder="구매자 지갑 ID" name="buyerWalletId" value=""/>
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="walletName2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금지갑</label>
					    <div class="col-sm-10 form-inline"> 
		  			    	<select name="walletName2" id="walletName2">
		  			    		<c:forEach items="${bbsList}" var="bbsListInfo" varStatus="status">
		  			    			<option value="<c:out value='${bbsListInfo.BOARD_WALLETID}'/>"><c:out value='${bbsListInfo.BOARD_MARKET}'/> <c:out value='${bbsListInfo.BOARD_SUBJECT}'/> <c:out value='${bbsListInfo.BOARD_PRICE}'/></option>
		  			    		</c:forEach>
		  			    	</select>
					    </div>
					  </div>
					  <input type="hidden" value="escrow" id="id_walletContent2" name="walletContent2" />
					  <div class="form-group row">
					    <label for="id_walletAmount2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금액</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" placeholder="입금액" id="id_walletAmount2" name="walletAmount2" maxlength="10" value="" />
					    </div>
					  </div>
					
					<div class="form-group" style="text-align:center">
						<input type="submit" class="btn btn-primary pull-center" onclick="FnTransferCoin();" value="송금" />
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();" />
					</div>
				</form>			
		</div>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>