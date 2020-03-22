package com.ksy.web.admin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.common.util.Util;
import com.ksy.service.admin.AdminService;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.City;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Day;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Stuff;
import com.ksy.service.domain.Tag;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;
import com.ksy.service.user.UserService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminservice;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
//	@Autowired
//	@Qualifier("communityServiceImpl")
//	private CommunityService communityService;
//	
//	@Autowired
//	@Qualifier("planServiceImpl")
//	private PlanService planService;
//	
//	@Autowired
//	@Qualifier("planSubServiceImpl")
//	private PlanSubService planSubService;
//	
//	@Autowired
//	@Qualifier("myPageServiceImpl")
//	private MyPageService myPageService;

	
	public AdminController() {

		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;
	
	@RequestMapping(value="getUserList")
	public String getUserList(@ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception {
		
		System.out.println(this.getClass()+"getUserList");
		
		
		User user = new User();
		
//		계정이 admin이 아닐경우 접속을 막기위해
		user= (User)session.getAttribute("user");
		if(!user.getRole().equals("A")) {
			return "redirect:/";
		}
		
		System.out.println("getAttribute ==>"+session.getAttribute("user"));
		
		
		
		//현재 페이지가 null일 경우 디폴트 1로 유지
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//map에  getUserList 담기
		Map<String, Object> map = adminservice.getUserList(search);
		
		//페이지를 눌렀을때 결과페이지의 페이지값을 찾아오는 작업 
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
				pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println("map.get ==>"+map.get("list"));
		
		//view(jsp)로 데이터전송
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search",search);
		
		System.out.println("model ==>"+model);
		
		return "forward:/view/admin/getUserList.jsp";
		
	}// end of getUserList
	
	//없어질예정
	@RequestMapping(value="getUser", method=RequestMethod.GET)
	public String getUser(@RequestParam("userId") String userId, Model model) throws Exception {
		
		System.out.println(this.getClass()+"getUser");
		
		User user = new User();
		user = userService.getUser(userId);
		
		//view(jsp)로 데이터전송
		model.addAttribute("user", user);
		
		System.out.println("model ==>"+model);
		
		return "forward:/view/user/getUser.jsp";
		
	}// end of getUser
	
	
	@RequestMapping(value="getAdminQnAList", method=RequestMethod.GET)
	public String getAdminQnAList(@ModelAttribute("search") Search search, Model model, HttpSession session ) throws Exception {
		
		System.out.println(this.getClass()+"getAdminQnaList");
		
		User user = new User();
		
//		계정이 admin이 아닐경우 접속을 막기위해
		user= (User)session.getAttribute("user");
		if(!user.getRole().equals("A")) {
			return "redirect:/";
		}
		
		//현재 페이지가 null일 경우 디폴트 1로 유지
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//map에  getUserList 담기
		Map<String, Object> map = adminservice.getAdminQnAList(search);
		
		//페이지를 눌렀을때 결과페이지의 페이지값을 찾아오는 작업 
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
				pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println("map.get ==>"+map.get("list"));
		
		//view(jsp)로 데이터전송
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search",search);
		
		System.out.println("model ==>"+model);
		
		return "forward:/view/admin/adminQnaList.jsp";
		
	}// end of getUser
	
	
	@RequestMapping(value="getQnaComment", method=RequestMethod.GET)
	public String getQnaComment(@RequestParam("postId") String postId, Model model) throws Exception {
		
		System.out.println("AdminController getQnaComment");
		
		Map<String,Object> map = adminservice.getQnaCommentList(postId);
		
		model.addAttribute("list",map.get("list"));
		
		return "forward:/view/admin/adminQnaList.jsp";
	}
	
	@RequestMapping(value="getPostReportList", method=RequestMethod.GET)
	public String getPostReportList(@ModelAttribute("search") Search search, Model model, HttpSession session ) throws Exception {
		
		System.out.println(this.getClass()+"getPostReportList Strat");
		
		User user = new User();
		
//		계정이 admin이 아닐경우 접속을 막기위해
		user= (User)session.getAttribute("user");
		if(!user.getRole().equals("A")) {
			return "redirect:/";
		}
		
		//현재 페이지가 null일 경우 디폴트 1로 유지
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("이전@@");
				
		Map<String,Object> map = adminservice.getPostReportList(search);
		
		System.out.println("이후@@");
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
				pageUnit, pageSize);
		
		System.out.println(resultPage);
		System.out.println("map.get==>"+map.get("list"));
		
		//view(jsp)로 데이터전송
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search",search);
		model.addAttribute("report", "post");
		
		//디버깅
		System.out.println("model ==>"+model);
		
		return "forward:/view/admin/getReportList.jsp";
	}
	
	@RequestMapping(value="getCmtReportList", method=RequestMethod.GET)
	public String getCmtReportList(@ModelAttribute("search") Search search, Model model, HttpSession session ) throws Exception {
		
		System.out.println(this.getClass()+"getCmtReportList Strat");
		
		User user = new User();
		
//		계정이 admin이 아닐경우 접속을 막기위해
		user= (User)session.getAttribute("user");
		if(!user.getRole().equals("A")) {
			return "redirect:/";
		}
		
		//현재 페이지가 null일 경우 디폴트 1로 유지
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
				
		Map<String,Object> map = adminservice.getCommentReportList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
				pageUnit, pageSize);
		
		System.out.println(resultPage);
		System.out.println("map.get==>"+map.get("list"));
		
		//view(jsp)로 데이터전송
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search",search);
		model.addAttribute("report", "cmt");
		
		//디버깅
		System.out.println("model ==>"+model);
		
		return "forward:/view/admin/getReportList.jsp";
	}
	
