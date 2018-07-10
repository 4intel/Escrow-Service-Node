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
<%@ page import ="java.text.*" %>
<% 
	DecimalFormat df = new DecimalFormat("###,###"); //3자리마다 자동콤마
%>
<%!
//코인 등록정보(stateCoin)
public static JSONObject getCoinHistoryView(String queryName, String strPID, String strCID) {
	JSONObject joQuery = new JSONObject();
	JSONArray jaParam = new JSONArray();
	
	String[] args = null;
	args = new String[] {strPID,"10000",strCID}; //["PID","10000","COIN_100"]
	
	//if(!ApiHelper.putQuerySignature(args,false,KeyManager.getPrivateKey(KeyManager.CPAPI_LEVEL.emMan300)))
		//return null;
	
	joQuery.put("query_type","query");    
	joQuery.put("func_name",queryName);   // { "query_type": "query", "func_name": "stateCoin" }

	for( String strArg : args) {
		jaParam.add(strArg);
		//System.out.println("strArg :"+strArg); //넘겨준 파라미터값
	}
	joQuery.put("func_args", jaParam);  

	JSONObject joRes = ApiHelper.postJSON(joQuery);
	if(joRes != null) {
		long nCode = (Long)joRes.getOrDefault("ec",-1L);
		if(nCode == 0) {
			String strValue = (String)joRes.getOrDefault("value","{}");
			System.out.println("strValue :"+strValue);
		} 
	}
	return joRes;
}
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
	<div class="container">
		<div class="col-lg-12">			
			<div class="jumbotron" style="padding-top: 20px;">
				<h3 style="text-align: center;">Coin View</h3>									
				<div>  	
					<div class="form-group" style="text-align:center;">					
					<%
					request.setCharacterEncoding("utf-8");
					response.setContentType("text/html; charset=utf-8");
					String strCID = request.getParameter("cid"); //코인아이디
					
					if(strCID == null) { // 코인아이디가 없다면? 코인리스트로 돌린다.
						out.println("<script>");
						out.println("alert('코인 아이디값이 없습니다.')");
						out.println("location.href='coin_list.jsp'");
						out.println("</script>");
					}
					
					String strPID = "P001";
					
					JSONObject joCoinList = null; //JSONObject 객체의 joCoinList 변수값을 null 선언
					//joCoinList = CPWalletUtil.getCoinHistoryView("stateCoin", strPID, strCID);
					joCoinList = getCoinHistoryView("stateCoin", strPID, strCID);
					
					String strCoinValue = ""; //JSONObject 넘어온값을 저장하는 변수를 선언한다.
					if(joCoinList!=null) { //값이있다면?
						strCoinValue = (String)joCoinList.getOrDefault("value","{}"); //getOrDefault : key 값이 없다면 입력시 설정한 default 값을 반환
					}
					
					if(strCoinValue.equals("")) {
						out.print("alertMassageCallBack('coin is empty');");
					}

					JSONObject joValue = new JSONObject();
					JSONParser jaTemp = new JSONParser();
					try {
						joValue = (JSONObject)jaTemp.parse(strCoinValue); //strCoinValue JSONObject parse
					} catch (ParseException e) {
						e.printStackTrace();
					}
					%>
						<% if (joValue != null) { %>
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
									<tr style="background-color:#ffffff;">
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)joValue.get("cid")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)joValue.get("nm")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)joValue.get("cou")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(String)joValue.get("cau")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(Long)joValue.get("cpc")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=(Long)joValue.get("exr")%></td>
										<td style="text-align:center;vertical-align:middle;word-break:break-all;"><%=df.format((Long)joValue.get("amt"))%></td>
									</tr>
								</tbody>	
							</table>
						</div>
						<% } %>
					</div>
			    </div>		
			</div>			
			
			<div class="jumbotron" style="padding-top: 20px; display:none;">
				<h3 style="text-align: center;">Coin View</h3>									
				<div>  	
					<div class="form-group" style="text-align:center;" id="lb_coin_view"></div>
			    </div>
				<script>
				var obj = JSON.parse('<%=strCoinValue.replaceAll("\n", "")%>');
				/*
				{
				"ver":10000,
				"cid":"COIN_00000200",
				"nm":"Hippo Coin",
				"st":2,
				"cou":"CON",
				"cau":"CUN",
				"cpc":1000,
				"exr":1,
				"mit":20,
				"mxt":0,
				"mnt":10000,
				"dtb":1483228800,
				"dte":32503593600,
				"frt":0,
				"fmx":0,
				"ffx":0,
				"fwd":"",
				"amt":1000000000000000,
				"mno":
				"memo"
				}
				*/
				var sHtml = '<div class="row"><table class="table table-hover demo-table-search " id="conlistTable">'; 
				sHtml += '<thead>'; 
				sHtml += '	<tr>'; 
				sHtml += '		<th style="text-align:center;">CID</th>'; 
				sHtml += '		<th style="text-align:center;">코인이름</th>'; 
				sHtml += '		<th style="text-align:center;">코인단위</th>';
				sHtml += '		<th style="text-align:center;">거래단위</th>'; 
				sHtml += '		<th style="text-align:center;">거래단위비</th>'; 
				sHtml += '		<th style="text-align:center;">환율</th>'; 
				sHtml += '		<th style="text-align:center;">발행총코인</th>'; 
				sHtml += '	</tr>'; 
				sHtml += '</thead>'; 
				sHtml += '<tbody>';
						sHtml += '<tr style="background-color:#ffffff;">'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.cid + '</td>'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.nm + '</td>'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.cou + '</td>'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.cau + '</td>'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.cpc + '</td>'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.exr + '</td>'
					      + '<td style="text-align:center;vertical-align:middle;word-break:break-all;">' + obj.amt + '</td>';
						sHtml +='</tr>';
				sHtml += '		</tbody>';
				sHtml += '	</table>';
				sHtml += '</div>';
				//$('#lb_coin_view').append(sHtml);
				</script>		
			</div>
			
			<div class="form-group" style="text-align:center">
				<input type="button" class="btn btn-primary pull-center" value="목록가기" onclick="location.href='coin_list.jsp'" />
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
