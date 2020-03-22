package com.ksy.service.room;

import java.util.List;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Room;


public interface RoomDao {

		public void addRoom(Room room) throws Exception;
		
		public Room getRoom(String roomId) throws Exception;
		
		public List<Room> getRoomList(Search search, String buyerId) throws Exception;
		
		public List<Room> getRoomListAdmin(Search search) throws Exception ;
		
		public int getTotalCount(Search search) throws Exception ;
		
}
