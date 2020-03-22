package com.ksy.service.domain;

public class Like {
	
	private String likeId; //like_id
	private String likeType; //like_type
	private String refId; //ref_id
	private String likeUserId; //like_user_id
	private String likeCheck; 
	
	public Like() {
		
	}

	public String getLikeId() {
		return likeId;
	}

	public void setLikeId(String likeId) {
		this.likeId = likeId;
	}

	public String getLikeType() {
		return likeType;
	}

	public void setLikeType(String likeType) {
		this.likeType = likeType;
	}

	public String getRefId() {
		return refId;
	}

	public void setRefId(String refId) {
		this.refId = refId;
	}

	public String getLikeUserId() {
		return likeUserId;
	}

	public void setLikeUserId(String likeUserId) {
		this.likeUserId = likeUserId;
	}

	public String getLikeCheck() {
		return likeCheck;
	}

	public void setLikeCheck(String likeCheck) {
		this.likeCheck = likeCheck;
	}

	@Override
	public String toString() {
		return "Like [likeId=" + likeId + ", likeType=" + likeType + ", refId=" + refId + ", likeUserId=" + likeUserId
				+ ", likeCheck=" + likeCheck + "]";
	}

}