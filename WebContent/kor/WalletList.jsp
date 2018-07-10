 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="alertMessage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<script src="../js/jquery.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<title>Coinpool</title>
<style type="text/css">
	a, a:hover {
		color:#000000;
		text-decoration:none;
	}
	
	.pull-center {
	margin-top:5px;
	}
</style>
<script>
var p_sAID = "";
var p_sANM = "";
var p_sCID = "";
var j_curWID = "";
var j_curWNM = "";
var p_walletList=null;

$(function(){
});
//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
	
	if(!AWI_isCheckPassword()) {
		alertMassageUrl('Please use after login.','login.jsp');
		return false;
	}
	
	loadAccountName();
	loadWalletList();
}
function loadAccountName() {
	p_sAID = AWI_getConfig("$ACCOUNT_ID");
	p_sANM = AWI_getConfig("ACCOUNT_NM");
	//var ss = AWI_notiLogin(p_sAID);
	if(p_sAID != null && p_sAID != undefined && p_sAID.length > 0){
		/*
		var alist = [p_sAID];
		$.ajax({
		       type:"POST",  
		        url:'/proc/query_list_account.jsp',   
		        data: JSON.stringify(alist),
		        async: false,
		        success:function(data,status,xhr)
		        {
		        	if(status == 'success')
		        	{
		     			var sRes = data.trim();
		     			var joRes = JSON.parse(sRes);
		     			if (joRes.length > 0){
		     				document.getElementById("s_account_name").innerHTML = "계정 : " + joRes[0].name;
		     			}
		        	}
		        },   
		       error:function(xhr,status,error)
		        { 
		        } 
		 });
		*/
		document.getElementById("s_account_name").innerHTML = "계정 : " + p_sANM;
	}
}

function loadWalletList() {
	var rowSelIdx = 0;
	var sHTML="";
	var elmtTBody = $('#id_walletlist_table_tbody');
	var sRes = AWI_listWallet(p_sAID);
	p_walletList = sRes;
	if(j_curWID.length <= 0){
		if(p_walletList.length > 0){
			j_curWID = p_walletList[0]['wid'];
			p_sCID = p_walletList[0]['cid'];
		}
	}
	for(var i =0; i < p_walletList.length ; i ++)
	{
		sHTML += '<tr id="id_WalletID_' + i + '" style="background-color:#ffffff;" onclick="javascript:WalletListRowColor(\'id_WalletID_' + i + '\');">'
	  		      + '<td style="text-align:center;vertical-align:middle;">'
	  		      + '<div class="radio"><label><input type="radio" name="name_WalletID" value="' + p_walletList[i]['wid'] + '"></label></div></td>'
	  		      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + p_walletList[i]['name'] + '</td>';
			if (j_curWID == p_walletList[i]['wid']) {
				rowSelIdx = i;
		    }
	}
	
	elmtTBody.html(sHTML);
	WalletListRowColor('id_WalletID_' + rowSelIdx, p_sCID);
	/*
	var sParam = "aid=" + p_sAID;
	$.post("../proc/query_list_wallet.jsp",sParam,function(data,status){
		var bResult = false;
		if(status == "success")
		{
			var rowSelIdx = 0;
			var sHTML="";
			var elmtTBody = $('#id_walletlist_table_tbody');
			var sRes = data.trim();
			var joRes = JSON.parse(sRes);
			j_curWID = AWI_getConfig("_CUR_WID");
			p_walletList = joRes;
			if(j_curWID.length <= 0){
				if(p_walletList.length > 0){
					j_curWID = AWI_setConfig("_CUR_WID", p_walletList[0]['wid']);
				}
			}
			for(var i =0; i < p_walletList.length ; i ++)
			{
				sHTML += '<tr id="id_WalletID_' + i + '" style="background-color:#ffffff;" onclick="javascript:WalletListRowColor(\'id_WalletID_' + i + '\');">'
			  		      + '<td style="text-align:center;vertical-align:middle;">'
			  		      + '<input type="radio" name="name_WalletID" value="' + p_walletList[i]['wid'] + '"></td>'
			  		      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + p_walletList[i]['name'] + '</td>';
	  			if (j_curWID == p_walletList[i]['wid']) {
	  				rowSelIdx = i;	  		    	
	  		    }
			}
			elmtTBody.html(sHTML);
			WalletListRowColor('id_WalletID_' + rowSelIdx);
		}
	});
	*/
}

