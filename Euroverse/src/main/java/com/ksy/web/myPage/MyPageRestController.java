package com.ksy.web.myPage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Point;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Room;
import com.ksy.service.domain.User;
import com.ksy.service.flight.FlightService;
import com.ksy.service.like.LikeService;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.plan.PlanService;
import com.ksy.service.room.RoomService;
import com.ksy.service.user.UserService;

@RestController
@RequestMapping("/myPage/*")

public class MyPageRestController {
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("myPageServiceImpl")
	private MyPageService myPageService;
	
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService;
	
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("flightServiceImpl")
	private FlightService flightService;
	
	@Autowired
	@Qualifier("roomServiceImpl")
	private RoomService roomService;
	
	
	public MyPageRestController() {
		System.out.println(this.getClass() + "default Constructor");
	}
	
	
	
	@RequestMapping(value="json/choolChecking")
	public Map choolChecking(HttpSession session)throws Exception{
		System.out.println("choolChecking in the RestController");

		Point point = new Point();
		User user = (User)session.getAttribute("user");
		point.setUserId(user.getUserId());
		point.setUsedType("C");
		point.setUsedPoint(100);
		Map returnMap = new HashMap();
		Date today = new Date();
		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
		List<Point> checkList = myPageService.getChoolCheckList(user.getUserId());
		SimpleDateFormat dbDate = new SimpleDateFormat("yyyy-MM-dd");
		if(checkList != null) {
			for(int i=0 ; i<checkList.size();i++) {
				if(dbDate.format(checkList.get(i).getUsedDate()).equals(date.format(today))) {
					returnMap.put("error", "error");
					return returnMap;
				}
			}
		}
		
		System.out.println("차차아아아아아아앙아!!!!!!!!!!!!!!!!!");
		myPageService.addPoint(point);
		myPageService.updateTotalPoint(point);
		User reloadUser = userService.getUser(user.getUserId());
		System.out.println("현재포인트는?!?!?!?!?!?"+reloadUser.getTotalPoint());
		session.setAttribute("user", reloadUser);
		System.out.println("차차아아아아아아앙아@@@@@@@@@@@@@@@@@@@@@@");
		
		
		returnMap.put("imageurl", "/resources/images/icon/lb-circle.png");
		//returnMap.put("title", "출석체크");
		returnMap.put("start",date.format(today));
		returnMap.put("point", reloadUser.getTotalPoint());
		System.out.println(returnMap);
		return returnMap;
	}
	
	
	@RequestMapping(value="json/choolCheck")
	public List choolCheck(HttpSession session)throws Exception {
		System.out.println("출석체크 해버리기!!!");
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		String SessionUserId = ((User)session.getAttribute("user")).getUserId();
		List<Point> choolCheckList = myPageService.getChoolCheckList(SessionUserId);
		System.out.println(choolCheckList);
		List list = new ArrayList();
		for(int i=0;i<choolCheckList.size();i++) {
			Map eventMap = new HashMap();
			//eventMap.put("imageurl", "/resources/images/icon/lb-circle.png");
			//eventMap.put("title", "<img src='/resources/images/icon/lb-circle.png' style='width:20px;height:auto;'>");
			eventMap.put("title", "<i class=\"fas fa-check\"></i>");
			String startDate = new SimpleDateFormat("yyyy-MM-dd").format(choolCheckList.get(i).getUsedDate());
			eventMap.put("start",startDate);
			list.add(eventMap);
		}
		return list;
	}
	
	
	@RequestMapping(value="json/getQnaCommentList")
	public Map getQnaCommentList(@RequestBody Post post)throws Exception{
		List<Comment> qnaCommentList = myPageService.getQnaCommentList(post.getPostId());
		Map map = new HashMap();
		
		if(qnaCommentList.size()==0) {
			System.out.println("호로로롤로롫");
			map.put("returnMessage","error");
		}else {
			map.put("qnaCommentList", qnaCommentList);
			map.put("returnMessage", "ok");
		}
		return map;
	}
	
