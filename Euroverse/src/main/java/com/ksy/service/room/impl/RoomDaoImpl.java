package com.ksy.service.room.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Room;
import com.ksy.service.room.RoomDao;

@Repository("roomDaoImpl")
public class RoomDaoImpl implements RoomDao{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public RoomDaoImpl() {
		System.out.println(this.getClass());
	}
	public void addRoom(Room room) throws Exception{
		sqlSession.insert("RoomMapper.addRoom", room);
	}
	
	public Room getRoom(String roomId) throws Exception{
		return sqlSession.selectOne("RoomMapper.getRoom", roomId);
	}
	public List<Room> getRoomList(Search search ,String buyerId ) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId",buyerId);
		return sqlSession.selectList("RoomMapper.getRoomList", map);
	}
	
	public List<Room> getRoomListAdmin(Search search) throws Exception {
		return sqlSession.selectList("RoomMapper.getRoomListAdmin", search );
	}

	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("OrderMapper.getTotalCount", search);

	}
	
//	public String makeCurrentPageSql(String sql, Search search) {
//		return sqlSession.selectOne(sql, search);
//	}


}
