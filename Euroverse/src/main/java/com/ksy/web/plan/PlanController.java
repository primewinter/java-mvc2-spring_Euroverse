package com.ksy.web.plan;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.common.util.Util;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Day;
import com.ksy.service.domain.Memo;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Point;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Stuff;
import com.ksy.service.domain.Tag;
import com.ksy.service.domain.Todo;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;
import com.ksy.service.user.UserService;

@Controller
@RequestMapping("/plan/*")
public class PlanController {

	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("planSubServiceImpl")
	private PlanSubService planSubService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("myPageServiceImpl")
	private MyPageService myPageService;
	
	
//	@Resource(name="uploadPath")
//	String uploadPath;
	String uploadPath = "C:\\Users\\User\\git\\Euroverse\\ksy\\WebContent\\resources\\images\\planImg";
	
	public PlanController() {
		System.out.println(this.getClass());
	}
	
	
	
	
	@RequestMapping( value = "getPlanList", method = RequestMethod.GET )
	public String getPlanList (	/*@RequestParam("userId") String userId, */ Model model, HttpSession session	) throws Exception {
		
		User user = (User)session.getAttribute("user");

		if(user == null) {
			return "redirect:/view/plan/planNotice.jsp";
		}
		
		List<Plan> listPlan = planService.getPlanList(user.getUserId());
		model.addAttribute("list", listPlan);
		
		return "forward:/view/plan/getPlanList.jsp";
	}
	
	/* PlanSubController로 이동 */
	@RequestMapping( value = "getPlan", method = RequestMethod.GET )
	public String getPlan (	@RequestParam("planId") String planId, Model model, HttpSession session	) throws Exception {
		
		User user = (User)session.getAttribute("user");
		if(user == null) {
			return "redirect:/view/plan/planNotice.jsp";
		}
		
		Plan plan = planService.getPlan(planId);
		
		List<User> planPartyList = planService.getPlanPartyList(planId);	//planPartyList
		plan.setPlanPartyList(planPartyList);
		
		List<Todo> todoList = planService.getTodoList(planId); 				//todoList
		List<Daily> dailyList = planSubService.getDailyList(plan);		//dailyList
		List<Stuff> stuffList = planSubService.getStuffList(planId);		//stuffList
		List<Memo> memoList = planSubService.getMemoList(planId);			//memoList
		plan.setTodoList(todoList);
		plan.setDailyList(dailyList);
		plan.setStuffList(stuffList);
		plan.setMemoList(memoList);
		
		List<Daily> budgetOverviewList = planSubService.getBudgetOverview(plan);
		plan.setBudgetOverviewList(budgetOverviewList);
		
		List<City> listCity = planSubService.getCityRouteList(planId);
		plan.setCityList(listCity);
		
		List<Day> dayList = Util.cityListToDayList(listCity, plan.getStartDate() );
		plan.setDayList(dayList);
		
		
		/* FullCalendar addEvent 위한 JSON 만들기.. */
		JSONArray cityArray = new JSONArray();
		
		for (City cityItem : listCity) {
			JSONObject cityEvent = new JSONObject();
//			ObjectMapper objMapper = new ObjectMapper();
//			String cityJson = objMapper.writeValueAsString(cityItem);
			
			cityEvent.put("title", cityItem.getCityName());
			cityEvent.put("start", cityItem.getStartDateStr());
			cityEvent.put("end", cityItem.getEndDateStr());
			cityEvent.put("textColor", "white");
			if( cityItem.getCountry() != null ) {
				if( cityItem.getCountry().equals("영국") ) {
					cityEvent.put("color", "#F9A081");
				}else if(cityItem.getCountry().equals("스위스") ) {
					cityEvent.put("color", "#98E657");
				}else if(cityItem.getCountry().equals("프랑스") ) {
					cityEvent.put("color", "#8886F4");
				}else if(cityItem.getCountry().equals("이탈리아") ) {
					cityEvent.put("color", "#76A0F3");
				}
			}else {
				cityEvent.put("color", "#51bec9");
			}
			
			cityArray.add(cityEvent);
		}
		
		/* GoogleMap API를 위한 JSON 만들기.. */
		JSONArray markerArray = new JSONArray();
		for (City cityItem : listCity) {
			JSONObject cityMarker = new JSONObject();
			
			JSONObject position = new JSONObject();
			position.put("lat", Double.parseDouble( cityItem.getCityLat() ));
			position.put("lng", Double.parseDouble( cityItem.getCityLng() ));
			
			cityMarker.put("position", position);
			cityMarker.put("title", cityItem.getCityName());
			
			markerArray.add(cityMarker);
		}
		
		plan.setPlanDday( Util.getDday(plan.getStartDate()));		//여행 D-Day
		if( plan.getPlanTotalDays() != 0) {
			plan.setEndDate( Util.getEndDate(plan.getStartDate(), plan.getPlanTotalDays()) );	//여행종료일자
		}
		
		model.addAttribute("plan", plan);
		model.addAttribute("cityEventList", cityArray);
		model.addAttribute("cityMarkerList", markerArray);
		
		return "forward:/view/plan/getPlan.jsp";
	}
	
