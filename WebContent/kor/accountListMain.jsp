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
<style type="text/css">
	a, a:hover {
		color:#000000;
		text-decoration:none;
	}
</style>
<script>

var j_curAID = "";
var j_curANM = "";
var j_listAccount = null;

$(function(){
});

//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
	j_curAID = AWI_getConfig("$ACCOUNT_ID");
	
	if(!AWI_isCheckPassword()) {
		alertMassageUrl('Please use after login.','login.jsp');
		return false;
	}
	
	loadAccountList();
}
function AWI_CallFromApp(strJson)
{ // '{ "func": { "cmd":"restoreAccount","result":"OK"} }'
	var joRoot = JSON.parse(strJson);  
	var joFunc = joRoot.func;

	if(joFunc.cmd == 'restoreAccount')
	{
		if(joFunc.result == 'OK')
		{
			location.href='accountRestoreConfirm.jsp';
			//loadAccountList();
		}
	}
	else if(joFunc.cmd == 'backupAccount')
	{
		if(joFunc.result == 'OK')
		{
			location.href='accountBackupConfirm.jsp';
			//loadAccountList();
		}
	}
}

function traceClear()
{
	$('#id_debug').text("");
}

function traceLog(sMsg)
{
	var sOldMsg = $('#id_debug').text();
	sOldMsg += sMsg;
	$('#id_debug').text(sOldMsg);
}

//-------------------------------
function proc_list_Account()
{
	j_listAccount  = AWI_listAccount();
	
	
	//var listAccount = []
	/*
	var sParam = JSON.stringify(listAccount);
	
	$.ajax({
	       type:"POST",  
	        url:'/proc/query_list_account.jsp',   
	        data: JSON.stringify(listAccount),
	        async: false,
	        success:function(data,status,xhr)
	        {
	        	if(status == 'success')
	        	{
	     			var sRes = data.trim();
	     			var joRes = JSON.parse(sRes);
	    			// [ {"aid":"xxxxx" , "name":"우리나라 지갑"}, 
	    			//	    {"aid":"xxxxx2" , "name":"우리나라 지갑2"} ]	
	    		    j_listAccount = joRes;
	        	}
	        },   
	       error:function(xhr,status,error)
	        { 
				
	        } 
	 });
	*/
}

function loadAccountList()
{
	traceClear();
	proc_list_Account();
	/*
	if(j_listAccount == null)
	{
		alertMassage('No account information.'); //error 메세지호출
		return;
	}
	*/
	
	var sHTML = ""
	var rowCnt = 0;
	var elmtTBody = $('#id_accountlist_table_tbody');
	
	if(j_curAID.length <= 0){
		j_curAID = j_listAccount[0]['aid'];
		AWI_setAccount(j_curAID);
	}
	
	for(var i =0; i < j_listAccount.length ; i ++)
	{
	  	   sHTML += '<tr id="id_AccountID_' + i + '" style="background-color:#ffffff;" onclick="javascript:WalletListRowColor(\'id_AccountID_' + i + '\');">'
	  		      + '<td style="text-align:center;vertical-align:middle;">'
	  		      + '<input type="radio" name="name_AccountID" value="' + j_listAccount[i]['aid'] + '"></td>'
	  		      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + j_listAccount[i]['name'] + '</td>';
	  		      
	  		      if (j_curAID == j_listAccount[i]['aid']) {
	              	rowCnt = i;	
	        		j_curANM = j_listAccount[i]['name'];
	  		      }
	  		  	 
	}
	elmtTBody.html(sHTML);
	
	// row 출력후 마지막 row Checked
	document.getElementsByName('name_AccountID')[rowCnt].checked = true; //첫번째 row 체크
	document.getElementById("id_AccountID_"+rowCnt).style.backgroundColor = "#f9f9f9"; //첫번째 row 색상변경
	
}

function WalletListRowColor(WalletRowID) {
	if( j_listAccount == null)
		return;
	
	var WalletRowID = WalletRowID; //넘어온RowID값
   	
	for(var i =0; i < j_listAccount.length ; i ++) {		
		if ("id_AccountID_"+i == WalletRowID) {
			document.getElementById("id_AccountID_"+i).style.backgroundColor = "#f9f9f9";
			document.getElementsByName('name_AccountID')[i].checked = true;
			j_curAID = j_listAccount[i]['aid'];
			j_curANM = j_listAccount[i]['name'];
			//AWI_setAccount(j_curAID);
		} else {
			document.getElementById("id_AccountID_"+i).style.backgroundColor = "#ffffff";
		}
	}		
}

function FnSelAccount(){
	AWI_setAccount(j_curAID);
	AWI_setConfig("ACCOUNT_NM",j_curANM);
	loadWalletList();
	location.href='WalletList.jsp';
}

function loadWalletList() {
	var sRes = AWI_listWallet(j_curAID);
	p_walletList = sRes;
	for(var i =0; i < p_walletList.length ; i ++) {
		AWI_setConfig("_CUR_WID",p_walletList[i]['wid']);
		AWI_setConfig("_CUR_WNM",p_walletList[i]['name']);
		break;
	}
}

function FnAccountRename(){
	AWI_setAccount(j_curAID);
	AWI_setConfig("ACCOUNT_NM",j_curANM);
	location.href='accountRename.jsp';
}

function FnAccountDelete(){
	AWI_setAccount(j_curAID);
	AWI_setConfig("ACCOUNT_NM",j_curANM);
	location.href='accountDelete.jsp';
	//AWI_deleteAccount(j_curAID)
}

function FnAccountBackup(){
	AWI_setAccount(j_curAID);
	// location.href='accountBackup.jsp';
	AWI_changeView("backupAccount",j_curAID)
}
function FnAccountResore(){
	AWI_changeView("restoreAccount","")
	
}
</script>
</head>
<body>    
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;background-color: transparent !important;">
				<h2 style="text-align: center;">Account List</h2>
				<hr/>
			</div>
			
			<div id='id_debug'></div>
				<form name="userListFom" method="post" action="#">
					
					<div class="row">	  			    			    	
	  			    	<table class="table " style="text-align:center;">
						    <thead class="thead-light">
								<tr>
									<th width="18%" style="text-align:center;"></th>
									<th style="text-align:center;">Account List</th>
								</tr>
							</thead>
							<tbody id='id_accountlist_table_tbody'>
							</tbody>
						</table>
				    </div>
					
					<div class="form-group" style="text-align:center">
						<a href="javascript:FnSelAccount();" class="btn btn-primary pull-center">Confirm</a>
					</div>
					
					<div class="form-group" style="text-align:center">
						<a href="accountNew.jsp" class="btn btn-outline-primary">계정<br>생성</a>
						<a href="javascript:FnAccountRename();" class="btn btn-outline-primary">계정<br>변경</a>
						<a href="javascript:FnAccountDelete();" class="btn btn-outline-primary">계정<br>삭제</a>
						<a href="javascript:FnAccountBackup();" class="btn btn-outline-primary">계정<br>백업</a>
						<a href="javascript:FnAccountResore();" class="btn btn-outline-primary">계정<br>복원</a>
					</div>
				</form>			
		</div>
	</div>
</body>
</html>