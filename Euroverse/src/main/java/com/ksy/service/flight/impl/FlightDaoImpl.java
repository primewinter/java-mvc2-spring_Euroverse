package com.ksy.service.flight.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Order;
import com.ksy.service.flight.FlightDao;

@Repository("flightDaoImpl")
public class FlightDaoImpl implements FlightDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public FlightDaoImpl() {
		System.out.println(this.getClass());
	}
	public void addFlight(Flight flight ) throws Exception{
		sqlSession.insert("FlightMapper.addFlight", flight);
		System.out.println("flight : "+flight);
	}
	
	public Flight getFlight(String flightId) throws Exception{
		return sqlSession.selectOne("FlightMapper.getFlight", flightId);
	}
	
	public List<Flight> getFlightList(Search search ,String buyerId ) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId",buyerId);
		return sqlSession.selectList("FlightMapper.getFlightList", map);
	}
	
	
	public List<Flight> getFlightListAdmin(Search search) throws Exception {
		return sqlSession.selectList("FlightMapper.getFlightListAdmin", search );
	}

	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("OrderMapper.getTotalCount", search);

	}



}