	/* PlanSubController로 이동 */
//	@RequestMapping( value = "editRoute", method = RequestMethod.GET )
//	public String editRoute (	@RequestParam("planId") String planId, Model model, HttpSession session	) throws Exception {
//		
//		Plan plan = planService.getPlan(planId);
//		
//		List<City> listCity = planSubService.getCityRouteList(planId);
//		plan.setCityList(listCity);
//		
//		List<Day> dayList = Util.cityListToDayList(listCity, plan.getStartDate() );
//		plan.setDayList(dayList);
//		
//		/* GoogleMap API를 위한 JSON 만들기.. */
//		JSONArray markerArray = new JSONArray();
//		for (City cityItem : listCity) {
//			JSONObject cityMarker = new JSONObject();
//			
//			JSONObject position = new JSONObject();
//			position.put("lat", Double.parseDouble( cityItem.getCityLat() ));
//			position.put("lng", Double.parseDouble( cityItem.getCityLng() ));
//			
//			cityMarker.put("position", position);
//			cityMarker.put("title", cityItem.getCityName());
//			cityMarker.put("cityImg", cityItem.getCityImg());
//			cityMarker.put("cityInfo", cityItem.getCityInfo());
//			
//			markerArray.add(cityMarker);
//		}
//		
//		model.addAttribute("plan", plan);
//		model.addAttribute("cityMarkerList", markerArray);
//		
//		return "forward:/view/plan/editRoute.jsp";
//	}
	
	
	
	@RequestMapping( value = "addPlan", method = RequestMethod.POST )
	public String addPlan (	@ModelAttribute("plan") Plan plan, Model model, HttpSession session	) throws Exception {
		
		User user = (User)session.getAttribute("user");		//음..
		
		if(user != null) { 
			plan.setPlanMaster(user); 
		}else {
			return "redirect:/view/plan/planNotice.jsp";
		}
		
		MultipartFile mpFile = (MultipartFile)plan.getPlanImgFile();
		if( mpFile.isEmpty() == false) {	//null 체크로 잡을 수 없음! 
			//String path = "C:\\Users\\User\\git\\Euroverse\\ksy\\WebContent\\resources\\images\\planImg";
			
			/*
			 * Calendar cal = Calendar.getInstance() ; 
			 * SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd_HHmmSS"); 
			 * String time = dateFormat.format(cal.getTime()); String fileName =
			 * mpFile.getOriginalFilename() + "_"+time;
			 */
			
			String fileName = mpFile.getOriginalFilename();
			fileName = uploadFile(fileName, mpFile.getBytes());
			//mpFile.transferTo( new File(path, fileName) );
			
			plan.setPlanImg(fileName);
			
		}else {
			plan.setPlanImg("defaultPlanImage.jpg");
		}

		planService.addPlan(plan);	
	
		return "redirect:/plan/getPlanList?userId="+user.getUserId();
	}
	
