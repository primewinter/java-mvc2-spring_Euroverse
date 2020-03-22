package com.ksy.service.like.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.service.domain.Like;
import com.ksy.service.domain.Post;
import com.ksy.service.like.LikeDao;
import com.ksy.service.like.LikeService;

//==> 회원관리 서비스 구현
@Service("likeServiceImpl")
public class LikeServiceImpl implements LikeService{
	
	///Field
	@Autowired
	@Qualifier("likeDaoImpl")
	private LikeDao likeDao;
	public void setLikeprodDao(LikeDao likeDao) {
		this.likeDao = likeDao;
	}
	
	///Constructor
	public LikeServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void like_check(Like like) throws Exception {
		likeDao.like_check(like);
	}
		
	public void like_check_cancel(Like like) throws Exception {
		likeDao.like_check_cancel(like);
	}

	public int countByLike(Like like) throws Exception {
		return likeDao.countByLike(like);
	}
	
	public Like getLike(Like like) throws Exception {
		return likeDao.getLike(like);
	}
	
	public void addLike(Like like) throws Exception {
		likeDao.addLike(like);
	}
	
	
	//////////////////////마이페이지에서 옮김/////////////////////////
	public List<Post> getBookMarkList(String userId)throws Exception{
		System.out.println("myPageDaoImpl getBookMarkList()");
		List<Like> list = likeDao.getBookMarkList(userId);
		List<Post> bookMarkList = new ArrayList<Post>();
		
		for(int i=0;i<list.size();i++) {
			Post post = likeDao.getBookMarkPost((list.get(i).getRefId()));
			bookMarkList.add(post);
		}
		return bookMarkList;
	}
	
	public List<Like> getLikeOrderList(String userId)throws Exception{
		
		return likeDao.getLikeOrderList(userId);
	}
	//////////////////////////////////////////////////////////////////
	
	
}