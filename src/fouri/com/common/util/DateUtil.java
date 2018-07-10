package fouri.com.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;

/**
 * @author
 *
 */
public class DateUtil {

	/**
	 * 해당 String형식의 날짜를 형식에 맞춰 date형으로 리턴한다.
	 * @param dateStr
	 * @param format
	 * @return
	 */
	public static Date getDate(String dateStr, String format) {
		 SimpleDateFormat sdf = new SimpleDateFormat(format);
		 Date date = null;
		 try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {
			date = null;
		}

		 return date;
	}

	/**
	 * String형 날짜로 몇일후의 날짜를 리턴.
	 * @param dateStr	yyyyMMdd
	 * @param days		+5 or -5 로 가능
	 * @param format	yyyyMMdd
	 * @return
	 */
	public static String getPlusMinusDate(String dateStr, int days, String format) {
		if( isNull(dateStr) ) {
			return "";
		}

		Calendar cal = Calendar.getInstance();
		cal.set( Integer.parseInt(dateStr.substring(0, 4)),
				Integer.parseInt(dateStr.substring(4, 6))-1,
				Integer.parseInt(dateStr.substring(6, 8)));

		return getPlusMinusDate(cal.getTime(), days, format);
	}

	/**
	 * 날짜의 몇일후의 날짜를 리턴.
	 * default format은 yyyyMMdd
	 * @param Date date
	 * @param int days	+5 or -5 로 가능
	 * @return String
	 */
	public static String getPlusMinusDate(Date date, int days) {
		return getPlusMinusDate(date, days, "yyyyMMdd");
	}

	/**
	 * 날짜의 몇일후의 날짜를 리턴.
	 * @param Date date
	 * @param int days	+5 or -5 로 가능
	 * @param String format
	 * @return String
	 */
	public static String getPlusMinusDate(Date date, int days, String pFormat) {
		String format = pFormat;
		Calendar calen = Calendar.getInstance(Locale.KOREAN);
		calen.setTime(date);
		calen.setTimeInMillis(calen.getTimeInMillis() + (60L * 60 * 24 * 1000 * days));
		if( isNull(format) ) {
			format = "yyyyMMdd";
		}

		return getDate(calen.getTime(), format);
	}

	/**
	 * 두 Date사이의 날짜 차이
	 * @param Date startDate
	 * @param Date endDate
	 * @return long
	 */
	public static long dayToDay(Date startDate, Date endDate) {
		long dayToday = 0;
		dayToday = (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24);
		return dayToday;
	}

	/**
	 * 현재 날짜를 format에 따라
	 * @param String format
	 * @return String
	 */
	public static String getDate(String format) {
		return getDate((new Date()), format);
	}

	/**
	 * 인자로 넘어온 date를 format에 따라.
	 * @param Date date
	 * @param String format
	 * @return String
	 */
	public static String getDate(Date date , String format) {

		if(date == null)return "";
		return (new SimpleDateFormat(format, Locale.KOREAN)).format(date);
	}

	/**
	 * weekday 1(일) 2(월) 3(화) 4(수) 5(목) 6(금) 0(토)
	 * 해당 년월의 일자별 요일을 가져온다.
	 * @param dateStr ex)200511
	 * @return
	 */
	public static HashMap weekDays(String dateStr) {

        HashMap map = new HashMap();
        if( isNull(dateStr) || dateStr.length() < 6) {
        	return map;
        }

        String yearStr = dateStr.substring(0, 4);
        String monthStr = dateStr.substring(4, 6);

        int year = Integer.parseInt(yearStr);
        int month = Integer.parseInt(monthStr);

        Calendar calendar = Calendar.getInstance();
        calendar.set(year, (month-1), 1);

        int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        int weekday = calendar.get(Calendar.DAY_OF_WEEK);

        for(int i = 1; i <= lastDay; i++) {
            map.put( String.valueOf(i), String.valueOf(weekday%7) );
            weekday++;
        }
        map.put("lastDay",	lastDay);

        return map;
    }

