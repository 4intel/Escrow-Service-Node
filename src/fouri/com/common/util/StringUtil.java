package fouri.com.common.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

/**
 * 공통 String Util
 * org.apache.commons.lang.StringUtils 상속후 필요 메소드 추가
 * 자세한 기타 자세한 스펙은 org.apache.commons.lang.StringUtils 참조
 * (url : http://jakarta.apache.org/commons/lang/api-release/org/apache/commons/lang/StringUtils.html)
 */
public class StringUtil extends StringUtils {
	/**
	 * 문자열 좌측의 공백을 제거하는 메소드
	 */
	public static String ltrim(String str){
		int len = str.length();
		int idx = 0;

		while ((idx < len) && (str.charAt(idx) <= ' '))
		{
			idx++;
		}
		return str.substring(idx, len);
	}

	/**
	 * 문자열 우측의 공백을 제거하는 메소드
	 */
	public static String rtrim(String str){
		int len = str.length();

		while ((0 < len) && (str.charAt(len-1) <= ' '))
		{
			len--;
		}
		return str.substring(0, len);
	}

	/**
	 * 인수에서 숫자부분만 뽑아내서 반환합니다.
	 */
	public static String getDigit(String sValue) {
		if (sValue == null || "".equals(sValue)) {
			return "";
		}
		
		String digitStr = "0123456789";
		StringBuffer sb = new StringBuffer();
		
		for (int i = 0 ; i < sValue.length(); i++) {
			
			char cValue = sValue.charAt(i);			
			for (int j = 0 ; j < digitStr.length(); j++) {
				
				char digit = digitStr.charAt(j);				
				if (cValue == digit) {
					sb.append(cValue);
				}
			}
		}				
		return sb.toString();		
	}

	/**
	 * String을
	 */
	public static String changeMoney(String str) {
		DecimalFormat df = new DecimalFormat("###,###");

		return df.format(parseInt(str));
	}

	/**
	 * 파라미터로 넘어오는 String을 , 를 제거해준다.
	 */
	public static String removeComma(String str) {
		String rtnValue = str;
		if ( isNull(str) ) {
			return "";
		}

		rtnValue = replace(rtnValue, ",", "");
		return rtnValue;
	}

	/**
	 * str이 null 이거나 "", "    " 일경우 return true
	 */
	public static boolean isNull(String str) {
		return (str == null || (str.trim().length()) == 0 );
	}

	public static boolean isNull(Object obj) {
		String str = null;
		if( obj instanceof String ) {
			str = (String)obj;
		} else {
			return true;
		}

		return isNull(str);
	}

	/**
	 * null이 아닐때.
	 */
	public static boolean isNotNull(String str) {
		/**
		 * isNull이 true이면 false
		 * false이면 true
		 */
		if( isNull(str) ){
			return false;

		} else {
			return true;
		}
	}

	public static boolean isNotNull(Object obj) {
		String str = null;
		if( obj instanceof String ) {
			str = (String)obj;
		} else {
			return false;
		}

		return isNotNull(str);
	}

	/**
	 * 파라미터가 null 이거나 공백이 있을경우
	 * "" 로 return
	 */
	public static String nvl(String value) {
		return nvl(value, "");
	}

	/**
	 * Object를 받아서 String 형이 아니거나 NULL이면 ""를 return
	 * String 형이면 형 변환해서 넘겨준다.
	 */
	public static String nvl(Object value) {
		Object rtnValue = value;
		if( rtnValue == null || !"java.lang.String".equals(rtnValue.getClass().getName())) {
			rtnValue = "";
		}

		return nvl((String)rtnValue, "");
	}

	/**
	 * 파라미터로 넘어온 값이 null 이거나 공백이 포함된 문자라면
	 * defaultValue를 return
	 * 아니면 값을 trim해서 넘겨준다.
	 */
	public static String nvl(String value, String defaultValue) {
		if (isNull(value)) {
			return defaultValue;
		}

		return value.trim();
	}