function WalletListRowColor(WalletRowID) {
	if( p_walletList == null)
		return;
	
	var WalletRowID = WalletRowID; //넘어온RowID값
   	
	for(var i =0; i < p_walletList.length ; i ++) {		
		if ("id_WalletID_"+i == WalletRowID) {
			document.getElementById("id_WalletID_"+i).style.backgroundColor = "#f9f9f9";
			document.getElementsByName('name_WalletID')[i].checked = true;
			j_curWID = p_walletList[i]['wid'];
			j_curWNM = p_walletList[i]['name'];
			p_sCID = p_walletList[i]['cid'];
			//AWI_setConfig("_CUR_WID",j_curWID);
		} else {
			document.getElementById("id_WalletID_"+i).style.backgroundColor = "#ffffff";
		}
	}
}

function FnHistory()
{
	AWI_setConfig("_CUR_WID",j_curWID);
	AWI_setConfig("_CUR_WNM",j_curWNM);
	AWI_setConfig("_CUR_CID",p_sCID);
	location.href='WalletHistory.jsp?wid=' + j_curWID;
}

function FnViewWID()
{
	AWI_setConfig("_CUR_WID",j_curWID);
	AWI_setConfig("_CUR_CID",p_sCID);
	//location.href='WalletQRCode.jsp';
	AWI_viewWalletID("",p_sCID);
}

function FnRenameWallet()
{
	AWI_setConfig("_CUR_CID",p_sCID);
	AWI_setConfig("_CUR_WID",j_curWID);
	location.href='WalletRename.jsp';
}

function FnTransferWallet(){
	if(confirm('일반 송금 거래 입니다.')) {
		AWI_setConfig("_CUR_WID",j_curWID);
		AWI_setConfig("_CUR_WNM",j_curWNM);
		AWI_setConfig("_CUR_CID",p_sCID);
		location.href='WalletRimit.jsp';	
	}
}
function FnTransferWallet2(){
	if(confirm('주문 내역 송금 입니다.')) {
		AWI_setConfig("_CUR_WID",j_curWID);
		AWI_setConfig("_CUR_WNM",j_curWNM);
		AWI_setConfig("_CUR_CID",p_sCID);
		location.href='WalletOrder.jsp';	
	}
}

</script>
</head>
<body>    
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">My Wallet List</h2>
				<hr/>
			</div>
					<div class="form-group">
	  			    	<span class="input-group-addon" style="font-weight:bold; height:50px;" id="s_account_name">계정 : </span>
				    </div>
					
					<div class="row">	  			    	
	  			    	<table class="table" style="text-align:center;">
						    <thead class="thead-light">
						      <tr>
								<th width="18%" style="text-align:center;"></th>
								<th style="text-align:center;">Wallet List</th>
						      </tr>
						    </thead>
							<tbody id='id_walletlist_table_tbody'>
							</tbody>
						</table>
				    </div>
					<div class="form-group" style="text-align:center;"></div>
					
					<div class="form-group" style="text-align:center">
						<!-- <a href="WalletNew.jsp" class="btn btn-outline-primary">지갑<br>생성</a>  -->
						<a href="javascript:FnRenameWallet();" class="btn btn-outline-primary">지갑<br>변경</a>
						<a href="javascript:FnHistory();" class="btn btn-outline-primary">거래<br>내역</a> 
						<a href="javascript:FnTransferWallet();" class="btn btn-outline-primary">송금<br>하기</a> 
						<a href="javascript:FnTransferWallet2();" class="btn btn-outline-primary">주문<br>결제</a>
						<a href="javascript:FnViewWID();" class="btn btn-outline-primary">QR<br>코드</a>
					</div>	
		</div>
	</div>
</body>
</html>