package com.ksy.service.community.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.common.Search;
import com.ksy.service.community.CommunityDao;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Offer;
import com.ksy.service.domain.Party;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Report;
import com.ksy.service.domain.Tag;

@Service("communityServiceImpl")
public class CommunityServiceImpl implements CommunityService{
	
	///Field
	@Autowired
	@Qualifier("communityDaoImpl")
	private CommunityDao communityDao;
	public void setCommunityDao(CommunityDao communityDao) {
		this.communityDao = communityDao;
	}
		
	public CommunityServiceImpl() {
		System.out.println(this.getClass());
	}

	public void addPost(Post post) throws Exception {
		communityDao.addPost(post);
	}

	public void addOffer(Offer offer) throws Exception {
		communityDao.addOffer(offer);
	}
	
	public void addTag(String tagContent, String postId) throws Exception {
		communityDao.addTag(tagContent, postId);
	}
	
	public void updatePost(Post post) throws Exception {
		communityDao.updatePost(post);
	}
	
	public void updateTag(Tag tag) throws Exception {
		communityDao.updateTag(tag);
	}
	
	public void deleteTag(String postId) throws Exception {
		communityDao.deleteTag(postId);
	}
	
	public void deleteOffer(String offerId) throws Exception {
		communityDao.deleteOffer(offerId);
	}
	
	public Post getPost(String postId, String userId, String boardName) throws Exception {
		return communityDao.getPost(postId, userId, boardName);
	}
	
	public Post getMainPost(String postId, String userId, String boardName) throws Exception {
		return communityDao.getMainPost(postId, userId, boardName);
	}
	
	public List<Comment> rcmtNum(String postId, String userId) throws Exception {
		List<Comment> list = communityDao.rcmtNum(postId, userId);
		
		return list;
	}
	
	public List<Tag> getTagList(String postId) throws Exception {
		
		List<Tag> list = communityDao.getTagList(postId);
		
		return list;
	}
	
	public List<Party> getParty(String postId) throws Exception {
		
		List<Party> list = communityDao.getParty(postId);
		
		return list;
	}

	public Map<String , Object > getPostList(Search search, String boardName) throws Exception {
		
		List<Post> list= communityDao.getPostList(search, boardName);
		int totalCount = communityDao.getPostTotalCount(search, boardName);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
	
		return map;
	}
	
	public List<Party> getMyPartyList(String userId) throws Exception {
		List<Party> list = communityDao.getMyPartyList(userId);
		
		return list;
	}
	
	public Map<String, Object> getMyOfferList(Search search, String userId) throws Exception {
		List<Offer> list = communityDao.getMyOfferList(search, userId);
		int totalCount = communityDao.getMyOfferTotalCount(userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public Map<String, Object> getAllPostList(Search search) throws Exception {
		
		List<Post> list= communityDao.getAllPostList(search);
		int totalCount = communityDao.getAllPostTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public Map<String , Object> getPlanPostList(Search search, String boardName) throws Exception {
		
		List<Post> list = communityDao.getPlanPostList(search, boardName);
		int totalCount = communityDao.getPostTotalCount(search, boardName);
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public Map<String , Object > getBestPostList(Search search, String boardName) throws Exception {
		
		List<Post> list= communityDao.getBestPostList(search, boardName);
		int totalCount = communityDao.getPostTotalCount(search, boardName);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
	
		return map;
	}
	
	public Map<String , Object > getCommentList(Search search, String postId, String userId) throws Exception {
		
		List<Comment> list= communityDao.getCommentList(search, postId, userId);
		int totalCount = communityDao.getCommentTotalCount(search, postId);
		int totalCount2 = communityDao.getRecommentTotalCount(search, postId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("totalCount2", new Integer(totalCount2));
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	
	public void addComment(Comment comment) throws Exception {
		communityDao.addComment(comment);
	}
	
	public void updateLike(String cmtId) throws Exception {
		communityDao.updateLike(cmtId);
	}
	
	public void updatePostLike(String postId) throws Exception {
		communityDao.updatePostLike(postId);
	}
	
	public void updateUnlike(String cmtId) throws Exception {
		communityDao.updateUnlike(cmtId);
	}
	
	public int selectLike(String postId) throws Exception {
		return communityDao.selectLike(postId);
	}
	
	public Comment getComment(String cmtId) throws Exception {
		return communityDao.getComment(cmtId);
	}
	
	public void updateComment(Comment comment) throws Exception {
		communityDao.updateComment(comment);
	}
	
	public void deleteComment(String cmtId) throws Exception {
		int count = communityDao.getRecommentCount(cmtId);
		
		if(count == 0) {
			communityDao.deleteComment(cmtId);
		}else {
			communityDao.deleteComment2(cmtId);
		}
	}
	
	public void addReport(Report report) throws Exception {
		communityDao.addReport(report);
	}
	
	public void dayBestReset() throws Exception {
		communityDao.dayBestReset();
	}
	
	public void weekBestReset() throws Exception {
		communityDao.weekBestReset();
	}
	
	public void monthBestReset() throws Exception {
		communityDao.monthBestReset();
	}
	
	public void deletePost(String postId) throws Exception {
		communityDao.deletePost(postId);
	}
	
	public void deletePartyUser(String partyId) throws Exception {
		communityDao.deletePartyUser(partyId);
	}
	
	
	
	
	
	////////////////////마이페이지에서 옮김////////////////////////////////////
public Map<String,Object> getMyPostList(Search search , String userId)throws Exception{
		
		List<Post> list= communityDao.getMyPostList(search, userId);
		int totalCount= communityDao.getMyPostListTotalCount(userId);
		//int totalCount = communityDao.getPostTotalCount(search, boardName);
		System.out.println("호호호호�P호호!!!!!!!!!!!!!!!!!");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount",totalCount);
		//map.put("totalCount", new Integer(totalCount));
		return map;
	}
	
	
	public Map<String,Object> getMyCommentList(Search search , String userId)throws Exception{
		System.out.println("댓글!!!!!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		List<Comment> list= communityDao.getMyCommentList(search, userId);
		int totalCount = communityDao.getMyCommentListTotalCount(userId);
		//int totalCount = communityDao.getPostTotalCount(search, boardName);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount",totalCount);
		//map.put("totalCount", new Integer(totalCount));
		System.out.println("이까지온거면 다 된거지!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(list);
		return map;
	}
	///////////////////////////////////////////////////////////////////////////
	
	
	
}