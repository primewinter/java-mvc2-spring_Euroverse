package com.ksy.service.planSub.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Memo;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Stuff;
import com.ksy.service.planSub.PlanSubDao;

@Repository
public class PlanSubDaoImpl implements PlanSubDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PlanSubDaoImpl() {
		super();
	}



	public List<Daily> getBudgetOverview(Plan plan) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getBudgetOverview", plan);
	}

	public List<Daily> getBudgetList(String planId) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getBudgetList", planId);
	}

	public List<Daily> getDailyList(Plan plan) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getDailyList", plan);
	}

	public Daily getDaily(Daily daily) throws Exception {
		return sqlSession.selectOne("PlanSubMapper.getDaily", daily);
	}

	public void addDaily(Daily daily) throws Exception {
		sqlSession.insert("PlanSubMapper.addDaily", daily);
	}

	public void updateDaily(Daily daily) throws Exception {
		sqlSession.update("PlanSubMapper.updateDaily", daily);
	}
	
	@Override
	public void deleteDaily(String dailyId) throws Exception {
		sqlSession.delete("PlanSubMapper.deleteDaily",dailyId);
	}
	


	public List<City> getCityRouteList(String planId) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getCityRouteList", planId);
	}

	public void addCityRoute(City city) throws Exception {
		sqlSession.insert("PlanSubMapper.addCityRoute", city);
	}

	public void deleteCityRoute(String cityId) throws Exception {
		sqlSession.delete("PlanSubMapper.deleteCityRoute", cityId);
	}

	public City getCityRoute(String cityId) throws Exception {
		return sqlSession.selectOne("PlanSubMapper.getCityRoute", cityId);
	}

	public void updateCityDuration(City city) throws Exception {
		sqlSession.update("PlanSubMapper.updateCityDuration", city);
	}

	public void updateTranType(City city) throws Exception {
		sqlSession.update("PlanSubMapper.updateTranType", city);
	}

	@Override
	public void updateVisitOrder(City city) throws Exception {
		sqlSession.update("PlanSubMapper.updateVisitOrder", city);
	}
	
	
	

	public List<Stuff> getStuffList(String planId) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getStuffList", planId);
	}

	public void checkStuff(Stuff stuff) throws Exception {
		sqlSession.update("PlanSubMapper.checkStuff", stuff);
	}

	public void addStuff(Stuff stuff) throws Exception {
		sqlSession.insert("PlanSubMapper.addStuff", stuff);
	}

	public void updateStuffName(Stuff stuff) throws Exception {
		sqlSession.update("PlanSubMapper.updateStuffName", stuff);
	}

	public void deleteStuff(String stuffId) throws Exception {
		sqlSession.delete("PlanSubMapper.deleteStuff", stuffId);
	}

	
	public List<Memo> getMemoList(String planId) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getMemoList", planId);
	}

	public void addMemo(Memo memo) throws Exception {
		sqlSession.insert("PlanSubMapper.addMemo", memo);
	}

	public void updateMemo(Memo memo) throws Exception {
		sqlSession.update("PlanSubMapper.updateMemo", memo);
	}

	public void deleteMemo(String memoId) throws Exception {
		sqlSession.delete("PlanSubMapper.deleteMemo", memoId);
	}
	
	@Override
	public void updateMemoCoordinates(Memo memo) throws Exception {
		sqlSession.update("PlanSubMapper.updateMemoCoordinates", memo);
	}
	
	
	
	//city_info 관련 메소드
	@Override
	public List<City> getCityListByScroll(int zoomLevel) throws Exception {
		return sqlSession.selectList("PlanSubMapper.getCityListByScroll", zoomLevel);
	}

	

}
