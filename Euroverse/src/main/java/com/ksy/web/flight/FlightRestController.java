package com.ksy.web.flight;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.User;
import com.ksy.service.flight.FlightService;
import com.ksy.service.like.LikeService;

@RestController
@RequestMapping("/flight/*")
public class FlightRestController {

	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService; 
	
	@Autowired
	@Qualifier("flightServiceImpl")
	private FlightService flightService;
	
	public FlightRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;

	
	
	@RequestMapping(value="/json/like/{cmtId}", method=RequestMethod.GET )
	public void like(@PathVariable String cmtId, HttpSession session, HttpServletResponse response ) throws Exception {
	  
		System.out.println("/community/json/like : GET");
		System.out.println(cmtId);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		 
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(cmtId);
	    like.setLikeType("C");
	    
	    if(likeService.countByLike(like)==0){
	    	likeService.addLike(like);
	    }
	    like=likeService.getLike(like);
	   
		Comment comment = communityService.getComment(cmtId);
		
		int cmtLikeCount = comment.getCmtLikeCount(); //게시판의 좋아요 카운트
		String likeCheck = like.getLikeCheck(); //좋아요 체크 값
		System.out.println("sdfdfsfsf"+likeCheck);
		List<String> msgs = new ArrayList<String>();
		System.out.println("들어가기전 댓글추천수 : "+cmtLikeCount);
		if(likeCheck.equals("F")) {
		  msgs.add("좋아요!");
		  likeService.like_check(like);
		  likeCheck="T";
		  cmtLikeCount++;
		  System.out.println("들어간 후 댓글 추천수 : "+cmtLikeCount);
		  communityService.updateLike(cmtId);   //좋아요 갯수 증가
		}else{
		  msgs.add("좋아요 취소");
		  likeService.like_check_cancel(like);
		  likeCheck="F";
		  cmtLikeCount--;
		  System.out.println("들어간 후 댓글 추천수 : "+cmtLikeCount);
		  communityService.updateUnlike(cmtId);   //좋아요 갯수 감소
		}
		JSONObject obj = new JSONObject();
		obj.put("cmtId", like.getRefId());
		obj.put("likeCheck", likeCheck);
		obj.put("cmtLikeCount", cmtLikeCount);
		obj.put("msg", msgs);
		
		out.println(obj);
	}
	
	@RequestMapping(value="/json/addFlight",  method=RequestMethod.POST )
	public void addFlight(@RequestBody Map jsonMap ,Flight flight , HttpSession session, HttpServletResponse response 
			) throws Exception {
	  
		System.out.println("/flight/json/addFlight : POST");
		response.setContentType("text/html;charset=utf-8");
		
		ObjectMapper objMap = new ObjectMapper();
		String mapString = objMap.writeValueAsString(jsonMap);
		JSONObject jsonObj = (JSONObject)JSONValue.parse(mapString);
		
		Map<String, String> checkMap = objMap.readValue(jsonObj.toString(), new TypeReference<Map<String, String>>(){});
		
		System.out.println("check : "+checkMap);
		//flight.setFlightId(checkMap.get("flightId"));
		System.out.println("value : "+checkMap.get("flightId"));
		flight.setAirline(checkMap.get("airline").trim());
		flight.setPrice(Integer.parseInt(checkMap.get("price")));
		flight.setTripCourse(checkMap.get("tripCourse"));
		flight.setDepCity(checkMap.get("depCity"));
		flight.setDepDate(checkMap.get("depDate"));
		flight.setDepTime(checkMap.get("depTime").trim());
		flight.setArrCity(checkMap.get("arrCity"));
		flight.setArrDate(checkMap.get("arrDate"));
		flight.setArrTime(checkMap.get("arrTime").trim());
		flight.setSeatGrade(checkMap.get("seatGrade"));
		flight.setAdultNum(Integer.parseInt(checkMap.get("adultNum")));
		flight.setChildNum(Integer.parseInt(checkMap.get("childNum")));
		flight.setInfantNum(Integer.parseInt(checkMap.get("infantNum")));
		flight.setLeadTime(checkMap.get("leadTime"));
		flight.setStopOver(checkMap.get("stopOver"));
		
		PrintWriter out = response.getWriter();
		 
		flightService.addFlight(flight);
		
		Like like = new Like(); 
		User user=(User)session.getAttribute("user");
		like.setLikeUserId(user.getUserId()); 
		like.setLikeType("F");
		System.out.println("플라이트아이디 : "+checkMap.get("flightId"));
		if (checkMap.get("flightId").equals("T") && flight.getFlightId() == null) { //원래 flight.getFlightId() 였음...
			likeService.addLike(like);
			like=likeService.getLike(like);
		}else {
			like.setRefId(checkMap.get("flightId"));
			like=likeService.getLike(like);
		}
	    System.out.println("악 : "+like.getRefId());
//	    if(likeService.countByLike(like)==0){
//			likeService.addLike(like); 
//		}
//	    like=likeService.getLike(like);
//		  
	    String likeCheck = like.getLikeCheck(); //좋아요 체크 값
	    List<String> msgs = new ArrayList<String>();
		  
	    if(likeCheck.equals("F")) { 
		    msgs.add("북마크에 추가되었습니다.");
		    likeService.like_check(like); 
		    likeCheck="T"; 
	    }else{
		    msgs.add("북마크 취소!");
		    likeService.like_check_cancel(like); 
		    likeCheck="F";
	    }
		 
	    
		JSONObject obj = new JSONObject();
		obj.put("refId", like.getRefId());
		obj.put("likeCheck", likeCheck);
		obj.put("msg", msgs);
		
		out.println(obj);
		
		
	}

	
}