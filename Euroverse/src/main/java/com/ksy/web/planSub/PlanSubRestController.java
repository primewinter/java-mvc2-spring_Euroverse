package com.ksy.web.planSub;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Memo;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Stuff;
import com.ksy.service.domain.User;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;

@RestController
@RequestMapping("/planSub/*")
public class PlanSubRestController {

	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("planSubServiceImpl")
	private PlanSubService planSubService;
	
	public PlanSubRestController() {
		System.out.println(this.getClass());
	}
	
	
	
	
	@RequestMapping( value = "json/getDailyList/{planId}", method = RequestMethod.GET )
	public List<Daily> getDailyList( @PathVariable String planId ) throws Exception {
		Plan plan = planService.getPlan(planId);
		
		List<Daily> dailyList = planSubService.getDailyList(plan);
		return dailyList;
	}
	
	@RequestMapping( value = "json/getDaily", method = RequestMethod.POST )
	public Daily getDaily( @RequestBody Daily daily ) throws Exception {
		
		Daily returnDaily = new Daily();
		returnDaily = planSubService.getDaily(daily);
		
		return returnDaily;
	}
	
	@RequestMapping( value = "json/addDaily", method = RequestMethod.POST )
	public List<Daily> addDaily( @RequestBody Daily daily ) throws Exception {
		
		planSubService.addDaily(daily);
		
		Plan plan = planService.getPlan(daily.getPlanId());
		List<Daily> dailyList = planSubService.getDailyList(plan);
		return dailyList;
	}
	
	@RequestMapping( value = "json/updateDaily", method = RequestMethod.POST )
	public List<Daily> updateDaily( @RequestBody Daily daily ) throws Exception {
		
		planSubService.updateDaily(daily);
		
		Plan plan = planService.getPlan(daily.getPlanId());
		List<Daily> dailyList = planSubService.getDailyList(plan);
		return dailyList;
	}
	
	@RequestMapping( value = "json/deleteDaily/{dailyId}", method = RequestMethod.GET )
	public void deleteDaily( @PathVariable String dailyId ) throws Exception {
		
		planSubService.deleteDaily(dailyId);
	}
	
	
	

	
	//스크롤 레벨로 city_info 리스트 가져오기
	@RequestMapping( value = "json/getCityListByScroll/{zoomLevel}", method = RequestMethod.GET )
	public List<City> getCityListByScroll( @PathVariable int zoomLevel ) throws Exception {
		
		List<City> cityInfoList = planSubService.getCityListByScroll(zoomLevel);
		return cityInfoList;
	}

	
	@RequestMapping( value = "json/getCityRouteList/{planId}", method = RequestMethod.GET )
	public List<City> getCityRouteList( @PathVariable String planId ) throws Exception {
		
		List<City> cityList = planSubService.getCityRouteList(planId);
		return cityList;
	}
	
	@RequestMapping( value = "json/addCityRoute", method = RequestMethod.POST )
	public City addCityRoute( @RequestBody City city ) throws Exception {
		
		planSubService.addCityRoute(city);
		
		List<City> cityList = planSubService.getCityRouteList(city.getPlanId());
		City newCity = cityList.get(cityList.size()-1);
		return newCity;
	}
	
	@RequestMapping( value = "json/deleteCityRoute/{cityId}/{planId}", method = RequestMethod.GET )
	public List<City> deleteCityRoute( @PathVariable String cityId, @PathVariable String planId ) throws Exception {
		
		planSubService.deleteCityRoute(cityId);
		
		List<City> cityList = planSubService.getCityRouteList(planId);
		return cityList;
	}
	
	@RequestMapping( value = "json/updateCityDuration", method = RequestMethod.POST )
	public List<City> updateCityDuration( @RequestBody City city ) throws Exception {
		
		planSubService.updateCityDuration(city);
		
		List<City> cityList = planSubService.getCityRouteList(city.getPlanId());
		return cityList;
	}
	
	@RequestMapping( value = "json/updateTranType", method = RequestMethod.POST )
	public List<City> updateTranType( @RequestBody City city ) throws Exception {
		
		planSubService.updateTranType(city);
		
		List<City> cityList = planSubService.getCityRouteList(city.getPlanId());
		return cityList;
	}
	
