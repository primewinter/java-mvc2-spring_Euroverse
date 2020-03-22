package com.ksy.service.admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ksy.common.Search;
import com.ksy.service.admin.AdminDao;
import com.ksy.service.domain.Comment;
import com.ksy.service.domain.Post;
import com.ksy.service.domain.Report;
import com.ksy.service.domain.User;

@Repository("adminDaoImpl")
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlsession) {
		this.sqlSession = sqlsession;
	}
	
	public AdminDaoImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<User> getUserList(Search search) throws Exception {
		
		System.out.println("AdminDaoImpl getUserList");
		return sqlSession.selectList("AdminMapper.getUserList", search);
	}
	
	@Override
	public int getTotalCount(Search search) throws Exception {
		
		System.out.println("AdminDaoImpl getTotalCount");
		return sqlSession.selectOne("AdminMapper.getTotalCount", search);
	}
	@Override
	public void updatePostReport(String postId) throws Exception{
		
		System.out.println("AdminDaoImpl updatePostReport");
		sqlSession.update("AdminMapper.adminPostBlocked", postId);
		
	}
	@Override
	public void updateCommReport(String commId) throws Exception {
		
		System.out.println("AdminDaoImpl updateCommReport");
		sqlSession.update("AdminMapper.adminCmtBlocked", commId);
	}
	//관리자가 답변한 댓글을 불러옴
	@Override
	public List<Comment> getQnaComment(String postId) throws Exception{
		
		System.out.println("AdminDaoImpl getQnaCommList");
		
		return sqlSession.selectList("AdminMapper.getQnaCommentList", postId);
		
	}
	//관리자가 댓글을 입력함
	@Override
	public void addQnaComment(Comment comment) throws Exception{
		
		System.out.println("AdminDaoImpl addQnaComment");
		
		sqlSession.insert("AdminMapper.addQnaComment", comment);
	}
	//유저가 문의한 댓글을 불러옴
	@Override
	public List<Post> getAdminQnAList(Search search) throws Exception{
		
		System.out.println("AdminDaoImpl getAdminQnAList");
		
		return sqlSession.selectList("AdminMapper.getAdminQnAList", search);
	}
	//댓글을 리스트로 불러오기 위한 게시글count
	@Override
	public int getAdminQnaListTotalCount(Search search) throws Exception{
		
		System.out.println("AdminDaoImpl getAdminQnaListTotalCount");
		
		return sqlSession.selectOne("AdminMapper.getAdminQnaListTotalCount", search);
	}
	//유저가 문의한 1:1문의에 관리자의 답글이 달리면 플래그가 변함 grade ="Q"
	@Override
	public void updateQnaGrade(String postId) throws Exception{
		
		System.out.println("AdminDaoImpl updateQnaGrade");
		
		sqlSession.update("AdminMapper.updateQnaGrade",postId);
	}
	//관리자가 등록한 답글을 삭제함
	@Override
	public void deleteQnaComm(String cmtId) throws Exception{
		
		System.out.println("AdminDaoImpl deleteQnaComm");
		
		sqlSession.update("AdminMapper.deleteQnaComm",cmtId);
	}
	//관리자가 게시글을 삭제할경우 post_grade 값을 다시 원상복구함 답변없음으로 만들기위해
	@Override
	public void backUpQnaGrade(String postId) throws Exception{
		
		System.out.println("AdminDaoImpl deleteUpdateQnaGrade");
		
		sqlSession.update("AdminMapper.backUpQnaGrade", postId);
	}
	
	//관리자 신고게시판 게시글 조회
	@Override
	public List<Report> getPostReportList(Search search) throws Exception{
		
		System.out.println("AdminDaoImpl getPostReportList");
		
		return sqlSession.selectList("AdminMapper.getPostReportList", search);
	}
	

	
	//관리자 신고게시판 게시글 총개수
	@Override
	public int getPostReportTotalCount(Search search) throws Exception {
		
		return sqlSession.selectOne("AdminMapper.getPostReportTotalCount", search);
	}
	
	//관리자 신고게시판 댓글 조회
	@Override
	public List<Report> getCommentReportList(Search search) throws Exception{
		
		System.out.println("AdminDaoImpl getCommentReportList");
		
		return sqlSession.selectList("AdminMapper.getCommentReportList",search);
	}
	
	// 관리자 신고게시판 댓글 총개수
	@Override
	public int getCommentReportTotalCount(Search search) throws Exception {
		
		return sqlSession.selectOne("AdminMapper.getCommentReportTotalCount", search);
	}
	
}
