package com.ksy.service.plan.test;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;

import com.ksy.common.util.Util;
import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Day;
import com.ksy.service.domain.Memo;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Stuff;
import com.ksy.service.domain.Todo;
import com.ksy.service.domain.User;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;

/*
 *	FileName :  PlanServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data 를 다양하게 Wiring 하자...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })

public class PlanServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	/* Plan Controller 테스트용 와이어링 */
	@Autowired
	@Qualifier("planSubServiceImpl")
	private PlanSubService planSubService;

	
	@Test
	public void testGetPlanListByUserId() throws Exception {
		
		String userId = "admin";
		
		List<Plan> planList = planService.getPlanList(userId);
		
		System.out.println("\n\n\n	list size : "+planList.size());
		System.out.println("\n\n\n	planList :: "+planList);
	}
	
	//@Test
	public void testGetPlanByPlanId() throws Exception {
		
		String planId = "10030";
		Plan plan = planService.getPlan(planId);
		
		System.out.println("\n\n	plan : "+plan);
		
		planId = "10002";
		plan = planService.getPlan(planId);
		
		System.out.println("\n\n	plan : "+plan);	
	}
	
	
	//******** 		Controller 테스트		  ********//
	// ===>>> PlanControllerTest.java 로 옮겨감ㅎㅎㅎㅎㅎㅎㅎ
	//@Test
	public void testGetPlanController() throws Exception {
		Model model = new Model() {
			
			@Override
			public Model mergeAttributes(Map<String, ?> arg0) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public boolean containsAttribute(String arg0) {
				// TODO Auto-generated method stub
				return false;
			}
			
			@Override
			public Map<String, Object> asMap() {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Model addAttribute(String arg0, Object arg1) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Model addAttribute(Object arg0) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Model addAllAttributes(Map<String, ?> arg0) {
				// TODO Auto-generated method stub
				return null;
			}
			
			@Override
			public Model addAllAttributes(Collection<?> arg0) {
				// TODO Auto-generated method stub
				return null;
			}
		};
		
		String planId = "10000";
		
		
		Plan plan = planService.getPlan(planId);
		//plan_id, plan_title, plan_img, plan_type, start_date, plan_status, (cr.sum - (cr.cnt-1)) plan_total_days, pt.plan_party_size 
		
		List<User> planPartyList = planService.getPlanPartyList(planId);	//planPartyList
		plan.setPlanPartyList(planPartyList);
		
		List<Todo> todoList = planService.getTodoList(planId); 				//todoList
		plan.setTodoList(todoList);
		
	
		//List<Daily> dailyList = planSubService.getDailyList(planId);		//dailyList
		List<Stuff> stuffList = planSubService.getStuffList(planId);		//stuffList
		List<Memo> memoList = planSubService.getMemoList(planId);			//memoList
		//plan.setDailyList(dailyList);
		plan.setStuffList(stuffList);
		plan.setMemoList(memoList);
		
		List<City> listCity = planSubService.getCityRouteList(planId);	
		/* */plan.setCityList(listCity);
		model.addAttribute("listCity", listCity);	//Plan 필드에 CityList 없어서 모델에 심어줌... :: 추후 변경?
		
		//List<Day> dayList = Util.cityListToDayList(listCity);
		//lan.setDayList(dayList);
		
		plan.setPlanDday( Util.getDday(plan.getStartDate()));		//여행 D-Day
		plan.setEndDate( Util.getEndDate(plan.getStartDate(), plan.getPlanTotalDays()) );	//여행종료일자
		
		
		//버짓 요약을 위한 리스트 : model에 심어서 보내주기
		//List<Daily> budgetOverviewList = planSubService.getBudgetOverview(planId);
		/* *///plan.setBudgetOverviewList(budgetOverviewList);
		//model.addAttribute("budgetOverviewList", budgetOverviewList);
		
		model.addAttribute("plan", plan);
		
		System.out.println("\n\n- - - - - - - - - - - - plan - - - - - - - - - - \n");
		System.out.println(plan);
		
		String returnString = "forward:/plan/getPlan.jsp";
	}
	
	
	
	//@Test
	public void testGetTodoListByPlanId() throws Exception {
		
		String planId = "10000";
		List<Todo> todoList = planService.getTodoList(planId);
		
		System.out.println("\n\n	todoList : "+todoList);
	}
	
	//@Test
	public void testGetPlanPartyListByPlanId() throws Exception {
		
		String planId = "10000";
		List<User> planPartyList = planService.getPlanPartyList(planId);
		
		System.out.println("\n\n	planPartyList : "+planPartyList);
	}
	
	//@Test
	public void testAddPlan() throws Exception {	//성공!
		
		Plan plan = new Plan();
		User planMaster = new User();
		planMaster.setUserId("test2222");
		plan.setPlanMaster(planMaster);
		plan.setPlanTitle("테스트플랜22");
		plan.setPlanImg("gooood.jpg");
		plan.setPlanType("D");
		plan.setStartDateString("20201212");	//지정한 월이 부적합합니다 오류 -> 매퍼에서 TO_DATE 설정해줘서 해결
		
		planService.addPlan(plan);
	}
	
	
	//@Test
	public void testUpdatePlan() throws Exception {		//성공!
		
		
		Plan plan = planService.getPlan("10030");
		
		System.out.println("	before plan :: "+plan);
		
		plan = new Plan();
	
		plan.setPlanId("10030");
		plan.setPlanTitle("updatePlanTest");
		plan.setPlanImg("updateComplete.jpg");
		plan.setPlanType("C");
		plan.setStartDateString("20201212");	
		
		planService.updatePlan(plan);
		
		plan = new Plan();
		plan = planService.getPlan("10030");
		
		System.out.println("	after plan :: "+plan);	
	}
	
	//@Test
	public void testUpdatePlanStatus() throws Exception {		//성공!
		
		Plan plan = planService.getPlan("10030");
		System.out.println("	before plan :: "+plan);
		
		plan = new Plan();
		plan.setPlanId("10030");
		plan.setPlanStatus("C");
		
		planService.updatePlanStatus(plan);
		
		plan = planService.getPlan("10030");
		System.out.println("	after plan :: "+plan);	
	}
	
	//@Test
	public void testDeletePlan() throws Exception {		//성공!
		
		String userId = "admin";
		List<Plan> planList = planService.getPlanList(userId);
		System.out.println("\n\n\n	before planList :: "+planList);
		
		planService.deletePlan("10001");
		
		planList = planService.getPlanList(userId);
		System.out.println("\n\n\n	after planList :: "+planList);
	}
	
	//@Test
	public void testDeletePlanParty() throws Exception {		//성공!
		
		String planId = "10000";
		List<User> planPartyList = planService.getPlanPartyList(planId);
		System.out.println("\n\n	planPartyList : "+planPartyList);
				
		Party party = new Party();
		party.setPartyUserId("testMember");
		party.setRefId("10000");
		
		planService.deletePlanParty(party);
		
		planPartyList = planService.getPlanPartyList(planId);
		System.out.println("\n\n	planPartyList : "+planPartyList);
	}
	
	//@Test
	public void testCheckUserFromParty() throws Exception {		//성공!
		
		Party party = new Party();
		party.setPartyUserId("user01");
		party.setRefId("10000");
		
		String userId = planService.checkUserFromParty(party);
		if( userId != null ) {
			System.out.println(userId + " 님은 이미 플래너에 참여중인 멤버입니다");
		}else {
			System.out.println("user01" +"님을 초대할까요?");
		}
		
		party.setPartyUserId("testMember");
		
		String userId2 = planService.checkUserFromParty(party);
		if( userId2 != null ) {
			System.out.println(userId2 + " 님은 이미 플래너에 참여중인 멤버입니다");
		}else {
			System.out.println("testMember" +" 님을 초대할까요?");
		}
	}
	
	//@Test
	public void testAddOffer() throws Exception {		//성공!
		
		Offer offer = new Offer();
		offer.setRefId("10000");
		offer.setFromUserId("admin");
		offer.setToUserId("sysy");
		offer.setOfferMsg("메시지 보내기~~");
		
		planService.addOffer(offer);
	}
	
	//@Test
	public void testCheckTodo() throws Exception {		//성공!
		
		Todo todo = new Todo();
		todo.setTodoId("10023");
		todo.setTodoCheck("T");
		
		planService.checkTodo(todo);
	}
	
	//@Test
	public void testAddTodo() throws Exception {		//성공!
		
		Todo todo = new Todo();
		todo.setTodoName("투두넣기 테스트");
		todo.setPlanId("10030");
		
		planService.addTodo(todo);
	}
	
	//@Test
	public void testUpdateTodoName() throws Exception {		//성공!
		
		Todo todo = new Todo();
		todo.setTodoName("투두이름 변경 테스트");
		todo.setTodoId("10023");
		
		planService.updateTodoName(todo);
	}
	
	//@Test
	public void testDeleteTodo() throws Exception {		//성공!
		
		planService.deleteTodo("10022");
	}
	
	
	
	
	
	/*
	 * //@Test public void testUpdateUserSlot() throws Exception { //성공!
	 * 
	 * planService.updateUserSlot("testMember"); }
	 * 
	 * //@Test public void testFindUserId() throws Exception { //성공!
	 * 
	 * String userId = planService.findUserId("testMember");
	 * 
	 * if( userId != null ) { System.out.println(userId + " 님은 존재하는 회원입니다 "); }else
	 * { System.out.println("testMember"+ " 는 존재하지 않습니다"); }
	 * 
	 * String userId2 = planService.findUserId("nonono");
	 * 
	 * if( userId2 != null ) { System.out.println(userId2 + " 님은 존재하는 회원입니다 ");
	 * }else { System.out.println("nonono"+ " 는 존재하지 않습니다"); } }
	 */
	
}