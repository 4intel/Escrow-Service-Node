package fouri.com.common.util;

import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.Calendar;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
public class EtcUtils {
	
	/**
	 * StringBuffer에서 특정 문자의 위치 찾기
	 * @param strbBuf
	 * @param chFind
	 * @param bIgnoreCase
	 * @param nStartPos
	 * @return  : 문자위치 , 없으면 -1
	 */
	public static int findChar(StringBuffer strbBuf, char chFind, boolean bIgnoreCase, int nStartPos)
	{
		int nEffectChars = strbBuf.length();
		int nIdx;
		if (nStartPos < 0) nStartPos = 0;
		if (bIgnoreCase == false)
		{
			for (nIdx = nStartPos; nIdx < nEffectChars; nIdx++)
			{
				if (strbBuf.charAt(nIdx) == chFind)
				{
					return nIdx;
				}
			}
		}
		else
		{
			chFind = Character.toUpperCase(chFind);
			for (nIdx = nStartPos; nIdx < nEffectChars; nIdx++)
			{
				if (Character.toUpperCase(strbBuf.charAt(nIdx)) == chFind)
				{
						return nIdx;
				}
			}

		}
		return -1;
	}
	
	/**
	 * StringBuffer에서 특정 문자열의 위치 찾기, strbBuf.IndexOf(strFind) 와 유사하지만
	 * , 대소문자 구분과, 시작 위치를 지정 할 수 있다.
	 * @param strbBuf
	 * @param chFind
	 * @param bIgnoreCase
	 * @param nStartPos
	 * @return  : 문자위치 , 없으면 -1
	 */
	public static int findStr(StringBuffer strbBuf, String strFind, boolean bIgnoreCase, int nStartPos)
	{
		if (strFind == null || strFind.length() == 0) return -1;
		int nEffectChars = strbBuf.length();
		int nIdx, nFindIdx, nFindLen;
		boolean bFound = false;
		char chFirst;
		if (nStartPos < 0) nStartPos = 0;
		chFirst = strFind.charAt(0);
		nFindLen = strFind.length();
		if (bIgnoreCase == false)
		{
			for (nIdx = nStartPos; nIdx < nEffectChars; nIdx++)
			{
				if (strbBuf.charAt(nIdx) == chFirst)
				{
					if (nIdx + nFindLen < nEffectChars)
					{
						bFound = true;
						for (nFindIdx = 1; nFindIdx < nFindLen; nFindIdx++)
						{
							if (strbBuf.charAt(nIdx + nFindIdx) != strFind.charAt(nFindIdx))
							{
								bFound = false;
								break;
							}
						}
						if (bFound) return nIdx;
					}
				}
			}
		}
		else
		{
			chFirst = Character.toUpperCase(chFirst);
			String strUpperFind = strFind.toUpperCase();
			for (nIdx = nStartPos; nIdx < nEffectChars; nIdx++)
			{
				if (Character.toUpperCase(strbBuf.charAt(nIdx)) == chFirst)
				{
					if (nIdx + nFindLen <= nEffectChars)
					{
						bFound = true;
						for (nFindIdx = 1; nFindIdx < nFindLen; nFindIdx++)
						{
							if (Character.toUpperCase(strbBuf.charAt(nIdx + nFindIdx)) != strUpperFind.charAt(nFindIdx))
							{
								bFound = false;
								break;
							}
						}
						if (bFound) return nIdx;
					}
				}
			}

		}
		return -1;
	}
	/**
	 * StringBuffer에 있는 모든 문자를 한번에 바꾸기
	 * @param strbBuf
	 * @param strOldToken
	 * @param strNewToken
	 * @param bIgnoreCase
	 * @param nStartPos
	 * @return
	 */
	public static StringBuffer replaceTokenAll(StringBuffer strbBuf, String strOldToken, String strNewToken,
			boolean bIgnoreCase, int nStartPos)
	{
		int nOldTokenLen = strOldToken.length();
		int nNewTokenLen = strNewToken.length();

		while ((nStartPos = findStr(strbBuf, strOldToken, bIgnoreCase, nStartPos)) != -1)
		{
			strbBuf = strbBuf.replace(nStartPos, nStartPos + nOldTokenLen, strNewToken);
			nStartPos += nNewTokenLen;
		}
		return strbBuf;
	}
	

