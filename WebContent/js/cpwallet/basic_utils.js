
// input element : y 입력 디폴트 초기값 지우기
// onFocus()이벤트에 연결 시켜서 기본값이면 지운다.
// <input onFocus='clearText(this);' >
function clearText(y)
{ 
	if (y.defaultValue==y.value) 
		y.value = ""; 
} 

//input element : y  값이 정상인지 확인
function checkText(y)
{ 
  var v = y.value;
  v = v.trim();
  if (y.defaultValue==v) 
		return false; 
	if (v == "")
	  return false;
	return true;
}

//문자열 값이 정상인지 확인
function checkValue(str)
{ 
  if(str == null)
	  return false;
  var v = str.trim();
	if (v == "")
	  return false;
	return true;
}

//-----------------------
// 입력 필드에 maxlength 속성을 설정하고 
// keyup 이벤트에 연결시켜서 글자수 제한
// <input type="text" maxlength='250' onkeyup='return checkMaxLength(this)'/>
function checkMaxLength(obj)
{
	 var maxLength = parseInt(obj.getAttribute('maxlength'));
	 if(obj.value.length > maxLength)
    {
		 alert("글자수는 " + maxLength + "자 이내로 제한됩니다.");
		 obj.value = obj.value.substring(0,maxLength);
    }
}

// html 과 충돌하지 않도록 , 문자열 인코딩
function htmlEscape(str)
{
    return str
        .replace(/&/g, '&amp;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;');
}

// html 인코딩 문자 복원
function htmlUnescape(str)
{
    return str
        .replace(/&quot;/g, '"')
        .replace(/&#39;/g, "'")
        .replace(/&lt;/g, '<')
        .replace(/&gt;/g, '>')
        .replace(/&amp;/g, '&');
}

// 브라우저 타입 확인
function getBrower()
{
	var agent = navigator.userAgent.toLowerCase();
	var appName =  navigator.appName.toLowerCase();
	if (agent.indexOf("chrome") != -1) {
		return "chrome"; //  alert("크롬 브라우저입니다.");
	}
	else if (agent.indexOf("safari") != -1) {
		return "safari"; // alert("사파리 브라우저입니다.");
	}
	else if (agent.indexOf("firefox") != -1) {
		return "firefox"; // alert("파이어폭스 브라우저입니다.");
	}
	else if ( appName.indexOf("explorer") != -1)
	{
		return "msie"; // alert("인터넷 익스플로러 7~10 브라우저 입니다.");
	}
	else if ( appName == 'netscape' && agent.search('trident') != -1) 
	{
		return "msie"; // alert("인터넷 익스플로러 11 브라우저 입니다.");
	}
	return "unknown";
}

// 서버로그 남기기
function serverLog(log,urlLogger,fnResult)
{
	var sData = 'log=' + encodeURI(log);
	$.ajax({
	     type:"POST",  
	     url: urlLogger,
	     data: sData,
	     dataType: "text",
	     async: false,
	     success:function(data,status,xhr)
	     {
	    	if(fnResult != null)
	    	{
		     	if(status == 'success')
		     	{
		     		fnResult("[success] status:"+status); 
		     	}
		     	else
		     	{
		     		fnResult("[fail] status:"+status+" / "+"message:"+xhr.responseText); 
		     	}
	    	}
	     },   
	     error:function(request,status,error)
	     { 
			
	    	 if(fnResult != null)
	    	 {
	    		//$('#id_status').text("[error] status:"+status+" / "+"message:"+request.responseText+" / "+"error:"+error); 
		    	 fnResult("[error] status:"+status+" / error:"+error); 	 
	    	 }
	     } 
	});
}


