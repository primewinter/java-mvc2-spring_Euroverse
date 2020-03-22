package com.ksy.service.domain;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import com.ksy.common.util.Util;

public class Post {
	
	private String boardName; //board_name
	private String postId; //post_id
	private String postGrade; //post_grade
	private String postNo; //post_no
	private String postContent; //post_content
	private String postTitle; //post_title
	private String postWriterId; //writer_id
	private String nickName;
	private Timestamp postDate; //post_date
	private int accCount; 
	private int accPerson; //acc_person 
	private Timestamp accStartDate; //acc_start_date
	private Timestamp accEndDate; //acc_end_date
	private String qnaKategorie;
	
	private String accStartDateStr;
	private String accEndDateStr;
	
	private int postLikeCount; 
	private int views; //views
	private int comments; 
	private String blocked; //blocked
	private String tags; //tags
	private String postLikeFlag; 
	private String deleted; //deleted
	private String planId; //plan_id;
	private String qnaFirstCate; //qna_first_cate
	private String qnaSecondCate; //qna_second_cate
	
	private String nextId;
	private String nextTitle;
	private String prevId;
	private String prevTitle;
	private User user;
	
	private String imgSrc;
	private String preview;
	private List<Tag> tagList;
	private List<Comment> cmtList;
	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post() {
		
	}

	public String getBoardName() {
		return boardName;
	}

	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getPostGrade() {
		return postGrade;
	}

	public void setPostGrade(String postGrade) {
		this.postGrade = postGrade;
	}

	public String getPostNo() {
		return postNo;
	}

	public void setPostNo(String postNo) {
		this.postNo = postNo;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostWriterId() {
		return postWriterId;
	}

	public void setPostWriterId(String postWriterId) {
		this.postWriterId = postWriterId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public Timestamp getPostDate() {
		return postDate;
	}

	public void setPostDate(Timestamp postDate) {
		this.postDate = postDate;
	}

	public int getAccCount() {
		return accCount;
	}

	public void setAccCount(int accCount) {
		this.accCount = accCount;
	}

	public int getAccPerson() {
		return accPerson;
	}

	public void setAccPerson(int accPerson) {
		this.accPerson = accPerson;
	}

	public Timestamp getAccStartDate() {
		return accStartDate;
	}

	public void setAccStartDate(Timestamp accStartDate) {
		this.accStartDate = accStartDate;
		
		if(accStartDate != null) {
			Date dateForDay = new Date(accStartDate.getTime());		
			this.accStartDateStr = accStartDate.toString().substring(0,10);
		}
	}

	public Timestamp getAccEndDate() {
		return accEndDate;
	}

	public void setAccEndDate(Timestamp accEndDate) {
		this.accEndDate = accEndDate;
		
		if(accEndDate != null) {
			Date dateForDay = new Date(accEndDate.getTime());		
			this.accEndDateStr = accEndDate.toString().substring(0,10);
		}
	}
	
	public String getAccStartDateStr() {
		return accStartDateStr;
	}

	public void setAccStartDateStr(String accStartDateStr) {
		this.accStartDateStr = accStartDateStr;
	}

	public String getAccEndDateStr() {
		return accEndDateStr;
	}

	public void setAccEndDateStr(String accEndDateStr) {
		this.accEndDateStr = accEndDateStr;
	}

	public int getPostLikeCount() {
		return postLikeCount;
	}

	public void setPostLikeCount(int postLikeCount) {
		this.postLikeCount = postLikeCount;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public int getComments() {
		return comments;
	}

	public void setComments(int comments) {
		this.comments = comments;
	}

	public String getBlocked() {
		return blocked;
	}

	public void setBlocked(String blocked) {
		this.blocked = blocked;
	}

	public String getTags() {
		return tags;
	}

	public void setTags(String tags) {
		this.tags = tags;
	}

	public String getPostLikeFlag() {
		return postLikeFlag;
	}

	public void setPostLikeFlag(String postLikeFlag) {
		this.postLikeFlag = postLikeFlag;
	}

	public String getDeleted() {
		return deleted;
	}

	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getQnaFirstCate() {
		return qnaFirstCate;
	}

	public void setQnaFirstCate(String qnaFirstCate) {
		this.qnaFirstCate = qnaFirstCate;
	}

	public String getQnaSecondCate() {
		return qnaSecondCate;
	}

	public void setQnaSecondCate(String qnaSecondCate) {
		this.qnaSecondCate = qnaSecondCate;
	}
	
	public String getNextId() {
		return nextId;
	}

	public void setNextId(String nextId) {
		this.nextId = nextId;
	}

	public String getNextTitle() {
		return nextTitle;
	}

	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}

	public String getPrevId() {
		return prevId;
	}

	public void setPrevId(String prevId) {
		this.prevId = prevId;
	}

	public String getPrevTitle() {
		return prevTitle;
	}

	public void setPrevTitle(String prevTitle) {
		this.prevTitle = prevTitle;
	}

	public String getQnaKategorie() {
		return qnaKategorie;
	}

	public void setQnaKategorie(String qnaKategorie) {
		this.qnaKategorie = qnaKategorie;
	}

	public String getImgSrc() {
		return imgSrc;
	}

	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}

	public String getPreview() {
		return preview;
	}

	public void setPreview(String preview) {
		this.preview = preview;
	}

	public List<Tag> getTagList() {
		return tagList;
	}

	public void setTagList(List<Tag> tagList) {
		this.tagList = tagList;
	}

	public List<Comment> getCmtList() {
		return cmtList;
	}

	public void setCmtList(List<Comment> cmtList) {
		this.cmtList = cmtList;
	}

	@Override
	public String toString() {
		return "Post [boardName=" + boardName + ", postId=" + postId + ", postGrade=" + postGrade + ", postNo=" + postNo
				+ ", postContent=" + postContent + ", postTitle=" + postTitle + ", postWriterId=" + postWriterId
				+ ", nickName=" + nickName + ", postDate=" + postDate + ", accCount=" + accCount + ", accPerson="
				+ accPerson + ", accStartDate=" + accStartDate + ", accEndDate=" + accEndDate + ", qnaKategorie="
				+ qnaKategorie + ", accStartDateStr=" + accStartDateStr + ", accEndDateStr=" + accEndDateStr
				+ ", postLikeCount=" + postLikeCount + ", views=" + views + ", comments=" + comments + ", blocked="
				+ blocked + ", tags=" + tags + ", postLikeFlag=" + postLikeFlag + ", deleted=" + deleted + ", planId="
				+ planId + ", qnaFirstCate=" + qnaFirstCate + ", qnaSecondCate=" + qnaSecondCate + ", nextId=" + nextId
				+ ", nextTitle=" + nextTitle + ", prevId=" + prevId + ", prevTitle=" + prevTitle + "]";
	}

}