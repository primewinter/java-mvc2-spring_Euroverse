package com.ksy.service.myPage;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.ksy.common.Search;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.LoginUser;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Point;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.TripSurvey;


public interface MyPageService {
	
	public void addPoint(Point point) throws Exception;
	public Map<String , Object> getPointList(Search search ,String userId) throws Exception;
	public List getChoolCheckList(String userId)throws Exception;
	
	public void updateTotalPoint(Point point)throws Exception;

	public void addTripSurvey(TripSurvey tripSurvey) throws Exception;
	public List<TripSurvey> getTripSurveyList(String userId) throws Exception;
	public void deleteTripSurvey(String userId)throws Exception;
	
	public void updateUserSlot(String userId) throws Exception;  
	

	////////////////////////Offer//////////////////////////////////////////
	public Map<String , Object> getOfferList(Search search , String userId) throws Exception;

	//public int getPlanCount(String userId)throws Exception;
	public void addPartyMember(Offer offer)throws Exception;
	
	public Offer getOffer(String offerId)throws Exception;
	
	public void updateOfferStatus(Offer offer) throws Exception;
	
	public List<Offer> getRefId(String userId)throws Exception;
	
	public List<Party> getPartyMember(String postId)throws Exception; 
	
	public int partyCount(String userId)throws Exception;
	
	
	////////////////////////QNA////////////////////////////////////////
	public void addQna(Post post)throws Exception;
	public Map<String , Object> getQnaList(Search search ,String userId)throws Exception;
	
	public List<Comment> getQnaCommentList(String postId)throws Exception;
	
	public void deleteQna(String postId)throws Exception;
	
	public void updateQna(Post post)throws Exception;
	
	
	
	//////////////////////LOGINUSER////////////////////////////////////////
	public void addLoginUser(LoginUser loginUser)throws Exception;
	public LoginUser getLoginUser(String userId)throws Exception;
	public void updateLoginUser(LoginUser loginUser)throws Exception;
	
	
}
