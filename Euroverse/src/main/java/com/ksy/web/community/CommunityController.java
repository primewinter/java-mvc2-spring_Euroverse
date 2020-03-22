package com.ksy.web.community;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.common.util.Util;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.City;
import com.ksy.service.domain.Daily;
import com.ksy.service.domain.Day;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Stuff;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;
import com.ksy.service.user.UserService;
import com.ksy.service.domain.Tag;
import com.ksy.service.domain.TripSurvey;

@Controller
@RequestMapping("/community/*")
public class CommunityController {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("myPageServiceImpl")
	private MyPageService myPageService;
	
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("planSubServiceImpl")
	private PlanSubService planSubService;
	
	
	public CommunityController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;

	@Scheduled(cron="0 0 10 * * ?") 
	public void dayBest() throws Exception {

		Calendar calendar = Calendar.getInstance();
	
		communityService.dayBestReset();
		 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
		System.out.println("일간 인기글 초기화 : "+dateFormat.format(calendar.getTime()));
	}
	
	@Scheduled(cron="0 0 10 ? * MON") 
	public void weekBest() throws Exception {

		Calendar calendar = Calendar.getInstance();
	
		communityService.weekBestReset();
		 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
		System.out.println("주간 인기글 초기화 : "+dateFormat.format(calendar.getTime()));
	}
	
	@Scheduled(cron="0 0 10 1 * ?") 
	public void monthBest() throws Exception {

		Calendar calendar = Calendar.getInstance();
		 
		communityService.monthBestReset();
	
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
		System.out.println("월간 인기글 초기화 : "+dateFormat.format(calendar.getTime()));
	}

	@RequestMapping( value="addPost", method=RequestMethod.GET )
	public String addPost( @RequestParam("boardName") String boardName, @RequestParam(required=false) String planId, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/addPost : GET");
		
		User user = (User)session.getAttribute("user");
		if( user == null) {
			return "forward:/view/community/check.jsp";
		}
		
		if( boardName.equals("D") ) {
			
			if(user.getRole().equals("G")) {
				model.addAttribute("addAcc","addAcc");
				return "forward:/view/community/check.jsp";
			}
			return "forward:/view/accompany/addFindAccPostView.jsp";

		}else if( boardName.equals("E") ) {	//플래너 게시할거임
			
			List<Plan> listPlan = planService.getPlanList(user.getUserId());
			
			model.addAttribute("planList", listPlan);
			model.addAttribute("planId", planId);
			
			return "forward:/view/community/addPlanPostView.jsp";
		}
		return "forward:/view/community/addPostView.jsp";
	}
	
