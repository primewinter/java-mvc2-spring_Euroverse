package com.ksy.service.domain;

import java.sql.Timestamp;

public class Room {
	private String roomId; //room_id
	private String roomName; //room_name
	private String roomAddr; //room_addr
	private int price; //price
	private String roomCity; //room_city
	private String checkIn; //check_in
	private String checkOut; //check_out
	private String detailLink; //detail_link
	private int adultNum;  //adult_num
	private int adultNum2;
	private int childNum; //child_num
	private int childNum2;
	private int roomNum; //room_num
	private String roomImg; //room_img
	private String mainService; //main_service
	private String familyService; //family_service
	private String sights; //sights
	private String hotelInfo; //hotel_info
	private String roomInfo; //room_info
	
	private String location;
	private String distance;
	private String grade;
	
	private String orderStatus; //order_status
	private Timestamp orderDate; //order_date
	private String refundDate;
	private String orderId; //order_status
	
	private String buyerId;
	
	
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public String getRefundDate() {
		return refundDate;
	}
	public void setRefundDate(String refundDate) {
		this.refundDate = refundDate;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	public String getDistance() {
		return distance;
	}
	public void setDistance(String distance) {
		this.distance = distance;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public int getAdultNum2() {
		return adultNum2;
	}
	public void setAdultNum2(int adultNum2) {
		this.adultNum2 = adultNum2;
	}
	public int getChildNum2() {
		return childNum2;
	}
	public void setChildNum2(int childNum2) {
		this.childNum2 = childNum2;
	}
	public String getRoomId() { 
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getRoomCity() {
		return roomCity;
	}
	public void setRoomCity(String roomCity) {
		this.roomCity = roomCity;
	}
	public String getCheckIn() {
		return checkIn;
	}
	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}
	public String getCheckOut() {
		return checkOut;
	}
	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}
	public String getRoomAddr() {
		return roomAddr;
	}
	public void setRoomAddr(String roomAddr) {
		this.roomAddr = roomAddr;
	}
	public String getDetailLink() {
		return detailLink;
	}
	public void setDetailLink(String detailLink) {
		this.detailLink = detailLink;
	}
	public String getMainService() {
		return mainService;
	}
	public void setMainService(String mainService) {
		this.mainService = mainService;
	}
	public String getFamilyService() {
		return familyService;
	}
	public void setFamilyService(String familyService) {
		this.familyService = familyService;
	}
	public String getSights() {
		return sights;
	}
	public void setSights(String sights) {
		this.sights = sights;
	}
	public String getHotelInfo() {
		return hotelInfo;
	}
	public void setHotelInfo(String hotelInfo) {
		this.hotelInfo = hotelInfo;
	}
	public String getRoomInfo() {
		return roomInfo;
	}
	public void setRoomInfo(String roomInfo) {
		this.roomInfo = roomInfo;
	}
	public int getAdultNum() {
		return adultNum;
	}
	public void setAdultNum(int adultNum) {
		this.adultNum = adultNum;
	}
	public int getChildNum() {
		return childNum;
	}
	public void setChildNum(int childNum) {
		this.childNum = childNum;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getRoomImg() {
		return roomImg;
	}
	public void setRoomImg(String roomImg) {
		this.roomImg = roomImg;
	}
	
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	@Override
	public String toString() {
		return "Room [roomId=" + roomId + ", roomName=" + roomName + ", roomAddr=" + roomAddr + ", price=" + price
				+ ", roomCity=" + roomCity + ", checkIn=" + checkIn + ", checkOut=" + checkOut + ", detailLink="
				+ detailLink + ", adultNum=" + adultNum + ", adultNum2=" + adultNum2 + ", childNum=" + childNum
				+ ", childNum2=" + childNum2 + ", roomNum=" + roomNum + ", roomImg=" + roomImg + ", mainService="
				+ mainService + ", familyService=" + familyService + ", sights=" + sights + ", hotelInfo=" + hotelInfo
				+ ", roomInfo=" + roomInfo + ", location=" + location + ", distance=" + distance + ", grade=" + grade
				+ "]";
	}
}
