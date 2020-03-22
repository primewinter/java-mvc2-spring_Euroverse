package com.ksy.service.domain;

public class TripSurvey {
	
	
	private String userId;
	private String surveyId;
	private String surveyType;
	private String surveyChoice;
	private String surveyImg;
	
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSurveyId() {
		return surveyId;
	}
	public void setSurveyId(String surveyId) {
		this.surveyId = surveyId;
	}
	public String getSurveyType() {
		return surveyType;
	}
	public void setSurveyType(String surveyType) {
		this.surveyType = surveyType;
	}
	public String getSurveyChoice() {
		return surveyChoice;
	}
	public void setSurveyChoice(String surveyChoice) {
		this.surveyChoice = surveyChoice;
	}
	public String getSurveyImg() {
		return surveyImg;
	}
	public void setSurveyImg(String surveyImg) {
		this.surveyImg = surveyImg;
	}
	@Override
	public String toString() {
		return "tripSurvey [userId=" + userId + ", surveyId=" + surveyId + ", surveyType=" + surveyType
				+ ", surveyChoice=" + surveyChoice + ", surveyImg=" + surveyImg + "]";
	}
	
	
	
	
	
	
	
}