	@RequestMapping(value="json/deleteBookMark/{postId}")
	public Map deleteBookMark(@PathVariable String postId , HttpSession session)throws Exception{
		
		
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(postId);
	    like.setLikeType("B");
	    likeService.like_check_cancel(like);
	    
	    
	    List<Post> bookMarkList = likeService.getBookMarkList(user.getUserId());
	    
		
		Map map = new HashMap();
		
		map.put("bookMarkList", bookMarkList);
		
		
		return map;
	}
	
	
	@RequestMapping(value="json/deleteLike/{refId}/{likeType}")
	public Map deleteLike(@PathVariable String refId ,@PathVariable String likeType ,HttpSession session)throws Exception{
		
		System.out.println("에에엥에에에@@@@@@@@@@@@@@@@@@@@@@@@@");
		System.out.println(likeType);
		Like like = new Like();
		User user=(User)session.getAttribute("user");
	    like.setLikeUserId(user.getUserId());
	    like.setRefId(refId);
	    like.setLikeType(likeType);
	    System.out.println("야아아압");
	    likeService.like_check_cancel(like);
	    System.out.println("호호호호호홓");
		List<Like> likeList = likeService.getLikeOrderList(user.getUserId());
		System.out.println(likeList);
		List<Flight> flightList = new ArrayList<Flight>();
		List<Room> roomList = new ArrayList<Room>();
		
		for(int i=0;i<likeList.size();i++) {
			if(likeList.get(i).getLikeType().equals("R")) {
				roomList.add(roomService.getRoom(likeList.get(i).getRefId()));
				
			}else if(likeList.get(i).getLikeType().equals("F")) {
				flightList.add(flightService.getFlight(likeList.get(i).getRefId()));
				
			}
		}
		
		
	    
		
			Map map = new HashMap();
			
			map.put("flightList", flightList);
			map.put("roomList", roomList);
			map.put("likeType", likeType);
		
		return map;
	}
	
	@RequestMapping(value="json/planOfferAccept/{offerId}")
	public Map planOfferAccept(@PathVariable String offerId , HttpSession session)throws Exception{
		
		User user = (User)session.getAttribute("user");
		Map map = new HashMap();
		
		Offer offer = myPageService.getOffer(offerId);
		System.out.println(offer);
		
		int havePlanCount = planService.getPlanCount(user.getUserId());
		System.out.println(havePlanCount);
		
		if(user.getSlot() <= havePlanCount) {
			map.put("resultMsg", "error");
			return map;
		}else if(user.getSlot() > havePlanCount) {
			List<Offer> offerList = (List<Offer>)myPageService.getRefId(user.getUserId());
			int result = 0;
			for(int i=0;i<offerList.size();i++) {
				if(offerList.get(i).getRefId().equals(offer.getRefId())) {
					result++;
				}
			}
			if(result==0) {
				offer.setOfferStatus("A");
				offer.setOfferType("P");
				myPageService.updateOfferStatus(offer);
				myPageService.addPartyMember(offer);
				map.put("planId", offer.getRefId());
				map.put("resultMsg", "ok");
				return map;
			}else if(result >= 1) {
				map.put("resultMsg", "over");
				return map;
			}
			
		}
		map.put("resultMsg", "error");
		return map;
	}
	
	
	@RequestMapping(value="json/partyOfferAccept/{offerId}")
	public Map partyOfferAccept(@PathVariable String offerId , HttpSession session)throws Exception{
		System.out.println("partyOfferAccept%@%!$$$!$!$!$$!$!$!$");
		User user = (User)session.getAttribute("user");
		Map map = new HashMap();
		Offer offer = myPageService.getOffer(offerId);
		//accPerson이 최대인원
		
		Post post = (Post)communityService.getPost(offer.getRefId(), user.getUserId(), "D");
		System.out.println(post);
		System.out.println("에에에에에에에~~~");
		System.out.println(post.getAccPerson());
		System.out.println(post.getAccCount());
		System.out.println(post.getAccPerson()==post.getAccCount());
		if(post.getAccPerson()==post.getAccCount()) {
			System.out.println("근데 이건 왜 안찍히냐?");
			map.put("resultMsg", "over");
			return map;
		}else if(post.getAccPerson()>post.getAccCount()){
			List<Party> partyList = myPageService.getPartyMember(offer.getRefId()); 
			int count = 0;
			for(int i=0;i<partyList.size();i++) {
				if(partyList.get(i).getPartyUserId().equals(offer.getFromUserId())) {
					count++;
				}
				
			}
			if(count==0) {
				offer.setToUserId(offer.getFromUserId());
				offer.setOfferStatus("A");
				offer.setOfferType("A");
				myPageService.updateOfferStatus(offer);
				myPageService.addPartyMember(offer);
				map.put("postId", offer.getRefId());
				map.put("resultMsg", "ok");
				return map;
			}else {
				map.put("resultMsg", "overLap");
				return map;
			}
			
		}else {
			
			map.put("resultMsg", "error");
			return map;
			
		}
		
	}


}
