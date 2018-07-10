package fouri.com.cmm.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.XmlWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

import fouri.com.cmm.service.FouriProperties;
import fouri.com.common.util.KeyManager;
import fouri.com.cpwallet.service.CoinListVO;
import fouri.com.cpwallet.web.CPWalletUtil;
import net.fouri.libs.bitutil.model.NetConfig;
import net.fouri.libs.bitutil.model.NetConfig.NetworkType;

public class FouriWebApplicationInitializer implements WebApplicationInitializer {

	private static final Logger LOGGER = LoggerFactory.getLogger(FouriWebApplicationInitializer.class);
	
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		LOGGER.debug("WebApplicationInitializer START-============================================");
		
		//-------------------------------------------------------------
		// ServletContextListener 설정
		//-------------------------------------------------------------
		servletContext.addListener(new fouri.com.cmm.context.FouriWebServletContextListener());
		
		//-------------------------------------------------------------
		// Spring CharacterEncodingFilter 설정
		//-------------------------------------------------------------
		FilterRegistration.Dynamic characterEncoding = servletContext.addFilter("encodingFilter", new org.springframework.web.filter.CharacterEncodingFilter());
		characterEncoding.setInitParameter("encoding", "UTF-8");
		characterEncoding.setInitParameter("forceEncoding", "true");
		characterEncoding.addMappingForUrlPatterns(null, false, "*.do");
		//characterEncoding.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "*.do");
		
		//-------------------------------------------------------------
		// Spring ServletContextListener 설정
		//-------------------------------------------------------------
		XmlWebApplicationContext rootContext = new XmlWebApplicationContext();
		rootContext.setConfigLocations(new String[] { "classpath*:fouri/spring/com/**/context-*.xml" });
		rootContext.refresh();
		rootContext.start();
		
		servletContext.addListener(new ContextLoaderListener(rootContext));
		
		//-------------------------------------------------------------
		// Spring ServletContextListener 설정
		//-------------------------------------------------------------
		XmlWebApplicationContext xmlWebApplicationContext = new XmlWebApplicationContext();
		xmlWebApplicationContext.setConfigLocation("/WEB-INF/config/fouri/springmvc/fouri-com-*.xml");
		ServletRegistration.Dynamic dispatcher = servletContext.addServlet("dispatcher", new DispatcherServlet(xmlWebApplicationContext));
		dispatcher.setLoadOnStartup(1);
		dispatcher.addMapping("*.do");
		
		//-------------------------------------------------------------
		// Spring RequestContextListener 설정
		//-------------------------------------------------------------
		servletContext.addListener(new org.springframework.web.context.request.RequestContextListener());
		
		LOGGER.debug("WebApplicationInitializer END-============================================");

		//----------------------------------
		// set default net type
		String strValue = FouriProperties.getProjectNet();
		NetworkType emType = NetworkType.TESTNET; 
		if(strValue.equalsIgnoreCase("MAINNET"))
			emType = NetworkType.MAINNET;
		else if(strValue.equals("DEBUGNET"))
			emType = NetworkType.DEBUGNET;
		NetConfig.setDefaultNet(emType);

		// Loading KeyManager
		KeyManager.reloadManagerKey();
		//----------------------------------
		// Coin List
		// [{"ver":10000,"cid":"COIN_00000100","nm":"BASE COIN","st":65539,"cou":"kPX","cau":"PX","cpc":1000,"exr":1,"mit":5,"mxt":0,"mnt":10000,"dtb":1483228800,"dte":32503593600,"frt":0,"fmx":0,"ffx":0,"fwd":"","amt":1000000000000000,"mno":""},
		// {"ver":10000,"cid":"COIN_00000200","nm":"sub coin","st":3,"cou":"CON","cau":"CUN","cpc":1000,"exr":1,"mit":20,"mxt":0,"mnt":10000,"dtb":1483228800,"dte":32503593600,"frt":0,"fmx":0,"ffx":0,"fwd":"","amt":1000000000000000,"mno":"memo"}]
		String strPID = "P001";
		
		JSONObject joCoinList = null;
		joCoinList = CPWalletUtil.getCoinHistory("queryCoin",strPID);
		
		String strCoinValue = "";
		if(joCoinList!=null) {
			strCoinValue = (String)joCoinList.getOrDefault("value","{}");	

			if(strCoinValue!=null && strCoinValue.length()>0 && !strCoinValue.equals("{}")) {

				JSONObject joValue = null;
				JSONParser jaTemp = new JSONParser();
				List<HashMap> coins = new ArrayList<HashMap>();
				try {
					JSONObject joValue2 = null;
					JSONArray questionArrary =   (JSONArray) jaTemp.parse(strCoinValue) ;
					if(questionArrary!=null) {
						for(int i=0; i<questionArrary.size(); i++) {
							joValue2 = (JSONObject)questionArrary.get(i);
							HashMap coin = new HashMap();
							coin.put("cid", joValue2.get("cid"));
							coin.put("nm", joValue2.get("nm"));
							coin.put("cou", joValue2.get("cou"));
							coins.add(coin);
						}
						CoinListVO.setCoinList(coins);
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
}
