<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="alertMessage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/cpwallet/view.css" />
<script src="../js/jquery.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<title>Coinpool</title>
<script>
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

var p_sAID = null;
var p_sANM = "";
var p_sCID = null;
var j_curWID = "";
var j_curWNM = "";

function loadAccountName() {
	p_sAID = AWI_getConfig("$ACCOUNT_ID");
	p_sANM = AWI_getConfig("ACCOUNT_NM");
	p_sCID = AWI_getConfig("_CUR_CID");
	j_curWNM = AWI_getConfig("_CUR_WNM");
	
	if(p_sAID != null && p_sAID != undefined && p_sAID.length > 0){
		document.getElementById("s_account_name").innerHTML = "계정 : " + p_sANM;
	}
}

function loadWalletName(p_walletId) {
	$.ajax({
	       type:"POST",
	        url:'/proc/query_get_wallet_name.jsp?wid='+p_walletId,   
	        async: false,
	        success:function(data,status,xhr) {
	        	if(status == 'success') {
	     			var sRes = data.trim();
	     			var joRes = JSON.parse(sRes);
	     			userWalletRimitFom.walletName2.value = joRes.nm; 
	        	}
	        },   
	       error:function(xhr,status,error)
	        { 
	    	   alertMassage('Communication error!'); //error 메세지호출
	        } 
	 });
}

function loadWalletList() {
	var sHTML="";
	j_curWID = AWI_getConfig("_CUR_WID");
	j_curWNM = AWI_getConfig("_CUR_WNM");
	var elmtTBody = $('#id_walletlist_selectbox_option'); //출금지갑

	sHTML += '<input type="hidden" id="wallet_id" name="wallet_id" value="'+j_curWID+'"/>';
	sHTML += '<input type="text" class="form-control" placeholder="출금지갑" id="walletName" name="walletName" value="'+j_curWNM+'"/>';
	elmtTBody.html(sHTML);
}

var j_lastQRcode = "";
function AWI_CallFromApp(strJson)
{ // '{ "func": { "cmd":"restoreAccount","result":"OK"} }'
	var joRoot = JSON.parse(strJson);  
	var joFunc = joRoot.func;
	if(joFunc.cmd == 'setQR')
	{
		j_lastQRcode = joFunc.value;
		loadWalletName(j_lastQRcode);
	}
	else if(joFunc.cmd == 'sendConfirm')
	{
		if(joFunc.ec != 0) {
			alertMassageUrl('송금 실패 ['+joFunc.ref+']','/kor/WalletList.jsp'); //error 메세지호출
		} else {
			orderSendForm.bwid.value = j_curWID;
			orderSendForm.bwid_nm.value = j_curWNM;
			orderSendForm.send_coin.value = $("#id_walletAmount2").val();
			$.post('/direct/buyer/send_coin_process.do',$('#orderSendForm').serialize(), function(sRes){	
			});
			alertMassageUrl('성공!','/kor/WalletList.jsp'); //error 메세지호출
		}
		//location.href='/kor/WalletList.jsp';
	}
}
function FnScanQRCode() {
	AWI_changeView("qrscan","")
}

// 전송
function FnTransferCoin() {
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
	var jaArgs = ["createTrans","PID","10000",j_lastQRcode, "R", walletAmount2,transferContent,walletContent,walletContent2,j_lastQRcode,cid ];
   
	sReturn = AWI_sendConfirm(jaArgs,"");
}
</script>
</head>
<body>
	<!-- 커피숍 주문 결제 시 결제 완료 처리 데이타 -->
	<form name="orderSendForm" id="orderSendForm" method="post" action="/direct/buyer/send_coin_process.do" onsubmit="return false;">
		<input type="hidden" name="bwid" id="bwid" value=""/>
		<input type="hidden" name="bwid_nm" id="bwid_nm" value=""/>
		<input type="hidden" name="send_coin" id="send_coin" value=""/>
	</form>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div>
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;padding-bottom:0px;">
				<h2 style="text-align: center;">Remittance</h2>
				<hr/>
			</div>

				<form name="userWalletRimitFom" method="post" action="userWalletRimit2.jsp" onsubmit="return false;" class="form-horizontal">
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
					      <input type="text" class="form-control" id="id_walletContent" placeholder="출금메모" name="walletContent">
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="walletName2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금지갑</label>
					    <div class="col-sm-10 form-inline"> 
		  			    	<input type="text" class="form-control" placeholder="입금지갑" name="walletName2" id="walletName2" value="" style="width:116px;">
		  			    	<input type="button" class="btn btn-primary pull-center" value="QR코드" onclick="FnScanQRCode();">
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="id_walletContent2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금메모</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" placeholder="입금메모" id="id_walletContent2" name="walletContent2" maxlength="20" />
					    </div>
					  </div>
					  <div class="form-group row">
					    <label for="id_walletAmount2" class="col-sm-2" style="font-weight:bold;padding-top:7px;">입금액</label>
					    <div class="col-sm-10"> 
					      <input type="text" class="form-control" placeholder="입금액" id="id_walletAmount2" name="walletAmount2" maxlength="10" value="0">
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
						<input type="submit" class="btn btn-primary pull-center" onclick="FnTransferCoin();" value="송금" />
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();" />
					</div>
				</form>			
		</div>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>