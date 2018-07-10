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
</head>
<body style="background-color:#eeeeee;">    
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name="userPassWorldLossFom" method="post" action="login.jsp">
					<h3 style="text-align: center;">Coinpool 암호분실신고</h3>					
					<div class="form-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="row">	  			    	
	  			    	<table class="table" style="text-align:center; border:1px solid #ffffff;">
							<tbody>
								<tr>
									<td style="background-color:#ffffff; text-align:center;vertical-align:middle;height:200px;">암호 분실 신고 안내문</td>
								</tr>
							</tbody>
						</table>
				    </div>
					<div class="form-group" style="text-align:center; height:30px;">
					</div>
					
					<div class="form-group" style="text-align:center">
						<a href="login.jsp" class="btn btn-primary pull-center">확인</a> 
					</div>
				</form>			
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>