	/**
	 * 지정된 날짜가 해당 월의 몇번째 주차에 해당하는지 조회하고 그 값을 반환한다.
	 * @param sDate 날짜 (예: 20040315)
	 * @return 주차에 해당하는 값(1: 1주, 2: 2주, 3: 3주, 4:4주, 5:5주)
	 */
	public static int getWeekth(String sDate) {

		if (sDate == null || sDate.length() != 8)
			return -1;

		Calendar c = Calendar.getInstance(Locale.KOREA);
		c.set( Integer.parseInt(sDate.substring(0, 4)), Integer.parseInt(sDate.substring(4, 6)) - 1, Integer.parseInt(sDate.substring(6)) );

		GregorianCalendar gc = new GregorianCalendar(Locale.KOREA);
		gc.setTime(c.getTime());

		return c.get(Calendar.WEEK_OF_MONTH);
	}

	/**
	 * 해당 년월의 마지막 일자
	 * @param yearMonth
	 * @return
	 */
	public static int getLastDay(int year, int month) {

		Calendar calendar = Calendar.getInstance();
        calendar.set(year, (month-1), 1);

        int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        return lastDay;
	}

	/**
	 * YYYYMMDD형식의 날짜를 div 구분자로 나눠서 리턴
	 * @param dateTime	20060704
	 * @param div	-
	 * @return
	 */
    public static String getParseDateString(String dateTime, String div) {

    	if(dateTime == null || dateTime.length() < 8) return dateTime;
 		if ( dateTime != null ) {
			String year = dateTime.substring(0, 4);
			String month = dateTime.substring(4, 6);
			String day = dateTime.substring(6, 8);

			return year + div + month + div + day;
		} else {
			return "";
		}
    }
    
    public static String getParseDateString(String dateTime) {

    	if(dateTime == null || dateTime.length() < 8) return dateTime;
 		if ( dateTime != null ) {
			String year = dateTime.substring(0, 4);
			String month = dateTime.substring(4, 6);
			String day = dateTime.substring(6, 8);

			return year + "년" + month + "월" + day + "일";
		} else {
			return "";
		}
    }
    
    public static long getDayDistance(String startDate, String endDate) throws Exception {
	    return getDayDistance(startDate, endDate, null);
	}

	public static long getDayDistance(String startDate, String endDate, String pFormat) throws Exception {
		String format = pFormat;
	    if(format == null) format = "yyyyMMdd";
	    SimpleDateFormat sdf = new SimpleDateFormat(format);
	    long day2day = 0L;
	    try {
	        Date sDate = sdf.parse(startDate);
	        Date eDate = sdf.parse(endDate);
	        day2day = (eDate.getTime() - sDate.getTime()) / 0x5265c00L;
	    } catch(Exception e) {
	        throw new Exception("wrong format string");
	    }
	    return Math.abs(day2day);
	}

	// 현재 날짜 기준 날짜 계산
	public static String getFormatDate(String format, String term_gubun,int term) {
		String ret_date = "";
		Calendar cur_date = Calendar.getInstance(); // 현재 날짜
		SimpleDateFormat formatter; // 날짜 포맷

		term_gubun = term_gubun.toUpperCase();
		if ("".equals(term_gubun))
			term_gubun = "NOW";

		try {
			if (term_gubun.equals("Y") || term_gubun.equals("M")
					|| term_gubun.equals("D") || term_gubun.equals("NOW")) {
				formatter = new SimpleDateFormat(format);


				if (term_gubun.equals("Y")) {
					cur_date.add(Calendar.YEAR, term);
				} else if (term_gubun.equals("M")) {
					cur_date.add(Calendar.MONTH, term);
				} else if (term_gubun.equals("D")) {
					cur_date.add(Calendar.DAY_OF_MONTH, term);
				}

				ret_date = formatter.format(cur_date.getTime());
			}
			return ret_date.trim();
		} catch (Exception e) {
			System.out.println("[MessageUtil::getDateFormt] Error = " + e);
		}
		return "";
	}

	public static boolean isNull(String val) {
		if(val==null) return true;
		return false;
	}
}
