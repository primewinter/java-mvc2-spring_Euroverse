package com.ksy.service.planSub.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Memo;
import com.ksy.service.domain.Stuff;
import com.ksy.service.planSub.PlanSubService;

@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data 를 다양하게 Wiring 하자...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })

public class PlanSubServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("planSubServiceImpl")
	private PlanSubService planSubService;

	
	//@Test
	public void testGetBudgetOverview() throws Exception {
		
		String planId = "10001";
		//List<Daily> listBudget = planSubService.getBudgetOverview(planId);
		
		//System.out.println("	budgetOverView :: "+listBudget);
	}
	
	//@Test
	public void testGetBudgetList() throws Exception {
		
		String planId = "10001";
		List<Daily> listBudget = planSubService.getBudgetList(planId);
		
		System.out.println("	budgetList :: "+listBudget);
	}
	
	@Test
	public void testGetDailyList() throws Exception {
		
		String planId = "10001";
		//List<Daily> listDaily = planSubService.getDailyList(planId);
		///System.out.println("	dailyList :: "+listDaily);
		
		planId = "10000";
		//listDaily = planSubService.getDailyList(planId);
		//System.out.println("	dailyList :: "+listDaily);
	}
	
	//@Test
	public void testGetDaily() throws Exception {
		
		String dailyId = "10001";
		//Daily daily = planSubService.getDaily(dailyId);
		//System.out.println("	daily :: "+ daily);
	}
	
	//@Test
	public void testAddDaily() throws Exception {
		
		//List<Daily> listDaily = planSubService.getDailyList("10030");
		//System.out.println("	before dailyList :: "+listDaily);
		
		Daily daily = new Daily();
		daily.setPlanId("10030");
		daily.setDailyCate("V");
		daily.setDailyDetail("일정 등록 테스트!!!!");
		daily.setDayNo("2");
		daily.setDayTime("12");
		
		//예산 지정 안할시 디폴트..
		daily.setBudgetAmount(0);
		daily.setBudgetCurrency("K");
		
		planSubService.addDaily(daily);
		
		//listDaily = planSubService.getDailyList("10030");
		//System.out.println("	after dailyList :: "+listDaily);
	}
	
	//@Test
	public void testUpdateDaily() throws Exception {
		
		//List<Daily> listDaily = planSubService.getDailyList("10030");
		//System.out.println("	before dailyList :: "+listDaily);
		
		Daily daily = new Daily();
		daily.setDailyId("10020");
		daily.setDailyCate("V");
		daily.setDailyDetail("일정 등록 업데이트!!!!!!");
		daily.setDayNo("3");
		daily.setDayTime("15");
		
		//예산 지정 안할시 디폴트..
		daily.setBudgetAmount(0);
		daily.setBudgetCurrency("K");
		
		planSubService.updateDaily(daily);
		
		//listDaily = planSubService.getDailyList("10030");
		//System.out.println("	after dailyList :: "+listDaily);
	}
	
	
	
	//@Test
	public void testGetCityRouteList() throws Exception {
		
		List<City> cityList = planSubService.getCityRouteList("10000");
		System.out.println("	cityList :: "+cityList);
	}
	
	//@Test
	public void testAddCityRoute() throws Exception {
		
		List<City> cityList = planSubService.getCityRouteList("10030");
		System.out.println("	before cityList :: "+cityList);
		
		City city = new City();
		city.setPlanId("10030");
		city.setVisitOrder(1);
		city.setCityName("레이캬비크");
		
		planSubService.addCityRoute(city);
		
		cityList = planSubService.getCityRouteList("10030");
		System.out.println("	after cityList :: "+cityList);
	}
	
	//@Test
	public void testDeleteCityRoute() throws Exception {
		
		List<City> cityList = planSubService.getCityRouteList("10030");
		System.out.println("	before cityList :: "+cityList);
		
		planSubService.deleteCityRoute("10020");
		
		cityList = planSubService.getCityRouteList("10030");
		System.out.println("	after cityList :: "+cityList);
	}
	
	//@Test
	public void testGetCityRoute() throws Exception {
		
		City city = planSubService.getCityRoute("10006");
		System.out.println("	city :: "+city);
	}
	
	//@Test
	public void testUpdateCityDuration() throws Exception {
		
		City city = planSubService.getCityRoute("10006");
		System.out.println("	before city :: "+city);
		
		city.setCityDuration(10);
		
		planSubService.updateCityDuration(city);
		
		city = planSubService.getCityRoute("10006");
		System.out.println("	before city :: "+city);
	}
	
	
	//@Test
	public void testUpdateTranType() throws Exception {
		
		City city = planSubService.getCityRoute("10006");
		System.out.println("	before city :: "+city);
		
		city.setTranType("B");
		
		planSubService.updateTranType(city);
		
		city = planSubService.getCityRoute("10006");
		System.out.println("	before city :: "+city);
	}
	
	
	
	//@Test
	public void testGetStuffList() throws Exception {
		
		List<Stuff> stuffList = planSubService.getStuffList("10030");	
		System.out.println("	stuffList :: "+stuffList);
	}
	
	//@Test
	public void testCheckStuff() throws Exception {
		
		List<Stuff> stuffList = planSubService.getStuffList("10030");	
		System.out.println("	before stuffList :: "+stuffList);
		
		Stuff stuff = new Stuff();
		stuff.setStuffCheck("T");
		stuff.setStuffId("10022");
		
		planSubService.checkStuff(stuff);
		
		stuffList = planSubService.getStuffList("10030");	
		System.out.println("	after stuffList :: "+stuffList);
	}
	
	//@Test
	public void testAddStuff() throws Exception {
		
		List<Stuff> stuffList = planSubService.getStuffList("10030");	
		System.out.println("	before stuffList :: "+stuffList);
		
		Stuff stuff = new Stuff();
		stuff.setPlanId("10030");
		stuff.setStuffName("준비물 추가하기 테스트2222222");
		
		planSubService.addStuff(stuff);
		
		stuffList = planSubService.getStuffList("10030");	
		System.out.println("	after stuffList :: "+stuffList);
	}
	
	//@Test
	public void testUpdateStuffName() throws Exception {
		
		List<Stuff> stuffList = planSubService.getStuffList("10030");	
		System.out.println("	before stuffList :: "+stuffList);
		
		Stuff stuff = new Stuff();
		stuff.setStuffId("10024");
		stuff.setStuffName("업데이트 준비물 이름");
		
		planSubService.updateStuffName(stuff);
		
		stuffList = planSubService.getStuffList("10030");	
		System.out.println("	after stuffList :: "+stuffList);
	}
	
	//@Test
	public void testDeleteStuff() throws Exception {
		
		List<Stuff> stuffList = planSubService.getStuffList("10030");	
		System.out.println("	before stuffList :: "+stuffList);
		
		planSubService.deleteStuff("10025");
		
		stuffList = planSubService.getStuffList("10030");	
		System.out.println("	after stuffList :: "+stuffList);
	}
	
	
	
	//@Test
	public void testGetMemoList() throws Exception {
		
		List<Memo> memoList = planSubService.getMemoList("10000");
		System.out.println("	memoList :: "+memoList);
	}
	
	//@Test
	public void testAddMemo() throws Exception {
		
		List<Memo> memoList = planSubService.getMemoList("10000");
		System.out.println("	before memoList :: "+memoList);
		
		Memo memo = new Memo();
		memo.setPlanId("10000");
		memo.setMemoDetail("메모등록 테스트트트트트트트ㅡㅡ");
		memo.setMemoRegUser("admin");
		
		planSubService.addMemo(memo);
		
		memoList = planSubService.getMemoList("10000");
		System.out.println("	after memoList :: "+memoList);
	}
	
	//@Test
	public void testUpdateMemo() throws Exception {
		
		List<Memo> memoList = planSubService.getMemoList("10000");
		System.out.println("	before memoList :: "+memoList);
		
		Memo memo = new Memo();
		memo.setMemoId("10020");
		memo.setMemoDetail("메모 수정 테스트~ㅎㅎㅎㅎㅎㅎ");
		
		planSubService.updateMemo(memo);
		
		memoList = planSubService.getMemoList("10000");
		System.out.println("	after memoList :: "+memoList);
	}
	
	//@Test
	public void testDeleteMemo() throws Exception {
		
		List<Memo> memoList = planSubService.getMemoList("10000");
		System.out.println("	before memoList :: "+memoList);
		
		planSubService.deleteMemo("10020");
		
		memoList = planSubService.getMemoList("10000");
		System.out.println("	after memoList :: "+memoList);
	}
	
}
