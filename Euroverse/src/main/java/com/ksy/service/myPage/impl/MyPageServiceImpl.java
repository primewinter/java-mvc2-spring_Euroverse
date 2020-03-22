package com.ksy.service.myPage.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.common.Search;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.LoginUser;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Point;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.myPage.MyPageDao;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.user.UserDao;
import com.ksy.service.user.UserService;


@Service("myPageServiceImpl")
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	
	@Autowired
	@Qualifier("myPageDaoImpl")
	private MyPageDao myPageDao;
	public void setMyPageDao(MyPageDao myPageDao) {
		this.myPageDao = myPageDao;
	}
	
	
	public MyPageServiceImpl() {
		super();
	}


	@Override
	public void addPoint(Point point) throws Exception {
		System.out.println("myPageService addPoint");
		myPageDao.addPoint(point);
	}

	@Override
	public Map<String, Object> getPointList(Search search ,String userId) throws Exception {
		System.out.println("myPageService getPointList");
		
		
		List<Point> pointList = myPageDao.getPointList(search,userId);
		int totalCount = myPageDao.getPointListTotalCount(search, userId);
		
		
		
		Map map = new HashMap(); 
		
		map.put("pointList", pointList);
		map.put("totalCount",totalCount);
		
		
		return map; 
	}
	
	public List getChoolCheckList(String userId)throws Exception{
		System.out.println("myPageService getChoolCheckList");
		return myPageDao.getChoolCheckList(userId);
	}
	
	public void updateTotalPoint(Point point)throws Exception {
		System.out.println("myPageService updateTotalPoint");
		myPageDao.updateTotalPoint(point);
		
	}
	
	

	public void updateUserSlot(String userId) throws Exception {
		myPageDao.updateUserSlot(userId);
	}
	
	
	
	
	
	
		///////////////////////survey//////////////////////
	public void addTripSurvey(TripSurvey tripSurvey) throws Exception{
		System.out.println("UserServiceImpl addTripSurvey");
		myPageDao.addTripSurvey(tripSurvey);
	}
	public List<TripSurvey> getTripSurveyList(String userId) throws Exception{
		System.out.println("UserDaoImpl getTripSurveyList");
		return myPageDao.getTripSurveyList(userId);
	}
	public void deleteTripSurvey(String userId)throws Exception{
		myPageDao.deleteTripSurvey(userId);
	}

	
	/////////////////////////////OFFER///////////////////////////////
	public Map<String,Object> getOfferList(Search search , String userId)throws Exception{
		List<Offer> planOfferList = myPageDao.getPlanOfferList(search, userId);
		List<Offer> partyOfferList = myPageDao.getPartyOfferList(search, userId);
		int planOfferListTotalCount = myPageDao.getPlanOfferListTotalList(userId);
		int partyOfferListTotalCount = myPageDao.getPartyOfferListTotalList(userId);
		
		
		Map<String , Object> returnMap = new HashMap<String, Object>();
		returnMap.put("partyOfferList", partyOfferList);
		returnMap.put("planOfferList", planOfferList);
		returnMap.put("partyOfferListTotalCount",partyOfferListTotalCount);
		returnMap.put("planOfferListTotalCount",planOfferListTotalCount);
		
		return returnMap;
	
	}
	
	public void addPartyMember(Offer offer)throws Exception{
		myPageDao.addPartyMember(offer);
	}
	
	
	public Offer getOffer(String offerId)throws Exception{
		return myPageDao.getOffer(offerId);
	}
	
	public void updateOfferStatus(Offer offer)throws Exception{
		myPageDao.updateOfferStatus(offer);
	}
	
	public List<Offer> getRefId(String userId)throws Exception{
		return myPageDao.getRefId(userId);
	}
	
	public List<Party> getPartyMember(String postId)throws Exception{
		
		return myPageDao.getPartyMember(postId);
	}
	
	
	public int partyCount(String userId)throws Exception{
		return myPageDao.partyCount(userId);
	}
	
	
	
	
	
	public void addQna(Post post)throws Exception{
		myPageDao.addQna(post);
	}


	@Override
	public Map<String , Object> getQnaList(Search search ,String userId) throws Exception {
		List<Post> qnaList = myPageDao.getQnaList(search, userId);
		int totalCount = myPageDao.getQnaListTotalCount(userId);
		List<Comment> cmtList = new ArrayList<>();
		for(Post post : qnaList) {
			cmtList = myPageDao.getAnswers(post.getPostId());
			post.setCmtList(cmtList);
		}
		
		Map<String , Object> returnMap = new HashMap<String, Object>();
		returnMap.put("qnaList", qnaList);
		returnMap.put("totalCount",totalCount);
		
		 return returnMap; 
	}
	
	public List<Comment> getQnaCommentList(String postId)throws Exception{
		List<Comment> qnaCommentList = myPageDao.getQnaCommentList(postId);
		return qnaCommentList;
	}


	@Override
	public void deleteQna(String postId) throws Exception {
		myPageDao.deleteQna(postId);
		
	}
	
	public void updateQna(Post post)throws Exception{
		myPageDao.updateQna(post);
	}
//////////////////////////////////LOGIN USER////////////////////////////////
	
	public void addLoginUser(LoginUser loginUser)throws Exception{
		myPageDao.addLoginUser(loginUser);
	}
	public LoginUser getLoginUser(String userId)throws Exception{
		return myPageDao.getLoginUser(userId);
	}
	public void updateLoginUser(LoginUser loginUser)throws Exception{
		myPageDao.updateLoginUser(loginUser);
	}

	
}
