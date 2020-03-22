package com.ksy.service.domain;

public class Qna {
	
	private String postId; // TABLE post의 post_id 
	private String userId; // user_id
	private String postTitle; // post_title
	private String postContent; //post_content
	private String qnaFirstCate;//qna_first_cate
	private String qnaSecondCate;//qna_second_cate
	
	
	private String qnaReply; //답변유무(t,f)   (comment에서 이 postId를 참조하는게 있으면 답변유무 true)
	
	public Qna() {
		
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
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

	public String getQnaReply() {
		return qnaReply;
	}

	public void setQnaReply(String qnaReply) {
		this.qnaReply = qnaReply;
	}

	@Override
	public String toString() {
		return "Qna [postId=" + postId + ", userId=" + userId + ", postTitle=" + postTitle + ", postContent="
				+ postContent + ", qnaFirstCate=" + qnaFirstCate + ", qnaSecondCate=" + qnaSecondCate + ", qnaReply="
				+ qnaReply + "]";
	}
	
	
	
	
	

}
