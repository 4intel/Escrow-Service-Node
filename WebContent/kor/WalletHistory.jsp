<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.List"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%> 
<%@ page import="fouri.com.common.util.EtcUtils"%>
<%@ page import="fouri.com.common.util.KeyManager"%>
<%@ page import="fouri.com.common.util.DateUtil"%>
<%@ page import="fouri.com.cpwallet.biz.ApiHelper"%>
<%@ page import="fouri.com.cpwallet.web.CPWalletUtil"%>
<%@ page import="fouri.com.cpwallet.service.CoinListVO"%>
<%@ include file="lang.jsp" %> 
<%@ include file="alertMessage.jsp" %>
<%
HttpSession loginsession = request.getSession(true); // true : 없으면 세션 새로 만듦

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");

List<HashMap> coinList = CoinListVO.getCoinList();
if(coinList==null || coinList.size()==0) coinList = CoinListVO.reloadCoinList();

String reloadCoinList = request.getParameter("reloadCoinList");
boolean isNowReloadPage = false;	// 코인정보 reloading을 위한 처리 방법. 화면 재시작은 한번만 한다.
if(reloadCoinList!=null && reloadCoinList.equals("Y")) {
	coinList = CoinListVO.reloadCoinList();
	isNowReloadPage = true;
}

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

//strWID = "cMhjabqXJNxVdFqMJSuhgfyAxe5k8xjv8L9REfCBDNn5sFJVSh4v";
//strWID = "cMfqx9WGLBBHnhtyXVN8AYQPirN7L4AozofmjvLU8bPTCXxkSW7n";

JSONObject joHistory = null;
if(!sdate.equals("") && !edate.equals("")) {
	String edatePlus = DateUtil.getPlusMinusDate(edate.replaceAll("-",""), 1, "yyyy-MM-dd"); // 종료일 +1
	joHistory = CPWalletUtil.getNHistory("historyTransE",strPID,strWID,0,sdate,edatePlus);
	//joHistory = CPWalletUtil.getNHistory("historyTransE",strPID,strWID,0,sdate,edate);
} else {
	joHistory = CPWalletUtil.getNHistory("historyNTransE",strPID,strWID,3,null,null);
}

StringBuffer p_strbHistory = new StringBuffer();
p_strbHistory.append("[");
if(joHistory != null)
{
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
		
		String flg = Long.toString((Long)jo_Record.get("flg"));
		int bitFlg = Integer.parseInt(flg);// & 1;
		//int bitFlg4 = Integer.parseInt(flg) & 4;
		
		p_strbHistory.append("\"val\":" +"\"" + jo_Record.get("val") +"\", ");
		p_strbHistory.append("\"amt\":" +"\"" + jo_Record.get("amt") +"\", ");
		p_strbHistory.append("\"msg\":" +"\"" + jo_Record.get("msg") +"\", ");
		p_strbHistory.append("\"mno\":" +"\"" + jo_Record.get("mno") +"\", ");
		p_strbHistory.append("\"flg\":" +"\"" + flg +"\", ");
		p_strbHistory.append("\"bitFlg\":" +"\"" + bitFlg +"\", ");
		p_strbHistory.append("\"wid\":" +"\"" + ((String)jo_Record.get("wid")).replaceAll("WA_", "") +"\", ");
		
		String txtag = (String)jo_Record.get("txtag");
		String txid = (String)jo_Record.get("txid");
		String trno = Long.toString((Long)jo_Record.get("trno"));
		String rwid = (String)jo_Record.get("rwid");
		
		if(txtag==null) {
			txtag = "";
		} else {
			String[] txtagArr = txtag.split(";");
			if(txtagArr!=null && txtagArr.length>0) {
				for(int j=0;j<txtagArr.length; j++) {
					String[] txtagArr2 =  txtagArr[j].split(":");
					if(txtagArr2!=null && txtagArr2.length>0 && txtagArr2[0].indexOf("escro_estmate")>-1) {
						if((bitFlg & 1)==1 && (txtagArr2[0].trim()).equals("sxx_escro_estmate")) p_strbHistory.append("\"txtag\":" +"\"" + txtagArr2[1] +"\", ");
						if((bitFlg & 1)==0 && (txtagArr2[0].trim()).equals("rxx_escro_estmate")) p_strbHistory.append("\"txtag\":" +"\"" + txtagArr2[1] +"\", ");
					}
				}	
			}
		}

		if(rwid==null) rwid = "";
		p_strbHistory.append("\"txid\":" +"\"" + txid +"\", ");
		p_strbHistory.append("\"trno\":" +"\"" + trno +"\", ");
		p_strbHistory.append("\"rwid\":" +"\"" + rwid.replaceAll("WA_", "") +"\", ");
		p_strbHistory.append("}");
	}
}
System.out.println("p_strbHistory : "+p_strbHistory);
p_strbHistory.append("]");
// 
%>