	/**
	 * Object를 받아서 String 형이 아니거나 NULL이면 defaultValue를 return
	 * String 형이면 형 변환해서 넘겨준다.
	 */
	public static String nvl(Object value, String defaultValue) {
		String valueStr = nvl(value);
		if ( isNull(valueStr) ) {
			return defaultValue;
		}

		return valueStr.trim();
	}

	/**
	 * Method ksc2asc.
	 * 8859-1를 euc-kr로 인코딩하는 함수
	 */
	public static String ksc2asc(String str) {
		String result = "";

		if (isNull(str)) {
			result = "";
		} else {
			try {
				result = new String( str.getBytes("euc-kr"), "8859_1" );
			} catch( Exception e ) {
				result = "";
			}
		}

		return result;
	}

	/**
	 * Method asc2ksc.
	 * euc-kr을 8859-1로 인코딩하는 함수
	 */
	public static String asc2ksc(String str) {
		String result = "";

		if (isNull(str)) {
			result = "";
		} else {
			try {
				result = new String( str.getBytes("8859_1"), "euc-kr" );
			} catch( Exception e ) {
				result = "";
			}
		}

		return result;
	}

	/**
	 *일반문자를 호스트 2바이트 문자로 바꾸기
	 */
	public static String hexHex2Str(String strString) {
		String ori = "";
		
		try {
			byte[] result = strString.getBytes("Cp933");
			String temp = "";

			for ( int i = 1; i < result.length-1; i++ ) {
				temp = Integer.toHexString(result[i]).toUpperCase();
				ori = ori + temp.substring(temp.length()-2);
			}
		} catch(Exception _ex) {
			_ex.printStackTrace();
		}
		return ori;
	}
	
	/**
	 * Insert the method's description here.
	 * Creation date: (2001-12-13 오후 5:03:43)
	 */
	public static String hexStr2Hex(String hexaString) {
		int byteLength = hexaString.length() / 2;
		
		byte[] result = new byte[ byteLength ];

		for ( int i = 0; i < byteLength; i++ ) {

			// 두 글자씩 잘라, byte값으로 변환
			String frag = hexaString.substring(i*2, i*2+2);
			result[i] = (byte)Integer.parseInt(frag, 16);

		}

		try {
			byte[] temp4 = new byte[ result.length + 2 ];
			System.arraycopy(result, 0, temp4, 1, result.length);
			
			// 양옆에 SO/SI붙이기
			temp4[0] = 0x0E;
			temp4[temp4.length-1] = 0x0F;

			// byte[]을 java string으로 변환
			String ori = new String( temp4, "Cp933");
			return getNcharToString(ori).trim();

		} catch(Exception _ex) {
			_ex.printStackTrace();
		}
		return null;
	}
	
	public static String getNcharToString(String Nchar) {
		
		if(Nchar==null || Nchar.length()==0)
			Nchar = "" ;
		else
			Nchar = Nchar.replace('　',' ');

		return Nchar;

	}
	
	/**
	 * Insert the method's description here.
	 * Creation date: (2001-12-13 오후 5:03:43)
	 */
	public static String hexStr2Str(String hexaString) {
		int byteLength = hexaString.length() / 2;
		
		byte[] result = new byte[ byteLength ];

		for ( int i = 0; i < byteLength; i++ ) {

			// 두 글자씩 잘라, byte값으로 변환
			String frag = hexaString.substring(i*2, i*2+2);
			result[i] = (byte)Integer.parseInt(frag, 16);

		}

		try {
			byte[] temp4 = new byte[ result.length + 2 ];
			System.arraycopy(result, 0, temp4, 1, result.length);
			
			// 양옆에 SO/SI붙이기
			temp4[0] = 0x0E;
			temp4[temp4.length-1] = 0x0F;

			// byte[]을 java string으로 변환
			String ori = new String( temp4, "Cp933");

			//Debug
			return ori.trim();

		} catch(Exception _ex) {
			_ex.printStackTrace();
		}
		return null;
	}
	/**************************************************************************************/
	/*	parse method start	*/


