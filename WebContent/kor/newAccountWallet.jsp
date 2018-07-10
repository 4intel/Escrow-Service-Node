<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%> 
<%@ include file="lang.jsp" %> 
<%
HttpSession p_Session = request.getSession(false);
if(p_Session == null)
{
	response.sendRedirect("sorry.jsp");
	return;
}

//이 페이지로 오기위해서는 반드시 gate.jsp 를 거치고 와야 한다. 
//    gate.jsp 에서 session.DID session.OS session._T$MP_ID 등을 설정해준다.
//아래 "_T$MP_ID"  는 gate.jsp에서 만들어준 임시 Session ID 이다. 
String p_strTempID =  EtcUtils.NullS((String)p_Session.getAttribute("_T$MP_ID"));
if(p_strTempID.isEmpty())
{
	p_strTempID =  EtcUtils.NullS((String)p_Session.getAttribute("ID"));
}
if(p_strTempID.isEmpty())
{
	response.sendRedirect("sorry.jsp");
	return;
}

// 장치 ID
String p_strDID = EtcUtils.NullS((String)p_Session.getAttribute("DID"));
if(p_strDID.isEmpty())
{
	response.sendRedirect("sorry.jsp");
	return;
}
// 장치 OS
String p_strOS =  EtcUtils.NullS((String)p_Session.getAttribute("OS"));
if(p_strOS.isEmpty())
{
	response.sendRedirect("sorry.jsp");
	return;
}

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="../js/cpwallet/app_interface.js"></script>
<style>
button {
	font-size:80px;
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
}

function FnNewWallet()
{
	var sNewWallet = AWI_newWallet("",100);  // { "result":"OK" , "aid":"account id" , "wid":"wallet id","cid":100 }
	var joNewWallet = JSON.parse(sNewWallet);
	if(joNewWallet['result'] != "OK")
	{
		location.href = "sorry.jsp";	
	    return;
	}
	var sAccountID = joNewWallet['aid'];
	var sWalletID = joNewWallet['wid'];
	var nCoinID = joNewWallet['cid'];
	var sPushID = AWI_getConfig("$PUSH_ID");
    var sGateQuery = "aid=" + sAccountID + "&wid=" + sWalletID + "&cid=" + nCoinID  + "&did=<%=p_strDID%>" + "&pid=" + sPushID + "&os=<%=p_strOS%>";
	 var sDInfo = AWI_getConfig('$DEVICE_INFO');
	var sParam = sGateQuery + "&inf=" + sDInfo;
	$.post("../proc/query_new_account.jsp",sParam,function(data,status){
		var bResult = false;
		if(status == "success")
		{
			var sRes = data.trim();
			var joRes = JSON.parse(sRes);
			if(joRes['result'] == "OK")
			{
		       bResult = true;
  		   	   AWI_notiWallet("OK",sAccountID,sWalletID);
				location.href = "gate.jsp?" + sGateQuery;	
			}
		}
		
		if(!bResult)
		{
			location.href = "sorry.jsp";		
		}
	});
}

function FnRestoreWallet()
{
	AWI_changeView("restoreWallet","")
}
</script>
</head>
<body>

<div style="width:100%;">
<center>
  <table border="0" cellspacing="0" cellpadding="0"  style="margin-top:300px;width:80% ">
  <tr>
    <td colspan="2"><H1>관리되는 지갑이 없습니다.</H1></td>
  </tr>
  <tr>
    <td><a href="javascript:FnNewWallet()"><H2>새 지갑 만들기</H2></a></td>
    <td><a href="javascript:FnResoreWallet()"><H2>기존 지갑 가져오기</H2></a></td>
  </tr>
</table>
</center>
</div>


</body>
</html>