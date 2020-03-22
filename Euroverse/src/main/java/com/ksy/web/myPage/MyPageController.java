package com.ksy.web.myPage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.Flight;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.Offer;
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

@Controller
@RequestMapping("/myPage/*")
public class MyPageController {

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
	@Qualifier("flightServiceImpl")
	private FlightService flightService;
	
	@Autowired
	@Qualifier("roomServiceImpl")
	private RoomService roomService;
	
	@Autowired
	@Qualifier("likeServiceImpl")
	private LikeService likeService;
	
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	
	

	 @Value("#{commonProperties['postPageUnit']}") int pageUnit;
	
	 @Value("#{commonProperties['postPageSize']}") int pageSize;
	

	public MyPageController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="pointList" )
	public String pointList(HttpSession session , @ModelAttribute("search") Search search, Model model)throws Exception {
		if(session.getAttribute("user")==null) {
			return"redirect:/main.jsp";
		}
		
		
		System.out.println("myPageController pointList");
		User user = (User)session.getAttribute("user");
		System.out.println(search);
		System.out.println("여깁니다@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map = new HashMap<String, Object>();
		
			map = myPageService.getPointList(search, user.getUserId());

			Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		System.out.println("@@@@@@@@@@@@"+map.get("pointList"));
		// Model 과 View 연결
		model.addAttribute("pointList", map.get("pointList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/view/myPage/pointList.jsp";
	}
	
	@RequestMapping(value="myPostCommentList")
	public String myPostCommentList(@ModelAttribute("search") Search search,HttpSession session , Model model)throws Exception{
		if(session.getAttribute("user")==null) {
			return"redirect:/main.jsp";
		}
		
		System.out.println("키크크크크크크크크@~~~");
		User user = (User)session.getAttribute("user");
		System.out.println(search);
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getCurrentPage2()==0) {
			search.setCurrentPage2(1);
		}
		
		
		if(search.getSearchKeyword()==null) {
			search.setSearchKeyword("post");
		}
		
		
		
		search.setPageSize(10);
		
		
		System.out.println("여기는!!!!!!!!!!!!내게시글댓글리스트!!");
		Map<String,Object> postMap = communityService.getMyPostList(search, user.getUserId());
		
		System.out.println("이게 나오나?!!???!!!!???!?!?!?!?!?!??!!??!?!!?!?!?!?");
		Map<String , Object> commentMap = communityService.getMyCommentList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)postMap.get("totalCount")).intValue(), pageUnit, 10);
		Page resultPage2 = new Page( search.getCurrentPage2(), ((Integer)commentMap.get("totalCount")).intValue(), pageUnit, 10);
		
		System.out.println(postMap);
		System.out.println(postMap.get("list"));
		System.out.println(commentMap.get("list"));
		
		
		model.addAttribute("postList",postMap.get("list"));
		model.addAttribute("commentList",commentMap.get("list"));
		
		model.addAttribute("resultPage",resultPage);
		model.addAttribute("resultPage2",resultPage2);
		
		model.addAttribute("keyword",search.getSearchKeyword());
		
		return "forward:/view/myPage/myPostCommentList.jsp";
	}
	
	@RequestMapping(value="myBookMarkList")
	public String myBookMarkList(HttpSession session , Model model)throws Exception{
		if(session.getAttribute("user")==null) {
			return"redirect:/main.jsp";
		}
		
		
		System.out.println("북마크리스트 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		User user = (User)session.getAttribute("user");
		List<Post> likeList = likeService.getBookMarkList(user.getUserId());
		System.out.println(likeList);
		
		
		model.addAttribute("bookMarkList",likeList);
		
		
		return "forward:/view/myPage/myBookMarkList.jsp";
	}
	
	
	@RequestMapping(value="myOfferList")
	public String myOfferList(@ModelAttribute("search") Search search , HttpSession session , Model model)throws Exception {
		if(session.getAttribute("user")==null) {
			return"redirect:/view/community/check.jsp";
		}
		
		System.out.println("오퍼리스트@!~!~~!@#!#@!@~@~@!~!@~@!~@!~@!~");
		User user = (User)session.getAttribute("user");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		if(search.getCurrentPage2()==0) {
			search.setCurrentPage2(1);
		}
		
		if(search.getSearchKeyword()==null) {
			search.setSearchKeyword("plan");
		}
		
		
		
		search.setPageSize(4);
		
		
		
		Map<String , Object> offerMap = myPageService.getOfferList(search,user.getUserId());
		List<Offer> planOfferList = (List<Offer>) offerMap.get("planOfferList");
		List<Offer> partyOfferList = (List<Offer>)offerMap.get("partyOfferList");
		System.out.println(planOfferList);
		System.out.println(partyOfferList);
		//int planOfferListTotalCount = (int)offerMap.get("planOfferList");
		//int partyOfferListTotalCount = (int)offerMap.get("partyOfferList");
		//System.out.println(planOfferListTotalCount);
		//System.out.println(partyOfferListTotalCount);
		
		
		Map<String , Object> planOfferMap = new HashMap<String, Object>();
		
		//planOfferMap = myPageService.getpl(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)offerMap.get("planOfferListTotalCount")).intValue(), pageUnit, 4);
		Page resultPage2 = new Page( search.getCurrentPage(), ((Integer)offerMap.get("partyOfferListTotalCount")).intValue(), pageUnit, 4);
		
		System.out.println(resultPage);
		System.out.println(resultPage2);
		
		
		model.addAttribute("planOfferList",planOfferList);
		model.addAttribute("partyOfferList",partyOfferList);
		model.addAttribute("resultPage",resultPage);
		model.addAttribute("resultPage2",resultPage2);
		model.addAttribute("keyword",search.getSearchKeyword());
		if( search.getSearchKeyword().equals("party")) {
			return "forward:/view/accompany/offerList.jsp";
		} else {
			return "forward:/view/myPage/myOfferList.jsp";
		}
	}
	
	
	
	@RequestMapping(value ="addQnaAndQnaList")
	public String addQnaAndQnaList(@ModelAttribute("search") Search search ,HttpSession session , Model model)throws Exception {
		if(session.getAttribute("user")==null) {
			return"redirect:/main.jsp";
		}
		
		System.out.println("@@@@@@@@@@@addQnaAndQnaList");
		User user = (User)session.getAttribute("user");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		search.setPageSize(4);
		
		Map<String , Object> map = myPageService.getQnaList(search,user.getUserId());
		
		List<Post> qnaList = (List<Post>)map.get("qnaList");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 4);
		
		model.addAttribute("qnaList",qnaList);
		model.addAttribute("resultPage" , resultPage);
		System.out.println("여기까지@@@@@@@@@@@@@@@@@@@@@@@");
		
		return "forward:/view/myPage/addQnaAndQnaList.jsp";
	}
	
	
	
	@RequestMapping( value="addQna", method=RequestMethod.POST )
	public String addQna( @ModelAttribute("post") Post post,  Model model, HttpSession session ) throws Exception {
		
		System.out.println("/mypage/addQna : POST");
	
		User user = (User)session.getAttribute("user");
		post.setPostWriterId(user.getUserId());
		post.setNickName(user.getNickname());
		
		myPageService.addQna(post);
	
		System.out.println("addQna완료했슴둥~~~~~~~~~~~~~~~~~~~~~");
		
		
		return "redirect:/myPage/addQnaAndQnaList";
	}
	
	@RequestMapping(value="deleteQna" , method=RequestMethod.GET)
	public String deleteQna(@RequestParam("postId") String postId)throws Exception {
		System.out.println("deleteQna~~~~~~");
		myPageService.deleteQna(postId);
		System.out.println("삭제완료!!");
		
		return"redirect:/myPage/addQnaAndQnaList";
	}
	
	@RequestMapping(value="updateQna" , method=RequestMethod.POST)
	public String updateQna( @ModelAttribute("post") Post post,  Model model, HttpSession session)throws Exception{
		System.out.println("updateQna@@%!$!$!$!$$!!@@!@!@!@!@!");
		System.out.println(post);
		
		myPageService.updateQna(post);
		System.out.println("업데이트 완료@!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		return "redirect:/myPage/addQnaAndQnaList";
	}
	
	@RequestMapping(value="offerReject")
	public String planOfferReject(@RequestParam("offerId")String offerId  , HttpSession session   )throws Exception{
		System.out.println("planOfferReject ~~~!!#@!#!");
		
		
		
		Offer offer = myPageService.getOffer(offerId);
		System.out.println(offer);
		offer.setOfferStatus("R");
		myPageService.updateOfferStatus(offer);
		
		
		return "redirect:/myPage/myOfferList";
	}
	
	
	
	@RequestMapping(value="likeOrderList")
	public String likeOrderList(HttpSession session , Model model)throws Exception{
		System.out.println("LIKEORDERLIST~~~~~~~");
		if(session.getAttribute("user")==null) {
			return"redirect:/main.jsp";
		}
		User user= (User)session.getAttribute("user");
		
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
		
		System.out.println(flightList);
		System.out.println(roomList);
			
		//model.addAttribute("likeList",likeList);
		
		model.addAttribute("flightList",flightList);
		model.addAttribute("roomList",roomList);
		
		return "forward:/view/myPage/likeOrderList.jsp";
	}

}