	/**
	 * String을 int형으로
	 * @param value
	 * @return
	 */
	public static int parseInt(String value) {
		return parseInt(value, 0);
	}
	/**
	 * Object를 int형으로
	 * defaultValue는 0이다.
	 */
	public static int parseInt(Object value) {
		String valueStr = nvl(value);
		return parseInt(valueStr, 0);
	}
	/**
	 * Object를 int형으로
	 * Object가 null이면 defaultValue return
	 */
	public static int parseInt(Object value, int defaultValue) {
		String valueStr = nvl(value);
		return parseInt(valueStr, defaultValue);
	}
	/**
	 * String을 int형으로
	 * String이 숫자 형식이 아니면 defaultValue return
	 */
	public static int parseInt(String value, int defaultValue) {
		int returnValue = 0;

		if( isNull(value) ) {
			returnValue = defaultValue;
		} else if( !isNumeric(value) ) {
			returnValue = defaultValue;
		} else {
			returnValue = Integer.parseInt(value);
		}

		return returnValue;
	}

	/**
	 * String을 long형으로
	 * defaultValue는 0이다.
	 */
	public static long parseLong(String value) {
		return parseLong(value, 0);
	}

	/**
	 * String을 long형으로
	 * 잘못된 데이타 일시 return은 defaultValue
	 */
	public static long parseLong(String value, long defaultValue) {
		long returnValue = 0;

		if( isNull(value) ) {
			returnValue = defaultValue;
		} else if( !isNumeric(value) ) {
			returnValue = defaultValue;
		} else {
			returnValue = Long.parseLong(value);
		}

		return returnValue;
	}

	/**
	 * Exception을 String으로 뽑아준다.
	 */
	public static String stackTraceToString(Throwable e) {
		try {
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			return "------\r\n" + sw.toString() + "------\r\n";
	  }catch(Exception e2) {
		  return StringUtil.stackTraceToString2(e);
	  }
	}
	/**
	 * Exception을 String으로 뽑아준다.
	 */
	public static String stackTraceToString2(Throwable e) {
		ByteArrayOutputStream b = new ByteArrayOutputStream();
		PrintStream p = new PrintStream(b);
		e.printStackTrace(p);
		p.close();
		String stackTrace = b.toString();
		try {
			b.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}

		return stackTrace;
	}

	/**
	 * Html 코드에서 &#60;br&#62; 태크 제거
	 */
	public static String convertHtmlBr(String comment) {
		String rtnValue = "";
		if( isNull(comment) ) {
			return "";
		}

		rtnValue = replace(comment, "\r\n", "<br>");

		return rtnValue;
	}


	/**
	 * String 배열을 List로 변환한다.
	 */
	public static List changeList(String [] values) {
		List list = new ArrayList();

		if( values == null ) {
			return list;
		}
		for(int i=0,n=values.length; i<n; i++) {
			list.add(values[i]);
		}

		return list;
	}


	public static String[] toTokenArray(String str, String sep){

		String[] temp = null;

		try{
			StringTokenizer st = new StringTokenizer(str, sep);
			temp = new String[st.countTokens()];
			int index = 0;
			while(st.hasMoreTokens()){
				temp[index++] = st.nextToken();
			}
		}catch(Exception e){
			e.printStackTrace();
		}

		return temp;
	}

    /**
     * <br> get strings from token
     * @param p_data
     * @param p_delim 구분자
     * @return hashtable.get (num)
     */
    static public Hashtable get_tokens (String p_str, String p_delim) throws Exception {
        Hashtable v_ht = new Hashtable ();

        StringTokenizer v_tokenizer = new StringTokenizer (p_str, p_delim);
        if (v_tokenizer == null)
            return v_ht;

        int v_cnt = 1;

        try {
            while (v_tokenizer.hasMoreTokens ())
                v_ht.put (String.valueOf(v_cnt++), v_tokenizer.nextToken ().trim ());
        } catch (Exception e) { e.printStackTrace(); throw new Exception (e); }

        return v_ht;
    }
    
