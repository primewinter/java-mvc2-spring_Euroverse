package com.ksy.service.room;

import java.util.Map;

import com.ksy.common.Search;
import com.ksy.service.domain.Room;


public interface RoomService {
	
	public void addRoom(Room room) throws Exception;
	
	public Room getRoom(String roomId) throws Exception;
	
	public Map<String,Object> getRoomList(Search search,String buyerId) throws Exception;
	
	public Map<String,Object> getRoomListAdmin(Search search) throws Exception;

}