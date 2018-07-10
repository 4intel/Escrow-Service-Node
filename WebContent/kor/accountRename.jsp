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
<script>
$(function(){
});

//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype) {
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
	loadAccountName();
}

var p_sAID = null;
var p_sANM = null;

function loadAccountName() {
	p_sAID = AWI_getConfig("$ACCOUNT_ID");
	p_sANM = AWI_getConfig("ACCOUNT_NM");
	if(p_sAID != null && p_sAID != undefined && p_sAID.length > 0){
		document.getElementById("id_account_name").value = p_sANM;
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
		     				document.getElementById("id_account_name").value = joRes[0].name;
		     			}
		        	}
		        },   
		       error:function(xhr,status,error)
		        { 
		        } 
		 });
		*/
	}
}

function SetAccountName(){
	p_sAID = AWI_getConfig("$ACCOUNT_ID");
	var sAName = document.getElementById("id_account_name").value
	if(sAName.length <= 0){
		alertMassage('Invalid Account name.'); //error 메세지호출
		return;
	}
	var sReturn = AWI_changeAccountName(p_sAID,sAName);
	var joReturn = JSON.parse(sReturn);
	if(joReturn.result=="OK") {
		//var sQuery = "aid=" + p_sAID + "&name=" + sAName;
		//$.post("../proc/query_update_account.jsp",sQuery);
		location.href='accountListMain.jsp';	
	}
}
</script>
</head>
<body>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">Update Account</h2>
				<hr/>
			</div>
				<div class="form-group">
  			    	<span class="input-group-addon" style="font-weight:bold;">Account Name : </span>
  			    	<input type="text" id="id_account_name" class="form-control" placeholder="Account Name" name="userName" maxlength="20" value=""/>
			    </div>
				
				<div class="form-group" style="text-align:center">
					<input type="button" class="btn btn-primary pull-center" value="Update" onclick="javascript:SetAccountName();">
					<input type="button" class="btn btn-primary pull-center" value="Cancel" onclick="history.back();">
				</div>
		</div>
	</div>
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>