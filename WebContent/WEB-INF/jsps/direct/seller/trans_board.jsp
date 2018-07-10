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

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
<style>
#order_box td {
	text-align:center;
}
#order_box td span{
	width:100%;
}
h5 {
	padding-left:20px;
}
</style>

	<div class="container">
		<form name="listForm" id="listForm" method="post" action="" onsubmit="return false;">
		
			<h3>카운터 관리</h3>
			

			<script>
				var paySum = 0; 	
			
				function addRow() {
					var appendStr = '<tr><td><span><input type="hidden" name="SNAME" value="'+listForm.s_mname.value+'" />'+listForm.s_mname.value+'</span></td>';
					appendStr+='<td><span><input type="hidden" name="SUNIT" value="'+listForm.s_unit.value+'" />'+listForm.s_unit.value+'</span></td>';
					appendStr+='<td><span><input type="hidden" name="SCNT" value="'+listForm.s_cnt.value+'" />'+listForm.s_cnt.value+'</span></td>';
					appendStr+='<td><span><input type="hidden" name="SSUM" value="'+(parseInt(listForm.s_unit.value) * parseInt(listForm.s_cnt.value))+'" />'+(parseInt(listForm.s_unit.value) * parseInt(listForm.s_cnt.value))+'</span></td></tr>';
					
					$('#order_box > tbody:last-child').append(appendStr);
					paySum += parseInt(listForm.s_unit.value) * parseInt(listForm.s_cnt.value);
					listForm.totalpay.value = paySum;
					listForm.s_mname.value = '';
					listForm.s_unit.value = '0';
					listForm.s_cnt.value = 1;
				}
				
				function calcMcnt(typ) {
					if(typ=='+') {
						listForm.s_cnt.value = parseInt(listForm.s_cnt.value)+1;
					} else {
						if(listForm.s_cnt.value!='1')
							listForm.s_cnt.value = parseInt(listForm.s_cnt.value)-1;
					}
				}
				
				function allClear() {
					paySum = 0;
					listForm.s_mname.value = '';
					listForm.totalpay.value = '0';
					listForm.s_unit.value = '0';
					listForm.s_cnt.value = 1;
					$('#order_msg').html('결제 대기중...');	
					$('#order_msg').css('display','none');
					$('#order_box tbody').html('');
					$('#order_box > tbody:first-child').append('<tr><td style="background:#eee;" width="25%"><span>메뉴명</span></td><td style="background:#eee;" width="25%"><span>단가</span></td><td style="background:#eee;" width="25%"><span>수량</span></td><td style="background:#eee;" width="25%"><span>금액</span></td></tr>');
				}
				
				var insertNo = 0;
				function sendOrder() {
					if(listForm.SNAME) {
						if(listForm.SNAME.value!='' || listForm.SNAME.length>1) {
							$.post('/direct/seller/send_order_proc.do',$('#listForm').serialize(), function(sRes){
								$('#order_msg').css('display','block');
								var data = JSON.parse(sRes);
								insertNo = data.message;
								checkdb();
						    });		
						}
					}
				}
				
				function checkdb() {
					$.post('/direct/seller/check_order.do',"nowSIDX="+insertNo, function(sRes){
						var data = JSON.parse(sRes);
						if(data.message!='') {
							var result = (data.message).split("|");
							if(result[1]=='1') {
								insertNo = 0;
								$('#order_msg').html('결제완료!<br/> 성명 : '+(result[4]) + ', 입금액 : '+result[5] + '<br/><button type="button" class="btn btn-warning btn-lg" style="width:95%;" onclick="allClear();">확인</button>');	
							}
						}
					});
					
					if(insertNo>0) {
					    setTimeout(checkdb,3000);	
					}
				}
			</script>
			
			<p>판매자 지갑주소</p>
			<input type="text" name="swid" value="cMfwAqGkefFdWfHoZBhBcpJViSaefJ113QfmjFMSnqBzixDoNw78" class="form-control" />
			
			<div style="position:absolute;top:50%;left:50%;width:300px;height:200px;margin:-150px 0 0 -150px;z-index:500;border:1px solid #ccc;background-color:#fff;display:none;padding:10px 10px 10px 10px;" id="order_msg">
				결제 대기중...
			</div>
			
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td width="50%" style="padding-right:15px;vertical-align:top;height:auto;border-right:1px solid #ccc;">
				
					<h5>주문내역</h5>
					<!-- 주문사항 -->
					
					<div style="border:1px solid #ccc; width:100%;min-height:250px;">
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
						
					</div>
						
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td style="padding-right:10px;"><p>합계금액</p></td>
						<td colspan="2"><input type="text" name="totalpay" value="0" class="form-control" /></td>
					</tr>
					<tr>
						<td colspan="2" style="padding-right:10px;"><p>메뉴명</p>
							<input type="text" name="s_mname" value="" class="form-control" /></td>
						<td><p>단가</p>
							<input type="text" name="s_unit" value="0" class="form-control" /></td>
					</tr>
					<tr>
						<td width="30%"><button type="button" class="btn btn-primary" style="width:100%;" onclick="calcMcnt('-');"><span class="glyphicon glyphicon-minus" style="font-size:20pt;font-weight:bold;height:40px;"></span></button></td>
						<td width="40%" style="text-align:center;padding:5px 5px 5px 5px;" ><p>수 량</p>
							<input type="text" name="s_cnt" value="0" class="form-control" /></td>
						<td width="30%"><button type="button" class="btn btn-primary" style="width:100%;" onclick="calcMcnt('+');"><span class="glyphicon glyphicon-plus" style="font-size:20pt;font-weight:bold;height:40px;"></span></button></td>
					</tr>
					</table>
					
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td colspan="2"><button type="button" class="btn btn-primary btn-lg" style="width:100%;" onclick="addRow();">메뉴추가</button></td>
					</tr>
					<tr><td colspan="4" style="height:10px;"></td></tr>
					<tr>
						<td><button type="button" class="btn btn-warning btn-lg" style="width:95%;" onclick="sendOrder();">주문서 전송</button></td>
						<td><button type="button" class="btn btn-warning btn-lg" style="width:95%;" onclick="allClear();">초기화</button> </td>
					</tr>
					</table>
					
				</td>
				
				
				<script>
				function addMenu() {
					if(listForm.mname.value == "") {
						return;
					}
					if(listForm.unit.value == "") {
						return;
					}
					$.post('/direct/seller/product_insert_proc.do',$('#listForm').serialize(), function(sRes){
						listForm.target="_self";
						listForm.action="/index.do?curl=/direct/seller/trans_board.do";
						listForm.submit();
				    });	
				}
				function deleteMenu() {
					$.post('/direct/seller/product_delete_proc.do',$('#listForm').serialize(), function(sRes){
						listForm.target="_self";
						listForm.action="/index.do?curl=/direct/seller/trans_board.do";
						listForm.submit();
				    });	
				}
				
				function moveMenu(p1,p2) {
					listForm.s_mname.value = p1;
					listForm.s_unit.value = p2;
					listForm.s_cnt.value = 1;
				} 
				</script>
				<td width="50%" style="padding-left:15px;vertical-align:top;"> 
					<!-- 상품관리 -->
					<h5>상품목록</h5>
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td style="border:1px solid #ccc;">
							
							<c:forEach items="${productList}" var="plist" varStatus="status">
								<div class="col-xs-4" style="text-align:center;"> 
								  	<button type="button" class="btn btn-info btn-lg" style="width:100%;margin-top:7px;margin-bottom:7px;" onclick="moveMenu('${plist.MNAME }','${plist.UNIT }')">${plist.MNAME }</button>
								  	<div>
								  		<input type="checkbox" name="pidx" value="${plist.IDX }" style="position:absolute;top:10px;right:20px;" />
								  	</div> 
								</div>
							</c:forEach>
						
						</td>
					</tr>
					</table>
					
					<hr/>
					 
					<div class="col-xs-6"> 
					  	메뉴명  
					    <input class="form-control" id="mname" name="mname" type="text" value=""/>
					</div>
					<div class="col-xs-6"> 
					  	단가 
					    <input class="form-control" id="unit" name="unit" type="text" value="0"/>
					</div>
					<div class="col-xs-12" style="text-align:center;"> 
						<br/>
						<button type="button" class="btn btn-primary btn-lg" style="width:40%;" onclick="addMenu();">메뉴추가</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-primary btn-lg" style="width:40%;" onclick="deleteMenu();">메뉴삭제</button> 
					</div> 
				</td>
			</tr>
			</table>
		
		</form>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
