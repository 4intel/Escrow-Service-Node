<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/kor/alertMessage.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<link rel="stylesheet" href="/css/bootstrap.min.css" />
<script src="/js/jquery.min.js"></script>
<script src="/js/popper.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/cpwallet/app_interface.js"></script>
<script>

var p_sAID = null;
var p_sANM = "";
var p_sCID = null;
var j_curWID = "";
var j_curWNM = "";

$(function(){
});
//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	// AWI_XXX 메소드 활성화
	AWI_ENABLE = true;
	if(dtype=='android')
		 AWI_DEVICE = dtype;
 	j_curAID = AWI_getConfig("$ACCOUNT_ID");
	if(!AWI_isCheckPassword()) {
		alertMassageUrl('Please use after login.','/kor/login.jsp');
		return false;
	}
}
</script>
<title>Escrow Bbs</title>
</head>
<body style="background-color:#eeeeee;">
	<div class="container">
		<div style="text-align:center;width:100%;">
			<br/>
			<h3>Escrow Product List</h3>
			
			<div style="padding-top: 20px;width:100%;">

				<div class="table-responsive" style="background-color: #ffffff;">  				    
					<table class="table" style="text-align: cetner; border:1px solid #ffffff; background-color: #ffffff; margin-bottom: 7px;width:100%;">
						    <c:forEach items="${bbsList}" var="bbsListInfo" varStatus="status">
							<tr>
								<td colspan="2" style="border-bottom:1px solid #fff;"><a href="/mbbsViewArticle.do?boardNum=<c:out value='${bbsListInfo.BOARD_NUM}'/>"><c:out value='${bbsListInfo.BOARD_SUBJECT}'/></a></td>
								<td style="border-bottom:1px solid #fff;"><c:out value='${bbsListInfo.BOARD_MARKET}'/></td>
							</tr>
							<tr>
								<td><span style="font-size:16px; font-weight:bold; color:#d34202;"><fmt:formatNumber value="${bbsListInfo.BOARD_PRICE}" groupingUsed="true" /></span></td>
								<td><c:out value='${bbsListInfo.BOARD_NAME}'/></td>
								<td><c:out value='${bbsListInfo.BOARD_DATE}'/></td>
							</tr>
							</c:forEach>
					</table>
					
					<!--페이징 시작--> 
					<%
					String p_link_script = "fn_select_list";			// Link URL (한글이 포함된 파라메터가 있는 경우 post 방식으로 사용)
					String p_formObjectId = "frm";						// Form name
					String p_pageObjectId = "pageIndex";				// 페이징 번호 객체
					String p_link_url = "/mbbs.do";								// Link URL
					String[] p_str = null;								// 파라메터
					%>
					<%@include file="/include/pagebar.jsp" %>
					<!--페이징 끝-->
				</div>
					
			</div>
		</div>
	</div>
</body>
</html>