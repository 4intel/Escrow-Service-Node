<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ include file="lang.jsp" %> 
<%
HttpSession p_Session = request.getSession(false);
if(p_Session == null)
{
	response.sendRedirect("gate.jsp");
	return;
}
String p_strAccountID = (String)p_Session.getAttribute("ID");
if(p_strAccountID == null)
{
	response.sendRedirect("gate.jsp");
	return;
}

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
%>
 <!DOCTYPE html>
 <html>
 <head>
 <meta charset="UTF-8">
 <meta name="viewport;" content=" user-scalable=no;" /> 

 <title>HTML5</title>
 <link type="text/css" rel="stylesheet" href="./css/style.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="../js/cpwallet/app_interface.js"></script>
  <script src="../js/basic_utils.js"></script>
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

function checkSpecial(str)
{
	//var special_pattern = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
	var special_pattern = /[`~!+{}#$%^&*|\\\'\";:\/?]/gi;
	if( special_pattern.test(str) == true )
	{
	    //alert('특수문자는 사용할 수 없습니다.');
	    return false;
	}
	return true;
}

// 테스트용 지갑 
var j_sAID = "cMgtvBQHg6pSazNXLkHzGNMkaPWGYH7mn4sxRHSxAocvvg7MVdEu";
var j_sWID = "cMiN9T8d5V9bAXCsvBsSkKB2zjYjSA3hvGmF6SwptaQAqfmN514B"; // coin id = 100
var j_nCID = 100;
var j_sTWID = "cMi4qDcskjSdfdxfoDUmjjaZaaKQ8QZGbGWdH4197M5HW2ADCmWn";

function fnResultHtml(sHTML)
{
	$("#id_result").html(sHTML);
}
function FnNewWallet()
{
	var sNewWallet = AWI_newWallet("",g_nCID);  // { "result":"OK" , "aid":"account id" , "wid":"wallet id","cid":100 }
	var joNewWallet = JSON.parse(sNewWallet);
	if(joNewWallet['result'] != "OK")
	{
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
	var sName= "내지갑"
	
    var sQuery = "aid=" + sAID + "&wid=" + sWID + "&cid=" + nCID + "&did="+sDID + "&pid=" + sPID 
                 + "&os=" + sOS + "&inf=" + sDI + "&name=" + sName;
    
  	 var sHTML = "<H1> 실패 입니다. </H1>" 
    
  	 $.post("../proc/query_new_account.jsp",sQuery,function(data,status){
		var bResult = false;
		if(status == "success")
		{
			var sRes = data.trim();
			var joRes = JSON.parse(sRes);
			if(joRes['result'] == "OK")
			{
		       bResult = true;
  		   	   AWI_notiWallet("OK",sAID,sWID);
  		  	   sHTML = "<table>"
  		  	                  +"<tr><td colspan=2> 새로운 지갑이 만들어 졌습니다.</td></tr>"
  		  	                  +"<tr><td>계정 지갑</td><td>" + sAID + "</td></tr>"
  		  	                  +"<tr><td>코인 지갑</td><td>" + sWID + "</td></tr>"
  		  	                +"</table>"; 
 			}
		}
		
	   	fnResultHtml(sHTML);
	});
}

function FnRestoreAccount()
{
	AWI_changeView("restoreAccount","")
} 
function FnBackupAccount()
{
	AWI_changeView("backupAccount",j_sAID)
}

function FnSendConfirm()
{
	var joSend = {};
    joSend['callback'] = "";
    joSend['aid'] = j_sAID;
    joSend['cid'] = j_nCID;
    joSend['twid'] = "cMi4qDcskjSdfdxfoDUmjjaZaaKQ8QZGbGWdH4197M5HW2ADCmWn";
    joSend['value'] = 1000000;
    
	AWI_sendConfirm(joSend);
}

function FnListAccount()
{
	var aryList  = AWI_listAccount()
	var sHTML = ""
	sHTML = "<table border='1' >"
            +"<tr><td colspan=2> 계정 지갑 목록 </td></tr>";
	for(var i =0; i < aryList.length ; i ++)
	{
	  	   sHTML += "<tr><td>" + (i + 1) + "</td><td>" + aryList[i] + "</td></tr>";
	}
    sHTML += "</table>"; 
   	fnResultHtml(sHTML);
} 

function FnVerifyWallet()
{
	alert(" confirm : " + AWI_verifyRID(j_sWID));
}

function FnDeleteAccount()
{
	var sAID = AWI_getConfig("$ACCOUNT_ID"); // 현재 계정 지갑 , AWI_setConfig() 지정 된
	AWI_deleteAccount(sWID)
	FnListAccount();
} 

function FnSampleQR()
{
	//var strText = encodeURIComponent('eqt&ec=M&sz=5');
	var strText = 'cMgXFgvWryGgKFjFMYGwm7Mr7K9mJWuxrUYEBi6SmM5a3kJGU9Mx'
	alert(strText);
	var sHost = AWI_getLocalHttpHost()
	var sQrImage = sHost + "/cpwallet.data/qrcode.png?code=" + strText + "&ec=M&sz=40";

	//$("#id_result img").attr('src',sQrImage);
	$("#id_result").html("<img src='" + sQrImage + "'>");
} 

function FnExitApp()
{
	AWI_exitApp();
} 
</script>
</head>

<body class="main-body">

<div class="wrap-body">
<!-- S : Login Area -->	
	<div  class="loginBg hCenter vCenter" >
			<div class="loginArea " style="vertical-align:middle; height:500px; margin-top:350px;">
				<div class="loginBox" style="width:100%; float:left;vertical-align:middle;">
				<div id="id_debug"></div>
				<div id="id_result"><img id="id_qrimg" src=""></img></div>
				<!-- 형식상 form --> 
				<form method="post" ></form>
				
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnListAccount();">Root 지갑 목록</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnRestoreAccount();">기존 지갑 등록</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnSendConfirm();">보내기 확인</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnBackupAccount();">지갑 백업</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnVerifyWallet();">지갑 ID 검증</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnDeleteAccount();">Root 지갑 삭제</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnSampleQR();">QR 셈플</div>
				<div class="btn btn-primary" style="width:100%; font-size:60px;vertical-align:middle;" onclick="javascript:FnExitApp();">종료하기</div>
					
				</div>
				
				
			</div>	

	</div>
<!-- E : Login Area -->	
</div>	
</body>
</html>


