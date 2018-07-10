<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
	
	var curWID = AWI_getConfig("_CUR_WID");
	var elemQR = $("#id_qrimage");
	var sLocalHost = AWI_getLocalHttpHost();
	var sURL = sLocalHost + "/cpwallet.data/qrcode.png?code=" + curWID + "&ec=M&sz=7";
	elemQR.attr("src",sURL);
}

function QRCodeDownload() {	
	var curWID = AWI_getConfig("_CUR_WID");
	var sLocalHost = AWI_getLocalHttpHost();	
	var sURL = sLocalHost + "/cpwallet.data/qrdown.png?code=" + curWID + "&ec=M&sz=10";	
	location.href=sURL;
	//location.href="file_down.jsp?file_name="+sURL;
}
</script>
</head>
<body style="background-color:#eeeeee;">    
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
					<h3 style="text-align: center;">Coinpool 지갑QR코드보기</h3>					
					<div class="form-group" style="text-align:center; height:20px;">
					</div>
					
					<div class="form-group" style="text-align:center;">			    	
	  			    	<img id='id_qrimage' src='' /></img>
				    </div>
					<div class="form-group" style="text-align:center; vertical-align:middle; height:20px;">
					</div>
					
					<div class="form-group" style="text-align:center">
						<input type="button" class="btn btn-primary pull-center" value="이미지 파일로 저장" onclick="QRCodeDownload();">
					</div>	
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>