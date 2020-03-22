package com.ksy.service.user.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.service.domain.Plan;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.domain.User;
import com.ksy.service.user.UserDao;

@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public UserDaoImpl() {
		super();
	}
	
	public void comeBackUser(User user)throws Exception{
		System.out.println("UserDaoImpl comeBackUser");
		sqlSession.update("UserMapper.comeBackUser",user);
	}

	@Override
	public void addUser(User user) throws Exception {
		System.out.println("UserDaoImpl addUser");
		sqlSession.insert("UserMapper.addUser",user);
	}

	@Override
	public void updateUser(User user) throws Exception {
		System.out.println("UserDaoImpl updateUser");
		sqlSession.update("UserMapper.updateUser",user);
	}

	@Override
	public void updatePwd(User user) throws Exception {
		System.out.println("UserDaoImpl updatePwd");
		sqlSession.update("UserMapper.updatePwd",user);
	}

	@Override
	public void updateRole(String userId) throws Exception {
		System.out.println("UserDaoImpl updateRole");
		sqlSession.update("UserMapper.updateRole",userId);
	}

	@Override
	public void unRegister(String userId) throws Exception {
		System.out.println("UserDaoImpl unRegister");
		sqlSession.update("UserMapper.unRegister",userId);
	}

	@Override
	public User getUser(String userId) throws Exception {
		System.out.println("UserDaoImpl getUser");
		return sqlSession.selectOne("UserMapper.getUser", userId);
	}

	@Override
	public List<String> getUserIdList(User user) throws Exception {
		System.out.println("UserDaoImpl getUserIdList");
		return sqlSession.selectList("UserMapper.getUserId",user);
	}
	
	
	public String checkNickname(String nickname) throws Exception{
		System.out.println("UserDaoImpl checkNickname");
		return sqlSession.selectOne("UserMapper.checkNickname",nickname);
	}
	
	public String checkUserId(String userId)throws Exception{
		System.out.println("UserDaoImpl checkUserId");
		return sqlSession.selectOne("UserMapper.checkUserId",userId);
	}
	
	public String findUserId(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.findUserId", userId);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * public List<Plan> getEndPlanList(String userId)throws Exception{
	 * System.out.println("getEndPlanList Dao");
	 * 
	 * return sqlSession.selectList("UserMapper.getEndPlanList",userId); }
	 */
	
}