package com.ksy.service.domain;


public class City {
	
	private String planId; 			//plan_id 
	private String cityId;			//city_id
	private String cityName;		//city_name
	private int visitOrder;			//visit_order
	private int cityDuration;		//city_duration
	private String tranType;		//tran_type	(CHAR) :: 기차(T),버스(B),항공(A),페리(F),기타(E)
	
	private String tranDuration; 	//이동 소요시간
	
	private String cityLat;		//위도
	private String cityLng; 	//경도
	private String country;		//국가
	private String cityInfo;	//도시정보
	private String cityImg;		//도시 이미지
	
	//private List<Bucket> bucketList;	//버킷리스트
	
	//FullCalendar에 뿌려주기 위함!! && city_route term..
	private String startDateStr;
	private String endDateStr;
	
	
	private long lat;
	private long lng;
	
//	private String countryColor;		//국가별 색
//	
//	public String getCountryColor() {
//		return countryColor;
//	}
//	public void setCountryColor(String countryColor) {
//		this.countryColor = countryColor;
//	}
	
	
	public long getLat() {
		return lat;
	}
	public void setLat(long lat) {
		this.lat = lat;
	}
	public long getLng() {
		return lng;
	}
	public void setLng(long lng) {
		this.lng = lng;
	}
	public String getStartDateStr() {
		return startDateStr;
	}
	public void setStartDateStr(String startDateStr) {
		this.startDateStr = startDateStr;
	}

	public String getEndDateStr() {
		return endDateStr;
	}
	public void setEndDateStr(String endDateStr) {
		this.endDateStr = endDateStr;
	}


	public City() {
		super();
	}

	
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public String getCityId() {
		return cityId;
	}
	public void setCityId(String cityId) {
		this.cityId = cityId;
	}

	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public int getVisitOrder() {
		return visitOrder;
	}
	public void setVisitOrder(int visitOrder) {
		this.visitOrder = visitOrder;
	}

	public int getCityDuration() {
		return cityDuration;
	}
	public void setCityDuration(int cityDuration) {
		this.cityDuration = cityDuration;
	}

	public String getTranType() {
		return tranType;
	}
	public void setTranType(String tranType) {
		this.tranType = tranType;
	}

	public String getTranDuration() {
		return tranDuration;
	}
	public void setTranDuration(String tranDuration) {
		this.tranDuration = tranDuration;
	}

	public String getCityLat() {
		return cityLat;
	}
	public void setCityLat(String cityLat) {
		this.cityLat = cityLat;
	}

	public String getCityLng() {
		return cityLng;
	}
	public void setCityLng(String cityLng) {
		this.cityLng = cityLng;
	}

	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}

	public String getCityInfo() {
		return cityInfo;
	}
	public void setCityInfo(String cityInfo) {
		this.cityInfo = cityInfo;
	}

	public String getCityImg() {
		return cityImg;
	}
	public void setCityImg(String cityImg) {
		this.cityImg = cityImg;
	}
	@Override
	public String toString() {
		return "\nCity [planId=" + planId + ", cityId=" + cityId + ", cityName=" + cityName + ", visitOrder=" + visitOrder
				+ ", cityDuration=" + cityDuration + ", tranType=" + tranType + ", tranDuration=" + tranDuration
				+ ", cityLat=" + cityLat + ", cityLng=" + cityLng + ", country=" + country + ", cityInfo=" + cityInfo
				+ ", cityImg=" + cityImg + ", startDateStr=" + startDateStr + ", endDateStr=" + endDateStr + ", lat="
				+ lat + ", lng=" + lng + "]";
	}

	
	
}
