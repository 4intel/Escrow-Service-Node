// 함수들의 사용 활성화
// APP에서 호출하는 AWI_OnLoadFromApp(json) 함수에서 
// var AWI_ENABLE = true;
 
var AWI_ENABLE = false;
var AWI_DEVICE = 'iphone';

//-----------------------------------------------------
// iphone interface 
//IPHONE 콜백 응답 함수 제어
// 응답을 받을 함수를 호출하는 곳에서 다음의 변수를 적당히 설정하고 호출 요
// AWI_getConfig()함수 참고
var  _timeIOSCallbackWaitEnd = Date.now();  // 응답 timeout 시간
var  _boolNeedIOSCallbackWait = false;       // 대기 필요 여부
var  _strIOSCallbackValue = "";                  // 리턴 받은 문자열
function awi_waitIPhoneCallback()
{
	while(_timeIOSCallbackWaitEnd > Date.now() && _boolNeedIOSCallbackWait == true)
	{   // 지정된 시간까지 대기
		;
	}
	return _strIOSCallbackValue;
}

function awi_callbackSuccess(ret)
{
	if(ret != null)
		_strIOSCallbackValue =  ret;
	_boolNeedIOSCallbackWait = false;
}

function awi_callbackError(ret)
{
	if(ret != null)
		_strIOSCallbackValue =  ret;
	_boolNeedIOSCallbackWait = false;
}

function awi_openCustomURLinIFrame(src)
{
    var rootElm = document.documentElement;
    var newFrameElm = document.createElement("IFRAME");
    newFrameElm.setAttribute("src",src);
    rootElm.appendChild(newFrameElm);
    //remove the frame now
    newFrameElm.parentNode.removeChild(newFrameElm);
}

function awi_calliOSFunction(functionName,args, successCallback, errorCallback)
{
    var url = "js2ios://?";

    var callInfo = {};
    callInfo.functionname = functionName;
    if (successCallback)
    {
        callInfo.success = successCallback;
    }
    if (errorCallback)
    {
        callInfo.error = errorCallback;
    }
    if (args)
    {
        callInfo.args = args;
    }

    url += JSON.stringify(callInfo)
 
    awi_openCustomURLinIFrame(url);
}
//======================================
// APP-WEB 인터페이스 함수들 
// APP의 페이지 이동 호출  
function AWI_goUrl(strUrl) {
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=goUrl&url="+escape(strUrl);
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}	  
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "goUrl";
	params['url'] = strUrl;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}
//새 계정 만들기 
//sOwner  : 소유자 이름, 계정 이름으로 같이 사용, 추후 계정 이름은 변경 가능
// 기본적으로 100번 코인이 만들어지게 된다.
function AWI_newAccount(sOwner)
{
	var sReturn = "{ \"result\":\"FAIL\" }"
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=newAccount&name="+sOwner;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "newAccount";
	    params['name'] = sOwner;
	    joCmd = {func:params};
	    sReturn = window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}
	return sReturn; // { "result":"OK" , "aid":"account id" , "wid":"wallet id" , "cid":## }
}


//새지갑 만들기 or 새계정 만들 완료후 알림  
// sResult : "OK" or "FAIL"
// sAID : newWallet에서 리턴받은것 or ""
// sWID : newWallet에서 리턴받은것  or ""
// nCID : 정수형 값으로 ( 코인 ID 이다)
function AWI_notiWallet(sResult,sAID,sWID,nCID)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=notiWallet&result=" + sResult + "&aid=" + sAID + "&wid=" + sWID + "&cid=" + nCID;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "notiWallet";
	params['result'] = sResult;
	params['aid'] = sAID;
	params['wid'] = sWID;
	params['cid'] = nCID;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

// Account  목록 요청 
// 계정 리스트를 조회한다. 
function AWI_listAccount()
{
	var sReturn = "{ \"result\":\"FAIL\" , \"list\":[{}] }"

	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=listAccount";
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "listAccount";
	    joCmd = {func:params};
	    sReturn  = window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
	var joReturn = JSON.parse(sReturn);  // {"result":"OK", "list": [ { "aid":"aid1","name":"기본계정" } ,{ "aid":"aid1","name":"기본계정" } ] }
	return joReturn['list'];
}

