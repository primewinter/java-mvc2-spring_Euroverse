package com.ksy.service.flight;

import java.util.List;

import com.ksy.common.Search;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Order;


public interface FlightDao {

		public void addFlight(Flight flight) throws Exception;
		
		public Flight getFlight(String flightId) throws Exception;
		
		public List<Flight> getFlightList(Search search, String buyerId) throws Exception;
		
		public List<Flight> getFlightListAdmin(Search search) throws Exception ;
		
		public int getTotalCount(Search search) throws Exception ;
		

}