	/**
	 * 레코드에 있는 java.sql.Date를 java.util.Date형식으로 전환
	 * 필드값이 null이면 null 를 리턴함
	 * @param rs
	 * @param strDateFieldName
	 * @return  java.util.Date  or null 
	 * @throws SQLException
	 */
	public static java.util.Date getJavaDate(ResultSet rs,String strDateFieldName) throws SQLException
	{
		String strDate;
		strDate = rs.getString(strDateFieldName);
		return getJavaDate(strDate);
	}
	
	/**
	 * @param strDate : 2016-07-05 15:59:01.0형식 문자열
	 *                       2016-07-05             , 처럼 날짜만 있는 형식도 처리한다.  
	 * @return java.util.Date를 리턴함
	 */
	@SuppressWarnings("deprecation")
	public static java.util.Date getJavaDate(String strDate)
	{
		if(strDate == null)
			return null;
		String[] astrField = splitString(strDate,"-:/. ",true,false);
		if(astrField.length < 3)
			return null;
		
		int nY,nM,nD;
		nY = Integer.parseInt(astrField[0]) - 1900;
		nM = Integer.parseInt(astrField[1]) - 1;
		nD = Integer.parseInt(astrField[2]);

		int nH,nMin,nS;
		nH = 0; 
		nMin = 0;
		nS = 0;
		if(astrField.length >= 6)
		{
			nH = Integer.parseInt(astrField[3]);
			nMin = Integer.parseInt(astrField[4]);
			nS = Integer.parseInt(astrField[5]);
		}
		//int nSS = 0;
		//if(astrField.length >= 7)
		//{
		//	nSS = Integer.parseInt(astrField[6]);
		//}
		return new java.util.Date(nY,nM,nD,nH,nMin,nS);
	}
	
	/**
	 * @param strDate : 20160705155901 형식 문자열
	 *                       20160705             , 처럼 날짜만 있는 형식도 처리한다.  
	 * @return java.util.Date를 리턴함
	 */
	@SuppressWarnings("deprecation")
	public static java.util.Date getJavaDate02(String strDate)
	{
		if(strDate == null)
			return null;
		
		int nY = 0;
		int nM = 0;
		int nD = 1;
		if(strDate.length() >= 4) 
			nY = Integer.parseInt(strDate.substring(0, 4)) - 1900;
		if(strDate.length() >= 6) 
			nM = Integer.parseInt(strDate.substring(4, 6)) - 1;
		if(strDate.length() >= 8)
			nD = Integer.parseInt(strDate.substring(6, 8));

		int nH,nMin,nS;
		nH = 0; 
		nMin = 0;
		nS = 0;
		if(strDate.length() >= 10)
			nH = Integer.parseInt(strDate.substring(8, 10));
		if(strDate.length() >= 12)
			nMin = Integer.parseInt(strDate.substring(10, 12));
		if(strDate.length() >= 14)
			nS = Integer.parseInt(strDate.substring(12, 14));

		return new java.util.Date(nY,nM,nD,nH,nMin,nS);
	}
	
	/**
	 * java.util.Date date 를 받아서 strFormat 형식(ex: yyyy-MM-dd HH:mm:ss ) 문자열로 리턴
	 * @param date
	 * @param strFormat
	 * @return  format 형식 문자열
	 */
	public static String getStrDate(java.util.Date date,String strFormat)
	{
		if(date == null)
			return null;
		SimpleDateFormat sf = new SimpleDateFormat(strFormat);
		return sf.format(date);
	}
	/**
	 * java.util.Date date 를 받아서 strFormat 형식(ex: yyyy-MM-dd HH:mm:ss ) 문자열로 리턴
	 * @param date
	 * @param strFormat
	 * @param strDefault   : date == null 경우 리턴 문자열
	 * @return  format 형식 문자열
	 */
	public static String getStrDate(java.util.Date date,String strFormat,String strDefault)
	{
		if(date == null)
			return strDefault;
		SimpleDateFormat sf = new SimpleDateFormat(strFormat);
		return sf.format(date);
	}

