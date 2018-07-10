<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%
request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
%>

<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<script src="../js/cpwallet/common.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
<style>
h5 {
	padding-left:20px;
}
</style>

<script>
function convertTimestamp(timestamp) {                                                                                 
	 var d = new Date(timestamp * 1000),	// Convert the passed timestamp to milliseconds       
		yyyy = d.getFullYear(),                                                                                            
		mm = ('0' + (d.getMonth() + 1)).slice(-2),	// Months are zero based. Add leading 0.  
		dd = ('0' + d.getDate()).slice(-2),			// Add leading 0.                                     
		hh = d.getHours(),                                                                                                   
		h = hh,                                                                                                                   
		min = ('0' + d.getMinutes()).slice(-2),		// Add leading 0.                                     
		ampm = 'AM',                                                                                                         
	 		time;                                                                                                                      
	 			                                                                                                                     
	 	if (hh > 12) {                                                                                                                    
	 		h = hh - 12;                                                                                                            
	 		ampm = 'PM';                                                                                                         
	 	} else if (hh === 12) {                                                                                                       
	 		h = 12;                                                                                                                   
	 		ampm = 'PM';                                                                                                         
	 	} else if (hh == 0) {                                                                                                          
	 		h = 12;                                                                                                                   
	 	}                                                                                                                                    
	 	                                                                                                                                     
	 	// ie: 2013-02-18, 8:35 AM	                                                                                             
	 	time = yyyy + '-' + mm + '-' + dd + ', ' + h + ':' + min + ' ' + ampm;                                       
	 		                                                                                                                             
	 	return time;                                                                                                                     
	 }                                                                                                                                        

function FnHistoryTransE() {
	$.post("/proc/historyTransE.jsp",$('#listForm').serialize(),function(data,status){
		var bResult = false;
		if(status == "success") {
			$('#order_box > tbody:last-child').html("");
			var sRes = JSON.parse(data.trim());
			if(sRes!=null && sRes.length>0) {
				for(var i=0; i<sRes.length ; i++) {
					var trno = sRes[i].trno;
					var flg = sRes[i].flg;
					var val = sRes[i].val;
					var amt = sRes[i].amt;
					var msg = sRes[i].msg;
					var mno = sRes[i].mno;
					var ttm = convertTimestamp(sRes[i].ttm);
					var appendStr = '<tr><td align=center><span>'+trno+'</span></td>';
					appendStr+='<td align=center><span>'+ttm+'</span></td>';
					if(mno==null || mno=='') {
						appendStr+='<td align=center><span>'+msg+'</span></td>';
					} else {
						appendStr+='<td align=center><span>'+mno+'</span></td>';
					}
					if(flg=='1') {
						appendStr+='<td align=center><span style="color:red;">-'+gfnAddComma(val)+'</span></td>';
					} else {
						appendStr+='<td align=center><span style="color:blue;">+'+gfnAddComma(val)+'</span></td>';	
					}
					appendStr+='<td align=center><span>'+gfnAddComma(amt)+'</span></td></tr>';
					
					$('#order_box > tbody:last-child').append(appendStr);
				}
			}
		}
	});
}
</script>

	<div class="container">
		<form name="listForm" id="listForm" method="post" action="" onsubmit="return false;">
		
			<h3>입출금 내역</h3>
			

			<script>
			
			</script>
			
			<p>판매자 지갑주소</p>
			<input type="text" name="tgwid" value="cMfwAqGkefFdWfHoZBhBcpJViSaefJ113QfmjFMSnqBzixDoNw78" class="form-control" />
			<br/>
			
			<button type="button" class="btn btn-warning btn-lg" style="width:30%;" onclick="FnHistoryTransE();">거래내역 조회</button>
			<br/><br/> 
			
			<table cellpadding="0" cellspacing="0" border="0" width="100%" id="order_box" class="table">
			<tr>
				<td style="background:#eee;" width="10%" align="center"><span>거래번호</span></td>
				<td style="background:#eee;" width="25%" align="center"><span>거래일시</span></td>
				<td style="background:#eee;" width="25%" align="center"><span>메세지</span></td>
				<td style="background:#eee;" width="20%" align="center"><span>금액</span></td>
				<td style="background:#eee;" width="20%" align="center"><span>잔액</span></td>
			</tr>
			<tbody>
			</tbody>
			</table>
			※ 최대 100건만 출력 됩니다.
		</form>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
