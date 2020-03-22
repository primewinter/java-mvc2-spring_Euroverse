package com.ksy.service.myPage;

import java.util.List;

import com.ksy.common.Search;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Like;
import com.ksy.service.domain.LoginUser;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Point;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.TripSurvey;

public interface MyPageDao {
	
	public void addPoint(Point point) throws Exception;
	public List<Point> getPointList(Search search ,String userId) throws Exception;
	public int getPointListTotalCount(Search search ,String userId)throws Exception;
	public List getChoolCheckList(String userId)throws Exception;
	public void updateTotalPoint(Point point)throws Exception;
	public void updateUserSlot(String userId) throws Exception;
	
	/////////////////////survey/////////////////////////////////////////
	public void addTripSurvey(TripSurvey tripSurvey) throws Exception;
	public List<TripSurvey> getTripSurveyList(String userId) throws Exception;
	public void deleteTripSurvey(String userId)throws Exception;
	
	
	//////////////////////////////offer///////////////////////////////////////
	public List<Offer> getPlanOfferList(Search search , String userId) throws Exception;
	public List<Offer> getPartyOfferList(Search search , String userId) throws Exception;
	
	public int getPlanOfferListTotalList(String userId)throws Exception;
	public int getPartyOfferListTotalList(String userId)throws Exception;
	
	public void addPartyMember(Offer offer)throws Exception;
	
	public Offer getOffer(String offerId)throws Exception;
	
	public void updateOfferStatus(Offer offer) throws Exception;
	
	public List<Offer> getRefId(String userId)throws Exception;
	
	public List<Party> getPartyMember(String postId)throws Exception;
	
	public int partyCount(String userId)throws Exception;
	
	
	//////////////////////////////QNA////////////////////////////////
	public void addQna(Post post)throws Exception;
	public List<Post> getQnaList(Search search , String userId)throws Exception;
	public int getQnaListTotalCount(String userId);
	
	public List<Comment> getAnswers(String postId) throws Exception;
	
	public List<Comment> getQnaCommentList(String postId)throws Exception;
	
	public void deleteQna(String postId)throws Exception;
	
	public void updateQna(Post post)throws Exception;
	
	
	
	////////////////////LOGINUSER//////////////////////////////
	public void addLoginUser(LoginUser loginUser)throws Exception;
	public LoginUser getLoginUser(String userId)throws Exception;
	public void updateLoginUser(LoginUser loginUser)throws Exception;
	
}