	/**
	 * (java.util.Date date 를 받아서
	 *   oracle:  to_date('2016-01-01 25:20:30','yyyy-MM-dd HH24:mm:ss') 
	 *   mssql: convert(DATETIME,'2016-01-01 25:20:30');  
	 * 형식의 DB 저장용 형식으로 리턴한다.
	 * @param date
	 * @param strDBType : oracle, mssql
	 * @return
	 */
	public static String getSqlDate(java.util.Date date,String strDBType)
	{
		if(date == null)
			return "null";
		String strDate = EtcUtils.getStrDate(date,"yyyy-MM-dd HH:mm:ss");
		String strSqlDate = "";
		if(strDBType.equals("oracle"))
			strSqlDate = "to_date('" + strDate + "','yyyy-MM-dd HH24:mi:ss')";
		else if(strDBType.equals("mssql"))
			strSqlDate = "convert(DATETIME,'" + strDate + "')";
		else
			strSqlDate = "'" + strDate + "'";
		return strSqlDate;
	}
	

	/**
	 * java.util.Date date 에 일 단위로 시간 값을 더한다.
	 * @param date
	 * @param nDay
	 * @param bClearHHmmss  : 시분초 값을 0으로 할 지 여부 (다음날 시작을 찾는 방식에서 유용함)
	 * @return
	 */
	public static java.util.Date addDateDay(java.util.Date date,int nDay,boolean bClearHHmmss)
	{
		if(date == null)
			return null;
		Calendar calTest = Calendar.getInstance();
		calTest.setTime(date);
		calTest.add(Calendar.DATE, nDay);
		if(bClearHHmmss)
		{
			calTest.set(Calendar.HOUR,0);
			calTest.set(Calendar.MINUTE,0);
			calTest.set(Calendar.SECOND,0);
		}
		return calTest.getTime();
	}

	/**
	 * 
	 * @param date
	 * @param nMonth
	 * @param bClearHHmmss  : 시분초 값을 0으로 할 지 여부 
	 * @return
	 */
	public static java.util.Date addDateMonth(java.util.Date date,int nMonth,boolean bClearHHmmss)
	{
		if(date == null)
			return null;
		Calendar calTest = Calendar.getInstance();
		calTest.setTime(date);
		calTest.add(Calendar.MONTH, nMonth);
		if(bClearHHmmss)
		{
			calTest.set(Calendar.HOUR,0);
			calTest.set(Calendar.MINUTE,0);
			calTest.set(Calendar.SECOND,0);
		}
		return calTest.getTime();
	}	
	/**
	 * 문자열이 null인 경우 ""를 리턴해줌
	 * @param strData
	 * @return
	 */
	public static String NullS(String strData)
	{
		if(strData == null)
			return "";
		return strData.trim();
	}
	/**
	 * 문자열이 null인 경우 strNull를 리턴해줌
	 * @param strData
	 * @param strNull  :  strData가 null 일경우 리턴할 문자열
	 * @return
	 */
	public static String NullS(String strData,String strNull)
	{
		if(strData == null)
			return strNull;
		return strData.trim();
	}
	
	/**
	 * 문자열이 null인 경우 strNull를 리턴해줌
	 * @param strData
	 * @param nMaxLen : strData가 nMaxLen 보다 크면, 짜른다
	 * @param strNull  :  strData가 null 일경우 리턴할 문자열
	 * @return
	 */
	public static String CheckS(String strData,int nMaxLen,String strNull)
	{
		if(strData == null)
			return strNull;
		strData = strData.trim();
		if(strData.length() > nMaxLen)
			strData =  strData.substring(0,nMaxLen);
		return strData;
	}
	/**
	 * 문자열이 null인 경우 ""를 리턴 함
	 * 문장열내에 HTML을 망가트릴 문자 (<>'" 등이 있으면 인코딩해서 리턴함) 
	 * @param strData
	 * @return
	 */
	public static String NullH(String strText)
	{
		if(strText == null)
			return "";

		boolean bFound = false;
		if(strText.indexOf('&') >= 0 || strText.indexOf('<')  >= 0 
				|| strText.indexOf('>')  >= 0 || strText.indexOf("'")  >= 0 || strText.indexOf("\"")  >= 0 )
		{
			bFound = true;
		}
		if(!bFound)
			return strText;

	    StringBuffer strbText = new StringBuffer();
	    strbText.append(strText);
	    EtcUtils.replaceTokenAll(strbText,"&","&amp;",false,0);
	    EtcUtils.replaceTokenAll(strbText,">","&gt;",false,0);
	    EtcUtils.replaceTokenAll(strbText,"<","&lt;",false,0);
	    EtcUtils.replaceTokenAll(strbText,"'","&apos;",false,0);
	    EtcUtils.replaceTokenAll(strbText,"\"","&quot;",false,0);
		return strbText.toString();
	}

