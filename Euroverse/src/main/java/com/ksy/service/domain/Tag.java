package com.ksy.service.domain;

public class Tag {
	
	private String tagId; //tag_id
	private String postId; //post_id
	private String tagContent; //tag_content
	
	public Tag(){
		
	}

	public String getTagId() {
		return tagId;
	}

	public void setTagId(String tagId) {
		this.tagId = tagId;
	}

	public String getPostId() {
		return postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	public String getTagContent() {
		return tagContent;
	}

	public void setTagContent(String tagContent) {
		this.tagContent = tagContent;
	}

	@Override
	public String toString() {
		return "Tag [tagId=" + tagId + ", postId=" + postId + ", tagContent=" + tagContent + "]";
	}

}
