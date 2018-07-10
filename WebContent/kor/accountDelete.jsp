<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Coinpool</title>
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

var j_sAID = null;
var j_sANM = null;

function loadAccountName() {
	j_sAID = AWI_getConfig("$ACCOUNT_ID");
	j_sANM = AWI_getConfig("ACCOUNT_NM");
	document.getElementById("id_account_name").value = j_sANM;
}

function FnAccountDelete(){
	AWI_deleteAccount(j_sAID);
}

function AWI_CallFromApp(strJson)
{ // '{ "func": { "cmd":"restoreAccount","result":"OK"} }'
	var joRoot = JSON.parse(strJson);  
	var joFunc = joRoot.func;

	if(joFunc.cmd == 'deleteAccount')
	{
		if(joFunc.result == 'OK'){
			location.href='accountDeleteConfirm.jsp?aid=' + joFunc.aid;
		}
	}
}

</script>
</head>
<body>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">Delete Account</h2>
				<hr/>
			</div>
				<form name="userDeleteFom" method="post" action="#">
					  <div class="form-group">
					    <label for="pwd">Account : </label>
					    <input type="text" id="id_account_name" class="form-control" placeholder="Account Name" name="userName" maxlength="20" readonly/>
					  </div>
					<div class="row">	  			    	
						
						<div class="alert alert-info">
									[주의]<br />
									계정을 삭제하기 위해서는 계정을 백업한 후에 삭제 가능 합니다.<br />
									백업 키를 분실하면 지갑 복구가 불가능하며 지갑에 있는 화폐는 모두 사용할 수 없게됩니다.<br />
									[확인]버튼을 누르면 백업 페이지로 이동합니다.<br />
						</div>
				    </div>
					<div class="form-group" style="text-align:center">						
						<input type="button" class="btn btn-primary pull-center" value="확인" onclick="FnAccountDelete();">
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();">
					</div>
				</form>
		</div>
	</div>
</body>
</html>