<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%> 
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.common.util.KeyManager"%>
<%@ page import="fouri.com.common.util.DateUtil"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="fouri.com.cpwallet.web.CPWalletUtil"%>
<%@ page import="java.text.*" %>
<% 
	DecimalFormat df = new DecimalFormat("###,###"); //3자리마다 자동콤마
%>

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
request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

String strPID = "P001";

JSONObject joCoinList = null;
joCoinList = CPWalletUtil.getCoinHistory("queryCoin",strPID);

String strCoinValue = "";
if(joCoinList!=null) {
	strCoinValue = (String)joCoinList.getOrDefault("value","{}");	
}
%>


<style>
a, a:hover {
	color: #000000;
	text-decoration: none;
}
#lb_coin_list li {
	list-style:none;
	text-align:left;
	line-height:200%;
	font-size:10pt;
}
</style>

	<div class="container">
		<div class="col-lg-12">
			<div class="jumbotron" style="padding-top: 20px; display:none;">
				<h3 style="text-align: center;">Coin List</h3>									
				<div>  	
					<div class="form-group" style="text-align:center;" id="lb_coin_list"></div>
			    </div>
			    
				<script>
				<%
				if(strCoinValue.equals("")) {			
					out.print("alertMassageCallBack('coin is empty');");
				}
				%>
				var obj = JSON.parse('<%=strCoinValue.replaceAll("\n", "")%>');
				p_coinList = obj;
			
				var sHtml = '<div class="row"><table class="table table-hover demo-table-search " id="conlistTable">'; 
				sHtml += '<thead>'; 
				sHtml += '	<tr>'; 
				sHtml += '		<th style="text-align:center;">CID</th>'; 
				sHtml += '		<th style="text-align:center;">코인단위</th>'; 
				sHtml += '		<th style="text-align:center;">거래단위</th>'; 
				sHtml += '		<th style="text-align:center;">거래단위비</th>'; 
				sHtml += '		<th style="text-align:center;">환율</th>'; 
				sHtml += '		<th style="text-align:center;">발행총코인</th>'; 
				sHtml += '	</tr>'; 
				sHtml += '</thead>'; 
				sHtml += '<tbody id="id_walletlist_table_tbody">';
				for(var i=0; i<obj.length; i++){
					sHtml += '<tr style="background-color:#ffffff;">'
				      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;"><a href=coin_state.jsp?cid='+ obj[i].cid +'>' + obj[i].cid + '</a></td>'
				      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj[i].cou + '</td>'
				      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj[i].cau + '</td>'
				      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj[i].cpc + '</td>'
				      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj[i].exr + '</td>'
				      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj[i].amt + '</td>';
					sHtml +='</tr>';
				}
				sHtml += '		</tbody>';
				sHtml += '	</table>';
				sHtml += '</div>';
				//$('#lb_coin_list').append(sHtml);		
			    </script>		
			</div>
			
			
			<div class="jumbotron" style="padding-top: 20px;">
				<h3 style="text-align: center;">Coin List</h3>									
				<div>  	
					<div class="form-group" style="text-align:center;">
						<div class="row">
							<table class="table table-hover demo-table-search " id="conlistTable">
								<thead>	
									<tr>		
										<th style="text-align:center;">CID</th>		
										<th style="text-align:center;">코인이름</th>		
										<th style="text-align:center;">코인단위</th>		
										<th style="text-align:center;">거래단위</th>		
										<th style="text-align:center;">거래단위비</th>		
										<th style="text-align:center;">환율</th>		
										<th style="text-align:center;">발행총코인</th>	
									</tr>
								</thead>
								
								<tbody>
									<%
									JSONParser jpTemp = new JSONParser();
									JSONArray jaReq = (JSONArray)jpTemp.parse(strCoinValue);
									if (jaReq != null) {
										for(int i=0; i<jaReq.size(); i++) {										
											JSONObject row = (JSONObject)jaReq.get(i);
									%>								
									<tr style="background-color:#ffffff;">
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><a href=coin_state.jsp?cid=<%=(String)row.get("cid")%>><%=(String)row.get("cid")%></a></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)row.get("nm")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)row.get("cou")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)row.get("cau")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(Long)row.get("cpc")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(Long)row.get("exr")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=df.format((Long)row.get("amt"))%></td>
									</tr>
									<%
										}
									}
									%>
								</tbody>	
							</table>
						</div>
					</div>
			    </div>		
			</div>
			
			
			<div class="thumbnail" style="padding-top: 20px;white-space:inherit;word-break:break-all;text-align:left">
				<%=joCoinList.toString() %>
			</div>			 
		</div>		
	</div>
	    
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
