package com.ksy.service.like;

import java.util.List;

import com.ksy.service.domain.Like;
import com.ksy.service.domain.Post;

public interface LikeService {
	
	public void like_check(Like like) throws Exception ;
		
	public void like_check_cancel(Like like) throws Exception ;

	public int countByLike(Like like) throws Exception ;
		
	public Like getLike(Like like) throws Exception ;
	
	public void addLike(Like like) throws Exception ;
	
	
	////////////////////////유저에서 옮김//////////////////////////////////
	public List<Post> getBookMarkList(String userId)throws Exception;
	public List<Like> getLikeOrderList(String userId)throws Exception;
	///////////////////////////////////////////////////////////////////
	
}