<%@ page language="java" contentType="text/html; charset=utf-8"  pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.cmm.service.FouriProperties"%>
<!DOCTYPE html>
<html>
	<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="https://fonts.googleapis.com/css?family=Baloo+Tammudu" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="/js/loader.js"></script>
    <script src="/js/cpwallet/app_interface.js"></script>
	<script>
		//Web에서 로딩되자 마자 실행하는 스크립트
		$(function() {
		});

		// 전송
		function FnTransferCoin() {
			userWalletRimitFom.submit();
		}
    </script>
  	</head>
  <body>
  
		<nav class="navbar navbar-default navbar-fixed-top">
		  <div class="container">
		    <div class="navbar-header">
		        <span style="display:inline-block; width:100%; margin:0 auto; padding:10px 0px 0px 0px; text-align:center; vertical-align:middle; font-size:28px; font-family: 'Baloo Tammudu', cursive; color:#ffffff;" onclick="javascript:location.href='/user/login.jsp'"></span>
		    </div>
		  </div>
		</nav>


	<div class="container">
		<p style="height:50px;">&nbsp;</p>
        <span style="font-size:24px; font-weight:bold;">Faucet</span>
        <div style="width:100%; height:8px; text-align:center;"></div> 
        
		<!-- Body : S -->
		<form name="userWalletRimitFom" method="post" action="/faucet_proc.do" onsubmit="return false;">
		  
		  <div style="width:100%;border:1px solid #F5ECDC;border-radius: 5px;padding:10px 10px 25px 10px;background:#FFFCF7;word-wrap: break-word;">
		  	<h4>Testnet coin</h4>
		  	<p>address: cMgqV2GF7nWFkyPb5Yxr9uCSvcg4Eg4YosrsZaSXXE1XvJNEtJGB</p>
		  	<p>balance: ...</p>
		  	<br/><br/>
			  <div class="form-group">
			    <label for="name">User wallet</label>
			    <input type="text" class="form-control" name="walletName2" id="walletName2" placeholder="Wallet ID" />
			    <br/><br/>
			    <button type="button" class="btn btn-primary" onclick="FnTransferCoin()">request 500,000PX from faucet</button>
			  </div>
		  
		  </div>
		  
		</form> 
		<!-- Body : E -->
		
	</div>
	

  </body>

</html>

