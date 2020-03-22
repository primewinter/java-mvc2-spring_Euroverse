package com.ksy.service.admin;

import java.util.Map;

import com.ksy.common.Search;
import com.ksy.service.domain.Comment;

public interface AdminService {

	public Map<String,Object> getUserList(Search search) throws Exception;

	public Map<String,Object> getQnaCommentList(String postId) throws Exception;
	
	public void addQnaComment(Comment comment) throws Exception;
	
	public Map<String,Object> getAdminQnAList(Search search) throws Exception;
	
	public void updateQnaGrade(String postId) throws Exception;
	
	public void deleteQnaComm(String cmtId) throws Exception;
	
	public void backUpQnaGrade(String postId) throws Exception;
	
	public Map<String,Object> getPostReportList(Search search) throws Exception;
	
	public Map<String , Object> getCommentReportList(Search search) throws Exception;
	
	public void updatePostReport(String postId) throws Exception;
	
	public void updateCommReport(String commId) throws Exception;
		
	
	
	
}