	/**
	 * JSON 문자열 1차원 배열을 String[]형으로 바꿔서 만듦
	 * @param jaItem
	 * @return
	 */
	public static String[] fromJSONArrayString(JSONArray jaItem)
	{
		String[]  aryItem = new String[jaItem.size()];
		for(int i = 0; i  < jaItem.size(); i ++)
		{
			aryItem[i] = (String)jaItem.get(i);
		}
		return aryItem;
	}
	
	/**
	 * JSONObject 필드에 값이 없는 것이 있는지 검사한다.
	 *  
	 * @param joChk
	 * @param aryNames  : 필드명 배열
	 * @return   :  false : 하나 이상  값이 NULL or Empty 이다.
	 *                   true : 모두 정상 값을 갖고 있다.
	 */
	public static boolean  checkJSONFieldEmpty(JSONObject  joChk,String[] aryNames)
	{
		String strTemp = null;
		for(String strName : aryNames)
		{
			strTemp = (String)joChk.get(strName);
			if(strTemp.isEmpty())
				return false;
		}
		return true;
	}

	/**
	 * . 선행 스페이스 제거
	 * . 숫자가 아닌 후행 문자들 제거
	 * . 0x선행시 16진수로 인식
	 * . 변환에 실패시 기본값으로 설정
	 * @param strInt
	 * @param nDefault  : 실패시 기본값 
	 * @return
	 */
	public static int parserInt(String strInt,int nDefault)
	{
		if(strInt == null)
			return nDefault;
		
		strInt = strInt.trim();
		int nStart = 0;
		int nEnd = -1;
		int nBase = 10;
		
		if(strInt.startsWith("0x") || strInt.startsWith("0X"))
		{
			nStart = 2;
			nBase = 16;
		}

		for(int i = nStart; i < strInt.length(); i++)
		{
			if(!Character.isDigit(strInt.charAt(i)))
				break;
			nEnd = i;
		}
		
		if(nEnd < nStart)
			return nDefault;
		try
		{
			return Integer.parseInt(strInt.substring(nStart, nEnd+1),nBase);
		}
		catch(NumberFormatException e)
		{
			;
		}
		return nDefault;
	}
	
	//==============================
	// 파일명 관련
	/**
	 * Path를 포함한 화일명에서 Path만을 리턴한다.
	 * @param strOrgFile
	 * @return
	 */
	static public String getFilepath(String strOrgFile)
	{
		int nDotPos = strOrgFile.lastIndexOf('.');
		int nSepPos = strOrgFile.lastIndexOf(File.separatorChar);
        if(nSepPos < 0)
            return "";
		if(nDotPos < 0 || nSepPos > nDotPos)
		{
			return strOrgFile;
		}
		return strOrgFile.substring(0,nSepPos);
	}
	/**
	 * Path를 포함한 화일명에서 filename.ext만을 리턴한다.
	 * @param strOrgFile
	 * @return
	 */
	static public String getFilename(String strOrgFile)
	{
		int nSepPos = strOrgFile.lastIndexOf(File.separatorChar);
		if(nSepPos >= 0)
		{
				return strOrgFile.substring(nSepPos+1,strOrgFile.length());
		}
		return strOrgFile;
	}
	/**
	 * Path를 포함한 화일명에서 filename만을 리턴한다.
	 *  Path와 확장자를 뺀 순수 파일명만을 리턴한다.
	 * @param strOrgFile
	 * @return
	 */
	static public String getFilenameOnly(String strOrgFile)
	{
		int nDotPos = strOrgFile.lastIndexOf('.');	
		int nSepPos = strOrgFile.lastIndexOf(File.separatorChar);
		if(nDotPos < 0 || nSepPos > nDotPos)
		{
			return strOrgFile.substring(nSepPos+1,strOrgFile.length());
		}
		else
		{
			return strOrgFile.substring(nSepPos+1,nDotPos);
		}
	}
	/**
	 * Path를 포함한 화일명에서 ext만을 리턴한다.
	 * @param strOrgFile
	 * @return
	 */
	static public String getFileExt(String strOrgFile)
	{
		int nDotPos = strOrgFile.lastIndexOf('.');
		int nSepPos = strOrgFile.lastIndexOf(File.separatorChar);
		if(nDotPos < 0 || nSepPos > nDotPos)
		{
			return "";
		}
		return strOrgFile.substring(nDotPos+1,strOrgFile.length());
	}	
	
