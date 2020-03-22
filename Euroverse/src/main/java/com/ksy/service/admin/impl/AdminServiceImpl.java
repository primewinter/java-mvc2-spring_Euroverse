package com.ksy.service.admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.ksy.common.Search;
import com.ksy.service.admin.AdminDao;
import com.ksy.service.admin.AdminService;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Report;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageDao;
import com.ksy.service.user.UserDao;

@Service("adminServiceImpl")
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	@Qualifier("adminDaoImpl")
	private AdminDao adminDao;
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	//Constructor
	public AdminServiceImpl() {
		// TODO Auto-generated constructor stub
	}
	//회원목록조회
	@Override
	public Map<String, Object> getUserList(Search search) throws Exception {
		
		System.out.println("AdminServiceImpl getUserList");
		
		List<User> list = adminDao.getUserList(search);
		int totalCount = adminDao.getTotalCount(search);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}


	@Override
	public void addQnaComment(Comment comment) throws Exception {
		
		System.out.println("AdminServiceImpl addQnaComment");
		
		adminDao.addQnaComment(comment);
		
	}
	

	@Override
	public Map<String,Object> getQnaCommentList(String postId) throws Exception {
		
		System.out.println("AdminServiceImpl getQnaCommList");
		
		List<Comment> list = adminDao.getQnaComment(postId);
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("list", list);
		
		return map;
	}
	
	//관리자qna 리스트 조회
	@Override
	public Map<String, Object> getAdminQnAList(Search search) throws Exception{
		
		System.out.println("AdminServiceImpl getAdminQnAList");

		List<Post> list = adminDao.getAdminQnAList(search);
		int totalCount = adminDao.getAdminQnaListTotalCount(search);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
	@Override
	public void updateQnaGrade(String cmdId) throws Exception{
		
		System.out.println("AdminServiceImpl updateQnaGrade");
		
		adminDao.updateQnaGrade(cmdId);
	}
	@Override
	public void deleteQnaComm(String cmtId) throws Exception{
		
		System.out.println("AdminServiceImpl deleteQnaComm");
		
		adminDao.deleteQnaComm(cmtId);
	}
	//답변완료를 다시 다변없음으로 바꿈
	@Override
	public void backUpQnaGrade(String postId) throws Exception{
		
		System.out.println("AdminServieImpl backUpQnaGrade");
		
		adminDao.backUpQnaGrade(postId);
	}
	
	@Override
	public Map<String,Object> getPostReportList(Search search) throws Exception{
		
		System.out.println(this.getClass()+"getPostReportList");
		
		List<Report> list= adminDao.getPostReportList(search);
		int totalCount = adminDao.getPostReportTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
		
	}
	
	@Override
	public Map<String , Object> getCommentReportList(Search search) throws Exception {
		
		List<Report> list= adminDao.getCommentReportList(search);
		int totalCount = adminDao.getCommentReportTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		System.out.println(list);
		
		return map;
	}
	
	//관리자가 댓글규제 ==> blocked = 'F' => 'T'
	@Override
	public void updateCommReport(String commId) throws Exception {
		
		System.out.println("AdminServiceImpl updateCommReport");
		
		adminDao.updateCommReport(commId);
		
	}
	
	//관리자가 게시글 ==> blocked = 'F' => 'T'
	@Override
	public void updatePostReport(String postId) throws Exception{
		
		System.out.println("AdminServiceImpl updatePostReport");
		
		adminDao.updatePostReport(postId);
		
	}

	
	
}
