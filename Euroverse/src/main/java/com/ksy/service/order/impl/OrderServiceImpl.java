package com.ksy.service.order.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.common.Search;
import com.ksy.service.domain.Order;
import com.ksy.service.domain.Point;
import com.ksy.service.order.OrderDao;
import com.ksy.service.order.OrderService;

@Service("orderServiceImpl")
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	@Qualifier("orderDaoImpl")
	private OrderDao orderDao;
	
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	public OrderServiceImpl() {
		System.out.println(this.getClass());
	}
	public void addFlightOrder(Order order) throws Exception{
		orderDao.addFlightOrder(order);
	}
	
	public void addRoomOrder(Order order) throws Exception {
		orderDao.addRoomOrder(order);
	}
	public void addPoint(Point point) throws Exception {
		orderDao.addPoint(point);
	}
	public List<Point> pointList(String orderId) throws Exception{
		return  orderDao.pointList(orderId);
	}
	public Order getFlightOrder (String flightId) throws Exception {
		return orderDao.getFlightOrder(flightId);
	}
	public Order getRoomOrder (String orderId) throws Exception {
		return orderDao.getRoomOrder(orderId);
	}
	public Map<String, Object> getOrderRefund(Order order) throws Exception{
		List<Order> list= (List<Order>) orderDao.getOrderRefund(order);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list);
		System.out.println(map);
		return map;
	}
	
	public Map<String,Object> getOrderList(Search search,String buyerId) throws Exception {
		
		List<Order> list= (List<Order>) orderDao.getOrderList(search, buyerId);
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = orderDao.getTotalCount(search);
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		System.out.println(map);
		return map;
	}

}