package fouri.com.cmm.context;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import fouri.com.cmm.service.FouriProperties;

public class FouriWebServletContextListener implements ServletContextListener {
    private static final Logger LOGGER = LoggerFactory.getLogger(FouriWebServletContextListener.class);
    
    public FouriWebServletContextListener(){
    	setProfileSetting();
    }

    public void contextInitialized(ServletContextEvent event){
    	if(System.getProperty("spring.profiles.active") == null){
    		setProfileSetting();
    	}
    }

    public void contextDestroyed(ServletContextEvent event) {
    	System.setProperty("spring.profiles.active", null);
    } 
    
    public void setProfileSetting(){
        try {
            LOGGER.debug("===========================Start ServletContextLoad START ===========");
            System.setProperty("spring.profiles.active", FouriProperties.getProperty("Globals.DbType")+","+FouriProperties.getProperty("Globals.Auth"));
            LOGGER.debug("Setting spring.profiles.active>"+System.getProperty("spring.profiles.active"));
            LOGGER.debug("===========================END   ServletContextLoad END ===========");
        } catch(IllegalArgumentException e) {
    		LOGGER.error("[IllegalArgumentException] Try/Catch...usingParameters Runing : "+ e.getMessage());
        } catch (Exception e) {
        	LOGGER.error("[" + e.getClass() +"] search fail : " + e.getMessage());
        }
    }
}
