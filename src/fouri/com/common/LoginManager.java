package fouri.com.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class LoginManager implements HttpSessionBindingListener {
	private static LoginManager loginManager = null;
	
	private static List<HashMap> loginUsers = new ArrayList<HashMap>();
	
	private LoginManager() {
		super();
	}
	
	public static synchronized LoginManager getInstance() {
		if(loginManager==null) {
			loginManager = new LoginManager();
		}
		return loginManager;
	}
	
	// 로그인 체크
	public boolean isValid(HttpSession session, String userId, String userPw) {
		setSession(session, userId);
		return true;
	}
	
	// 로그인 여부 체크
	// 로그인 했을경우 true, 로그인 안한경우 false
	public boolean isLogin(String sessionId) {
		boolean isLogin = false;
		
		for(int i=0; i<loginUsers.size(); i++) {
			HashMap map = loginUsers.get(i);
			if(((String)map.get("user_id")).equals(sessionId)) {
				isLogin = true;					
			}
		}
		return isLogin;
	}
	
	// 해시테이블에 id 저장
	public void setSession(HttpSession session, String userId) {
		HashMap lm = new HashMap<String,String>();
		lm.put("user_id", userId);
		lm.put("session_id", session.getId());
		loginUsers.add(lm);
		session.setMaxInactiveInterval(20);
		session.setAttribute("user_id", userId);
		session.setAttribute("login", this.getInstance());

		System.out.println("--------------------------------------");
		for(int i=0; i<loginUsers.size(); i++) {
			HashMap map = loginUsers.get(i);
			System.out.println("key : " + map.get("user_id") +" , "+map.get("session_id"));
		}
		System.out.println("--------------------------------------");
	}
	
	// 세션이 성립됬을때
	public void valueBound(HttpSessionBindingEvent event) {
		;
	}
	
	// 세션이 끊겼을때
	public void valueUnbound(HttpSessionBindingEvent event) {
		List<HashMap> loginUsers2 = new ArrayList<HashMap>();
		for(int i=0; i<loginUsers.size(); i++) {
			HashMap map = loginUsers.get(i);
			if(!((String)map.get("session_id")).equals(event.getSession().getId())) {
				loginUsers2.add(map);
			} else {
				System.out.println("제거~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"+(String)map.get("user_id"));	
			}
		}
		loginUsers = loginUsers2;
	}
	
	// 세션 ID로 현재 로그인한 ID를 구분해 냄
	//public String getUserId(String sessionId) {
	//	return (String)loginUsers.get(sessionId);
	//}
	
	// 현재 접속자수
	public int getUserCount() {
		return loginUsers.size();
	}
}