    public static String strip(String str, String str1){

    	if(str == null || "".equals(str.trim())) return "";

	    String temp = str;
		int pos = -1;
		while((pos = temp.indexOf(str1, pos)) != -1) {
			String left = temp.substring(0, pos);
			String right = temp.substring(pos + 1, temp.length());
			temp = left + "" + right;
			pos += 1;
		}
		return temp;
    }

    /**
	 * Method ksc2asc.
	 * euc-kr을 euc-kr로 인코딩하는 함수
	 * @param str - String
	 */
	public static String ksc2utf8(String str) {
		String result = "";

		if (isNull(str)) {
			result = "";
		} else {
			try {
				result = new String( str.getBytes("euc-kr"), "utf-8" );
			} catch( Exception e ) {
				result = "";
			}
		}

		return result;
	}
	
    /**
	 * @return String
	 */
	public static String utf82ksc(String str) {
		String result = "";

		if (isNull(str)) {
			result = "";
		} else {
			try {
				result = new String( str.getBytes("utf-8"), "euc-kr" );
			} catch( Exception e ) {
				result = "";
			}
		}

		return result;
	}
	
    /**
	 * @return String
	 */
	public static String convertInconding(String str, String t1, String t2) {
		String result = "";

		if (isNull(str)) {
			result = "";
		} else {
			try {
				result = new String( str.getBytes(t1), t2 );
			} catch( Exception e ) {
				result = "";
			}
		}

		return result;
	}

	/**
	 * string에 있는 ', ", \r\n 를 HTML 코드로 변환한다.
	 */
	public static String changeQuotation(String str) {
		String rtnValue = str;
		rtnValue = nvl(rtnValue);
		rtnValue = replace(replace(replace(rtnValue, "'", "&#39;"), "\"", "&#34;"), "\r\n", "<br>");

		return rtnValue;
	}
	public static String changeQuotation(Object obj) {
		if( isStringInteger(obj) ) {
			return changeQuotation(String.valueOf(obj));
		}

		return "";
	}

	/**
	 * 해당 Object가 String or Integer 이면 true
	 * 아니면 false
	 */
	public static boolean isStringInteger(Object obj) {

		boolean flag = false;

		if( obj instanceof String || obj instanceof Integer ) {
			flag = true;
		}

		return flag;
	}

	/**
	 * 백분율을 구한다.
	 * %는 빼고 값만 리턴
	 */
	public static String percentValue(int value, int total) {
		double val = Double.parseDouble(String.valueOf(value)) / Double.parseDouble(String.valueOf(total)) * 100;

		DecimalFormat df = new DecimalFormat("##0.0");
		return df.format(val);
	}




	/**
	 *  XSS(Cross Site Scripting) 취약점 해결을 위한 처리
	 *
	 * @param sourceString String 원본문자열
	 * @return String 변환문자열
	 */
	public static String replaceXSS(String sourceString){
		String rtnValue = null;
		if(sourceString!=null){
			rtnValue = sourceString;
			if(rtnValue.indexOf("<x-") == -1){
				rtnValue = rtnValue.replaceAll("< *(j|J)(a|A)(v|V)(a|A)(s|S)(c|C)(r|R)(i|I)(p|P)(t|T)", "<x-javascript");
				rtnValue = rtnValue.replaceAll("< *(v|V)(b|B)(s|S)(c|C)(r|R)(i|I)(p|P)(t|T)", "<x-vbscript");
				rtnValue = rtnValue.replaceAll("< *(s|S)(c|C)(r|R)(i|I)(p|P)(t|T)", "<x-script");
				rtnValue = rtnValue.replaceAll("< *(i|I)(f|F)(r|R)(a|A)(m|M)(e|E)", "<x-iframe");
				rtnValue = rtnValue.replaceAll("< *(f|F)(r|R)(a|A)(m|M)(e|E)", "<x-frame");
				rtnValue = rtnValue.replaceAll("(e|E)(x|X)(p|P)(r|R)(e|E)(s|S)(s|S)(i|I)(o|O)(n|N)", "x-expression");
				rtnValue = rtnValue.replaceAll("(a|A)(l|L)(e|E)(r|R)(t|T)", "x-alert");
				rtnValue = rtnValue.replaceAll(".(o|O)(p|P)(e|E)(n|N)", ".x-open");
				rtnValue = rtnValue.replaceAll("< *(m|M)(a|A)(r|R)(q|Q)(u|U)(e|E)(e|E)", "<x-marquee");
				rtnValue = rtnValue.replaceAll("&#", "&amp;#");
			}
		}

		return rtnValue;
    }