	@RequestMapping( value = "downloadPlan", method = RequestMethod.POST )
	public String downloadPlan (	@ModelAttribute("plan") Plan plan, Model model, HttpSession session	) throws Exception {
		
		User user = (User)session.getAttribute("user");		
		if(user != null) { 
			plan.setPlanMaster(user); 
		}else {
			return "redirect:/view/plan/planNotice.jsp";
		}
		
		MultipartFile mpFile = (MultipartFile)plan.getPlanImgFile();
		if( mpFile.isEmpty() == false) {	//null 체크로 잡을 수 없음! 
			
			String fileName = mpFile.getOriginalFilename();
			fileName = uploadFile(fileName, mpFile.getBytes());
			plan.setPlanImg(fileName);
		}else {
			plan.setPlanImg("defaultPlanImage.jpg");
		}

		planService.copyPlan(plan);	
		
		return "redirect:/plan/getPlanList?userId="+user.getUserId();
	}
	
	
	//파일 이름 중복제거용 함수
	private String uploadFile(String originalName, byte[] fileData) throws Exception{
		
		UUID uuid = UUID.randomUUID();	//uuid 생성 (Universal Unique IDentifier, 범용 고유 식별자)
		
		String savedName = uuid.toString()+"_"+originalName;
		File target = new File(uploadPath, savedName);
		
		FileCopyUtils.copy(fileData, target);	//임시 디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
		
		return savedName;
	}
	
	
	@RequestMapping( value = "updatePlan", method = RequestMethod.POST )
	public String updatePlan (	@ModelAttribute("plan") Plan plan, Model model	) throws Exception {
	
		MultipartFile mpFile = (MultipartFile)plan.getPlanImgFile();
		if( mpFile.isEmpty() == false) {	//null 체크로 잡을 수 없음! 
			
			String fileName = mpFile.getOriginalFilename();
			fileName = uploadFile(fileName, mpFile.getBytes());
			
			plan.setPlanImg(fileName);
		}else { //plan.setPlanImg("defaultPlanImage.jpg");
		}		
		
		planService.updatePlan(plan);
		
		return "redirect:/plan/getPlan?planId="+plan.getPlanId();
	}
	
	@RequestMapping( value = "updatePlanStatus", method = RequestMethod.POST )
	public String updatePlanStatus (	@ModelAttribute("plan") Plan plan, Model model	) throws Exception {
	
		planService.updatePlanStatus(plan);
	
		//plan = planService.getPlan(plan.getPlanId());	//<- 이 과정이 굳이 필요한가..? <- 필요하다!!! <-아닌거같음.. 필요없음!!!!!!
		//model.addAttribute("plan", plan);		
		
		return "redirect:/plan/getPlan?planId="+plan.getPlanId();
	}
	
	@RequestMapping( value = "deletePlan", method = RequestMethod.POST )
	public String deletePlan (	@RequestParam("planId") String planId, Model model, HttpSession session	) throws Exception {
	
		planService.deletePlan(planId);
		
		User user = (User)session.getAttribute("user");
		if(user == null) {
			return "redirect:/view/plan/planNotice.jsp";
		}
		
		return "redirect:/plan/getPlanList?userId="+user.getUserId();
	}
	
	
	
	//deletePlanParty 레스트에 있던거 옮겨옴!!!!!!
	@RequestMapping( value = "deletePlanParty", method = RequestMethod.POST )
	public String deletePlanParty (	@ModelAttribute("party") Party party, Model model, HttpSession session	) throws Exception {
	
		planService.deletePlanParty(party);
		
		User user = (User)session.getAttribute("user");
		if(user == null) {
			return "redirect:/view/plan/planNotice.jsp";
		}
		
		if( party.getPartyRole().equals("S")) {		//셀프탈퇴
			return "redirect:/plan/getPlanList?userId="+user.getUserId();		//내가 탈퇴하는 경우
		}else { // if( party.getPartyRole().equals("F")) {	//마스터의 강퇴
			return "redirect:/plan/getPlan?planId="+party.getRefId();		//마스터가 강퇴시키는 경우
		}
	}
	
	//레스트에 있던거 가져옴
	@RequestMapping( value = "updateUserSlot", method = RequestMethod.GET )
	public String updateUserSlot( @RequestParam("userId") String userId, HttpSession session ) throws Exception {
		
		Point usedPoint = new Point();
		usedPoint.setUserId(userId);
		usedPoint.setUsedType("S");
		usedPoint.setUsedPoint(500);
		
		myPageService.addPoint(usedPoint);
		myPageService.updateUserSlot(userId);
		
		User newUser = userService.getUser(userId);
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();	//유저정보 업데이트 되었기 때문에 세션에 다시 박아주기!
		if( sessionId.equals( userId ) ){
			session.setAttribute("user", newUser);
		}
		
		return "redirect:/plan/getPlanList?userId="+userId;
	}
	
	
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;
	
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	
	
	
}
