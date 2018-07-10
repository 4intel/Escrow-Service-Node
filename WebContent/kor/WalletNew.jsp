<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%> 
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.common.util.KeyManager"%>
<%@ page import="fouri.com.common.util.DateUtil"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="fouri.com.cpwallet.web.CPWalletUtil"%>
<%@ include file="lang.jsp" %>
<%@ include file="alertMessage.jsp" %>
<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

String strPID = "P001";

JSONObject joCoinList = null;
joCoinList = CPWalletUtil.getCoinHistory("queryCoin",strPID);

String strCoinValue = "";
if(joCoinList!=null) {
	strCoinValue = (String)joCoinList.getOrDefault("value","{}");	
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
<style>
#lb_coin_list li {
	list-style:none;
	text-align:left;
	line-height:200%;
	font-size:10pt;
}
</style>
<script>
//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
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
		document.getElementById("s_account_name").innerHTML = "계정 : " + p_sANM;
	}
}

function makeWallet() {
	var chk=false;
	var coinId= '';
	if(userWalletJoinFom.wid.length) {
		for(var c=0; c<userWalletJoinFom.wid.length; c++) {
			if(userWalletJoinFom.wid[c].checked) {
				chk=true;
				coinId = userWalletJoinFom.wid[c].value;
			}
		}
	} else {
		if(userWalletJoinFom.wid.checked) {
			chk=true;
			coinId = userWalletJoinFom.wid.value;
		}
	}
	if(!chk) {
		alertMassage('Coin checked.!'); //error 메세지호출
		return;
	}
	var makeResult = AWI_newWallet(p_sAID,parseInt(coinId.substring(5)),userWalletJoinFom.wName.value);
	var r2 = JSON.parse(makeResult);
	var wid = "";
	var cid = "";
	if(r2.result=='OK') {
		wid = r2.wid;
		cid = r2.cid;
		var sDI = AWI_getConfig('$DEVICE_INFO');
		$.ajax({
		       type:"POST",  
		        url:'/proc/query_make_wallet.jsp?dinfo='+sDI+'&aid='+p_sAID+'&wid='+wid+'&cid='+cid+'&wname='+userWalletJoinFom.wName.value,   
		        async: false,
		        success:function(data,status,xhr) {
					var sRes = data.trim();
					var joRes = JSON.parse(sRes);
		        	if(joRes['result'] == 'OK') {
		        		AWI_notiWallet('OK',p_sAID,wid,cid);
			        	location.href='/kor/WalletList.jsp';
		        	} else {
		        		alertMassageUrl(joRes['ref'],'/kor/WalletList.jsp'); //error 메세지호출
		        	}
		        },
		       error:function(xhr,status,error) { 
		    	   alertMassageUrl('Failed.','/kor/WalletList.jsp'); //error 메세지호출
		        } 
		 });
	} else {
		alertMassage('Failed.'); //error 메세지호출
	}
}

var p_coinList;
function WalletListRowColor(WalletRowID) {
	var WalletRowID = WalletRowID; //넘어온RowID값
   	
	for(var i =0; i < p_coinList.length ; i ++) {		
		if ("id_WalletID_"+i == WalletRowID) {
			document.getElementById("id_WalletID_"+i).style.backgroundColor = "#f9f9f9";
			document.getElementsByName('wid')[i].checked = true;
		} else {
			document.getElementById("id_WalletID_"+i).style.backgroundColor = "#ffffff";
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
				<h2 style="text-align: center;">Create Wallet</h2>
				<hr/>
			</div>
				<form name="userWalletJoinFom" method="post" action="userWalletJoinAction.jsp" onsubmit="return false;">
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold; height:50px;" id="s_account_name">Account : </span>
				    </div>
					<div class="form-group" style="text-align:center;" id="lb_coin_list">
					</div>
					
					<div class="form-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">지갑이름 : </span>
	  			    	<input type="text" class="form-control" placeholder="지갑이름" name="wName" maxlength="20"/>
				    </div>
					
					<div class="form-group" style="text-align:center">
						<input type="submit" class="btn btn-primary pull-center" value="만들기" onclick="makeWallet()"/>
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();">
					</div>
				</form>			
		</div>
	</div>
	
	<script>
		<%
		if(strCoinValue.equals("")) {			
			out.print("alertMassageCallBack('coin is empty');");
		}
		%>
		var obj = JSON.parse('<%=strCoinValue.replaceAll("\n", "")%>');
		p_coinList = obj;
	
		var sHtml = '<div class="row"><table class="table" style="text-align:center; border:1px solid #ffffff;">'; 
		sHtml += '<thead class="thead-light">'; 
		sHtml += '	<tr style="background-color: #337ab7;color:#ffffff;">'; 
		sHtml += '		<th width="18%" style="text-align:center;"></th>'; 
		sHtml += '		<th style="text-align:center;">Coin List</th>'; 
		sHtml += '	</tr>'; 
		sHtml += '</thead>'; 
		sHtml += '<tbody id="id_walletlist_table_tbody">';
		for(var i=0; i<obj.length; i++){
			sHtml += '<tr id="id_WalletID_' + i + '" style="background-color:#ffffff;" onclick="javascript:WalletListRowColor(\'id_WalletID_' + i + '\');">'
		      + '<td style="text-align:center;vertical-align:middle;">'
		      + '<input type="radio" name="wid" value="'+obj[i].cid+'"/></td>'
		      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj[i].nm + '</td>';
			sHtml +='</tr>';
		}
		sHtml += '		</tbody>';
		sHtml += '	</table>';
		sHtml += '</div>';
		$('#lb_coin_list').append(sHtml);
	</script>
	
						  			    	
	  			    	<table class="table table-striped" style="text-align:center; border:1px solid #ffffff;">
							<thead>
							</thead>
							<tbody id='id_walletlist_table_tbody'>
							</tbody>
						</table>
				    </div>
</body>
</html>