// 계정 이름 변경  
function AWI_changeAccountName(sAID,sName) {
	var sReturn = "{ \"result\":\"FAIL\" , \"aid\":\"\"}"

	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=changeAccountName?aid="+sAID+"&name=" + sName;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "changeAccountName";
	    params['aid'] = sAID;
	    params['name'] = sName;
	    joCmd = {func:params};
	    sReturn  = window.AWI.callAppFunc(JSON.stringify(joCmd));
	    return sReturn;
	}

}

//코인 지갑 만들기 
//sAID 계정에 속한 코인지갑을 만든다.
//nCoinID : 정수값으로 취급할 코인의 ID 번호 이다. 
//sOwner  : 소유자 명, 지갑 명으로 같이 사용, 지갑명은 추후 수정 가능.  
function AWI_newWallet(sAID,nCID,sOwner)
{
	var sReturn = "{ \"result\":\"FAIL\" }"
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=newWallet&aid="+sAID+"&cid=" + nCID + "&name="+sOwner;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "newWallet";
	    params['aid'] = sAID;
	    params['cid'] = nCID;
	    params['name'] = sOwner;
	    joCmd = {func:params};
	    sReturn = window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}

	return sReturn; // { "result":"OK" , "aid":"account id" , "wid":"wallet id" , "cid":## }
}

// 계정에 속한 Wallet  목록 요청 
function AWI_listWallet(sAID)
{
	var sReturn = "{ \"result\":\"FAIL\" , \"list\":[{}] }";
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=listWallet?aid=" + sAID;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "listWallet";
	    params['aid'] = sAID;
	    joCmd = {func:params};
	    sReturn  = window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
	var joReturn = JSON.parse(sReturn);  // {"result":"OK", "list": [ { "wid":"wid1","cid": xxx, "name":"기본계정" } ,{ "wid":"wid1","cid":xxx,"name":"기본계정" } ] }
	return joReturn['list'];
}

//계정의 CID 코인지갑정보 조회 
// sAID : 계정 
// nCID : 코인 번호
function AWI_getWallet(sAID,nCID)
{
	var sReturn = "{ \"result\":\"FAIL\" , \"value\":{} }"

	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=getWallet?aid=" + sAID + "&cid=" + nCID;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "getWallet";
	    params['aid'] = sAID;
	    params['cid'] = nCID;
	    joCmd = {func:params};
	    sReturn  = window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
	var joReturn = JSON.parse(sReturn);  // {"result":"OK", "value":{ "wid":"wid1","cid": xxx, "name":"기본계정" } }
	return joReturn['value'];
}
//지갑 이름 변경  
// sAID : 게정 
// nCID : 코인 번호
// sName : 변경할 이름
function AWI_changeWalletName(sAID,nCID,sName)
{
	var sReturn = "{ \"result\":\"FAIL\" , \"aid\":\"\"}"

	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=changeWalletName?aid="+sAID+"&cid="+nCID + "&name=" + sName;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "changeWalletName";
	    params['aid'] = sAID;
	    params['cid'] = nCID;
	    params['name'] = sName;
	    joCmd = {func:params};
	    sReturn  = window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
}
//지갑 코드 이미지를 보여준다.  
//sAID : 게정 ("" 면 현제 사용중이 계정이용 )
//nCID : 코인 번호
function AWI_viewWalletID(sAID,nCID)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=viewWalletID?aid="+sAID+"&cid="+nCID;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "viewWalletID";
	    params['aid'] = sAID;
	    params['cid'] = nCID;
	    joCmd = {func:params};
	    window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
}
//Wallet ID 형식 검증
// sRID : Account_ID of Wallet_ID 
// return boolean 
function AWI_verifyRID(sRID)
{
	var sReturn = "{ \"result\":\"FAIL\" }"

	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=verifyRID?rid=" + sRID;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	    var joCmd = null;
	    var params = new Object();
	    params['cmd'] = "verifyRID";
	    params['rid'] = sRID;
	    joCmd = {func:params};
	    sReturn  = window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}
	var joResult = JSON.parse(sReturn);
	if(joResult['result'] == "OK")
		return true;
	return false;
}

//Root WID 삭제 
function AWI_deleteAccount(sAID)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=deleteAccount&aid=" + sAID;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "deleteAccount";
	params['aid'] = sAID;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}
