<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>
<%@ page import="fouri.com.common.util.EtcUtils"%>  
 

<%@ page import="java.util.ArrayList" %> 
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>  
<%@ include file="lang.jsp" %> 
<%
HttpSession p_Session = request.getSession(false);
if(p_Session == null)
{
	response.sendRedirect("gate.jsp");
	return;
}
String strWID = (String)p_Session.getAttribute("WID");
if(strWID == null)
{
	response.sendRedirect("login.jsp");
	return;
}

request.setCharacterEncoding("utf-8");
response.setContentType("text/html; charset=utf-8");


%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport;" content="user-scalable=no" /> 

<title>Join</title>
<link type="text/css" rel="stylesheet" href="./css/style.css">
 <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
 <script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>
  <script src="../js/mContent.js" ></script>
 <script src="../js/cpwallet/app_interface.js"></script>

<script> 
// 현재 보여지고 있는 SITE 정보
var j_joSite = null; 

//App에서 로딩되자 마자 호출하는 함수임
function AWI_OnLoadFromApp(dtype)
{
	 // AWI_XXX 메소드 활성화
	 AWI_ENABLE = true;
	 if(dtype=='android')
		 AWI_DEVICE = dtype;
}

function FnSelectSite(sSTID)
{
	j_joSite =  j_joSitePool[sSTID];
	// select title 영역
    $('#id_select_menu').html(j_joSite.name +"<span class='bt'></span>");	
    // 리스트 표시된 메뉴를 닫음
    $( "#id_site_list").css("display","none");
    // 리스트 표시된 메뉴가 닫혔음을 설정 함
    $('#id_select_menu').removeClass("on");
    // 기존 등록되어 있는 리스트 모두 지우고..
    var oHist = $('#id_history');
    oHist.html(""); 
    oHist.append("<div class='infoText' style='width:85%;' >" 
					+ "<div style='margin:30px 40px;'>No history</div>"
					+ "</div>");
	var sParam = "stid=" + sSTID + "&rows=20";
	$.getJSON("../proc/query_history.jsp",sParam,function(data,status){
		if(status == "success")
		{
			if(data.result	== "OK")
			{
				j_dateLast = new Date();
				var dateSt = null;
				var jaSt = data.sensor;  // DB에 등록되어 있는 센서 상태정보 값 배열이다. Date로 정열(desc)되어있다.
				var joSt = null;
				var sState = "";
				var oList = null;
				if(jaSt.length > 0)
					oHist.html("");   // 일단 다 지우고...
				// 일단 처음이니까 toDay 출력
				oHist.append("<div style='margin-top:80px;' class=''></div>");
				oList = $('#id_history > div:last');
				oList.append("<div style='margin-left:-15px;' class='historyTodayText'><img src='./images/historyT.png' width='60' height='60' align='absmiddle' style='margin-right:30px;'>오늘" + new Date().format('  yyyy-MM-dd [E]') + "</div>");
				for(var i = 0; i < jaSt.length ; i ++)
				{
					joSt = jaSt[i];  // 하나의 상태정보를 얻고,
					dateSt = parseDate(joSt.dt);
					if(!isSameDate(j_dateLast,dateSt))
					{
						oHist.append("<div style='margin-top:80px;  float:left;' class=''></div>");
						oList = $('#id_history > div:last');
						oList.append("<div style='margin-left:-15px;' class='historyTitleText'><img src='./images/historyD.png' width='60' height='60' align='absmiddle' style='margin-right:30px;'>" +dateSt.format('  yyyy-MM-dd [E]')  + "</div>");
						j_dateLast = dateSt;
					}
					if(joSt.st == "0") sState = joSt.sn + " [closed]";
					else sState = joSt.sn + " <span style='color:red;'>[opened]</span>";
					oList.append("<div style='float:left; width:85%;' class='historyBorder'>" 
				               + "<div style='float:left; margin-left:25px;  margin-top:25px ;'>" +sState + "</div><div style='float:right; margin-left:25px; margin-top:25px ; '>" +joSt.dt.substring(11,16)+ "</div>"
				               + "</div>");
				}
				if(jaSt.length > 0)
					j_dateLast = parseDate(jaSt[jaSt.length-1].dt);
			}
		}
	});	
}

