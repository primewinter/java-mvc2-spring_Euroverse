package com.ksy.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.service.community.CommunityDao;
import com.ksy.service.domain.Party;
import com.ksy.common.Search;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Report;
import com.ksy.service.domain.Tag;

@Repository("communityDaoImpl")
public class CommunityDaoImpl implements CommunityDao{
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	public CommunityDaoImpl() {
		System.out.println(this.getClass());
	}

	synchronized public void addPost(Post post) throws Exception {
		sqlSession.insert("CommunityMapper.addPost", post);
		if( post.getBoardName().equals("D")) {
			sqlSession.insert("CommunityMapper.addParty", post.getPostWriterId());
		}
	}
	
	public void addOffer(Offer offer) throws Exception {
		sqlSession.insert("CommunityMapper.addOffer", offer);
	}
	
	public void addTag(String tagContent, String postId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("tagContent", tagContent);
		map.put("postId", postId);
		
		sqlSession.insert("CommunityMapper.addTag", map);
	}
	
	public void updatePost(Post post) throws Exception {
		sqlSession.update("CommunityMapper.updatePost", post);
	}
	
	public void updateTag(Tag tag) throws Exception {
		sqlSession.update("CommunityMapper.updateTag", tag);
	}

	public void deleteTag(String postId) throws Exception {
		sqlSession.delete("CommunityMapper.deleteTag", postId);
	}
	
	public void deleteOffer(String offerId) throws Exception {
		sqlSession.delete("CommunityMapper.deleteOffer", offerId);
	}
	
	public Post getPost(String postId, String userId, String boardName) throws Exception {
		if(postId == null) {
			postId = sqlSession.selectOne("CommunityMapper.getCurrvalPostId");
		}else {
		sqlSession.update("CommunityMapper.updateViews", postId);
		sqlSession.update("CommunityMapper.updateBestPost", postId);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("postId", postId);
		map.put("userId", userId);
		map.put("boardName", boardName);
		
		return sqlSession.selectOne("CommunityMapper.getPost", map);
	}
	
	public Post getMainPost(String postId, String userId, String boardName) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("postId", postId);
		map.put("userId", userId);
		map.put("boardName", boardName);
		return sqlSession.selectOne("CommunityMapper.getPost", map);
	}
	
	public List<Tag> getTagList(String postId) throws Exception {
		return sqlSession.selectList("CommunityMapper.getTagList", postId);
	}
	
	public List<Party> getParty(String postId) throws Exception {
		
		if(postId == null) {
			Post post = new Post();
			
			String partyPostId = sqlSession.selectOne("CommunityMapper.getCurrvalPostId");
			post.setPostId(partyPostId);
			
			return sqlSession.selectList("CommunityMapper.getParty", post.getPostId());
		}else {
			return sqlSession.selectList("CommunityMapper.getParty", postId);
		}
	}
	
	public List<Party> getMyPartyList(String userId) throws Exception {
		return sqlSession.selectList("CommunityMapper.getMyPartyList", userId);
	}
	
	public List<Offer> getMyOfferList(Search search, String userId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("userId", userId);
		
		return sqlSession.selectList("CommunityMapper.getMyOfferList", map);
	}
	
	public List<Post> getPostList(Search search, String boardName) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("boardName", boardName);
		