//기본 Root 계정으로 설정 - 기본계정이 없는 경우 계정 리스트 중 아무거나 기본 계정으로 설정한다.  
function AWI_resetAccount()
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=resetAccount";
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "resetAccount";
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}
//기본 계정을 설정한다.
// parameter : {"func":{"cmd":"setAccount”,”aid”:”accountID”}}
// return    : { "result":"OK"} { "result":"FAIL"}
function AWI_setAccount(sAID)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=setAccount";
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "setAccount";
	params['aid'] = sAID;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}
//APP의 View 전환 호출 
// param strView  : 현재 webview, qrscan ,backupWallet,restoreWallet 가지 적용 중. 
function AWI_changeView(strView,param)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=changeView&view="+strView + "&param=" + param;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}	  
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "changeView";
	params['view'] = strView;
	params['param'] = param;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

//APP의 View 닫기( 사실상 View 전환과 비슷한 효과가 있다.) 
// 닫히면서 이전 View가 나타나는 효과...
//strView  : 닫을 view이름(paymentWebview 이용중...) 
function AWI_closeView(strView,param)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=closeView&view="+strView + "&param=" + param;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}	  
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "closeView";
	params['view'] = strView;
	params['param'] = param;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

//APP의 캡션 타이틀 변경 호출  
function AWI_setTitle(strTitle)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=title&value="+strTitle;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "title";
	params['value'] = strTitle;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

//정보 설정
function AWI_setConfig(strName,strValue)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=setConfig&name="+strName + "&value="+strValue;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "setConfig";
	params['name'] = strName;
	params['value'] = strValue;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

// 폰에 설정한 설정 정보 값을 조회한다.
function AWI_getConfig(strName)
{
	var sReturn = "{ \"result\":\"FAIL\", \"value\":\"\" }"
	if(!AWI_ENABLE) return "";
	if(AWI_DEVICE == 'iphone') {
		var args = "cmd=getConfig&name="+strName;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	} else {
		var joCmd = null;
		var params = new Object();
		params['cmd'] = "getConfig";
		params['name'] = strName;
		joCmd = {func:params};
		sReturn =  window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}
	var joReturn = JSON.parse(sReturn); // { "result":"OK", "value":"....." }
	return joReturn['value'];
}
// 이 폰의 PUSH ID 값을 google 서버에서 조회한다.
// 단순이 값을 알아보기위한 것이라면, AWI_getConfig('$PUSH_ID')를 이용하는 것이 좋다.
function AWI_requestPushID()
{
	var sReturn = "{ \"result\":\"FAIL\", \"value\":\"\" }"
	if(!AWI_ENABLE) return "";
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=requestPushID";
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "requestPushID";
	joCmd = {func:params};
	sReturn =  window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}
	var joReturn = JSON.parse(sReturn); // { "result":"OK", "value":"....." }
	return joReturn['value'];
}

// 폰에서 동작하는 내부 서버 정보를 조회한다.
function AWI_getLocalHttpHost()
{
	var sReturn = "{ \"result\":\"FAIL\", \"ip\":\"\", \"port\":0  }"
	if(!AWI_ENABLE) return "";
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=getLocalHttpHost";
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "getLocalHttpHost";
	joCmd = {func:params};
	sReturn =  window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}
	var joReturn = JSON.parse(sReturn); // { "result":"OK", "ip":"xxx.xxx.xxx.xxx", "port":8060 }
	return "http://127.0.0.1:" + joReturn['port'];
}

// 세션 로그인 상태를 알린다.
function AWI_notiLogin(sAID)
{         
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=login&wid="+strWID;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "login";
	params['aid'] = sAID;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));		
}


//WebView Cache 클리어
function AWI_clearCache()
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=clearCache";
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "clearCache";
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}
//폰에 설정한 암호를 검증한다.
// return : bool
function AWI_checkPassword(strPW)
{
	var sReturn = "{ \"result\":\"FAIL\", \"value\":\"\" }"
	if(!AWI_ENABLE) return "";
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=checkPassword&value="+strPW;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
		var joCmd = null;
		var params = new Object();
		params['cmd'] = "checkPassword";
		params['value'] = strPW;
		joCmd = {func:params};
		sReturn =  window.AWI.callAppFunc(JSON.stringify(joCmd));	
	}
	var joReturn = JSON.parse(sReturn); // { "result":"OK", "value":true }
	return joReturn['value'];
}