//	@RequestMapping( value="getPost", method=RequestMethod.GET )
//	public String getPost( @RequestParam("postId") String postId, @RequestParam("boardName") String boardName, Model model, HttpSession session ) throws Exception {
//		
//		System.out.println("/community/getPost : GET");
//		
//		User user=(User)session.getAttribute("user");
//		
//		if(user == null) {
//			return "forward:/view/community/check.jsp";
//		}
//		Post post = communityService.getPost(postId, user.getUserId(), boardName);
//		
//		if( post == null ) {
//			model.addAttribute("delete", "delete");
//			
//			return "forward:/view/community/check.jsp";
//		}
//		List<Tag> tag = communityService.getTagList(postId);
//
//		User userProfile = userService.getUser(user.getUserId());
//		
//		model.addAttribute("user", userProfile);
//		model.addAttribute("post", post);
//		model.addAttribute("tag", tag);
//		
//		List<User> userList = new ArrayList<User>();
//		
//		if( boardName.equals("D") ) {
//			
//			if(user.getRole().equals("G")) {
//				return "forward:/view/community/check.jsp";
//			}
//			
//			List<Party> party = communityService.getParty(postId);
//		
//			for(int i=0; i<party.size(); i++) {
//				
//				User partyUser = userService.getUser(party.get(i).getPartyUserId());
//				List<TripSurvey> tripSurvey = myPageService.getTripSurveyList(party.get(i).getPartyUserId());
//				
//				List<String> tripStyle = new ArrayList<String>();
//				
//				for(int j=0; j<tripSurvey.size(); j++) {
//					
//					if(tripSurvey.get(j).getSurveyType().equals("T")) {
//						String surveyChoice = tripSurvey.get(j).getSurveyChoice();
//						tripStyle.add(surveyChoice);
//						partyUser.setTripStyle(tripStyle);
//					}
//				}
//				userList.add(partyUser);
//			}
//			System.out.println("userList : "+userList);
//			
//			model.addAttribute("userList", userList);
//			model.addAttribute("party", party);
//			
//			return "forward:/view/accompany/getAccFindPost.jsp";
//		}else if( boardName.equals("E") ) {
//			//플래너 게시물 가져오기
//			String planId = post.getPlanId();
//			
//			Plan plan = planService.getPlan( planId );
//			List<Daily> dailyList = planSubService.getDailyList(plan);		//dailyList
//			List<Stuff> stuffList = planSubService.getStuffList(planId);		//stuffList
//			List<Daily> budgetOverviewList = planSubService.getBudgetOverview(plan);
//			List<City> listCity = planSubService.getCityRouteList(planId);
//			List<Day> dayList = Util.cityListToDayList(listCity, plan.getStartDate() );
//			plan.setDayList(dayList);
//			plan.setCityList(listCity);
//			plan.setBudgetOverviewList(budgetOverviewList);
//			plan.setDailyList(dailyList);
//			plan.setStuffList(stuffList);
//			
//			/* FullCalendar addEvent 위한 JSON 만들기.. */
//			JSONArray cityArray = new JSONArray();
//			
//			for (City cityItem : listCity) {
//				JSONObject cityEvent = new JSONObject();
//
//				cityEvent.put("title", cityItem.getCityName());
//				cityEvent.put("start", cityItem.getStartDateStr());
//				cityEvent.put("end", cityItem.getEndDateStr());
//				cityEvent.put("textColor", "white");
//				if( cityItem.getCountry() != null ) {
//					if( cityItem.getCountry().equals("영국") ) {
//						cityEvent.put("color", "#F9A081");
//					}else if(cityItem.getCountry().equals("스위스") ) {
//						cityEvent.put("color", "#98E657");
//					}else if(cityItem.getCountry().equals("프랑스") ) {
//						cityEvent.put("color", "#8886F4");
//					}else if(cityItem.getCountry().equals("이탈리아") ) {
//						cityEvent.put("color", "#76A0F3");
//					}
//				}else {
//					cityEvent.put("color", "#51bec9");
//				}
//
//				cityArray.add(cityEvent);
//			}
//			
//			/* GoogleMap API를 위한 JSON 만들기.. */
//			JSONArray markerArray = new JSONArray();
//			for (City cityItem : listCity) {
//				JSONObject cityMarker = new JSONObject();
//				
//				JSONObject position = new JSONObject();
//				position.put("lat", Double.parseDouble( cityItem.getCityLat() ));
//				position.put("lng", Double.parseDouble( cityItem.getCityLng() ));
//				
//				cityMarker.put("position", position);
//				cityMarker.put("title", cityItem.getCityName());
//				
//				markerArray.add(cityMarker);
//			}
//			
//			plan.setPlanDday( Util.getDday(plan.getStartDate()));		//여행 D-Day
//			if( plan.getPlanTotalDays() != 0) {
//				plan.setEndDate( Util.getEndDate(plan.getStartDate(), plan.getPlanTotalDays()) );	//여행종료일자
//			}
//			
//			model.addAttribute("boardName", boardName);
//			model.addAttribute("plan", plan);
//			model.addAttribute("cityEventList", cityArray);
//			model.addAttribute("cityMarkerList", markerArray);
//			
//			return "forward:/view/community/getPlanPost.jsp";
//		}
//		return "forward:/view/community/getPost.jsp";
//	}
	
//	@RequestMapping(value="updatePostReport", method=RequestMethod.GET)
//	public String updatePostReport(@RequestParam("refId") String refId, Model model, HttpSession session ) throws Exception {
//		
//		System.out.println(this.getClass()+"updatePostReport Strat");
//		
//		adminservice.updatePostReport(refId);
//		
//		return "forward:/view/admin/getReportList.jsp";
//		
//	}
//	
//	@RequestMapping(value="updateCmtReport", method=RequestMethod.GET)
//	public String updateCmtReport(@RequestParam("refId") String refId, Model model, HttpSession session ) throws Exception {
//		
//		System.out.println(this.getClass()+"updateCmtReport Strat");
//		
//		adminservice.updateCommReport(refId);
//		
//		return "forward:/view/admin/getReportList.jsp";
//		
//	}
	
	
	
}//end of class
