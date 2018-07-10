<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<title>Coinpool</title>
</head>
<body style="background-color:#eeeeee;">
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name="userDeleteConfirmFom" method="post" action="#">
					<h3 style="text-align: center;">Coinpool 송금결과</h3>					
					<div class="form-group" style="text-align:center; height:10px;">
					</div>			
					
					<div class="row">	  			    	
	  			    	<table class="table" style="text-align:center; border:1px solid #ffffff;">
							<tbody>
								<tr>
									<td style="background-color:#ffffff; text-align:center;vertical-align:top;height:80px;font-weight:bold;">
									[알림]<br />
									성공적으로 코인이<br />
									송금되어습니다.<br />
									</td>
								</tr>
							</tbody>
						</table>
				    </div>
				    <div style="text-align:center; height:10px">
					</div>
					
					<div class="form-group" style="text-align:center">
						<input type="button" class="btn btn-primary pull-center" value="확인" onclick="location.href='userWalletHistory.jsp';">
					</div>			    
				</form>			
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>