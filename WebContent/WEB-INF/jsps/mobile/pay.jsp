<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="fouri.com.cmm.service.FouriProperties"%>
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

$(function(){
});
//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	 // AWI_XXX 메소드 활성화
	 AWI_ENABLE = true;
	 if(dtype=='android')
		 AWI_DEVICE = dtype;
     loadAccountName(); //계정이름
     loadWalletList(); //지갑리스트
 	j_curAID = AWI_getConfig("$ACCOUNT_ID");
}

function loadAccountName() {
	p_sAID = AWI_getConfig("$ACCOUNT_ID");
	p_sANM = AWI_getConfig("ACCOUNT_NM");
	p_sCID = AWI_getConfig("_CUR_CID");
	j_curWNM = AWI_getConfig("_CUR_WNM");
	
	if(p_sAID != null && p_sAID != undefined && p_sAID.length > 0){
		document.getElementById("s_account_name").innerHTML = "계정 : " + p_sANM;
	}
}

function loadWalletList() {
	var sHTML="";
	j_curWID = AWI_getConfig("_CUR_WID");
	j_curWNM = AWI_getConfig("_CUR_WNM");
	var elmtTBody = $('#id_walletlist_selectbox_option'); //출금지갑

	sHTML += '<input type="hidden" id="wallet_id" name="wallet_id" value="'+j_curWID+'"/>';
	sHTML += '<input type="text" class="form-control" placeholder="출금지갑" id="walletName" name="walletName" value="'+j_curWNM+'" readonly />';
	elmtTBody.html(sHTML);
}

var j_lastQRcode = "<%=FouriProperties.getProperty("escrow_wallet_id")%>";
function AWI_CallFromApp(strJson) { 
	// '{ "func": { "cmd":"restoreAccount","result":"OK"} }'
	var joRoot = JSON.parse(strJson);  
	var joFunc = joRoot.func;
	//sendConfirm
	if(joFunc.ec != 0) {
		alertMassageUrl('송금 실패 ['+joFunc.ref+']','/mbbs.do'); //error 메세지호출
	} else {
		alert('성공!');
		$.post('/mbbsPaymentInsert.do', $('#userWalletRimitFom').serialize(), function(sRes){
			//sResData = JSON.parse(sRes.trim());
			// var joRes = JSON.parse(sRes);
			
			location.href='/mbbs.do';
	    });
	}
}

// 전송
function FnTransferCoin(boardNum) {
	// jaArgs = [ "createTrans","PID","10000","receiver WID",
	//  "R","value","transfer memo","sender memo","receiver memo","CID"]
    if(j_lastQRcode == "") {
    	alertMassage('no wallet'); //error 메세지호출
    	return ;
    }

    var transferContent = "Demo send";
    var walletContent = $("#id_walletContent").val();
    var walletContent2 = $("#id_walletContent2").val();
    var walletAmount2 = $("#id_walletAmount2").val();
    var cid = p_sCID;
    //[ "createTrans","PID","10000","receiver WID",  "R","value","transfer memo","sender memo","receiver memo","realID","CID"]
	var jaArgs = ["createTrans","PID","10000",j_lastQRcode, "R", walletAmount2,transferContent,walletContent,walletContent2,"<c:out value='${bbsView.BOARD_WALLETID}'/>",cid ];

	userWalletRimitFom.swid.value = "<c:out value='${bbsView.BOARD_WALLETID}'/>";
	userWalletRimitFom.bwid.value = j_curWID;
	userWalletRimitFom.boardNum.value = boardNum;
	userWalletRimitFom.swidnm.value = '${bbsView.BOARD_NAME}';
	userWalletRimitFom.bwidnm.value = p_sANM;
	
	sReturn = AWI_sendConfirm(jaArgs,"");
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

				<form name="userWalletRimitFom" id="userWalletRimitFom" method="post" action="userWalletRimit2.jsp" onsubmit="return false;" class="form-horizontal">
					<input type="hidden" name="swid" value=""/>
					<input type="hidden" name="bwid" value=""/>
					<input type="hidden" name="swidnm" value=""/>
					<input type="hidden" name="bwidnm" value=""/>
					<input type="hidden" name="boardNum" value="0"/>
				
					<div class="form-group form-inline">
	  			    	<span class="input-group-addon" style="font-weight:bold; height:50px;" id="s_account_name">계정 : </span>
				    </div>
				    
					  <div class="form-group row">
					    <label for="id_walletContent" class="col-sm-2" style="font-weight:bold;padding-top:7px;">출금지갑</label>
					    <div class="col-sm-10"> 
					      <span id="id_walletlist_selectbox_option"></span>	
					    </div>
					  </div>		
					  <div class="form-group row">
					    <label for="id_walletContent" class="col-sm-2" style="font-weight:bold;padding-top:7px;">출금메모</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" id="id_walletContent" placeholder="출금메모" name="walletContent" value="<c:out value='${bbsView.BOARD_MARKET}'/> : <c:out value='${bbsView.BOARD_SUBJECT}'/>"/>
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="walletName2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금지갑</label>
					    <div class="col-sm-10 form-inline"> 
		  			    	<input type="text" class="form-control" placeholder="입금지갑" name="walletName2" id="walletName2" value="<c:out value='${bbsView.BOARD_MARKET}'/>" style="width:116px;" readonly />
					    </div>
					  </div>
					  <input type="hidden" value="escrow" id="id_walletContent2" name="walletContent2" />
					  <div class="form-group row">
					    <label for="id_walletAmount2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금액</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" placeholder="입금액" id="id_walletAmount2" name="walletAmount2" maxlength="10" value="${bbsView.BOARD_PRICE}" readonly/>
					    </div>
					  </div>
					
					<!-- 
					<div class="row">	  			    	
	  			    	<table class="table" style="text-align:center; border:1px solid #ffffff;">
							<tbody>
								<tr>
									<td style="background-color:#ffffff; text-align:center;vertical-align:top;height:60px;font-weight:bold;">
									코인명1(한화)에서 코인명2(달러)로<br />
									환전되어 송금됩니다.<br />
									</td>
								</tr>
							</tbody>
						</table>
				    </div>
				     -->
					
					<div class="form-group" style="text-align:center">
						<input type="submit" class="btn btn-primary pull-center" onclick="FnTransferCoin(${bbsView.BOARD_NUM});" value="송금" />
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();" />
					</div>
				</form>			
		</div>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>