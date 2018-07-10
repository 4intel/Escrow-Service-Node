<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%
	String strAccountID = EtcUtils.NullS(request.getParameter("aid"));
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
	loadAccountName();
}

var p_sAID = null;

function loadAccountName() {
	p_sAID = "<%=strAccountID%>"
	if(p_sAID != null && p_sAID != undefined && p_sAID.length > 0){
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
		     				document.getElementById("id_account_name").innerHTML = "계정 : " + joRes[0].name;
		     			}
		        	}
		        },   
		       error:function(xhr,status,error)
		        { 
		        } 
		 });
	}
}

</script>
</head>
<body style="background-color:#eeeeee;">
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name="userDeleteConfirmFom" method="post" action="#">
					<h3 style="text-align: center;">Coinpool 계정삭제완료</h3>					
					<div class="form-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span id="id_account_name" class="input-group-addon" style="font-weight:bold; height:50px;">계정 : </span>
				    </div>
					<div class="form-group" style="text-align:center; height:30px;">
					</div>				
					
					<div class="row">	  			    	
	  			    	<table class="table" style="text-align:center; border:1px solid #ffffff;">
							<tbody>
								<tr>
									<td style="background-color:#ffffff; text-align:center;vertical-align:top;height:100px;font-weight:bold;">
									[알림]<br />
									계정이 성공적으로 삭제되었습니다.<br />
									백업키(12개)를 모두 분실되지 않도록<br />
									보관하십시오.<br />
									</td>
								</tr>
							</tbody>
						</table>
				    </div>
				    <div style="text-align:center; height:10px">
					</div>
					
					<div class="form-group" style="text-align:center">
						<input type="button" class="btn btn-primary pull-center" value="확인" onclick="location.href='accountListMain.jsp';">
					</div>			    
				</form>			
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>