package com.ksy.web.main;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

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
import com.ksy.service.domain.Push;
import com.ksy.service.domain.Stuff;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.domain.User;
import com.ksy.service.like.LikeService;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;
import com.ksy.service.push.PushService;
import com.ksy.service.user.UserService;

@RestController
@RequestMapping("/main/json/*")
public class MainRestController {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService; 
	
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
	
	@Autowired
	@Qualifier("pushServiceImpl")
	private PushService pushService;
	
	public MainRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;

	@RequestMapping(value="getBestList", method = RequestMethod.GET)
	public Map<String, Object> getBestList( String boardName, Search search, HttpServletRequest request ) throws Exception{
		
		System.out.println("main/json/getBestList : GET");
		System.out.println("boardName : "+boardName);
		
		String bestPost = request.getParameter("bestPost");
		System.out.println(bestPost);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		if( search.getSorting() == null ) {
			search.setSorting("0");
		}
		Map<String , Object> map = new HashMap<String, Object>();
		System.out.println("베스트리스트 가져오기!!" +search +"||"+boardName);
		map = communityService.getBestPostList(search, boardName);
		System.out.println("베스트리스트 가져오기 성공!!!!");
		
		List<Post> list = (List<Post>)map.get("list");
		List<Post> newList = new ArrayList<>();
		Map<String, Object> planMap = new HashMap<>();
		Map<String, Object> result = new HashMap<>();
		
		for(Post post : list ) {
			if( post != null ) {
				System.out.println("\t\t\tpost ::: "+post);
			if( post.getBoardName().equals("D") ) {
//				
//				List<Party> party = communityService.getParty(post.getPostId());
//			
//				for(int i=0; i<party.size(); i++) {
//					
//					User partyUser = userService.getUser(party.get(i).getPartyUserId());
//					List<TripSurvey> tripSurvey = myPageService.getTripSurveyList(party.get(i).getPartyUserId());
//					
//					List<String> tripStyle = new ArrayList<String>();
//					
//					for(int j=0; j<tripSurvey.size(); j++) {
//						
//						if(tripSurvey.get(j).getSurveyType().equals("T")) {
//							String surveyChoice = tripSurvey.get(j).getSurveyChoice();
//							tripStyle.add(surveyChoice);
//							partyUser.setTripStyle(tripStyle);
//						}
//					}
//					userList.add(partyUser);
//				}
//				System.out.println("userList : "+userList);
//				
//				model.addAttribute("userList", userList);
//				model.addAttribute("party", party);
				
			}else if(  post.getBoardName().equals("E") ) {
				//플래너 게시물 가져오기
//				String planId = post.getPlanId();
//				
//				Plan plan = planService.getPlan( planId );
//				List<Daily> dailyList = planSubService.getDailyList(planId);		//dailyList
//				List<Stuff> stuffList = planSubService.getStuffList(planId);		//stuffList
//				List<Daily> budgetOverviewList = planSubService.getBudgetOverview(planId);
//				List<City> listCity = planSubService.getCityRouteList(planId);
//				List<Day> dayList = Util.cityListToDayList(listCity, plan.getStartDate() );
//				plan.setDayList(dayList);
//				plan.setCityList(listCity);
//				plan.setBudgetOverviewList(budgetOverviewList);
//				plan.setDailyList(dailyList);
//				plan.setStuffList(stuffList);
//				
//				/* FullCalendar addEvent 위한 JSON 만들기.. */
//				JSONArray cityArray = new JSONArray();
//				
//				for (City cityItem : listCity) {
//					JSONObject cityEvent = new JSONObject();
//
//					cityEvent.put("title", cityItem.getCityName());
//					cityEvent.put("start", cityItem.getStartDateStr());
//					cityEvent.put("end", cityItem.getEndDateStr());
//					cityEvent.put("textColor", "white");
//					if( cityItem.getCountry() != null ) {
//						if( cityItem.getCountry().equals("영국") ) {
//							cityEvent.put("color", "#F9A081");
//						}else if(cityItem.getCountry().equals("스위스") ) {
//							cityEvent.put("color", "#98E657");
//						}else if(cityItem.getCountry().equals("프랑스") ) {
//							cityEvent.put("color", "#8886F4");
//						}else if(cityItem.getCountry().equals("이탈리아") ) {
//							cityEvent.put("color", "#76A0F3");
//						}
//					}else {
//						cityEvent.put("color", "#51bec9");
//					}
//
//					cityArray.add(cityEvent);
//				}
//				
//				/* GoogleMap API를 위한 JSON 만들기.. */
//				JSONArray markerArray = new JSONArray();
//				for (City cityItem : listCity) {
//					JSONObject cityMarker = new JSONObject();
//					
//					JSONObject position = new JSONObject();
//					position.put("lat", Double.parseDouble( cityItem.getCityLat() ));
//					position.put("lng", Double.parseDouble( cityItem.getCityLng() ));
//					
//					cityMarker.put("position", position);
//					cityMarker.put("title", cityItem.getCityName());
//					
//					markerArray.add(cityMarker);
//				}
//				
//				
//				plan.setPlanDday( Util.getDday(plan.getStartDate()));		//여행 D-Day
//				if( plan.getPlanTotalDays() != 0) {
//					plan.setEndDate( Util.getEndDate(plan.getStartDate(), plan.getPlanTotalDays()) );	//여행종료일자
//				}
//				
//				planMap.put("plan", plan);
//				planMap.put("cityEventList", cityArray);
//				planMap.put("cityMarkerList", markerArray);
//				result.put("planList",planMap);
			} else {
				Post p = communityService.getPost(post.getPostId(), post.getPostWriterId(), post.getBoardName());
				newList.add(p);
				System.out.println("베스트 목록에 담은 글 :: "+p);
			}
		}
		}
		
		result.put("list", newList);
		
		
//		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
//		System.out.println(resultPage);
//		
//		map.put("resultPage", resultPage);
//		map.put("search", search);
//		map.put("boardName", boardName);
		
		return result;
	}
	
	
	@RequestMapping(value="getRecentList", method = RequestMethod.GET)
	public List<Post> getRecentList( String boardName, Search search) throws Exception{
		
		System.out.println("main/json/getBestList : GET boardName : "+boardName);
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(12);
		if( search.getSorting() == null ) {
			search.setSorting("0");
		}
		
		Map<String , Object> map = new HashMap<String, Object>();
		System.out.println("최신글 가져오기!!" +search +"||"+boardName);
		map = communityService.getPostList(search, boardName);
		System.out.println("최신글 가져오기 성공!!!!");
		
		List<Post> list = (List<Post>)map.get("list");
		List<Post> newList = new ArrayList<>();
		
		for(Post post : list ) {
			Post p = communityService.getMainPost(post.getPostId(), post.getPostWriterId(), boardName);
			p.setUser(userService.getUser(p.getPostWriterId()));
			newList.add(p);
			System.out.println("최신글에 담은 글 :: "+p);
		}
		
		return newList;
	}
	
	@RequestMapping(value="getMainPlanner", method = RequestMethod.GET)
	public Map<String, Object> getMainPlanner( String boardName, Search search) throws Exception {
		System.out.println("/community/getMainPlanner : GET");
		System.out.println("메인 플래너 boardName : "+boardName);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(12);
		
		Map<String , Object> map = new HashMap<String, Object>();
		
		map = communityService.getPostList(search, boardName);
		
		
		Map<String, Object> returnMap = new HashMap<>();
		
		
		List<Post> postList = (List<Post>)map.get("list");
		List<Plan> planList = new ArrayList<Plan>();
		
		for(int i=0; i<postList.size(); i++) {
			Plan plan = planService.getPlan(postList.get(i).getPlanId());
			postList.get(i).setUser(userService.getUser(postList.get(i).getPostWriterId()));
			//planList.add(plan);
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
			
			
		}

		returnMap.put("list", map.get("list"));
		returnMap.put("planList", planList);
		
		return returnMap;
		
	}
	
}
