package com.ksy.service.order;

import java.util.List;
import java.util.Map;

import com.ksy.common.Search;
import com.ksy.service.domain.Order;
import com.ksy.service.domain.Point;


public interface OrderService {
	
	public void addFlightOrder(Order order) throws Exception;
	
	public void addRoomOrder(Order order) throws Exception;
	
	public void addPoint(Point point) throws Exception;
	
	public List<Point> pointList(String orderId) throws Exception;
	
	public Order getFlightOrder(String flightId) throws Exception;
	
	public Order getRoomOrder(String orderId) throws Exception;
	
	public Map<String,Object> getOrderList(Search search,String buyerId) throws Exception;
	
	public Map<String, Object> getOrderRefund(Order order) throws Exception; 
	
}