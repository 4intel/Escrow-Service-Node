package fouri.com.common.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LogUtil {

	static public void e(Logger logger,Exception e,String strMsg)
	{
		StringWriter stringWriter = new StringWriter();
		PrintWriter printWriter = new PrintWriter(stringWriter);
		e.printStackTrace(printWriter);
		try 
		{
			printWriter.close();
			stringWriter.close();
		} 
		catch (IOException e1) 
		{
		}
		
		logger.log(Level.SEVERE, e.getClass() + ": " +  ((strMsg == null) ? "" : strMsg + ":") + e.getMessage() + ": " + e.getCause() + "\n" +  stringWriter.toString());
	}
	static public void w(Logger logger,String strMsg)
	{
		logger.warning(strMsg);
	}
	
	static public void d(Logger logger, String strMsg)
	{
		logger.log( Level.FINE, strMsg);
	}
	
	static public void t(Logger logger, String strMsg)
	{
		logger.log(Level.FINER,strMsg);
	}
	
	public static void l(Logger logger, Level level, String msg, boolean withStackTrace) {
	    String finalMsg = msg;
	    if (withStackTrace) {
	        logger.log(level, finalMsg, new Throwable());
	    } else {
	        logger.log(level, finalMsg);
	    }
	}
	
	//------------------------------------
	public static void enableLogging( Object cls) {
	    Logger logger = Logger.getLogger(cls.getClass().getName());
	    logger.setLevel(Level.ALL);
	    for (Handler h : logger.getParent().getHandlers()) {
	        h.setLevel(Level.ALL);
	   }
	}
}
