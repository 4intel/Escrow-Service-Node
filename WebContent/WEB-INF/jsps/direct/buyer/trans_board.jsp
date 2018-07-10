<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="../js/cpwallet/app_interface.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>

<script type="text/javascript" src="/js/qr/jquery.qrcode.js"></script>
<script type="text/javascript" src="/js/qr/qrcode.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>

	<script>
	var nowSIDX = 0;
	function checkDb() {
		$.post('/direct/buyer/check_order.do',"nowSIDX="+nowSIDX, function(sRes){
			var data = JSON.parse(sRes);
			if(data.message=='') {
			    setTimeout(checkDb,3000);
			} else {
				if(nowSIDX==0) {	// 현재 진행중 여부
					var result = (data.message).split("|");	
					nowSIDX = result[0];
					
					jQuery('#qrcodeTable').qrcode({
						render	: "table",
						text	: result[2]
					});	

					$.ajax({
						type     : 'POST',
						dataType : "json",
						url      : '/direct/buyer/order_product_list.do',
						data     : "sidx="+nowSIDX,
						success  : function (data) {
							if( data.result == 'success' ) {
								var oList = data.order_list;
								var sump = 0;
								for(var idx=0; idx< oList.length; idx++) {
									var appendStr = '<tr><td><span>'+oList[idx].SNAME+'</span></td>';
									appendStr+='<td><span>'+oList[idx].SUNIT+'</span></td>';
									appendStr+='<td><span>'+oList[idx].SCNT+'</span></td>';
									appendStr+='<td><span>'+(parseInt(oList[idx].SUNIT) * parseInt(oList[idx].SCNT))+'</span></td></tr>';
									sump += (parseInt(oList[idx].SUNIT) * parseInt(oList[idx].SCNT));
									$('#order_box > tbody:last-child').append(appendStr);
								}
								$('#order_box > tbody:last-child').append("합계금액 : "+sump);
							}
						}
					});
					
				}	// if(nowSIDX==0) {
				if(nowSIDX!=0) {
					var result = (data.message).split("|");	
					if(result[1]=='1') {
						nowSIDX = 0;
						$('#order_box tbody').html('');
						$('#qrcodeTable').html('');
						$('#order_box > tbody:first-child').append('<tr><td style="background:#eee;" width="25%"><span>메뉴명</span></td><td style="background:#eee;" width="25%"><span>단가</span></td><td style="background:#eee;" width="25%"><span>수량</span></td><td style="background:#eee;" width="25%"><span>금액</span></td></tr>');
					}
				}

			    setTimeout(checkDb,3000);	
			}
	    });		
	}
	
	checkDb();
	</script>
	
	<div class="container">
	
		<h3>구매자 대기 화면</h3>
		<div style="border:1px solid #ccc;margin:30px 30px 30px 30px;width:100%;height:100%;min-height:300px;" id="buyer_box">

			<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td width="50%" style="padding:10px 10px 10px 10px;" valign=top>
						<table cellpadding="0" cellspacing="0" border="0" width="100%" id="order_box">
						<tr>
							<td style="background:#eee;" width="25%"><span>메뉴명</span></td>
							<td style="background:#eee;" width="25%"><span>단가</span></td>
							<td style="background:#eee;" width="25%"><span>수량</span></td>
							<td style="background:#eee;" width="25%"><span>금액</span></td>
						</tr>
						<tbody>
						</tbody>
						</table>
				</td>
				<td width="50%" style="padding:10px 0 0 10px;">
					<div id="qrcodeTable"></div>
				</td>
			</tr>
			</table>
		</div>
	
	</div>

