package com.ksy.service.domain;

import java.sql.Timestamp;

public class Point {
	
	public Point() {
		
	}
	
	//point TABLE
	private String pointId; //point_id
	private String userId; //user_id
	private String refId; //ref_id
	private String usedType; //used_type  출석체크(C) , 슬롯구매(S) , 항공권,숙소 구매(B) , 포인트사용(U)
	private int usedPoint; //used_point
	private Timestamp usedDate; //used_date
	
	
	private String usedData;
	private String usedContent;
	
	
	public String getPointId() {
		return pointId;
	}
	public void setPointId(String pointId) {
		this.pointId = pointId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getRefId() {
		return refId;
	}
	public void setRefId(String refId) {
		this.refId = refId;
	}
	public String getUsedType() {
		return usedType;
	}
	public void setUsedType(String usedType) {
		this.usedType = usedType;
		
		if(usedType !=null&&usedType.length()!=0) {
			
			switch(usedType) {
				case "C":
					usedData = "적립";
					usedContent = "출석체크";
					break;
				case "F":
					usedData = "적립";
					usedContent = "항공권구매";
					break;
				case "R":
					usedData = "적립";
					usedContent = "숙소구매";
					break;
				case "S":
					usedData = "차감";
					usedContent = "슬롯구매";
					break;
				case "U":
					usedData = "차감";
					usedContent = "포인트사용";
					break;
			
			}
			// 출석체크(C) , 슬롯구매(S) , 항공권구매(F),숙소구매(R) , 포인트사용(U)
			
			
			
			
			
			
		}
		
		
	}
	public int getUsedPoint() {
		return usedPoint;
	}
	public void setUsedPoint(int usedPoint) {
		this.usedPoint = usedPoint;
	}
	public Timestamp getUsedDate() {
		return usedDate;
	}
	public void setUsedDate(Timestamp usedDate) {
		this.usedDate = usedDate;
	}
	
	
	
	
	public String getUsedData() {
		return usedData;
	}
	public void setUsedData(String usedData) {
		this.usedData = usedData;
	}
	public String getUsedContent() {
		return usedContent;
	}
	public void setUsedContent(String usedContent) {
		this.usedContent = usedContent;
	}
	@Override
	public String toString() {
		return "Point [pointId=" + pointId + ", userId=" + userId + ", refId=" + refId + ", usedType=" + usedType
				+ ", usedPoint=" + usedPoint + ", usedDate=" + usedDate + "]";
	}
	
	
 
	
	
	
	
	
	

}
