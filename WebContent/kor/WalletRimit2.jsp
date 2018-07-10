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
				<form name="userWalletRimitFom" method="post" action="userWalletRimitConfirm.jsp">
					<h3 style="text-align: center;">Coinpool 송금확인</h3>					
					<div class="form-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold; height:50px;">계정 : 계정001</span>
				    </div>
					<div class="form-group" style="text-align:center; height:10px;">
					</div>	
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">출금지갑 : </span>
	  			    	<input type="text" class="form-control" placeholder="출금지갑" name="walletName" maxlength="20" value="출금 지갑 001">
				    </div>
				    <div class="input-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">출금메모 : </span>
	  			    	<input type="text" class="form-control" placeholder="출금메모" name="walletContent" maxlength="20" value="출금메모">
				    </div>
				    <div class="input-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">출금액 : </span>
	  			    	<input type="text" class="form-control" placeholder="출금액" name="walletAmount" maxlength="20" value="출금액">
				    </div>
				    <div class="input-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">입금지갑 : </span>
	  			    	<input type="text" class="form-control" placeholder="입금지갑" name="walletName2" maxlength="20" value="입금 지갑 001">
				    </div>
				    <div class="input-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">입금메모 : </span>
	  			    	<input type="text" class="form-control" placeholder="입금메모" name="walletContent2" maxlength="20" value="입금메모">
				    </div>
				    <div class="input-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="input-group">
	  			    	<span class="input-group-addon" style="font-weight:bold;">입금액 : </span>
	  			    	<input type="text" class="form-control" placeholder="입금액" name="walletAmount2" maxlength="20" value="입금액">
				    </div>
				    <div class="input-group" style="text-align:center; height:10px;">
					</div>
					
					<div class="row">	  			    	
	  			    	<table class="table" style="text-align:center; border:1px solid #ffffff;">
							<tbody>
								<tr>
									<td style="background-color:#ffffff; text-align:center;vertical-align:top;height:60px;font-weight:bold;">
									위의 내용과 같이 코인을<br />
									송금 하시겠습니까?<br />
									</td>
								</tr>
							</tbody>
						</table>
				    </div>
					
					<div class="form-group" style="text-align:center">
						<input type="submit" class="btn btn-primary pull-center" value="변경">
						<input type="button" class="btn btn-primary pull-center" value="취소" onclick="history.back();">
					</div>
				</form>			
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>