	/**
	 * 특정문자를 HTML TAG형식으로 변경하는 메소드.
	 *
	 * <xmp>
	 * & --> &amp;
	 * < --> &lt;
	 * > --> &gt;
	 * " --> &quot;
	 * ' --> &#039;
	 *-----------------------------------------------------------------
	 * <option type=radio  name=r value="xxxxxxxx"> yyyyyyy
	 * <input  type=hidden name=h value="xxxxxxxx">
	 * <input  type=text   name=t value="xxxxxxxx">
	 * <textarea name=msg rows=20 cols=53>xxxxxxx</textarea>
	 *-
	 * 위와 같은 HTML 소스를 생성할 때, xxxxxxx 부분의 문자열 중에서
	 * 아래에 있는 몇가지 특별한 문자들을 변환하여야 합니다.
	 * 만약 JSP 라면 미리 변환하여 HTML 전체 TAG를 만들거나, 혹은 아래처럼 사용하세요.
	 *-
	 * <option type=radio  name=r value="<%= StringUtil.translate(s) %>"> yyyyyyy
	 * <input  type=hidden name=n value="<%= StringUtil.translate(s) %>">
	 * <input  type=text   name=n value="<%= StringUtil.translate(s) %>">
	 * <textarea name=body rows=20 cols=53><%= StringUtil.translate(s) %></textarea>
	 *-
	 * 또 필요하다면 yyyyyyy 부분도  translate(s)를 할 필요가 있을 겁니다.
	 * 필요할 때 마다 사용하세요.
	 *-
	 * </xmp>
	 *
	 * @return the translated string.
	 * @param str java.lang.String
	 */
	public static String translate(String str){
		if ( str == null ) return null;

		StringBuffer buf = new StringBuffer();
		char[] c = str.toCharArray();
		int len = c.length;

		for ( int i=0; i < len; i++){
			if      ( c[i] == '&' ) buf.append("&amp;");
			else if ( c[i] == '<' ) buf.append("&lt;");
			else if ( c[i] == '>' ) buf.append("&gt;");
			else if ( c[i] == '"' ) buf.append("&quot;");	// (char)34
			else if ( c[i] == '\'') buf.append("&#039;");	// (char)39
			else buf.append(c[i]);
		}
		return buf.toString();
	}

   /**
    * String 앞 또는 뒤를 특정문자로 지정한 길이만큼 채워주는 함수    <BR>
    * (예) pad("1234","0", 6, 1) --> "123400"   <BR>
    *
    * @param    src 	Source string
    * @param    pad 	pad string
    * @param    totLen     total length
    * @param    mode     앞/뒤 구분 (-1:front, 1:back)
    * @return   String
    */
	public static String pad(String src, String pad, int totLen, int mode){
		String paddedString = "";

		if(src == null) return "";
		int srcLen = src.length();

		if((totLen<1)||(srcLen>=totLen)) return src;

		for(int i=0; i< (totLen-srcLen); i++){
			paddedString += pad;
		}

		if(mode == -1)
			paddedString += src;	// front padding
		else
	     	paddedString = src + paddedString; //back padding

		return paddedString;
	}

