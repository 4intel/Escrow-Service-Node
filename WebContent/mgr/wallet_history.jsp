<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%> 
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.common.util.KeyManager"%>
<%@ page import="fouri.com.common.util.DateUtil"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="fouri.com.cpwallet.web.CPWalletUtil"%>


<%@ include file="inc/top.jsp" %>
	
	
<!-- header S -->
<%@ include file="inc/header.jsp" %>
<!-- header E -->
	
	
<div class="page-with-contextual-sidebar page-with-sidebar">
	
	
	<!-- left: menu S -->
	<%@ include file="inc/left.jsp" %>
	<!-- left: menu E -->
	
	<!-- content S -->
	<div class="content-wrapper page-with-new-nav">
		<div class=" limit-container-width">
			<div class="content" id="content-body">
				<div class="project-home-panel text-center">


<!-- BODY : S -->				
<%
HttpSession loginsession = request.getSession(true); // true : 없으면 세션 새로 만듦

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");
String sdate = request.getParameter("sdate");
String edate = request.getParameter("edate");
if(sdate==null) sdate="";
if(edate==null) edate="";

String today = DateUtil.getDate("yyyy-MM-dd");
String today1W = DateUtil.getFormatDate("yyyy-MM-dd", "D", -7);
String today1M = DateUtil.getFormatDate("yyyy-MM-dd", "M", -1);
String today3M = DateUtil.getFormatDate("yyyy-MM-dd", "M", -3);
String today6M = DateUtil.getFormatDate("yyyy-MM-dd", "M", -6);
String today12M = DateUtil.getFormatDate("yyyy-MM-dd", "M", -12);

String strWID = request.getParameter("wid");
String strPID = "P001";
if(strWID==null) strWID="";
//strWID = "cMgftcbjkrNSWtNRtUd1m6h3CG3JLzsKDNP6S2TidEuwCgo5bTd7";
 
JSONObject joHistory = null;
StringBuffer p_strbHistory = new StringBuffer();

if(strWID!=null && !strWID.equals("")) {
	
	if(!sdate.equals("") && !edate.equals("")) {
		joHistory = CPWalletUtil.getNHistory("historyTrans",strPID,strWID,10,sdate,edate);
	} else {
		joHistory = CPWalletUtil.getNHistory("historyNTrans",strPID,strWID,10,null,null);
	}
	
	p_strbHistory.append("[");
	if(joHistory != null) {
		JSONArray p_jaRecord = (JSONArray)joHistory.get("Record");
		JSONObject jo_Record = null;
		SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd");
		String strDate = "";
		String strValue = "";
		Date dateRecord = null;
		long lDate = 0;
		long lValue = 0;
		for(int i = 0; i < p_jaRecord.size(); i ++) {
			jo_Record = (JSONObject)p_jaRecord.get(i);
			if(i > 0)
				p_strbHistory.append(",");
			lDate = (long)jo_Record.get("ttm");
			
			dateRecord = new Date(lDate * 1000);
			strDate = sf.format(dateRecord);
			
			p_strbHistory.append("{");
			p_strbHistory.append("\"date\":" +"\"" + strDate +"\", ");
			
			lValue = (long)jo_Record.get("val");
			p_strbHistory.append("\"value\":" +"\"" + lValue +"\", ");

			p_strbHistory.append("\"val\":" +"\"" + jo_Record.get("val") +"\", ");
			p_strbHistory.append("\"amt\":" +"\"" + jo_Record.get("amt") +"\", ");
			p_strbHistory.append("\"msg\":" +"\"" + jo_Record.get("msg") +"\", ");
			p_strbHistory.append("\"mno\":" +"\"" + jo_Record.get("mno") +"\", ");
			p_strbHistory.append("\"flg\":" +"\"" + jo_Record.get("flg") +"\", ");
			p_strbHistory.append("}");
		}
	}
	p_strbHistory.append("]");
}
%>

<style type="text/css">
	a, a:hover {
		color:#000000;
		text-decoration:none;
	}
	
	#search_date_zone span {
		cursor:pointer;
	}
