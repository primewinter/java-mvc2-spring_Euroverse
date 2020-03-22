package com.ksy.service.domain;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class LoginUser {
	
	private String userId;
	private String sessionId;
	private Timestamp loginDate;
	
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSessionId() {
		return sessionId;
	}
	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	public Timestamp getLoginDate() {
		return loginDate;
	}
	public void setLoginDate(Timestamp loginDate) {
		this.loginDate = loginDate;
	}
	
	
	
	
	@Override
	public String toString() {
		return "LoginUser [userId=" + userId + ", sessionId=" + sessionId + ", loginDate=" + loginDate + "]";
	}
	
	
	
	
	
	
	

}
