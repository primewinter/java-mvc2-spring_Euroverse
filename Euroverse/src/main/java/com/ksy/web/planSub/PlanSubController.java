package com.ksy.web.planSub;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ksy.common.util.Util;
import com.ksy.service.domain.City;
import com.ksy.service.domain.Day;
import com.ksy.service.domain.Plan;
import com.ksy.service.plan.PlanService;
import com.ksy.service.planSub.PlanSubService;

@Controller
@RequestMapping("/planSub/*")
public class PlanSubController {

	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("planSubServiceImpl")
	private PlanSubService planSubService;
	
	public PlanSubController() {
		System.out.println(this.getClass());
	}
	
	
	
	
	@RequestMapping( value = "editRoute", method = RequestMethod.GET )
	public String editRoute (	@RequestParam("planId") String planId, Model model, HttpSession session	) throws Exception {
		
		Plan plan = planService.getPlan(planId);
		
		List<City> listCity = planSubService.getCityRouteList(planId);
		plan.setCityList(listCity);
		
		List<Day> dayList = Util.cityListToDayList(listCity, plan.getStartDate() );
		plan.setDayList(dayList);
		
		/* GoogleMap API를 위한 JSON 만들기.. */
		JSONArray markerArray = new JSONArray();
		for (City cityItem : listCity) {
			JSONObject cityMarker = new JSONObject();
			
			JSONObject position = new JSONObject();
			position.put("lat", Double.parseDouble( cityItem.getCityLat() ));
			position.put("lng", Double.parseDouble( cityItem.getCityLng() ));
			
			cityMarker.put("position", position);
			cityMarker.put("title", cityItem.getCityName());
			cityMarker.put("cityImg", cityItem.getCityImg());
			cityMarker.put("cityInfo", cityItem.getCityInfo());
			
			markerArray.add(cityMarker);
		}
		
		model.addAttribute("plan", plan);
		model.addAttribute("cityMarkerList", markerArray);
		
		return "forward:/view/plan/editRoute.jsp";
	}
	
	
//	@RequestMapping( value = "editRoute", method = RequestMethod.POST )
//	public String editRoute (	@RequestParam("planId") String planId, Model model	) throws Exception {
//	
//		Plan plan = planService.getPlan(planId);
//		List<City> cityRouteList = planSubService.getCityRouteList(planId);
//		
//		model.addAttribute("plan", plan);
//		model.addAttribute("cityRouteList", cityRouteList);
//		
//		return "forward:/planSub/editRoute.jsp";
//	}
	
//	@RequestMapping( value = "getBudgetList", method = RequestMethod.POST )
//	public String getBudgetList (	@RequestParam("planId") String planId, Model model	) throws Exception {
//	
//		List<Daily> budgetList = planSubService.getBudgetList(planId);
//		model.addAttribute("budgetList", budgetList);
//		
//		return "forward:/plan/getBudgetList.jsp";
//	}
	
}