	/**
	 * 이파일이 존재한다면 중복되지 않는 파일명을 리턴한다.
	 * @param strOrgFile
	 * @return
	 */
	static public String getUniqFilename(String strOrgFile)
	{
		File fileContent = new File(strOrgFile);
		if(!fileContent.exists())
			return strOrgFile;

		String strNewPureFilename = null;
		int i = 1;
		String strPurePath = 	getFilepath(strOrgFile);
		String strPureFilename = 	getFilenameOnly(strOrgFile);	
		String strFileExt = 	getFileExt(strOrgFile);	

		strNewPureFilename = String.format("%s(%d)", strPureFilename,i++);	
		String strNewFilename = 	strPurePath + File.separator + strNewPureFilename + "." + strFileExt;
		fileContent = new File(strNewFilename);
		while(fileContent.exists())
		{
			strNewPureFilename = String.format("%s(%d)", strPureFilename,i++);	
			strNewFilename = 	strPurePath + File.separator + strNewPureFilename + "." + strFileExt;
			fileContent = new File(strNewFilename);
		}
		return strNewFilename;
	}
	/**
	 * 파일을 읽어서 byte[]배열로 리턴한다.
	 * 
	 * @param path
	 * @return
	 */
	public static byte[] readFile(String strFilename)
	{
		File filePath = new File(strFilename);
		FileInputStream inputStream;
		byte[] bytRet = null;
		try
		{
			inputStream = new FileInputStream(filePath);
			bytRet =  readFile(inputStream);
			inputStream.close();
		}
		catch (FileNotFoundException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bytRet;
	}
	
	/**
	 * 파일을 읽어서 byte[]배열로 리턴한다.
	 * 
	 * @param path
	 * @return
	 */
	public static byte[] readFile(InputStream isFile)
	{
		ByteArrayOutputStream bytearray = new ByteArrayOutputStream();
		try
		{
			byte[] body = new byte[1024];
			int i = 0;
			while ((i = isFile.read(body)) > 0)
			{
				bytearray.write(body, 0, i);
			}
			bytearray.flush();

		}
		catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		byte[] rtn = bytearray.toByteArray();

		if (rtn.length > 3)
		{
			if ((byte) rtn[0] == (byte) 0xef && (byte) rtn[1] == (byte) 0xbb && (byte) rtn[2] == (byte) 0xbf)
			{
				bytearray.reset();
				// utf-8
				bytearray.write(rtn, 3, rtn.length - 3);
			}
		}
		return bytearray.toByteArray();
	}
	
	/**
	 * 웹페이지 응답으로 데이타(이미지)를 전송할 목적으로 만들었다.
	 * 주의 할 것은 이 함수를 *.jsp페이지에서 호출하기전에
	 *  out.clear(); 하고 호출하기 바람, 그렇게 하지 않으면, exception 발생할 꺼임.. ( 되긴 되지만...) 
	 * @param response
	 * @param imgContentsArray
	 */
	 static public void sendResponseData( HttpServletResponse response , byte[] imgContentsArray ) 
	 {       
	     ServletOutputStream  svrOut = null ;   BufferedOutputStream outStream = null ;
	      try
	      {                  
	          svrOut = response.getOutputStream(); 
	          outStream =  new BufferedOutputStream( svrOut );                   
	          outStream.write(  imgContentsArray, 0, imgContentsArray.length );     
	          outStream.flush();                      
	      } 
	      catch( Exception writeException ) 
	      {
	          writeException.printStackTrace();
	      }
	      finally 
	      {
	           try 
	           {            
	              if ( outStream != null ) 
	             	 outStream.close(); 
	           } 
	           catch( Exception closeException ) 
	           {
	             closeException.printStackTrace();
	           }   
	        }
	   }
	/**
	 * bAns boolean 값을 "예","아니오"로 리턴한다.
	 * @param bAns
	 * @return
	 */
	static public String getYesNo(boolean bAns)
	{
		return bAns?"예":"아니요";
	}
	/**
	 * strAns  값이 "예","true","TRUE" 는  true 로 리턴한다.
	 *                 "아니오"," false","FALSE"  false 로 리턴한다.
	 *                 위 경우 외는 false 리턴 
	 * @param bAns
	 * @return
	 */
	static public boolean getBool(String strAns)
	{
		if(strAns == null)
			return false;
		if(strAns.equalsIgnoreCase("true"))
			return true;
		if(strAns.equalsIgnoreCase("false"))
			return false;
		
		if(strAns.equalsIgnoreCase("예"))
			return true;
		if(strAns.equalsIgnoreCase("아니오"))
			return false;
		
		return false;
	}
	/**
	 * strDelim에 들어있는 문자들을 각각의 델리미터로 인정하고 문자열을 분리한다.
	 * 
	 * @param strMsg	: 분리할 문자열
	 * @param strDelim  : 델리미터 문자열 
	 * @param btrimToken : 분리된 토큰을 trim할 지 여부, (델미미터는 trim하지 않는다)
	 * @param bIncludeDelim : 리턴하는 토클 배열에 델리미터를 포한 시킬 것인가?
	 * @return
	 */
	public static String[] splitString(String strMsg, String strDelim, boolean btrimToken, boolean bIncludeDelim)
	{
		StringTokenizer tokMsg = new StringTokenizer(strMsg.trim(), strDelim, true);
		ArrayList<String> aStr = new ArrayList<String>();
		String strTok;
		boolean bPreTokIsDelim = true;
		while (tokMsg.hasMoreTokens())
		{
			strTok = tokMsg.nextToken();
			if (strDelim.indexOf(strTok) >= 0)
			{
				if (bPreTokIsDelim) aStr.add("");
				if (bIncludeDelim) aStr.add(strTok);
				bPreTokIsDelim = true;
			}
			else
			{
				if (btrimToken) aStr.add(strTok.trim());
				else aStr.add(strTok);
				bPreTokIsDelim = false;
			}
		}
		if (bPreTokIsDelim) aStr.add("");
		String[] aTokens = new String[aStr.size()];
		aTokens = aStr.toArray(aTokens);
		return aTokens;
	}
	
	/**
	 * 
	 * @param strUrl
	 * @param bytContent
	 * @param strContentType : null or type , 
	 *               ex) "text/html; charset=utf-8", "text/xml", "text/json","application/json" , "image/jpeg"
	 *                      "application/x-www-form-urlencoded" 
	 * @return
	 */
	public static byte[] requestPost(String strUrl,String strContent,String strContentType)
	{
		// -------------------
		byte[] bytReturn = null;
		HttpClient client = new HttpClient();
		PostMethod method = new PostMethod(strUrl);
		if(strContentType != null)
		{
			if(!strContentType.isEmpty())
				method.setRequestHeader("Content-type", strContentType);
		}
		
		method.setRequestBody(strContent);

		try
		{
			System.out.println(strContent);
			int statusCode = client.executeMethod(method); // url에 지정한 사이트에 접속함

			if (statusCode == HttpStatus.SC_OK)
			{
				bytReturn = method.getResponseBody();
			}
			else
			{
				System.out.println("(IPHONE) Push FAIL(" + statusCode + ")");
			}
		}
		catch (HttpException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		catch (IOException e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally
		{
			if (method != null)
				method.releaseConnection();
		}
		return bytReturn;
	}

}