	/**
	 * 주어진 길이(iLength)만큼 주어진 문자(cPadder)를 strSource의 왼쪽에 붙혀서 보내준다.
	 * ex) lpad("abc", 5, '^') ==> "^^abc"
	 *     lpad("abcdefghi", 5, '^') ==> "abcde"
	 *     lpad(null, 5, '^') ==> "^^^^^"
	 */
	public static String lpad(String strSource, int iLength, char cPadder){
		StringBuffer sbBuffer = null;

		if (!isEmpty(strSource)){
			int iByteSize = getByteSize(strSource);
			if (iByteSize > iLength){
				return strSource.substring(0, iLength);
			}else if (iByteSize == iLength){
				return strSource;
			}else{
				int iPadLength = iLength - iByteSize;
				sbBuffer = new StringBuffer();
				for (int j = 0; j < iPadLength; j++){
					sbBuffer.append(cPadder);
				}
				sbBuffer.append(strSource);
				return sbBuffer.toString();
			}
		}

		//int iPadLength = iLength;
		sbBuffer = new StringBuffer();
		for (int j = 0; j < iLength; j++){
			sbBuffer.append(cPadder);
		}
		return sbBuffer.toString();
	}

	/**
	 * 주어진 길이(iLength)만큼 주어진 문자(cPadder)를 strSource의 오른쪽에 붙혀서 보내준다.
	 * ex) lpad("abc", 5, '^') ==> "abc^^"
	 *     lpad("abcdefghi", 5, '^') ==> "abcde"
	 *     lpad(null, 5, '^') ==> "^^^^^"
	 */
	public static String rpad(String strSource, int iLength, char cPadder){
		StringBuffer sbBuffer = null;
			if (!isEmpty(strSource)){
			int iByteSize = getByteSize(strSource);
			if (iByteSize > iLength){
				return strSource.substring(0, iLength);
			}else if (iByteSize == iLength){
				return strSource;
			}else{
				int iPadLength = iLength - iByteSize;
				sbBuffer = new StringBuffer(strSource);
				for (int j = 0; j < iPadLength; j++){
					sbBuffer.append(cPadder);
				}
				return sbBuffer.toString();
			}
		}
		sbBuffer = new StringBuffer();
		for (int j = 0; j < iLength; j++){
			sbBuffer.append(cPadder);
		}
		return sbBuffer.toString();
	}

	/**
	 *  byte size를 가져온다.
	 */
	public static int getByteSize(String str){
		if (str == null || str.length() == 0)
			return 0;
		byte[] byteArray = null;
			try{
			byteArray = str.getBytes("UTF-8");
		}catch (UnsupportedEncodingException ex){}
		if (byteArray == null) return 0;
		return byteArray.length;
	}
	     /**
     * 긴 문자열 자르기
     * @param srcString      대상문자열
     * @param nLength        길이
     * @param isNoTag        테그 제거 여부
     * @param isAddDot        "..."을추가 여부
     * @return
     */
    public static String strCut(String srcString, int nLength, boolean isNoTag, boolean isAddDot){  // 문자열 자르기
        String rtnVal = srcString;
        int oF = 0, oL = 0, rF = 0, rL = 0;
        int nLengthPrev = 0;

        // 태그 제거
        if(isNoTag) {
            Pattern p = Pattern.compile("<(/?)([^<>]*)?>", Pattern.CASE_INSENSITIVE);  // 태그제거 패턴
            rtnVal = p.matcher(rtnVal).replaceAll("");
        }
        rtnVal = rtnVal.replaceAll("&amp;", "&");
        rtnVal = rtnVal.replaceAll("(!/|\r|\n|&nbsp;)", "");  // 공백제거
        try {
        	byte[] bytes = rtnVal.getBytes("UTF-8");     // 바이트로 보관
	        // x부터 y길이만큼 잘라낸다. 한글안깨지게.
	        int j = 0;
	        if(nLengthPrev > 0) while(j < bytes.length) {
	        	if((bytes[j] & 0x80) != 0) {
	        		oF+=2; rF+=3; if(oF+2 > nLengthPrev) {break;} j+=3;
	            } else {if(oF+1 > nLengthPrev) {break;} ++oF; ++rF; ++j;}
	        }

	        j = rF;

	        while(j < bytes.length) {
	        	if((bytes[j] & 0x80) != 0) {
	        		if(oL+2 > nLength) {break;} oL+=2; rL+=3; j+=3;
	            } else {if(oL+1 > nLength) {break;} ++oL; ++rL; ++j;}
	        }

	        rtnVal = new String(bytes, rF, rL, "UTF-8");  // charset 옵션

	        if(isAddDot && rF+rL+3 <= bytes.length) {rtnVal+="...";}  // ...을 붙일지말지 옵션
        } catch(UnsupportedEncodingException e){
        	e.printStackTrace();
        	return srcString;
        }

	    return rtnVal;
    }


