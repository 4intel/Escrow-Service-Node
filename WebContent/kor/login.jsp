<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ include file="lang.jsp" %>
<%@ include file="alertMessage.jsp" %> 
<%
HttpSession loginsession = request.getSession(true); // true : 없으면 세션 새로 만듦

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

//-------------------------------------
String sWID = EtcUtils.NullS((String)loginsession.getAttribute("WID"));
String p_sAID = EtcUtils.NullS((String)loginsession.getAttribute("AID"));
boolean p_bGoWalletPage = false;
if(!p_sAID.isEmpty())
{
	p_bGoWalletPage = true;
}
%>
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
function AWI_OnLoadFromApp(dtype)
{
	 // AWI_XXX 메소드 활성화
	 AWI_ENABLE = true;
	 if(dtype=='android')
		 AWI_DEVICE = dtype;
}

function checkPW()
{
	var sPW = document.getElementById('id_pw').value;
	var bAns = AWI_checkPassword(sPW);
	
	if(bAns)
	{	
		<%
		if(p_bGoWalletPage)
		{
			out.println("AWI_setAccount('" + p_sAID + "');");	
			out.println("location.href='WalletList.jsp'");	
		}
		else
		{
		%>
			var sAID = AWI_getConfig("$ACCOUNT_ID")
			if(sAID != "")
				location.href='WalletList.jsp';
			else
				location.href='accountListMain.jsp';
		<%
		}
		%>
	}
	else
		alertMassage('The password is incorrect.'); //error 메세지호출
}
</script>
</head>
<body>
	<div class="container">
		<div style="height:10px;"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">Escrow Wallet Login</h2>
				<hr/>
			</div>
					
					  <div class="form-group">
					    <label for="pwd">Password : </label>
					    <input type="password" class="form-control" id='id_pw' name="userPassword" maxlength="20"/>
					  </div>
					<div class="form-group" style="text-align:center; height:30px;">
					</div>
					 
					<div class="form-group" style="text-align:center">
						<a href="#none" onClick="javascript:checkPW()" class="btn btn-primary pull-center">Login</a>
					</div>
					<div class="form-group" style="text-align:center; height:30px;">
					</div>
					
					<div class="form-group" style="text-align:center">
						<a href="userPassWordModify.jsp" class="btn btn-outline-primary">암호변경</a> 
						<a href="userPassWordLoss.jsp" class="btn btn-outline-primary">암호분실신고</a>
					</div>
		</div>
	</div>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>
</html>