function AWI_setPassword(strOldPW,strNewPW)
{
	var sReturn = "{ \"result\":\"FAIL\", \"value\":\"\" }"
	if(!AWI_ENABLE) return "";
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=setPassword&newpw="+strNewPW+"&oldpw="+strOldPW;
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
		var joCmd = null;
		var params = new Object();
		params['cmd'] = "setPassword";
		params['oldpw'] = strOldPW;
		params['newpw'] = strNewPW;
		joCmd = {func:params};
		sReturn =  window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
	var joReturn = JSON.parse(sReturn); // { "result":"OK", "value":true }
	return joReturn['value'];
}
// return boolean, test to pass the password
function AWI_isCheckPassword()
{
	var sReturn = "{ \"result\":\"FAIL\", \"value\":false }"
	if(!AWI_ENABLE) return false;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=isCheckPassword";
		_boolNeedIOSCallbackWait = true;
		_timeIOSCallbackWaitEnd = Date.now() + 2000; // 2초안에 응답 
		_strIOSCallbackValue = "";
		awi_calliOSFunction("callAppFunc",args 	,"awi_callbackSuccess" ,"awi_callbackError" );
		sReturn = awi_waitIPhoneCallback();
	}
	else
	{
		var joCmd = null;
		var params = new Object();
		params['cmd'] = "isCheckPassword";
		joCmd = {func:params};
		sReturn =  window.AWI.callAppFunc(JSON.stringify(joCmd));
	}
	var joReturn = JSON.parse(sReturn); // { "result":"OK", "value":true }
	return joReturn['value'];
}
// App 종료 요청 
function AWI_exitApp()
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=exitApp";
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "exitApp";
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

//메뉴 닫는다.
function AWI_closeMenu()
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var args = "cmd=closeMenu";
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params = new Object();
	params['cmd'] = "closeMenu";
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));	
}

//Send coin 확인 호출 및 전송
//It transfers coin to coin-wallet belong current account and confirm.
// realID is setted in case of not equals receiver WID and  realID
//jaArgs = [ "createTrans","PID","10000","receiver WID",
//         "R","value","transfer memo","sender memo","receiver memo","realID","CID"]
function AWI_sendConfirm(jaArgs,sCallbackUrl)
{
	if(!AWI_ENABLE) return;
	if(AWI_DEVICE == 'iphone')
	{
		var sUrl = encodeURL(sCallbackUrl);
		var sArgs = JSON.stringify(jaArgs);
		sArgs = encodeURL(sArgs);
		
		var args = "cmd=sendConfirm&callback=" + sUrl + "&args=" + sArgs;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}
	var joCmd = null;
	var params =  new Object();
	params['cmd'] = "sendConfirm";
	params['callback'] = sCallbackUrl;
	params['args'] = jaArgs;
	joCmd = {func:params};
	window.AWI.callAppFunc(JSON.stringify(joCmd));
}

//attach sub-information of transaction 
// 현재 활성중인 계정에서 적용된다.
// trNO : transaction sequence number
// tgtWID : 평가 받는 대상
// txTag : 평가 내용 
// CID   : 코인 번호
//jaArgs = [ "PID","10000","txID","trNO", "tgtWID", "Owner type S/R", "txTag","CID" ]
function AWI_attachTransTag(jaArgs,sCallbackUrl)
{
	if(!AWI_ENABLE) return; 
	if(AWI_DEVICE == 'iphone')
	{
		var sUrl = encodeURL(sCallbackUrl);
		var sArgs = JSON.stringify(jaArgs);
		sArgs = encodeURL(sArgs);
		
		var args = "cmd=attachTransTag&callback=" + sUrl + "&args=" + sArgs;
		awi_calliOSFunction("callAppFunc",args,null,null);
		return ;
	}	  
	var joCmd = null;
	var params =  new Object();
	params['cmd'] = "attachTransTag";
	params['callback'] = sCallbackUrl;
	params['args'] = jaArgs;
	joCmd = {func:params};

	window.AWI.callAppFunc(JSON.stringify(joCmd));
}