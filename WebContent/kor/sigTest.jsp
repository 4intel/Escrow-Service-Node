<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ include file="lang.jsp" %> 
<%

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

//-----------------------------	
//사용자 소유의 새로운 사이트를 등록한다
// 기본 GATE도 같이 등록된다
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
<script> 
function clearText(y)
{ 
	if (y.defaultValue==y.value) 
		y.value = ""; 
} 
function checkValue(str)
{ 
  if(str == null)
	  return false;
  var v = str.trim();
	if (v == "")
	  return false;
	return true;
}

var privateExponent = "4B48F60D02460811DABF74D79770E8DD72B5EEFF1324F651D4543D98B8C9F0F7ED3E245C49D967A30B279564AFF4FE53E2D92704FB4D6E923732F4AF8CFDA2114A49B6E425FD44AEACB80F00125AF6468F1A666EDDD5CFD6BFAB27950EF3DFB78671734BF1BB782CBB654A7FBB9BFB897E37F0324710360E1515B1FF0EE7FAF1";

var modulus = "00A68A945DE1175E4EBA23C53B8A1237CE9AA292020ECB373D90837FBD8DB8164687B7913543EA838E2B669BD1626FA9872397C5398485D951CFC229E102A78654B61E9EB2BC3B36BD2624ACF5C8B82ABD33A5AF4144C55034A3E5BF8282F3D5CB0CF9F550844E68A58DADC3BCC7CF726F227F8EC5FAC2494F1FBDEEF39212B5FF";

var publicExponent = "10001";
function FnSigTest()
{
	var signature = "Hello world";
	var rsa = new RSAKbcdfhinprstwey();
	rsa.setPrivate(modulus, publicExponent, privateExponent);

	var result = rsa.signString(signature, 'sha256');
	rsa.setPublic(modulus, publicExponent);

	console.log(result);
	console.log(rsa.verifyString(result, 'sha256'));
}
</script> 
</head>
<body>
<div><textarea rows="5" cols="80" style="width:500px; height:300px; font-size:12pt;"></textarea></div>
<div id="id_result"></div>
<button onClick="FnSigTest()">Test</button>
</body>
</html>
