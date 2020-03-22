package com.ksy.service.planSub;

import java.util.List;

import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Memo;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Stuff;

public interface PlanSubService {
	
	public List<Daily> getBudgetOverview(Plan plan) throws Exception;

	public List<Daily> getBudgetList(String planId) throws Exception;
	

	public List<Daily> getDailyList(Plan plan) throws Exception;

	public Daily getDaily(Daily daily) throws Exception;
	
	public void addDaily(Daily daily) throws Exception;
	
	public void updateDaily(Daily daily) throws Exception;
	
	public void deleteDaily(String dailyId) throws Exception;
	
	
	
	public List<City> getCityRouteList(String planId) throws Exception;

	public void addCityRoute(City city) throws Exception;
	
	public void deleteCityRoute(String cityId) throws Exception;
	
	public City getCityRoute(String cityId) throws Exception;
	
	public void updateCityDuration(City city) throws Exception;
	
	public void updateTranType(City city) throws Exception;
	
	public void updateVisitOrder(City city) throws Exception;
	
	
	public List<Stuff> getStuffList(String planId) throws Exception;

	public void checkStuff(Stuff stuff) throws Exception;
	
	public void addStuff(Stuff stuff) throws Exception;
	
	public void updateStuffName(Stuff stuff) throws Exception;
	
	public void deleteStuff(String stuffId) throws Exception;
	

	
	public List<Memo> getMemoList(String planId) throws Exception;

	public void addMemo(Memo memo) throws Exception;
	
	public void updateMemo(Memo memo) throws Exception;
	
	public void deleteMemo(String memoId) throws Exception;

	public void updateMemoCoordinates(Memo memo) throws Exception;
	
	
	//city_info ฐüทร..
	public List<City> getCityListByScroll(int zoomLevel) throws Exception;
	
}