		return sqlSession.selectList("CommunityMapper.getPostList", map);
	}
	
	public List<Post> getAllPostList(Search search) throws Exception {
		return sqlSession.selectList("CommunityMapper.getAllPostList", search);
	}
	
	public List<Post> getPlanPostList(Search search, String boardName) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("boardName", boardName);
		
		return sqlSession.selectList("CommunityMapper.getPlanPostList", map);
	}
	
	public List<Post> getBestPostList(Search search, String boardName) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("boardName", boardName);
		
		return sqlSession.selectList("CommunityMapper.getBestPostList", map);
	}
	
	public List<Comment> getCommentList(Search search, String postId, String userId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("search", search);
		map.put("postId", postId);
		
		return sqlSession.selectList("CommunityMapper.getCommentList", map);
	}
	
	public List<Comment> rcmtNum(String postId, String userId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("userId", userId);
		map.put("postId", postId);
		
		return sqlSession.selectList("CommunityMapper.rcmtNum", map);
	}

	public int getPostTotalCount(Search search, String boardName) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("boardName", boardName);
		
		return sqlSession.selectOne("CommunityMapper.getPostTotalCount", map);
	}
	
	public int getMyOfferTotalCount(String userId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getMyOfferTotalCount", userId);
	}
	
	public int getAllPostTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getAllPostTotalCount", search);
	}
	
	public int getCommentTotalCount(Search search, String postId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("postId", postId);
		
		return sqlSession.selectOne("CommunityMapper.getCommentTotalCount", map);
	}
	
	public int getRecommentTotalCount(Search search, String postId) throws Exception {
		
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("postId", postId);
		
		return sqlSession.selectOne("CommunityMapper.getRecommentTotalCount", map);
	}
	
	public void addComment(Comment comment) throws Exception {
		sqlSession.insert("CommunityMapper.addComment", comment);
	}
	
	public void updateLike(String cmtId) throws Exception {
		sqlSession.update("CommunityMapper.updateLike", cmtId);
	}
	
	public void updatePostLike(String postId) throws Exception {
		sqlSession.update("CommunityMapper.updatePostLike", postId);
	}
	
	public void updateUnlike(String cmtId) throws Exception {
		sqlSession.update("CommunityMapper.updateUnlike", cmtId);
	}
	
	public int selectLike(String postId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.selectLike", postId);
	}
	
	public Comment getComment(String cmtId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getComment", cmtId);
	}
	
	public int getRecommentCount(String cmtId) throws Exception {
		return sqlSession.selectOne("CommunityMapper.getRecommentCount", cmtId);
	}
	
	public void deleteComment2(String cmtId) throws Exception {
		sqlSession.update("CommunityMapper.deleteComment2", cmtId);
	}
	
	public void updateComment(Comment comment) throws Exception {
		sqlSession.update("CommunityMapper.updateComment", comment);
	}
	
	public void deleteComment(String cmtId) throws Exception {
		sqlSession.update("CommunityMapper.deleteComment", cmtId);
	}
	
	public void addReport(Report report) throws Exception {
		if(report.getReportTarget().equals("P")) {
			sqlSession.update("CommunityMapper.postBlocked", report.getRefId());
		}else if(report.getReportTarget().equals("C")) {
			sqlSession.update("CommunityMapper.cmtBlocked", report.getRefId());	
		}
		sqlSession.insert("CommunityMapper.addReport", report);
	}
	
	synchronized public void dayBestReset() throws Exception {
		sqlSession.delete("CommuniryMapper.deleteDayBestPost");
		
		sqlSession.insert("CommunityMapper.insertDayBestPost");
		
		sqlSession.update("CommunityMapper.dayBestReset");
	}
	
	synchronized public void weekBestReset() throws Exception {
		sqlSession.delete("CommuniryMapper.deleteWeekBestPost");
		
		sqlSession.insert("CommunityMapper.insertWeekBestPost");
		
		sqlSession.update("CommunityMapper.weekBestReset");
	}
	
	synchronized public void monthBestReset() throws Exception {
		sqlSession.delete("CommuniryMapper.deleteMonthBestPost");
		
		sqlSession.insert("CommunityMapper.insertMonthBestPost");
		
		sqlSession.update("CommunityMapper.monthBestReset");
	}
	
	public void deletePost(String postId) throws Exception {
		sqlSession.update("CommunityMapper.deletePost", postId);
	}
	
	public void deletePartyUser(String partyId) throws Exception {
		sqlSession.delete("CommunityMapper.deletePartyUser", partyId);
	}
	
	
	
	
	
	
	
	//////////////////////마이페이지에서 옮김/////////////////////////////
	public List<Post> getMyPostList(Search search, String userId){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("userId", userId);
		
		
		return sqlSession.selectList("CommunityMapper.getMyPostList",map);
	}
	
	public List<Comment> getMyCommentList(Search search, String userId){
		System.out.println("myPageDaoImpl");
		System.out.println("@@@@@@@@@@@@@@@@@@@@");
		System.out.println(search);
		System.out.println("유저아이디"+userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("userId", userId);
		
		
		return sqlSession.selectList("CommunityMapper.getMyCommentList",map);
	}
	
	public int getMyPostListTotalCount(String userId)throws Exception{
		
		return sqlSession.selectOne("CommunityMapper.getMyPostListTotalCount",userId);
	}
	
	public int getMyCommentListTotalCount(String userId)throws Exception{
		
		return sqlSession.selectOne("CommunityMapper.getMyCommentListTotalCount",userId);
	}
	/////////////////////////////////////////////////////////////

}
