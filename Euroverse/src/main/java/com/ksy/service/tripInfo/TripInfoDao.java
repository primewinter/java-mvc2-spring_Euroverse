package com.ksy.service.tripInfo;

import java.util.List;

import com.ksy.service.domain.TripInfo;



public interface TripInfoDao {
	
	// INSERT
	public void insertUrl(TripInfo url) throws Exception ;
		
	public List<TripInfo> getUrl(String conName) throws Exception;

}