package com.ksy.service.order.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.common.Search;
import com.ksy.service.domain.Order;
import com.ksy.service.domain.Point;
import com.ksy.service.order.OrderDao;

@Repository("orderDaoImpl")
public class OrderDaoImpl implements OrderDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public OrderDaoImpl() {
		System.out.println(this.getClass());
	}
	public void addFlightOrder(Order order) throws Exception{
		sqlSession.insert("OrderMapper.addFlightOrder", order);
	}
	public void addRoomOrder(Order order) throws Exception {
		sqlSession.insert("OrderMapper.addRoomOrder", order);
	}
	public void addPoint(Point point) throws Exception{
		sqlSession.insert("UserMapper.addPoint", point);
	}
	public List<Point> pointList (String orderId) throws Exception{
		return sqlSession.selectList("UserMapper.pointList", orderId);
	}
	public Order getFlightOrder(String flightId) throws Exception{
		return sqlSession.selectOne("OrderMapper.getFlightOrder", flightId);
	}
	public Order getRoomOrder(String orderId) throws Exception{
		return sqlSession.selectOne("OrderMapper.getRoomOrder", orderId);
	}
		
	public List<Order> getOrderList(Search search ,String buyerId ) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId",buyerId);
		return sqlSession.selectList("OrderMapper.getOrderList", map);
	}
	
	public List<Order> getOrderRefund(Order order)throws Exception{
		System.out.println("1");
		if (order.getOrderStatus() == "C") {
			System.out.println("2");
			return sqlSession.selectOne("OrderMapper.refundStatus" , order);
		} else {
			return sqlSession.selectOne("OrderMapper.updateStatus" , order);
		}
	}

	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("OrderMapper.getTotalCount", search);

	}
	
//	public String makeCurrentPageSql(String sql, Search search) {
//		return sqlSession.selectOne(sql, search);
//	}


}