function FnMoreSiteHistory()
{
    var oHist = $('#id_history');
    
	var sParam = "stid=" + j_joSite.stid + "&date="+makeStrDate(j_dateLast) + "&rows=30";
	$.getJSON("../proc/query_history.jsp",sParam,function(data,status){
		if(status == "success")
		{
			if(data.result	== "OK")
			{
				var dateSt = null;
				var jaSt = data.sensor;  // DB에 등록되어 있는 센서 상태정보 값 배열이다. Date로 정열(desc)되어있다.
				var joSt = null;
				var sState = "";
				var oList = null;
				oList = $('#id_history > div:last');
				for(var i = 0; i < jaSt.length ; i ++)
				{
					joSt = jaSt[i];  // 하나의 상태정보를 얻고,
					dateSt = parseDate(joSt.dt);
					if(!isSameDate(j_dateLast,dateSt))
					{
						oHist.append("<div style='margin-top:80px;  float:left;' class=''></div>");
						oList = $('#id_history > div:last');
						oList.append("<div style='margin-left:-15px;' class='historyTitleText'><img src='./images/historyD.png' width='60' height='60' align='absmiddle'  style='margin-right:30px;'>" +dateSt.format('  yyyy-MM-dd [E]')  + "</div>");
						j_dateLast = dateSt;
					}
					joSt.sn // dlfma;;
					joSt.st // dlfma;;
					if(joSt.st == "0") sState = joSt.sn + " [closed]";
					else sState = joSt.sn + "<span style='color:red;'>[opened]</span>";
					oList.append("<div style='float:left; width:85%;' class='historyBorder'>" 
					               + "<div style='float:left; margin-left:25px;  margin-top:25px ;'>" +sState + "</div><div style='float:right; margin-left:25px; margin-top:25px ; '>" +joSt.dt.substring(11,16)+ "</div>"
					               + "</div>");
				}
				if(jaSt.length > 0)
					j_dateLast = parseDate(jaSt[jaSt.length-1].dt);
			}
		}
	});	
}

//yyyy-MM-dd HH:mm:ss 형식 문자열을 파싱한다
//Date 개체를 리턴한다.
function parseDate(sDate)
{
	if(sDate == null) return null;
	// 그냥 전달해도 된다.  복잡하게 하지 말자
	// 아~~ 아이폰(사파리에서는 안된다..)
	// return new Date(sDate);
	// 파싱해서 하자	

	if(sDate.length != 19) return null;
	var nY = parseInt(sDate.substring(0,4));
	var nM = parseInt(sDate.substring(5,7));
	var nD = parseInt(sDate.substring(8,10));
	var nH = parseInt(sDate.substring(11,13));
	var nMin = parseInt(sDate.substring(14,16));
	var nS = parseInt(sDate.substring(17,19));

	var oDate = new Date(nY,nM-1,nD,nH,nMin,nS,0);
	return oDate;
}

//Date 출력 포맷 함수
//new Date().format('yyyy-MM-dd [E]') : 2016-10-31 [월요일]
 String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
 String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
 Number.prototype.zf = function(len){return this.toString().zf(len);};
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};

//Date 개체를 yyyy-MM-dd HH:mm:ss 와 같은 형태의 문자열로 만듦
function makeStrDate(sDate)
{
	return sDate.format("yyyy-MM-dd HH:mm:ss");
}

// objDate 는 Date 개체이다
// objDate가 오늘 인지를 확인한다.
// return : true or false
function isToday(objDate)
{
	var toDay = new Date();
	if(objDate.getFullYear() == toDay.getFullYear()
			&& objDate.getMonth() == toDay.getMonth()
			&& objDate.getDate() == toDay.getDate())
		return true;
	return false;
}

//date1, date2는 Date 개체이다
//date1과 date2가 같은 날짜인지 확인한다.
//return : true or false
function isSameDate(date1,date2)
{
	if(date1.getFullYear() == date2.getFullYear()
			&& date1.getMonth() == date2.getMonth()
			&& date1.getDate() == date2.getDate())
		return true;
	return false;
}
</script>
</head>

<body class="main-body">


<div class="wrap-body">

	<!-- 여기서부터는 앱입니다. 전체적으로 보려고 우선 넣어놓고 작업합니다. 작업시 삭제 바랍니다. -->
	<!--<div class="appTitle"><img src="./images/headerTemp.jpg"></div>  -->
	<!-- 여기까지가 앱영역입니다. -->

	<div  class="joinBg" >
		<div class="blueBg" style="width:100%; text-align:center; color:#fff; font-size:50px; padding:40px 0px 40px 0px;">
		<section class="sub-top" style="width:80%; margin:0 auto;">
			<div class="select-area" >
				<div class="controll" >
					<a id='id_select_menu'  href="#" class="select-menu" style="padding-top:2px;">FnSelectSite() 에서 표시됨<span class="bt"></span></a>
				</div>
				<div id='id_site_list' class="select-box" style="display:none">
					<ul style="height:1080px;">
						<li><a href="#">COINPOOL_SPIRING Coin</a></li>   
						<li><a href="#">COINPOOL_SUMMER Coin</a></li>   
						<li><a href="#">COINPOOL_FALL Coin</a></li>   
						<li><a href="#">COINPOOL_WINTER Coin</a></li>   
					</ul>
				</div>				
			</div>
		</section>
		</div> <!--  end of  class_blueBg -->
		<div id='id_history' class="memJoinArea" >
			<div class="infoText" style="width:85%;" >
				<!-- FnSelectSensor() ,   FnMoreSensorHistory() 에서 만들어짐-->
			</div>
		</div>
<!-- E : Login Area -->	

		<div style="width:100%; margin-bottom:30px;" class="">&nbsp;
			<div  class="hCenter">
				<div class="btn btn-default" style="width:85%; text-align:center; font-size:50px;vertical-align:middle; margin-top:60px; background: #E8E8E8; border-radius:60px;" onClick="javascript:FnMoreSiteHistory()">더보기... </div>
			</div>	
		</div>	
	</div>
</div>	

</body>
</html>
