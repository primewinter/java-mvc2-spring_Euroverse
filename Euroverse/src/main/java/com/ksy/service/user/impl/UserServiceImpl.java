package com.ksy.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.service.domain.Plan;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.domain.User;
import com.ksy.service.user.UserDao;
import com.ksy.service.user.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	
	public UserServiceImpl() {
		super();
	}

	public void comeBackUser(User user)throws Exception{
		userDao.comeBackUser(user);
	}
	
	
	@Override
	public void addUser(User user) throws Exception {
		System.out.println(this.getClass()+"addUser");
		userDao.addUser(user);
	}


	@Override
	public void updateUser(User user) throws Exception {
		System.out.println(this.getClass()+"updateUser");
		userDao.updateUser(user);
	}


	@Override
	public void updatePwd(User user) throws Exception {
		System.out.println(this.getClass()+"updatePwd");
		userDao.updatePwd(user);
	}


	@Override
	public void updateRole(String userId) throws Exception {
		System.out.println(this.getClass()+"updateRole");
		userDao.updateRole(userId);
	}


	@Override
	public void unRegister(String userId) throws Exception {
		System.out.println(this.getClass()+"unRegister");
		userDao.unRegister(userId);
	}


	@Override
	public User getUser(String userId) throws Exception {
		System.out.println(this.getClass()+"getUser");
		return userDao.getUser(userId);
	}


	@Override
	public List<String> getUserIdList(User user) throws Exception {
		System.out.println(this.getClass()+"getUserIdList");
		return userDao.getUserIdList(user);
	}
	
	public String checkNickname(String nickname)throws Exception{
		System.out.println(this.getClass()+"checkNickname");
		return userDao.checkNickname(nickname);
	}
	
	public String checkUserId(String userId)throws Exception{
		System.out.println(this.getClass()+"checkUserId");
		return userDao.checkUserId(userId);
	}
	
	
	
	
	public String findUserId(String userId) throws Exception {
		return userDao.findUserId(userId);
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	////////////////////////////plan////////////////////////////////
	/*
	 * public List<Plan> getEndPlanList(String userId)throws Exception{
	 * System.out.println(this.getClass()+"getEndPlanList"); return
	 * userDao.getEndPlanList(userId); }
	 */
	
}
