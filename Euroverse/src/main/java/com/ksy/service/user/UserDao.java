package com.ksy.service.user;

import java.util.List;

import com.ksy.service.domain.Plan;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.domain.User;

public interface UserDao {
	
	public void addUser(User user) throws Exception;
	
	public void updateUser(User user) throws Exception;
	public void updatePwd(User user)throws Exception;
	public void updateRole(String userId)throws Exception;
	public void unRegister(String userId)throws Exception;
	public void comeBackUser(User user)throws Exception;
	
	
	
	public User getUser(String userId) throws Exception ;
	
	public String checkNickname(String nickname)throws Exception;
	
	public String checkUserId(String userId)throws Exception;
	
	public List<String> getUserIdList(User user) throws Exception;
	
	
	public String findUserId(String userId) throws Exception;
	
}