	@RequestMapping( value="addPost", method=RequestMethod.POST )
	public String addPost( @ModelAttribute Post post, @RequestParam("tagContent") String[] tagContent, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/addPost : POST");
	
		User user = (User)session.getAttribute("user");
		post.setPostWriterId(user.getUserId());
		post.setNickName(user.getNickname());
		
		if(post.getPostGrade() == null) {
			post.setPostGrade("B");
		}
		
		//플래너 아이디 있으면 카피해서 새로 세팅 (플래너 게시)
		if( post.getPlanId() != null || post.getPlanId()=="" ) {
			
			String originPlanId = post.getPlanId();
			
			Plan copyPlan = new Plan();
			copyPlan.setPlanId(originPlanId);
			//copyPlan.setPlanMaster(user);
			
			String copiedPlanId = planService.copyPlan(copyPlan);	//plan에 planId만 담겨서 감!
			
			post.setPlanId(copiedPlanId);
		}
		System.out.println(post.getPostDate());
		communityService.addPost(post);
		
		post = communityService.getPost(post.getPostId(), user.getUserId(),post.getBoardName());

		List<Tag> tags = new ArrayList<Tag>();
	
		for(int i=0; i<tagContent.length; i++) {
			Tag tag = new Tag();
			communityService.addTag(tagContent[i], post.getPostId());
			tag.setTagContent(tagContent[i]);
			tags.add(tag);
		}

		model.addAttribute("post", post);
		model.addAttribute("tag", tags);
		
		List<User> userList = new ArrayList<User>();
		
		if( post.getBoardName().equals("D") ) {
			
			if(user.getRole().equals("G")) {
				return "forward:/view/community/check.jsp";
			}
			
			List<Party> party = communityService.getParty(post.getPostId());
		
			for(int i=0; i<party.size(); i++) {
				
				User partyUser = userService.getUser(party.get(i).getPartyUserId());
				List<TripSurvey> tripSurvey = myPageService.getTripSurveyList(party.get(i).getPartyUserId());
				
				List<String> tripStyle = new ArrayList<String>();
				
				for(int j=0; j<tripSurvey.size(); j++) {
					
					if(tripSurvey.get(j).getSurveyType().equals("T")) {
						String surveyChoice = tripSurvey.get(j).getSurveyChoice();
						tripStyle.add(surveyChoice);
						partyUser.setTripStyle(tripStyle);
					}
				}
				userList.add(partyUser);
			}
			System.out.println("userList : "+userList);
			
			model.addAttribute("userList", userList);
			model.addAttribute("party", party);
			
			return "forward:/view/accompany/getAccFindPost.jsp";
		}
		
		if( post.getPlanId() != null || post.getPlanId()=="" ) {
			
			Plan copiedPlan = planService.getPlan(post.getPlanId());
			
			List<Daily> dailyList = planSubService.getDailyList(copiedPlan);		//dailyList
			List<Stuff> stuffList = planSubService.getStuffList(copiedPlan.getPlanId());		//stuffList
			List<Daily> budgetOverviewList = planSubService.getBudgetOverview(copiedPlan);
			List<City> listCity = planSubService.getCityRouteList(copiedPlan.getPlanId());
			List<Day> dayList = Util.cityListToDayList(listCity, copiedPlan.getStartDate() );
			
			copiedPlan.setDailyList(dailyList);
			copiedPlan.setStuffList(stuffList);
			copiedPlan.setBudgetOverviewList(budgetOverviewList);
			copiedPlan.setCityList(listCity);
			copiedPlan.setDayList(dayList);
			
			model.addAttribute("plan", copiedPlan );
			
			
			/* FullCalendar addEvent 위한 JSON 만들기.. */
			JSONArray cityArray = new JSONArray();
			
			for (City cityItem : listCity) {
				JSONObject cityEvent = new JSONObject();

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
			
			model.addAttribute("cityEventList", cityArray);
			model.addAttribute("cityMarkerList", markerArray);
			
			
			return "forward:/view/community/getPlanPost.jsp";
		}
		
		return "forward:/view/community/getPost.jsp";
	}
	
	@RequestMapping( value="updatePost", method=RequestMethod.GET )
	public String updatePost( @RequestParam("postId") String postId, @RequestParam("boardName") String boardName, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/updatePost : GET");
		
		User user=(User)session.getAttribute("user");
		
		Post post = communityService.getPost(postId, user.getUserId(), boardName);
		List<Tag> tag = communityService.getTagList(postId);
		
		model.addAttribute("post", post);
		model.addAttribute("tag", tag);
		
		communityService.deleteTag(postId);
	
		return "forward:/view/community/updatePostView.jsp";
	}
	
	@RequestMapping( value="updatePost", method=RequestMethod.POST )
	public String updatePost( @ModelAttribute Post post, @RequestParam("tagContent") String[] tagContent, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/updatePost : POST");
		User user=(User)session.getAttribute("user");
		
		communityService.updatePost(post);
		
		System.out.println("/community/updateTag : POST");
		for(int i = 0; i < tagContent.length; i++) {
			communityService.addTag(tagContent[i], post.getPostId());
		}
	
		post = communityService.getPost(post.getPostId(), user.getUserId(), post.getBoardName());
		List<Tag> tag = communityService.getTagList(post.getPostId());
		
		model.addAttribute("post", post);
		model.addAttribute("tag", tag);
		
		List<User> userList = new ArrayList<User>();
		
		if( post.getBoardName().equals("D") ) {
			
			if(user.getRole().equals("G")) {
				return "forward:/view/community/check.jsp";
			}
			
			List<Party> party = communityService.getParty(post.getPostId());
		
			for(int i=0; i<party.size(); i++) {
				
				User partyUser = userService.getUser(party.get(i).getPartyUserId());
				List<TripSurvey> tripSurvey = myPageService.getTripSurveyList(party.get(i).getPartyUserId());
				
				List<String> tripStyle = new ArrayList<String>();
				
				for(int j=0; j<tripSurvey.size(); j++) {
					
					if(tripSurvey.get(j).getSurveyType().equals("T")) {
						String surveyChoice = tripSurvey.get(j).getSurveyChoice();
						tripStyle.add(surveyChoice);
						partyUser.setTripStyle(tripStyle);
					}
				}
				userList.add(partyUser);
			}
			System.out.println("userList : "+userList);
			
			model.addAttribute("userList", userList);
			model.addAttribute("party", party);
			
			return "forward:/view/accompany/getAccFindPost.jsp";
		}
		
		if( post.getPlanId() != null || post.getPlanId()=="" ) {
			
			Plan copiedPlan = planService.getPlan(post.getPlanId());
			
			List<Daily> dailyList = planSubService.getDailyList(copiedPlan);		//dailyList
			List<Stuff> stuffList = planSubService.getStuffList(copiedPlan.getPlanId());		//stuffList
			List<Daily> budgetOverviewList = planSubService.getBudgetOverview(copiedPlan);
			List<City> listCity = planSubService.getCityRouteList(copiedPlan.getPlanId());
			List<Day> dayList = Util.cityListToDayList(listCity, copiedPlan.getStartDate() );
			
			copiedPlan.setDailyList(dailyList);
			copiedPlan.setStuffList(stuffList);
			copiedPlan.setBudgetOverviewList(budgetOverviewList);
			copiedPlan.setCityList(listCity);
			copiedPlan.setDayList(dayList);
			
			model.addAttribute("plan", copiedPlan );
			
			
			/* FullCalendar addEvent 위한 JSON 만들기.. */
			JSONArray cityArray = new JSONArray();
			
			for (City cityItem : listCity) {
				JSONObject cityEvent = new JSONObject();

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
			
			model.addAttribute("cityEventList", cityArray);
			model.addAttribute("cityMarkerList", markerArray);
			
			
			return "forward:/view/community/getPlanPost.jsp";
		}
		
		return "forward:/view/community/getPost.jsp";
	}
	
	@RequestMapping( value="getPost", method=RequestMethod.GET )
	public String getPost( @RequestParam("postId") String postId, @RequestParam("boardName") String boardName, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/getPost : GET");
		
		User user=(User)session.getAttribute("user");
		
		if(user == null) {
			return "forward:/view/community/check.jsp";
		}
		Post post = communityService.getPost(postId, user.getUserId(), boardName);
		
		if( post == null ) {
			model.addAttribute("delete", "delete");
			
			return "forward:/view/community/check.jsp";
		}
		List<Tag> tag = communityService.getTagList(postId);

		User userProfile = userService.getUser(user.getUserId());
		
		model.addAttribute("user", userProfile);
		model.addAttribute("post", post);
		model.addAttribute("tag", tag);
		
		List<User> userList = new ArrayList<User>();
		
		if( boardName.equals("D") ) {
			
			if(user.getRole().equals("G")) {
				return "forward:/view/community/check.jsp";
			}
			
			List<Party> party = communityService.getParty(postId);
		
			for(int i=0; i<party.size(); i++) {
				
				User partyUser = userService.getUser(party.get(i).getPartyUserId());
				List<TripSurvey> tripSurvey = myPageService.getTripSurveyList(party.get(i).getPartyUserId());
				
				List<String> tripStyle = new ArrayList<String>();
				
				for(int j=0; j<tripSurvey.size(); j++) {
					
					if(tripSurvey.get(j).getSurveyType().equals("T")) {
						String surveyChoice = tripSurvey.get(j).getSurveyChoice();
						tripStyle.add(surveyChoice);
						partyUser.setTripStyle(tripStyle);
					}
				}
				userList.add(partyUser);
			}
			System.out.println("userList : "+userList);
			
			model.addAttribute("userList", userList);
			model.addAttribute("party", party);
			
			return "forward:/view/accompany/getAccFindPost.jsp";
		}else if( boardName.equals("E") ) {
			//플래너 게시물 가져오기
			String planId = post.getPlanId();
			
			Plan plan = planService.getPlan( planId );
			List<Daily> dailyList = planSubService.getDailyList(plan);		//dailyList
			List<Stuff> stuffList = planSubService.getStuffList(planId);		//stuffList
			List<Daily> budgetOverviewList = planSubService.getBudgetOverview(plan);
			List<City> listCity = planSubService.getCityRouteList(planId);
			List<Day> dayList = Util.cityListToDayList(listCity, plan.getStartDate() );
			plan.setDayList(dayList);
			plan.setCityList(listCity);
			plan.setBudgetOverviewList(budgetOverviewList);
			plan.setDailyList(dailyList);
			plan.setStuffList(stuffList);
			
			/* FullCalendar addEvent 위한 JSON 만들기.. */
			JSONArray cityArray = new JSONArray();
			
			for (City cityItem : listCity) {
				JSONObject cityEvent = new JSONObject();

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
			
			model.addAttribute("boardName", boardName);
			model.addAttribute("plan", plan);
			model.addAttribute("cityEventList", cityArray);
			model.addAttribute("cityMarkerList", markerArray);
			
			return "forward:/view/community/getPlanPost.jsp";
		}
		return "forward:/view/community/getPost.jsp";
	}
	
	@RequestMapping( value="getAllPostList" )
	public String getAllPostList( @ModelAttribute("search") Search search, Model model ) throws Exception {
		
		System.out.println("/community/getAllPostList : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map = communityService.getAllPostList(search);
		List<Post> list = (List<Post>)map.get("list");
		for(Post post : list ) {
			post.setUser(userService.getUser(post.getPostWriterId()));
			List<Tag> tag = communityService.getTagList(post.getPostId());
			post.setTagList(tag);
		}
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/view/community/getAllPostList.jsp";
	}
	
	@RequestMapping( value="getPostList" )
	public String getPostList( @RequestParam("boardName") String boardName, @ModelAttribute("search") Search search, Model model, HttpServletRequest request ) throws Exception{
		
		System.out.println("/community/getPostList : GET / POST");
		System.out.println("boardName : "+boardName);
		
		String bestPost = request.getParameter("bestPost");
		System.out.println(bestPost);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map = new HashMap<String, Object>();
		
		if( boardName.equals("C") ) {
			if( search.getSorting() == null ) {
				search.setSorting("0");
			}
			map = communityService.getBestPostList(search, boardName);
			List<Post> list = (List<Post>)map.get("list");
			for(Post post : list ) {
				post.setUser(userService.getUser(post.getPostWriterId()));
			}
		}else if ( boardName.equals("F")) {
			map = communityService.getPostList(search, boardName);
			List<Post> list = (List<Post>)map.get("list");
			for(Post post : list ) {
				System.out.println("첫번째 포스트 : "+post);
				post.setUser(userService.getUser(post.getPostWriterId()));
				Post contentPost = communityService.getMainPost(post.getPostId(), post.getPostWriterId(), boardName);
				List<Tag> tag = communityService.getTagList(post.getPostId());
				post.setTagList(tag);
				String content = contentPost.getPostContent();
				
				if (content.contains("<img")) {
	                int startInt = content.indexOf("img");
	                int endInt = content.indexOf(">", startInt);
	                String result = content.substring(startInt - 1, endInt + 1);
	                post.setImgSrc(result);
	            } else {
	                post.setImgSrc("<img src='/resources/images/commImg/default_trip_img.jpeg'>");
	            }
			
			}
		} else {
			map = communityService.getPostList(search, boardName);
			List<Post> list = (List<Post>)map.get("list");
			for(Post post : list ) {
				post.setUser(userService.getUser(post.getPostWriterId()));
			}
		}
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("boardName", boardName);
		
		if( boardName.equals("C") ) {
			return "forward:/view/community/getBestPostList.jsp";
		}else if( boardName.equals("E") ) {
			
			List<Post> postList = (List<Post>)map.get("list");
			for(Post post : postList ) {
				post.setUser(userService.getUser(post.getPostWriterId()));
			}
			List<Plan> planList = new ArrayList<Plan>();
			
			for(int i=0; i<postList.size(); i++) {
			Plan plan = planService.getPlan(postList.get(i).getPlanId());
			
			List<City> listCity = planSubService.getCityRouteList(plan.getPlanId());
			plan.setCityList(listCity);
			
			String planImgString = "https://maps.googleapis.com/maps/api/staticmap?size=250x220&mobile=true&visible=43,7";
			planImgString = planImgString + "&path=color:black|weight:1";
			
			for(City cityItem : listCity) {
				planImgString = planImgString + "|" + cityItem.getCityLat() +","+ cityItem.getCityLng();
			} //50.112,8.684|48.861,2.342|45.112,3.684
			
			for(City cityItem : listCity) {
				planImgString = planImgString + "&markers=size:tiny%7Ccolor:red|" + cityItem.getCityLat() +","+ cityItem.getCityLng();
			}
			
			planImgString = planImgString + "&key=AIzaSyCMoE1_1g-id6crD_2M4nCDF4IsmcncLU4&format=png&maptype=roadmap";
			planImgString = planImgString + "&style=element:geometry%7Ccolor:0xebe3cd&style=element:labels.text.fill%7Ccolor:0x79524f&style=element:labels.text.stroke%7Ccolor:0xf5f1e6&style=feature:administrative%7Celement:geometry.stroke%7Ccolor:0xc9b2a6&style=feature:administrative.land_parcel%7Celement:geometry.stroke%7Ccolor:0xdcd2be&style=feature:administrative.land_parcel%7Celement:labels%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xae9e90&style=feature:landscape.natural%7Celement:geometry%7Ccolor:0xfcf9f5&style=feature:poi%7Celement:geometry%7Ccolor:0xe7dec2&style=feature:poi%7Celement:labels.text%7Cvisibility:off&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x93817c&style=feature:poi.business%7Cvisibility:off&style=feature:poi.park%7Celement:geometry.fill%7Ccolor:0xe8edde&style=feature:poi.park%7Celement:labels.text%7Cvisibility:off&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x447530&style=feature:road%7Cvisibility:off&style=feature:road%7Celement:geometry%7Ccolor:0xf5f1e6&style=feature:road.arterial%7Celement:geometry%7Ccolor:0xfdfcf8&style=feature:road.highway%7Celement:geometry%7Ccolor:0xf8c967&style=feature:road.highway%7Celement:geometry.stroke%7Ccolor:0xe9bc62&style=feature:road.highway.controlled_access%7Celement:geometry%7Ccolor:0xe98d58&style=feature:road.highway.controlled_access%7Celement:geometry.stroke%7Ccolor:0xdb8555&style=feature:road.local%7Celement:labels%7Cvisibility:off&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x806b63&style=feature:transit.line%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:transit.line%7Celement:labels.text.fill%7Ccolor:0xa0938b&style=feature:transit.line%7Celement:labels.text.stroke%7Ccolor:0xebe3cd&style=feature:transit.station%7Celement:geometry%7Ccolor:0xdfd2ae&style=feature:water%7Celement:geometry.fill%7Ccolor:0xdaedec&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x83a39e";
			
			plan.setPlanImg(planImgString);
			
			planList.add(plan);
			
			model.addAttribute("boardName", boardName);
			model.addAttribute("plan", planList);
			}
			return "forward:/view/community/getPlanPostList.jsp";
		}else if( boardName.equals("F") ) {
			return "forward:/view/community/getReviewPostList.jsp";
		}else if( boardName.equals("D") ) {
			return "forward:/view/accompany/accMain.jsp";
		} else {
			return "forward:/view/community/getPostList.jsp";
		}
	}
	
	@RequestMapping( value="deletePost", method=RequestMethod.GET)
	public String deletePost( @RequestParam("postId") String postId, @RequestParam("boardName") String boardName) throws Exception {
		
		System.out.println("/community/deletePost : GET");
		
		communityService.deletePost(postId);
		
		return "redirect:/community/getPostList?boardName="+boardName;
	}
	
	@RequestMapping( value="deletePartyUser", method=RequestMethod.GET)
	public String deletePartyUser( @RequestParam("partyId") String partyId, @RequestParam("postId") String postId, HttpSession session ) throws Exception {
		
		System.out.println("/community/deletePartyUser : GET");
	
		communityService.deletePartyUser(partyId);
		
		return "redirect:/community/getPost?postId="+postId+"&boardName=D";
	}
	
	@RequestMapping( value="getMyPartyList" )
	public String getMyPartyList( Model model, HttpSession session ) throws Exception {
		
		System.out.println("/community/getMyPartyList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			return "forward:/view/community/check.jsp";
		}
		List<User> userList = new ArrayList<User>();
		List<Party> myPartyList = communityService.getMyPartyList(user.getUserId()); //회원이 참여중인 파티들 리스트
		List<List> listMap = new ArrayList<List>();
		
		for(int i=0; i<myPartyList.size(); i++) {
			List<Party> partyList = communityService.getParty(myPartyList.get(i).getRefId()); //회원이 참여중인 파티의 postId 가져와서 파티 참여 회원들 목록 가져오기
			listMap.add(partyList);
			
			for(int j=0; j<partyList.size(); j++) {
				User partyUser = userService.getUser(partyList.get(j).getPartyUserId());
				
				List<TripSurvey> tripSurvey = myPageService.getTripSurveyList(partyList.get(j).getPartyUserId());
				
				List<String> tripStyle = new ArrayList<String>();
				
				for(int s=0; s<tripSurvey.size(); s++) {
					
					if(tripSurvey.get(s).getSurveyType().equals("T")) {
						String surveyChoice = tripSurvey.get(s).getSurveyChoice();
						tripStyle.add(surveyChoice);
						partyUser.setTripStyle(tripStyle);
					}
				}
				
				for(int k=0; k<userList.size(); k++) {
					if(userList.get(k).getUserId().equals(partyList.get(j).getPartyUserId())) {
						userList.remove(k);
					}
				}
				userList.add(partyUser);
			}
		}
		model.addAttribute("list", listMap);
		model.addAttribute("userList", userList);
		
		return "forward:/view/accompany/getMyPartyList.jsp";
	}
	
	@RequestMapping( value="getMyOfferList" )
	public String getMyOfferList( @ModelAttribute("search") Search search, HttpSession session, Model model ) throws Exception {
		
		System.out.println("/community/getMyOfferList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user == null) {
			return "forward:/view/community/check.jsp";
		}
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = communityService.getMyOfferList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return "forward:/view/accompany/getMyOfferList.jsp";
	}
	
	@RequestMapping( value="deleteOffer", method=RequestMethod.GET )
	public String deleteOffer( @RequestParam("offerId")String offerId, HttpSession session )throws Exception{
		
		System.out.println("/community/deleteOffer : GET");
		
		communityService.deleteOffer(offerId);
		
		return "redirect:/community/getMyOfferList";
	}
}