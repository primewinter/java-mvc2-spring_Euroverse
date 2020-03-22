package com.ksy.service.tripInfo;

import java.util.List;
import java.util.Map;

import com.ksy.service.domain.TripInfo;

public interface TripInfoService {
	
	//url¡÷º“ insert
	public void addUrl(TripInfo tripInfo) throws Exception;
	
	public List<TripInfo> getUrl(String conName) throws Exception;
	

}