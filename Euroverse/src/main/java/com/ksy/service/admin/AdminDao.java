package com.ksy.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.ksy.common.Search;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Report;
import com.ksy.service.domain.User;

public interface AdminDao {

	//각 유저의 List와 page Data를 가져오기 위한 메서드
	public List<User> getUserList(Search search) throws Exception;
	
	// page에 총 페이지수 를 가져오기 위한 메서드  총 page수를 쓰기위해 int 로 리턴
	public int getTotalCount(Search search) throws Exception;
	 
	public void updatePostReport(String postId) throws Exception;
	
	public void updateCommReport(String commId) throws Exception;
	
	//getQnaCommentList 는 select*from 으로 쿼리문 작성
	public List<Comment> getQnaComment(String postId) throws Exception;
	
	public void addQnaComment(Comment comment) throws Exception;
	
	public List<Post> getAdminQnAList(Search search) throws Exception;
	
	public int getAdminQnaListTotalCount(Search search) throws Exception;
	
	public void updateQnaGrade(String postId) throws Exception;
	
	public void deleteQnaComm(String cmtId) throws Exception;
	
	public void backUpQnaGrade(String postId) throws Exception;
	
	public List<Report> getPostReportList(Search search) throws Exception;
	
	public List<Report> getCommentReportList(Search search) throws Exception;
	
	public int getPostReportTotalCount(Search search) throws Exception;
	
	public int getCommentReportTotalCount(Search search) throws Exception;
	
	
}
