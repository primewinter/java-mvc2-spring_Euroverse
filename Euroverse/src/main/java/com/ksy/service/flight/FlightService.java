package com.ksy.service.flight;

import java.util.Map;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;


public interface FlightService {
	
	public Flight addFlight(Flight flight) throws Exception;
	
	public Flight getFlight(String flightId) throws Exception;
	
	public Map<String,Object> getFlightList(Search search,String buyerId) throws Exception;
 
	public Map<String,Object> getFlightListAdmin(Search search) throws Exception;
	
}