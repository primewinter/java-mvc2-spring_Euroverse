package com.ksy.service.order;

import java.util.List;

import com.ksy.common.Search;
import com.ksy.service.domain.Order;
import com.ksy.service.domain.Point;


public interface OrderDao {


		public void addFlightOrder(Order order) throws Exception;
		
		public void addRoomOrder(Order order) throws Exception;
		
		public void addPoint(Point point) throws Exception;
		
		public List<Point> pointList(String orderId) throws Exception;
		
		public Order getFlightOrder(String flightId) throws Exception;
		
		public Order getRoomOrder(String orderId) throws Exception;
		
		public List<Order> getOrderList(Search search, String buyerId) throws Exception;
		
		public List<Order> getOrderRefund(Order order) throws Exception;
		
		public int getTotalCount(Search search) throws Exception ;
		
		//public String makeCurrentPageSql(String sql, Search search) ;

}