</style>
<script>
var j_jaHistroy = <%=p_strbHistory%>;
// var j_jaHistroy = [{ "date":"2017/11/12", "value":3344 }, { ... } ]
	
	// 날짜 설정
	function setSearchDate(pGubun) {
		if(pGubun==1) {
			wallet_form.sdate.value = "<%=today%>";
			wallet_form.edate.value = "<%=today%>";
		} else if(pGubun==2) { 
			wallet_form.sdate.value = "<%=today1W%>";
			wallet_form.edate.value = "<%=today%>";
		} else if(pGubun==3) { 
			wallet_form.sdate.value = "<%=today1M%>";
			wallet_form.edate.value = "<%=today%>";
		} else if(pGubun==4) { 
			wallet_form.sdate.value = "<%=today3M%>";
			wallet_form.edate.value = "<%=today%>";
		} else if(pGubun==5) { 
			wallet_form.sdate.value = "<%=today6M%>";
			wallet_form.edate.value = "<%=today%>";
		} else if(pGubun==6) {
			wallet_form.sdate.value = "<%=today12M%>";
			wallet_form.edate.value = "<%=today%>";
		}
	}

	</script>
	
	<div class="container">
		<div class="col-lg-12">
			<div class="jumbotron" style="padding-top: 20px;">
				<form name="wallet_form" method="post" action="wallet_history.jsp" onsubmit="return false;">
					<h3 style="text-align: center;">Transaction List</h3>
										
					<div class="row" style="background-color: #ffffff;">  	
					
						<div class="input-group">
		  			    	<span class="input-group-addon" style="font-weight:bold;">Wallet ID : </span>
		  			    	<input type="text" class="form-control" placeholder="Wallet ID" id="wid" name="wid" style="width:80%;" value="<%=strWID%>"/>
		  			    	<input type="button" class="btn btn-primary pull-center" onclick="submitSearch();" value="Confirm" />	  			    	
					    </div>
						
						<div id="id_hlist"></div>
						
	  			    	<table style="width:100%; text-align: center; border:1px solid #ffffff;">
							<thead>
								<tr>
									<th style="text-align:center; padding-top:10px; padding-left:10px;" colspan="2">기간설정</th>
								</tr>
							</thead>
							<tbody>								
								<tr>
									<td colspan="2" style="text-align:center;vertical-align:top;">
										<div id="search_date_zone">
											<span class="label label-default" onclick="setSearchDate(1)">당일</span>
											<span class="label label-default" onclick="setSearchDate(2)">1주일</span>
											<span class="label label-default" onclick="setSearchDate(3)">1개월</span>
											<span class="label label-default" onclick="setSearchDate(4)">3개월</span>
											<span class="label label-default" onclick="setSearchDate(5)">6개월</span>
											<span class="label label-default" onclick="setSearchDate(6)">1년</span>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align:center;vertical-align:middle;height:40px; padding-top: 5px;">
										<div class="btn-group" role="group">
	  			    						<input type="text" class="form-control" placeholder="시작일" name="sdate" maxlength="20" style="width:130px; height:35px;" value="<%=sdate%>"/>
	  									</div>
	  									&nbsp; - &nbsp;
                        				<div class="btn-group" role="group">
	  			    						<input type="text" class="form-control" placeholder="종료일" name="edate" maxlength="20" style="width:130px; height:35px;" value="<%=edate%>"/>
	  									</div>					
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align:center;vertical-align:middle;height:40px; padding:7px;">
										<input type="submit" class="btn btn-primary btn-default btn-block" value="조회" onclick="submitSearch()"/>										
									</td>
								</tr>
							</tbody>
						</table>
				    </div>				
					
				</form>			
			</div>
			
			<div class="thumbnail" style="padding-top: 20px;white-space:inherit;word-break:break-all;text-align:left">
				<% 
				if(joHistory!=null && joHistory.size()>0) {
					out.print(joHistory.toString());
				}
				%>
			</div>
			 
		</div>
		
	</div>
	<script>
	function FnLoadHistory()
	{
		var sHtml = "";  
		for(var i = 0; i < j_jaHistroy.length ; i ++) {
			sHtml +="<table class=\"table\" style=\"text-align: cetner; border:1px solid #ffffff; background-color: #ffffff; margin-bottom: 7px;\">";
			//sHtml +="	<tr>";
			//sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\" colspan=\"2\">";
			//sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['msg']+"</span>";
			//sHtml +="	</tr>";
			//sHtml +="	<tr>";
			sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\" width=\"30%\">";
			sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['date']+"</span>";
			if(j_jaHistroy[i]['mno']==null || j_jaHistroy[i]['mno']=='')
				sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['msg']+"</span>";
			else 
				sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['mno']+"</span>";
			sHtml +="		</td>";
			sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\" width=\"40%\">";
			if(gfnAddComma(j_jaHistroy[i]['flg'])=='1') {
				sHtml +="			<span style=\"font-size:14px; color:#d34202;\">거래금액 </span>";
				sHtml +="			<span style=\"font-size:16px; font-weight:bold; color:#d34202;\">"+gfnAddComma(j_jaHistroy[i]['value'])+"</span> <span style=\"font-size:14px;\"> Coin";
			} else {
				sHtml +="			<span style=\"font-size:14px; color:blue;\">거래금액 </span>"; 
				sHtml +="			<span style=\"font-size:16px; font-weight:bold; color:blue;\">"+gfnAddComma(j_jaHistroy[i]['value'])+"</span> <span style=\"font-size:14px;\"> Coin";
			}
			sHtml +="		</td>";
			sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\" width=\"30%\">";
			sHtml +="			<span style=\"font-size:14px; color:#000000;\">잔액</span>";
			sHtml +="			<span style=\"font-size:16px; font-weight:bold; color:#000000;\">"+gfnAddComma(j_jaHistroy[i]['amt'])+"</span> <span style=\"font-size:14px;\"> Coin</span>";
			sHtml +="		</td>";
			sHtml +="	</tr>";
			sHtml +="</table>";	
		}
		$('#id_hlist').append(sHtml);
	}
	 FnLoadHistory();

	// 검색 조회
	function submitSearch() {
		location.href="/mgr/wallet_history.jsp?wid="+$('#wid').val();
	}
	</script>
<!-- BODY : E -->
	
	
				</div>
			</div>
		</div>
	</div>
	<!-- content E -->
			
			
	<!-- left: bottom S -->
	<%@ include file="inc/bottom.jsp" %>
	<!-- left: bottom E -->
	

</div>
	
</body>
</html>	
