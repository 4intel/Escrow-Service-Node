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
//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	 // AWI_XXX 메소드 활성화
	 AWI_ENABLE = true;
	 if(dtype=='android')
		 AWI_DEVICE = dtype;
}

function FnNewAccount()
{
	var sName = document.getElementById('id_account_name').value;
	
	//var sNewWallet = AWI_newWallet("",100);  // { "result":"OK" , "aid":"account id" , "wid":"wallet id","cid":100 }
	var sNewWallet = AWI_newAccount(sName);  // { "result":"OK" , "aid":"account id" , "wid":"wallet id","cid":100 }
	var joNewWallet = JSON.parse(sNewWallet);
	//var joNewWallet = { "result":"OK" , "aid":"cMhemRVoMp2CJ1HUhpwkzqEu3satuRsdnFfG3zzXwv4hq8Wro1Q3" , "wid":"wallet id","cid":100 }	
	if(joNewWallet['result'] != "OK") {
		location.href = "sorry.jsp";	
	    return;
	}
	var sAID = joNewWallet['aid'];
	var sWID = joNewWallet['wid'];
	var nCID = joNewWallet['cid'];
	var sPID = AWI_getConfig("$PUSH_ID");
	var sDID = AWI_getConfig("$DEVICE_ID");
	var sOS = AWI_getConfig("$DEVICE_OS");
	var sDI = AWI_getConfig('$DEVICE_INFO');
	//var sName = $("#id_account_name").value(); //var sName= "내지갑"
	
	if (sName.length <= 0) {
		alertMassage('Invalid Account name'); //error 메세지호출
		return;
	}
	
    var sQuery = "aid=" + sAID + "&wid=" + sWID + "&cid=" + nCID + "&did="+sDID + "&pid=" + sPID 
                 + "&os=" + sOS + "&inf=" + sDI + "&name=" + sName;
    
  	 var sHTML = "<H1> 실패 입니다. </H1>" 
 	 //traceLog("New003-");
  	 
  	 $.post("../proc/query_new_account.jsp",sQuery,function(data,status){
		var bResult = false;
		if(status == "success")
		{
			var sRes = data.trim();
			var joRes = JSON.parse(sRes);
			if(joRes['result'] == "OK")
			{
				bResult = true;
				AWI_notiWallet("OK",sAID,sWID,nCID);
				AWI_setAccount(sAID);
				location.href='accountListMain.jsp';
 			} else {
 				alert("실패 입니다.");
 			}
		} else {
			alert("실패 입니다.");
		}
	});
}
</script>
</head>
<body>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">Create Account</h2>
				<hr/>
			</div>
				  <div class="form-group">
				    <label for="pwd">Account Name : </label>
				    <input type="text" id="id_account_name" class="form-control" placeholder="Account Name" name="userName" maxlength="20">
				  </div>
				
				<div class="form-group" style="text-align:center">
					<input type="button" class="btn btn-primary pull-center" value="Create" onClick="FnNewAccount();">
					<input type="button" class="btn btn-primary pull-center" value="Cancel" onclick="history.back();">
				</div>
		</div>
	</div>
</body>
</html>