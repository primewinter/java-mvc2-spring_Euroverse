package com.ksy.service.push.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.service.domain.Push;
import com.ksy.service.push.PushDao;


@Repository("pushDaoImpl")
public class PushDaoImpl implements PushDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PushDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addPush(Push push) throws Exception {
		if(sqlSession.selectOne("PushMapper.getPushId", push) == null) {
			System.out.println("\t\t\tinsert «“ push¿« pushType :"+push);
			sqlSession.insert("PushMapper.addPush", push);
		} else {
			sqlSession.update("PushMapper.updateCmtCount", push);
		}

	}
	@Override
	public List<Push> getPushList(Map<String, Object> map) throws Exception {
		List<Push> pushList =  sqlSession.selectList("PushMapper.getPushList", map);
		for(Push push : pushList ) {
			if(push.getPushType().equals("C")) {
				push.setTitle(sqlSession.selectOne("PushMapper.getPostTitle", push));
				push.setBoardName(sqlSession.selectOne("PushMapper.getBoardName1", push));
			} else if (push.getPushType().equals("R")) {
				push.setTitle(sqlSession.selectOne("PushMapper.getCmtContent", push));
				push.setBoardName(sqlSession.selectOne("PushMapper.getBoardName2", push));
			} else if (push.getPushType().equals("I")) {
				push.setTitle(sqlSession.selectOne("PushMapper.getPlanTitle", push));
			} else if (push.getPushType().equals("A")) {
				push.setTitle(sqlSession.selectOne("PushMapper.getAccTitle", push));
			}
			System.out.println("set Title & boardName :::: "+push);
		}
		return pushList;
	}
	@Override
	public void readPush(String userId) throws Exception {
		sqlSession.update("PushMapper.readPush", userId);
		
	}
	@Override
	public void deletePush(List<String> pushId) throws Exception {
		sqlSession.update("PushMapper.deletePush", pushId);
	}
	@Override
	public int getUnreadCount(String userId) throws Exception {
		return sqlSession.selectOne("PushMapper.getUnreadCount", userId);
	}
	
	@Override
	public int getTotalCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("PushMapper.getTotalCount", map);
	}
	
	
}
