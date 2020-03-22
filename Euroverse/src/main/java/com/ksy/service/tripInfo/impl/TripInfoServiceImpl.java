package com.ksy.service.tripInfo.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.service.domain.TripInfo;
import com.ksy.service.tripInfo.TripInfoDao;
import com.ksy.service.tripInfo.TripInfoService;



@Service("tripInfoServiceImpl")
public class TripInfoServiceImpl implements TripInfoService{
	
	///Field
	@Autowired
	@Qualifier("tripInfoDaoImpl")
	private TripInfoDao tripInfoDao;
	public void setClickDao(TripInfoDao tripInfoDao) {
		this.tripInfoDao = tripInfoDao;
	}
	
	///Constructor
	public TripInfoServiceImpl() {
		System.out.println(this.getClass());
	}

	//@Override
	public void addUrl(TripInfo tripInfo) throws Exception {
		tripInfoDao.insertUrl(tripInfo);
	}
	//@Override
	public List<TripInfo> getUrl(String conName) throws Exception {
		
		System.out.println("TripInfoServiceImpl getUrl");
		
		return tripInfoDao.getUrl(conName);
	}
	
}