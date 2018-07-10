<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="alertMessage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
function AWI_OnLoadFromApp(dtype) {
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
	loadAccountName(); //계정이름
	loadWalletName(); //지갑이름
}

var p_sAID = null; //계정아이디 선언
var p_sANM = null;
var p_sCID = null;

function loadAccountName() {
	p_sAID = AWI_getConfig("$ACCOUNT_ID");
	p_sANM = AWI_getConfig("ACCOUNT_NM");
	if (p_sAID != null && p_sAID != undefined && p_sAID.length > 0) {
		document.getElementById("s_account_name").innerHTML = "계정 : " + p_sANM;
		/*
		var alist = [p_sAID];
		
		$.ajax({
			type:"post",
			url:"/proc/query_list_account.jsp",
			data:JSON.stringify(alist),
			async: false,
			success:function(data,status,xhr)
			{				
				if ( status == "success") {
					var sRes = data.trim();
					var joRes = JSON.parse(sRes);
					
					if(joRes.length > 0) {						
						document.getElementById("s_account_name").innerHTML = "계정 : " + joRes[0].name;
					}
				}
			},
			error:function(xhr,status,error){
				
			}
		});
		*/
		
	}
}

function loadWalletName() {
	var p_sWID = AWI_getConfig("_CUR_WID"); //WID
	p_sCID = AWI_getConfig("_CUR_CID");
	var joRes = AWI_getWallet(p_sAID,p_sCID);
	document.getElementById("id_wallet_name").value = joRes.name; 
	/*
	var sParam = "wid=" + p_sWID;
	$.post("../proc/query_name_wallet.jsp",sParam,function(data,status){
		if (status == "success") { //성공이라면?
			var sRes = data.trim();
		    var joRes = JSON.parse(sRes);

		    var wname = joRes.name;
		    document.getElementById("id_wallet_name").value = wname; 
		}
		
	});
	*/
}

function SetWalletName() {
	var sWname = document.getElementById("id_wallet_name").value;
	var sWID = AWI_getConfig("_CUR_WID"); //WID
	
	if (sWname.length <= 0) {
		alertMassage('Invalid Wallet name.'); //error 메세지호출
		return;
	}
	AWI_changeWalletName(p_sAID,p_sCID,sWname);
	//var sParam = "wid=" + sWID + "&wname=" + sWname;
	//$.post("../proc/query_update_wallet.jsp",sParam);
	location.href="WalletList.jsp";
}
</script>
</head>
<body>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">Update Wallet Name</h2>
				<hr/>
			</div>
				<form name="userWalletNameModifyFom" method="post" action="userWalletNameModifyAction.jsp">
					<div class="form-group">
	  			    	<span class="input-group-addon" style="font-weight:bold; height:50px;" id="s_account_name">계정 : </span>
				    </div>
					
					<div class="form-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">지갑이름 : </span>
	  			    	<input type="text" class="form-control" placeholder="지갑이름" name="userName" id="id_wallet_name" maxlength="20">
				    </div>
					<div class="form-group" style="text-align:center; height:30px;">
					</div>
					
					<div class="form-group" style="text-align:center">
						<input type="button" class="btn btn-primary pull-center" value="변경" onclick="javascript:SetWalletName();">
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();">
					</div>
				</form>			
		</div>
	</div>
</body>
</html>