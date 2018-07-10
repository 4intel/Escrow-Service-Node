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
String p_strAID = EtcUtils.NullS((String)p_Session.getAttribute("ID"));
if(p_strAID.isEmpty())
{
	response.sendRedirect("sorry.jsp");
	return;
}

// 새롭게 바뀔 장치 ID
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

function FnSure(sAns)
{

	if(sAns == 'continue')
	{
	    var sGateQuery = "aid=<%=p_strAID%>" + "&did=<%=p_strDID%>" + "&os=<%=p_strOS%>";
		var sDInfo = AWI_getConfig('$DEVICE_INFO');
		
		var sParam =  sGateQuery + "&dinfo=" + sDInfo;
		$.post("../proc/query_confirm_device.jsp",sParam,function(data,status){
			if(status == "success")
			{
				var rRes = data.trim();
				var joRes = JSON.parse(sRes);
				if(joRes['result'] == "OK")
				{
			       bResult = true;
	  		   	   AWI_notiWallet("OK",j_sAccountID,j_sWalletID);
					location.href = "gate.jsp?" + sGateQuery;	
				}
			}
		});
	}
	else // if( sAns == 'cancel')
	{
		//location.href = "bye.jsp";
		AWI_exitApp();
	}
}
</script>
</head>
<body>

<div style="width:100%;">
<center><table border="0" cellspacing="0" cellpadding="0"  style="margin-top:300px;width:80% ">
  <tr>
    <td colspan="2"><img src="./images/confirmDevice01.png" alt="confirm device" style="width:100%;"></td>
  </tr>
  <tr>
    <td><a href="javascript:FnSure('continue')"><img src="./images/confirmDevice02.png" alt="confirm device" style="width:100%;"></a></td>
    <td><a href="javascript:FnSure('cancel')"><img src="./images/confirmDevice03.png" alt="confirm device" style="width:100%;"></a></td>
  </tr>
</table>
</center>
</div>


</body>
</html>