<!DOCTYPE html>
<html>
<head>
<title>Coinpool</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/cpwallet/view.css" />
<script src="../js/jquery.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/cpwallet/app_interface.js"></script>
<script src="../js/cpwallet/common.js"></script>
<!-- Star Rating : S -->
<script src="/js/star-rating.js" type="text/javascript"></script>
<link rel="stylesheet"  href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">    
<link rel="stylesheet" href="/css/cpwallet/star-rating.css" media="all" rel="stylesheet" type="text/css"/>    
<!-- Star Rating : E --> 

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
var bitSendF  = 1;
var bitEscrowF = 2;
var bitRewardF = 4;

var j_jaHistroy = <%=p_strbHistory%>;
// var j_jaHistroy = [{ "date":"2017/11/12", "value":3344 }, { ... } ]

$(function(){
});

var coinCOU = "";

//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	 // AWI_XXX 메소드 활성화
	 AWI_ENABLE = true;
	 if(dtype=='android')
		 AWI_DEVICE = dtype;
	 
	p_sWNM = AWI_getConfig("_CUR_WNM");
	document.getElementById("s_wallet_name").innerHTML = "지갑 : " + p_sWNM;

	// coin list(coin 단위정보 얻기)
	var cid = AWI_getConfig("_CUR_CID");
	<%
	for(int i=0; i<coinList.size(); i++) {
		HashMap map = (HashMap)coinList.get(i);
		%>
		if(parseInt("<%=((String)map.get("cid")).replaceAll("COIN_","")%>",10) == parseInt(cid,10)) { coinCOU = "<%=(String)map.get("cou")%>"; }
		<%
	}
	%>
	if(coinCOU=="") {
		<% if(!isNowReloadPage) { // 페이지 재시작은 한번만. %>
			location.href="./WalletHistory.jsp?reloadCoinList=Y";
		<% } %>
	}
	$('.aaa').html(coinCOU);
}
	
	function WalletListRowColor(WalletRowID,WalletRowCount) {
		var WalletRowID = WalletRowID; //넘어온RowID값
		var WalletRowCount = WalletRowCount; //넘어온Row카운터값		
		for(i=1; i<=WalletRowCount; i++){			
			if ("WalletID_"+i == WalletRowID) {
				document.getElementById("WalletID_"+i).style.backgroundColor = "#f9f9f9";
			} else {
				document.getElementById("WalletID_"+i).style.backgroundColor = "#ffffff";
			}
		}
	}

	// 검색 조회
	function submitSearch() {
		userWalletHistoryFom.action="/kor/WalletHistory.jsp";
		userWalletHistoryFom.target="_self";
		userWalletHistoryFom.submit();
	}
	
	// 날짜 설정
	function setSearchDate(pGubun) {
		if(pGubun==1) {
			userWalletHistoryFom.sdate.value = "<%=today%>";
			userWalletHistoryFom.edate.value = "<%=today%>";
		} else if(pGubun==2) { 
			userWalletHistoryFom.sdate.value = "<%=today1W%>";
			userWalletHistoryFom.edate.value = "<%=today%>";
		} else if(pGubun==3) { 
			userWalletHistoryFom.sdate.value = "<%=today1M%>";
			userWalletHistoryFom.edate.value = "<%=today%>";
		} else if(pGubun==4) { 
			userWalletHistoryFom.sdate.value = "<%=today3M%>";
			userWalletHistoryFom.edate.value = "<%=today%>";
		} else if(pGubun==5) { 
			userWalletHistoryFom.sdate.value = "<%=today6M%>";
			userWalletHistoryFom.edate.value = "<%=today%>";
		} else if(pGubun==6) {
			userWalletHistoryFom.sdate.value = "<%=today12M%>";
			userWalletHistoryFom.edate.value = "<%=today%>";
		}
	}

	//
	function setEsmateValue(txid, trno, wid, rwid, flg) {
		$("#txid").val(txid);
		$("#trno").val(trno);
		$("#wid").val(wid);
		$("#rwid").val(rwid);
		$("#flg").val(flg);
	}
	// 평점등록
	function attachTransTag() {
		var txid = $("#txid").val();
		var trno = $("#trno").val();
		var rwid = $("#rwid").val();
		var wid = $("#wid").val();
		var flg = $("#flg").val();
		var bitFlag = parseInt(flg) & 1;
		var star_num = $("#star_num").val();
		var cid = AWI_getConfig("_CUR_CID");
		if(rwid=="") rwid = wid;

		var param_gubun = "";
		var owner_type = "";
		if(bitFlag==1) { 
			param_gubun = "sxx_";
			owner_type = "S";
		} else {
			param_gubun = "rxx_";
			owner_type = "R";
		}
		var jaArgs = ["PID","10000",txid,trno,rwid, owner_type, param_gubun+"escro_estmate:"+star_num+";" ,cid ];
		AWI_attachTransTag(jaArgs,"");
	}
	function AWI_CallFromApp(strJson) {
		var joRoot = JSON.parse(strJson);  
		var joFunc = joRoot.func;
		//if(joFunc.cmd == 'setQR')
		submitSearch();
	}
	</script>