    /**
     * <br> string cut
     * @param p_str string
     * @param p_s start location
     * @param p_e end location
     */
    static public String get_string_from (String p_str, int p_s, int p_e) {
        try {
            return (p_str.length() > p_e) ? p_str.substring (p_s, p_e) + "..." : p_str;
        } catch (Exception e) { return p_str.length () > p_s ? p_str.substring (p_s, p_str.length ()) : ""; }
    }

    /**
     * <br> string cut from spec
     * @param p_data string
     * @param p_start start with string
     * @param p_end end with string
     */
    static public String cut_string_from (String p_data, String p_start, String p_end) {
        int v_pos = 0;
        String v_data = p_data;

        try {
            if ((v_pos = v_data.indexOf (p_start)) == -1) return v_data;

            String v_head = v_data.substring (0, v_pos);
            v_data = v_data.substring (v_pos, v_data.length ());
            return v_head
                   + v_data.substring (v_data.indexOf (p_end) + p_end.length (), v_data.length ());
        }

        catch (Exception e) { return p_data; }
    }

    /* <br> string replace
     * @param p_text full text
     * @param p_org
     * @param p_tar
     */
    static public String cvt_string_from (String p_text, String p_org, String p_tar)
    {
        int v_locate = 0, v_prev = -1;
        String v_tmp = "";

        if (p_text == null || "".equals (p_text))
            return "";

        while (v_locate != -1) {
            if ((v_locate = p_text.indexOf (p_org)) == -1) break;

            if (v_locate == v_prev)
                break;

            v_prev = v_locate;

            v_tmp = p_text.substring (0, v_locate);
            v_tmp += p_tar;
            v_tmp += p_text.substring (v_locate + p_org.length (), p_text.length ());

            p_text = v_tmp;
        };

        return p_text;
    }

    public static String mReplaceBRTag(String inStr) {
        int length = inStr.length();
        StringBuffer buffer = new StringBuffer();
        for(int i = 0; i < length; i++)
        {
            String tmp = inStr.substring(i, i + 1);
            if("\n".compareTo(tmp) == 0)
                buffer.append("<br>");
            if(" ".compareTo(tmp) == 0)
                buffer.append("&nbsp;");
            else
                buffer.append(tmp);
        }

        return buffer.toString();
    }

	
	/**
	 * 배열의 내용을 SQL IN안에 들어가도록 변환하여 반환합니다.
	 * 예) [aaa][bbb][ccc] ->  'aaa','bbb','ccc'
	 */
	public static String convertSQLINString(String [] value) {
		StringBuffer sb = new StringBuffer();
		for (int i  = 0; i < value.length; i++) {
			sb.append(value[i]);
			if (i < value.length - 1) {
				sb.append(",");
			} 
		}
		return sb.toString();		
	}
    
    /**
     * yyyy-MM-dd hh:mm:ss 형식의 현재시간을 반환합니다.
     */
    public static Timestamp getCurrentTime() {
         SimpleDateFormat formatter = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
         Calendar cal = Calendar.getInstance();
         String today = formatter.format(cal.getTime());
         Timestamp ts = Timestamp.valueOf(today);
         
         return ts;
    }

    /**
     * XSS 방지 처리.
     */
    public static String unscript(String data) {
        if (data == null || data.trim().equals("")) {
            return "";
        }
        
        String ret = data;
        
        ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
        ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
        
        ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
        ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
        
        ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
        ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
        
        ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
        
        ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
        ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

        return ret;
    }
}