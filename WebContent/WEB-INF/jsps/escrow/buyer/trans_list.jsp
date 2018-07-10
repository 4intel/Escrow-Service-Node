<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<link rel="stylesheet" href="../css/cpwallet/bootstrap.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>

<style>
h3 {
	color:#24981f;font-size:24px;font-family:'맑은고딕','Malgun Gothic';font-weight:900;
}
</style>
<script>
	function searchAction() {
		listForm.pageIndex.value = "1";
		listForm.action="/index.do?curl=/escrow/buyer/trans_list.do";
		listForm.target="_self";
		listForm.submit();
	}
	
	function nextStep(pid) {
		if(confirm("택배 수취확인 처리를 진행합니다.")) {
			$.post('/escrow/buyer/trans_update.do',"tstate=3&idx="+pid, function(sRes){
				searchAction();
		    });	
		}
	}
</script>
	<div class="container">
		<form name="listForm" id="listForm" method="post" action="" onsubmit="return false;">
		<input type="hidden" name="pageIndex" id="pageIndex" value="${pageInfoVO.pageIndex }" />
		
		<h3>구매자 거래내역</h3>
		
		<div class="col-lg-4"></div>
		<div class="col-lg-12">
		
			<h5>구매자 목록</h5>
			<select name="searchId" id="searchId" onchange="searchAction()" class="form-control">
				<option value="-1">:::구매자 목록:::</option>
				<c:forEach items="${buyerList}" var="blist" varStatus="status">
					<option value="${blist.bwid }" <c:if test="${pageInfoVO.searchId==blist.bwid }">selected="selected"</c:if>>${blist.bwid_nm }</option>
				</c:forEach>
			</select>
		
			<div class="jumbotron" style="padding-top: 20px;">

				<div class="row">				    
					<table class="table table-striped" style="text-align: center; border:1px solid #ffffff">
						<thead>
							<tr style="background-color: #337ab7;color:#ffffff;">
								<th width="5%" style="text-align: center;">번호</th>
								<th style="text-align: center;">마켓</th>
								<th style="text-align: center;">상품명</th>
								<th style="text-align: center;">가격</th>
								<th width="10%" style="text-align: center;">구매자</th>
								<th width="10%" style="text-align: center;">거래일</th>
								<th width="15%" style="text-align: center;">진행상태</th>
								<th width="15%" style="text-align: center;">작업</th>
							</tr>						
						</thead>
						<tbody id='id_accountlist_table_tbody'>
						    <c:forEach items="${bbsList}" var="escrowInfo" varStatus="status">
							<tr style="background-color:#ffffff;">
								<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
								<td><c:out value='${escrowInfo.BOARD_MARKET}'/></td>
								<td><c:out value='${escrowInfo.BOARD_SUBJECT}'/></td>
								<td><fmt:formatNumber value="${escrowInfo.BOARD_PRICE}" groupingUsed="true" /></td>
								<td><c:out value='${escrowInfo.BWID_NM}'/></td>
								<td><c:out value='${escrowInfo.REGDATE}'/></td>
								<td>
									<c:if test="${escrowInfo.TSTATE==1}"><span>구매요청</span></c:if>
									<c:if test="${escrowInfo.TSTATE==2}"><span style="color:red;">배송출발</span></c:if>
									<c:if test="${escrowInfo.TSTATE==3}"><span>수취확인</span></c:if>
									<c:if test="${escrowInfo.TSTATE==4}"><span style="color:blue;">거래완료</span></c:if>
								</td>
								<td>
									<c:if test="${escrowInfo.TSTATE==1}">
										배송 준비중...
									</c:if>
									<c:if test="${escrowInfo.TSTATE==2}"><button type="button" class="btn btn-success" onclick="nextStep('${escrowInfo.IDX}')">물품 수취확인</button></c:if>
									<c:if test="${escrowInfo.TSTATE==3}">수취완료 / 입금 대기중</c:if>
									<c:if test="${escrowInfo.TSTATE==4}"></c:if>
								</td>
							</tr>
							</c:forEach>
						</tbody>
					</table> 
					
					<!--페이징 시작-->  
					<%
					String p_link_script = "fn_select_list";			// Link URL (한글이 포함된 파라메터가 있는 경우 post 방식으로 사용)
					String p_formObjectId = "frm";						// Form name
					String p_pageObjectId = "pageIndex";				// 페이징 번호 객체
					String p_link_url = "/index.do?curl=/escrow/buyer/trans_list.do";								// Link URL
					String[] p_str = null;								// 파라메터
					%>
					<%@include file="/include/pagebar.jsp" %>
					<!--페이징 끝-->
				</div>
				
					
			</div>
		</div>
		
		</form>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
