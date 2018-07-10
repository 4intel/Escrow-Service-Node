<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="alertMessage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<title>Coinpool</title>
<script>
function AWI_OnLoadFromApp(dtype)
{
	 // AWI_XXX 메소드 활성화
	 AWI_ENABLE = true;
	 if(dtype=='android')
		 AWI_DEVICE = dtype;
}

function setPW()
{
	var sOldPW = $('#id_oldpw').val();
	var sPW1 = $('#id_newpw1').val();
	var sPW2 = $('#id_newpw2').val();
		
	var bAns = AWI_checkPassword(sOldPW);
	if(!bAns)
	{
		alertMassage('The old password is incorrect.'); //error 메세지호출		
		return
	}
	
	if(sPW1 != sPW2)
	{
		alertMassage('New passwords are different.'); //error 메세지호출
		return 
	}
	
	if(!AWI_setPassword(sOldPW, sPW1))
		alertMassage('Fail to change password.'); //error 메세지호출
	location.href = "login.jsp";
}
</script>
</head>
<body style="background-color:#eeeeee;">    
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
					<h3 style="text-align: center;">Coinpool 암호변경</h3>					
					<div class="form-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">현재암호 : </span>
	  			    	<input type="password" class="form-control" placeholder="현재암호" id='id_oldpw' name="userPassword" maxlength="20">
				    </div>
					<div class="form-group" style="text-align:center; height:5px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">새암호 : </span>
	  			    	<input type="password" class="form-control" placeholder="새암호" id='id_newpw1' name="userPasswordNew" maxlength="20">
				    </div>
					<div class="form-group" style="text-align:center; height:5px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">새암호 확인 : </span>
	  			    	<input type="password" class="form-control" placeholder="새암호 확인" id='id_newpw2' name="userPasswordNew2" maxlength="20">
				    </div>
					<div class="form-group" style="text-align:center; height:5px;">
					</div>
					
					<div class="form-group" style="text-align:center">
						<input type="button" class="btn btn-primary pull-center" value="변경" onclick="setPW();">
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();">
					</div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<br /><br /><br /><br /><br />
</body>
</html>