	@RequestMapping( value = "json/updateVisitOrder", method = RequestMethod.POST )
	public List<City> updateVisitOrder( @RequestBody City city ) throws Exception {
		
		planSubService.updateVisitOrder(city);
		
		List<City> cityList = planSubService.getCityRouteList(city.getPlanId());
		return cityList;
	}
	
//	@RequestMapping( value = "json/getCityRoute/{cityId}", method = RequestMethod.GET )
//	public City getCityRoute( @PathVariable String cityId ) throws Exception {
//		
//		City city = planSubService.getCityRoute(cityId);
//		return city;
//	}
	
	
	
	
	@RequestMapping( value = "json/getStuffList/{planId}", method = RequestMethod.GET )
	public List<Stuff> getStuffList( @PathVariable String planId ) throws Exception {
		
		List<Stuff> stuffList = planSubService.getStuffList(planId);
		return stuffList;
	}
	
	//GET으로 했더니 stuffName 한글 입력하면 깨져 들어와서 POST로 변경!!!
	@RequestMapping( value = "json/addStuff", method = RequestMethod.POST )
	public List<Stuff> addStuff( @RequestBody Stuff stuff ) throws Exception {
		
		planSubService.addStuff(stuff);
		
		List<Stuff> stuffList = planSubService.getStuffList(stuff.getPlanId());
		return stuffList;
	}
	
	@RequestMapping( value = "json/deleteStuff/{stuffId}", method = RequestMethod.GET )
	public void deleteStuff( @PathVariable String stuffId ) throws Exception {
		
		planSubService.deleteStuff(stuffId);
	}
	
	/* checkStuff & updateStuffName 메소드 묶고 SQL을 다이나믹으로 만들어주기! */
	@RequestMapping( value = "json/checkStuff/{stuffCheck}/{stuffId}", method = RequestMethod.GET )
	public void checkStuff( @PathVariable String stuffId, @PathVariable String stuffCheck ) throws Exception {
		
		Stuff stuff = new Stuff();
		stuff.setStuffId(stuffId);
		stuff.setStuffCheck(stuffCheck);
		
		planSubService.checkStuff(stuff);
	}
	
//	@RequestMapping( value = "json/updateStuffName/{stuffName}/{stuffId}", method = RequestMethod.GET )
//	public void updateStuffName( @PathVariable String stuffName, @PathVariable String stuffId ) throws Exception {
//		
//		Stuff stuff = new Stuff();
//		stuff.setStuffName(stuffName);
//		stuff.setStuffId(stuffId);
//		planSubService.updateStuffName(stuff);
//	}

	
	
	@RequestMapping( value = "json/getMemoList/{planId}", method = RequestMethod.GET )
	public List<Memo> getMemoList( @PathVariable String planId ) throws Exception {
		
		List<Memo> memoList = planSubService.getMemoList(planId);
		return memoList;
	}
	
	@RequestMapping( value = "json/addMemo", method = RequestMethod.POST )
	public Memo addMemo( @RequestBody Memo memo, HttpSession session ) throws Exception {
		
		User user = (User)session.getAttribute("user");
		if(user != null) {
			memo.setMemoRegUser(user.getUserId());
		}
		
		planSubService.addMemo(memo);
		
		List<Memo> memoList = planSubService.getMemoList(memo.getPlanId());
		Memo newMemo = memoList.get( 0 );
		return newMemo;
	}
	
	@RequestMapping( value = "json/updateMemo", method = RequestMethod.POST )
	public List<Memo> updateMemo( @RequestBody Memo memo ) throws Exception {
		planSubService.updateMemo(memo);
		
		List<Memo> memoList = planSubService.getMemoList(memo.getPlanId());
		return memoList;
	}
	
	@RequestMapping( value = "json/deleteMemo/{memoId}/{planId}", method = RequestMethod.GET )
	public List<Memo> deleteMemo( @PathVariable String memoId, @PathVariable String planId ) throws Exception {
		planSubService.deleteMemo(memoId);
		
		List<Memo> memoList = planSubService.getMemoList(planId);
		return memoList;
	}
	
	@RequestMapping( value = "json/updateMemoCoordinates", method = RequestMethod.POST )
	public void updateMemoCoordinates( @RequestBody Memo memo ) throws Exception {
		planSubService.updateMemoCoordinates(memo);
	}
	
	
	
	
	
	@RequestMapping( value = "json/getBudgetOverviewList/{planId}/{planTotalDays}", method = RequestMethod.GET )
	public List<Daily> getBudgetOverviewList( @PathVariable String planId, @PathVariable int planTotalDays ) throws Exception {
		
		Plan plan = new Plan();
		plan.setPlanId(planId);
		plan.setPlanTotalDays(planTotalDays);
		
		List<Daily> budgetOverviewList = planSubService.getBudgetOverview(plan);
		return budgetOverviewList;
	}
	
	
}