</head>
<body>
	<div class="container">
			<div class="jumbotron" style="padding-top:20px;background-color: transparent !important;padding-bottom:0;">
				<h2 style="text-align: center;">Transaction history</h2>
				<hr/>
			</div>
			
				<form name="userWalletHistoryFom" method="post" action="WalletHistory.jsp" onsubmit="return false;">
					<input type="hidden" name="wid" value="<%=strWID%>"/>
					<div class="form-group">
	  			    	<span class="input-group-addon" style="font-weight:bold; height:50px;" id="s_wallet_name"></span>
				    </div>
					
					<div class="row" style="background-color: #ffffff;">  	
					
						<div id="id_hlist" style="padding:0 20px 0 20px;width:100%;"></div>
						
	  			    	<table style="width:100%; text-align: center; border:1px solid #ffffff;">
							<thead>
								<tr>
									<th width="50%" style="text-align:left; padding-top:10px; padding-left:10px;">거래내역</th>
									<td width="50%" style="text-align:right; padding-top:10px; padding-right:10px;">기간설정</td>
								</tr>
							</thead>
							<tbody>								
								<tr>
									<td colspan="2" style="text-align:center;vertical-align:top;">
										<div id="search_date_zone">
											<span class="btn btn-primary btn-sm" onclick="setSearchDate(1)">당일</span>
											<span class="btn btn-primary btn-sm" onclick="setSearchDate(2)">1주일</span>
											<span class="btn btn-primary btn-sm" onclick="setSearchDate(3)">1개월</span>
											<span class="btn btn-primary btn-sm" onclick="setSearchDate(4)">3개월</span>
											<span class="btn btn-primary btn-sm" onclick="setSearchDate(5)">6개월</span>
											<span class="btn btn-primary btn-sm" onclick="setSearchDate(6)">1년</span>
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
					
					<div class="form-group" style="text-align:center; padding-top:10px;">
						<input type="button" class="btn btn-primary pull-center" value="돌아가기" onclick="history.back();">
					</div>
					
					
					<!-- Star Rating 모달 팝업 : S -->
					<div class="modal" id="esmateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">Star Rating</h4>
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
					      </div>
					      <div class="modal-body">
						  	<input value="10" type="number" id="star_num" class="rating" min=0 max=10 step=1 data-size="xs" data-show-clear="true" data-show-caption="true">
					      </div>
					      <div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="attachTransTag();">Save changes</button>
							<input type="hidden" id="txid" value=""/>
							<input type="hidden" id="trno" value=""/>
							<input type="hidden" id="wid" value=""/>
							<input type="hidden" id="rwid" value=""/>
							<input type="hidden" id="flg" value=""/>
					      </div>
					    </div>
					  </div>
					</div>
					<!-- Star Rating 모달 팝업 : E -->
					
					
				</form>			
	</div>
	
	<script>
	function FnLoadHistory()
	{
		var sHtml = ""; 
		for(var i = 0; i < j_jaHistroy.length ; i ++) {
			sHtml +="<table class=\"table\" style=\"text-align: cetner; border:1px solid #ffffff; background-color: #ffffff; margin-bottom: 7px;\">";
			//sHtml +="	<tr>";
			//sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\" colspan=\"2\">";
			//sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['msg']+"</span><br />";
			//sHtml +="	</tr>";
			sHtml +="	<tr>";
			sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\">";
			sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['date']+"</span><br />";
			if(j_jaHistroy[i]['mno']==null || j_jaHistroy[i]['mno']=='') {
				sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['msg']+"</span><br />";
			} else {
				if((parseInt(j_jaHistroy[i]['bitFlg']) & bitRewardF) == bitRewardF) {
					sHtml +="			<span style=\"font-size:12px;\">Evaluation reward</span><br />";
				} else {
					sHtml +="			<span style=\"font-size:12px;\">"+j_jaHistroy[i]['mno']+"</span><br />";	
				}
			}
			sHtml +="		</td>";
			sHtml +="		<td style=\"text-align:left; padding-top: 13px; padding-left:10px; line-height:22px;\">";
			if((parseInt(j_jaHistroy[i]['bitFlg']) & bitSendF) == bitSendF) {	// 보낸 금액
				sHtml +="			<span style=\"font-size:14px; color:#d34202;\">거래금액 </span>";
				sHtml +="			<span style=\"font-size:16px; font-weight:bold; color:#d34202;\">"+gfnAddComma(j_jaHistroy[i]['value'])+"</span> <span style=\"font-size:14px;\" class=\"aaa\"> </span><br />";
			} else {										// 받은 금액
				sHtml +="			<span style=\"font-size:14px; color:blue;\">거래금액 </span>"; 
				sHtml +="			<span style=\"font-size:16px; font-weight:bold; color:blue;\">"+gfnAddComma(j_jaHistroy[i]['value'])+"</span> <span style=\"font-size:14px;\" class=\"aaa\"> </span><br />";
			}
			sHtml +="			<span style=\"font-size:14px; color:#000000;\">잔액</span>";
			sHtml +="			<span style=\"font-size:16px; font-weight:bold; color:#000000;\">"+gfnAddComma(j_jaHistroy[i]['amt'])+"</span> <span style=\"font-size:14px;\" class=\"aaa\"> </span><br />";

			if(j_jaHistroy[i]['txtag']==null || j_jaHistroy[i]['txtag']=='') { 
				if(j_jaHistroy[i]['trno']!='0' && (parseInt(j_jaHistroy[i]['bitFlg']) & bitRewardF) != bitRewardF) {
					sHtml +="			<button type=\"button\" class=\"btn btn-primary btn-xs\" data-toggle=\"modal\" data-target=\"#esmateModal\" onclick=\"setEsmateValue('"+j_jaHistroy[i]['txid']+"','"+j_jaHistroy[i]['trno']+"','"+j_jaHistroy[i]['wid']+"','"+j_jaHistroy[i]['rwid']+"','"+j_jaHistroy[i]['flg']+"')\">별점주기</button><br />";	
				}	
			} else {
				sHtml +="			<input value=\""+j_jaHistroy[i]['txtag']+"\" class=\"rating\" min=0 max=10 step=1 data-size=\"xxs\" data-readonly=\"true\" data-show-clear=\"false\" data-show-caption=\"false\">";	
			}
			sHtml +="		</td>";
			sHtml +="	</tr>";			
			sHtml +="</table>";	
		}
		$('#id_hlist').append(sHtml);
	}

	FnLoadHistory();
	</script>
	
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>
</html>