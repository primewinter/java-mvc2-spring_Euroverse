package com.ksy.service.domain;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class User {
	
	
	
	//user TABLE
	private String userId;  //user_id
	private String userName; //user_name
	private String nickname; //nickname
	private String pwd; //pwd
	private String role; //role     비인증(G general) , 인증(Q qualified ) , 탈퇴(X) , 관리자(A) ,동행마스터(L leader)  , 멤버(M)
	
	private String email; //email
	private String emailId; // <<이메일 앞부분 편하게 사용하기위해서
	private String choiceEmail; // <<이메일 뒷부분 편하게 사용하기 위해서
	
	private String phone;  //phone
	
	private String phone1;
	private String phone2;
	private String phone3;
	
	//private String userImg; //user_img
	private String sex; //sex 남자(M) , 여자(F)
	private String birth; //birth
	private int slot;//slot
	private int totalPoint;//total_point 
	private String pushAgree; //push_agree  T , F
	
	private Timestamp regDate; //reg_date
	private Timestamp unRegDate;//unreg_date
	
	private List<String> dreamCountry; // TABLE trip_survey 에서  type 이 dreamCountry인것
	private List<String> tripStyle; // TABLE trip_survey 에서  type 이 tripStyle인것
	private List<String> countryImg;
	private List<String> styleImg;
	
	private MultipartFile image;
	private String userImg;
	
	
	
	public User() {
		
	}
	

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}


	

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}





	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}





	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}





	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}





	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
		if(email!=null&&email.length()!=0) {
			emailId = email.split("@")[0];
			choiceEmail = email.split("@")[1];
		}
	}
	
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setChoiceEmail(String choiceEmail) {
		this.choiceEmail = choiceEmail;
	}
	
	public String getChoiceEmail() {
		return choiceEmail;
	}



	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
		/////////////// EL 적용 위해 추가 ///////////
		if(phone.split("-").length==3){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}
	
	
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	
	public String getPhone1() {
		return phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public String getPhone3() {
		return phone3;
	}

	
	
	
	
	
	
	
	

//	public String getUserImg() {
//		return userImg;
//	}
//	public void setUserImg(String userImg) {
//		this.userImg = userImg;
//	}





	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}





	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}





	public int getSlot() {
		return slot;
	}
	public void setSlot(int slot) {
		this.slot = slot;
	}





	public int getTotalPoint() {
		return totalPoint;
	}
	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}





	public String getPushAgree() {
		return pushAgree;
	}
	public void setPushAgree(String pushAgree) {
		this.pushAgree = pushAgree;
	}





	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}





	public Timestamp getUnRegDate() {
		return unRegDate;
	}
	public void setUnRegDate(Timestamp unRegDate) {
		this.unRegDate = unRegDate;
	}





	public List<String> getDreamCountry() {
		return dreamCountry;
	}
	public void setDreamCountry(List<String> dreamCountry) {
		this.dreamCountry = dreamCountry;
	}





	public List<String> getTripStyle() {
		return tripStyle;
	}
	public void setTripStyle(List<String> tripStyle) {
		this.tripStyle = tripStyle;
	}


	
	

	public MultipartFile getImage() {
		return image;
	}


	public void setImage(MultipartFile image) {
		this.image = image;
	}
	
	
	public String getUserImg() {
		return userImg;
	}
	
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	
	
	
	
	public List<String> getCountryImg() {
		return countryImg;
	}


	public void setCountryImg(List<String> countryImg) {
		this.countryImg = countryImg;
	}


	public List<String> getStyleImg() {
		return styleImg;
	}


	public void setStyleImg(List<String> styleImg) {
		this.styleImg = styleImg;
	}


	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", nickname=" + nickname + ", pwd=" + pwd
				+ ", role=" + role + ", email=" + email + ", phone=" + phone + ", userImg=" + userImg + ", sex=" + sex
				+ ", birth=" + birth + ", slot=" + slot + ", totalPoint=" + totalPoint + ", pushAgree=" + pushAgree
				+ ", regDate=" + regDate + ", unRegDate=" + unRegDate + ", dreamCountry=" + dreamCountry + ", tripStyle="
				+ tripStyle +",   image="  + image+  "]";
	}
	
	
	
	
	
	
	

}
