package com.ksy.service.flight.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Order;
import com.ksy.service.flight.FlightDao;
import com.ksy.service.flight.FlightService;

@Service("flightServiceImpl")
public class FlightServiceImpl implements FlightService{
	
	@Autowired
	@Qualifier("flightDaoImpl")
	private FlightDao flightDao;
	
	public void setFlightDao(FlightDao flightDao) {
		this.flightDao = flightDao;
	}
	public FlightServiceImpl() {
		System.out.println(this.getClass());
	}
	public Flight addFlight(Flight flight) throws Exception{
		flightDao.addFlight(flight);
		return flight;
	}
	
	public Flight getFlight (String flightId) throws Exception {
		return flightDao.getFlight(flightId);
	}
	
	public Map<String,Object> getFlightList (Search search , String buyerId ) throws Exception {
		List<Flight> list= (List<Flight>) flightDao.getFlightList(search, buyerId);
		Map<String, Object> map = new HashMap<String, Object>();
		
		int totalCount = flightDao.getTotalCount(search);
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		System.out.println(map);
		return map;
	}
	
	
	public Map<String,Object> getFlightListAdmin(Search search) throws Exception {
		List<Flight> list= (List<Flight>) flightDao.getFlightListAdmin(search);
		int totalCount = flightDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}


}