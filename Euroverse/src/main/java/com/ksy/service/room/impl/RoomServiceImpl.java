package com.ksy.service.room.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Room;
import com.ksy.service.room.RoomDao;
import com.ksy.service.room.RoomService;

@Service("roomServiceImpl")
public class RoomServiceImpl implements RoomService{
	
	@Autowired
	@Qualifier("roomDaoImpl")
	private RoomDao roomDao;
	
	public void setRoomDao(RoomDao roomDao) {
		this.roomDao = roomDao;
	}
	public RoomServiceImpl() {
		System.out.println(this.getClass());
	}
	public void addRoom(Room room) throws Exception{
		roomDao.addRoom(room);
	}
	
	public Room getRoom (String roomId) throws Exception {
		return roomDao.getRoom(roomId);
	}
	public Map<String,Object> getRoomList (Search search , String buyerId ) throws Exception {
		List<Room> list= (List<Room>) roomDao.getRoomList(search, buyerId);
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = roomDao.getTotalCount(search);
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		System.out.println(map);
		return map;
	}
	
	public Map<String,Object> getRoomListAdmin(Search search) throws Exception {
		List<Room> list= (List<Room>) roomDao.getRoomListAdmin(search);
		int totalCount = roomDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

}