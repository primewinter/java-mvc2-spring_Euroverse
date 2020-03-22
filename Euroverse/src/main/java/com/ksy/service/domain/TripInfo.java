package com.ksy.service.domain;

//==>È¸¿øÁ¤º¸¸¦ ¸ðµ¨¸µ(Ãß»óÈ­/Ä¸½¶È­)ÇÑ Bean
public class TripInfo {

	/// Field
	private String conUrl;
	private int conId;
	private String conInfo1;
	private String conInfo2;
	private String conInfo3;
	private String conInfo4;
	private String conName;
	private String boardname;
	
	
	
	
	public String getBoardname() {
		return boardname;
	}
	public void setBoardname(String boardname) {
		this.boardname = boardname;
	}
	public String getConUrl() {
		return conUrl;
	}
	public void setConUrl(String conUrl) {
		this.conUrl = conUrl;
	}
	public int getConId() {
		return conId;
	}
	public void setConId(int conId) {
		this.conId = conId;
	}
	public String getConInfo1() {
		return conInfo1;
	}
	public void setConInfo1(String conInfo1) {
		this.conInfo1 = conInfo1;
	}
	public String getConInfo2() {
		return conInfo2;
	}
	public void setConInfo2(String conInfo2) {
		this.conInfo2 = conInfo2;
	}
	public String getConInfo3() {
		return conInfo3;
	}
	public void setConInfo3(String conInfo3) {
		this.conInfo3 = conInfo3;
	}
	public String getConInfo4() {
		return conInfo4;
	}
	public void setConInfo4(String conInfo4) {
		this.conInfo4 = conInfo4;
	}
	public String getConName() {
		return conName;
	}
	public void setConName(String conName) {
		this.conName = conName;
	}
	
	
	@Override
	public String toString() {
		return "TripInfo [conUrl=" + conUrl + ", conId=" + conId + ", conInfo1=" + conInfo1 + ", conInfo2=" + conInfo2
				+ ", conInfo3=" + conInfo3 + ", conInfo4=" + conInfo4 + ", conName=" + conName + ", boardname="
				+ boardname + "]";
	}
	
	
	
	
	
}//end of class