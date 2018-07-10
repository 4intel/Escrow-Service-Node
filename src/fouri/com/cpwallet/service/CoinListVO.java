package fouri.com.cpwallet.service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import fouri.com.cpwallet.web.CPWalletUtil;

@SuppressWarnings("serial")
public class CoinListVO implements Serializable {

	private static List<HashMap> coinList = new ArrayList<HashMap>();

	public static List<HashMap> getCoinList() {
		return (ArrayList<HashMap>)coinList;
	}

	public static void setCoinList(List<HashMap> clist) {
		coinList = clist;
	}

	public static HashMap getCoinInfo(int coinNo) {
		HashMap rmap = null;
		for(int i=0; i<coinList.size(); i++) {
			rmap = coinList.get(i);
			if( Integer.parseInt(((String)rmap.get("cid")).replaceAll("COIN_",""))  == coinNo) {
				return rmap;
			}
		}
		return null;
	}
	public static String getCoinCou(int coinNo) {
		HashMap rmap = null;
		for(int i=0; i<coinList.size(); i++) {
			rmap = coinList.get(i);
			if( Integer.parseInt(((String)rmap.get("cid")).replaceAll("COIN_",""))  == coinNo) {
				return (String)rmap.get("cou");
			}
		}
		return null;
	}
	
	// reload coin list
	public static List<HashMap> reloadCoinList() {
		// [{"ver":10000,"cid":"COIN_00000100","nm":"BASE COIN","st":65539,"cou":"kPX","cau":"PX","cpc":1000,"exr":1,"mit":5,"mxt":0,"mnt":10000,"dtb":1483228800,"dte":32503593600,"frt":0,"fmx":0,"ffx":0,"fwd":"","amt":1000000000000000,"mno":""},
		// {"ver":10000,"cid":"COIN_00000200","nm":"sub coin","st":3,"cou":"CON","cau":"CUN","cpc":1000,"exr":1,"mit":20,"mxt":0,"mnt":10000,"dtb":1483228800,"dte":32503593600,"frt":0,"fmx":0,"ffx":0,"fwd":"","amt":1000000000000000,"mno":"memo"}]
		String strPID = "P001";
		
		JSONObject joCoinList = null;
		joCoinList = CPWalletUtil.getCoinHistory("queryCoin",strPID);
		
		String strCoinValue = "";
		if(joCoinList!=null) {
			strCoinValue = (String)joCoinList.getOrDefault("value","{}");	
		}
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
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		coinList = coins;
		
		return coins;
	}
}
