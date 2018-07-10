<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="fouri.com.cmm.service.FouriProperties" %>

<%@ include file="lang.jsp" %> 
<%
String p_strAbsUrl = "http://"+request.getServerName()+":"+request.getLocalPort()+FouriProperties.getProjectRoot() + "/"  + p_strLang;
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<title>Coinpool</title>
<style type="text/css">
	a, a:hover {
		color:#000000;
		text-decoration:none;
	}
</style>
<script>
$(function(){
});

//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype){
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
}

function FnExitApp(){
	AWI_closeMenu();
	AWI_exitApp();
}

function FnGoLogin(){
	AWI_closeMenu();
	AWI_goUrl('<%=p_strAbsUrl%>/login.jsp');
}
function FnGoLogout(){
	AWI_closeMenu();
	AWI_checkPassword('');
	AWI_goUrl('<%=p_strAbsUrl%>/login.jsp');
}

function FnGoAccountListMain(){
	AWI_closeMenu();
	AWI_goUrl('<%=p_strAbsUrl%>/accountListMain.jsp');
}

function FnGoWalletListMain(){
	AWI_closeMenu();
	AWI_goUrl('<%=p_strAbsUrl%>/WalletList.jsp');
}

function FnGate()
{

	var sAID = AWI_getConfig('$ACCOUNT_ID');
	var sOS = AWI_getConfig('$DEVICE_OS');
	var sDID = AWI_getConfig('$DEVICE_ID');
	var sURL = '<%=p_strAbsUrl%>/gate.jsp?aid=' + sAID + '&did='+sDID+'&os='+sOS;	
	AWI_closeMenu();
	AWI_goUrl(sURL);
}

function FnScriptTest()
{
	AWI_closeMenu();
	
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "testAPI";
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

function FnSendTest()
{
	AWI_closeMenu();
	AWI_goUrl('<%=p_strAbsUrl%>/WalletRimit_chs.jsp');
}
//개발중 , 함수 테스트 용 
function api_testAPI(sParam)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=testAPI&param="+sParam;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "testAPI";
	params['param'] = sParam;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

function FnSetDefaultAccount()
{
	AWI_closeMenu();
	AWI_resetAccount();
}

function  FnClearCache()
{
	AWI_closeMenu();
	AWI_clearCache();
}

function FnClearPushID()
{
	AWI_closeMenu();
	AWI_setConfig("$PUSH_ID","");
}

function FnAlarmPopup()
{
	AWI_closeMenu();

	var joCmd = null;
	var params = new Object();
	params['cmd'] = 'alarmPush';
	params['title'] = 'Coinpool';
	params['msg'] = 'lee-HOME-결제되었습니다.';
	params['wid'] = '000000';
	params['cid'] = 100;
	joCmd = {func:params};
	var sReturn = window.AWI.callAppFunc(JSON.stringify(joCmd));
	var joReturn = JSON.parse(sReturn);	
}
function  FnMenuReload()
{
	AWI_closeMenu();

	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=title&value="+strTitle;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "reload menu";
	params['value'] = "";
	joCmd = {func:params};
	window.AWI.callAppMenuFunc(JSON.stringify(joCmd));	
}
var j_bWaitOn = true;
function FnWaitCursor()
{
	AWI_closeMenu();

	var joCmd = null;
	var params = new Object();
	params['cmd'] = 'waitCursor';
	params['msg'] = '여는중';
	params['show'] = j_bWaitOn ? "true" : "false";
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));		
	
	j_bWaitOn = !j_bWaitOn;
}
function FnGoEscrow()
{
	AWI_closeMenu();
	AWI_goUrl('http://escrow.coinpool.world/mbbs.do');
}

</script>
</head>

<body style="background-color:#eeeeee;">    

	<table class="table table-striped" style="text-align:center; border:1px solid #ffffff;">
		<thead>
			<tr style="background-color: #337ab7;color:#ffffff;">
				<th width="70%" style="text-align:left;vertical-align:middle;">메인메뉴</th>
				<th width="30%" style="text-align:right;"><a href="javascript:FnExitApp();" class="btn btn-primary pull-center">앱종료</a></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnGoLogout();">로그아웃</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnGoAccountListMain();">계정관리</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnGoWalletListMain();">지갑관리</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnGoEscrow();">에스크로 사이트</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnExitApp();">종료</td>
			</tr>
		</tbody>
	</table>
	
	<!--
	<table class="table table-striped" style="text-align:center; border:1px solid #ffffff;">
		<thead>
			<tr style="background-color: #337ab7;color:#ffffff;">
				<th style="text-align:left;vertical-align:middle;">임시메뉴(DEBUG)</th>
			</tr>
		</thead>
		<tbody> 
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnGate();">대문통과</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnMenuReload();">Reload Menu</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnSetDefaultAccount();">기본 계정으로 설정</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnClearCache();">Clear Web Cache</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnClearPushID();">Clear Push ID</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnScriptTest();">스크립트 디버깅</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnAlarmPopup();">Alarm Test</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:left;vertical-align:middle;" onclick="FnSendTest();">Send Test</td>
			</tr>
		</tbody>
	</table>
	-->
<!-- 	
	<a href="#none" onclick="FnClearCache();"> Clear Web Cache</a>
	 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>