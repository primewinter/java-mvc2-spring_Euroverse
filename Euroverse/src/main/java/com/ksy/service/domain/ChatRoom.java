package com.ksy.service.domain;

import java.sql.Date;
import java.util.List;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.springframework.web.multipart.MultipartFile;

public class ChatRoom {
	
	private ObjectId _id;
	private String chatRoomId; // chatRoom_id
	private String chatRoomName; // chatRoom_name
	private int chatMemNum; // chatMem_num 채팅 참여 인원
	private String creator;
	private List<String> chatMems; // 채팅 참여 회원 목록
	private String[] joinMems;
	private Date createdDate;
	private String chatImg;
	private MultipartFile chatRoomFile;

	// 출력용 field
	private Document lastChat; // 마지막 메시지
	private int unreadMsgCount; // 안 읽은 메시지 수
	public ObjectId get_id() {
		return new ObjectId(chatRoomId);
	}
	public void set_id(ObjectId _id) {
		this._id = _id;
	}
	public String getChatRoomId() {
		return chatRoomId;
	}
	public void setChatRoomId(String chatRoomId) {
		this.chatRoomId = chatRoomId;
	}
	public String getChatRoomName() {
		return chatRoomName;
	}
	public void setChatRoomName(String chatRoomName) {
		this.chatRoomName = chatRoomName;
	}
	public int getChatMemNum() {
		return chatMemNum;
	}
	public void setChatMemNum(int chatMemNum) {
		this.chatMemNum = chatMemNum;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public List<String> getChatMems() {
		return chatMems;
	}
	public void setChatMems(List<String> chatMems) {
		this.chatMems = chatMems;
	}
	public String[] getJoinMems() {
		return joinMems;
	}
	public void setJoinMems(String[] joinMems) {
		this.joinMems = joinMems;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Document getLastChat() {
		return lastChat;
	}
	public void setLastChat(Document lastChat) {
		this.lastChat = lastChat;
	}
	public int getUnreadMsgCount() {
		return unreadMsgCount;
	}
	public void setUnreadMsgCount(int unreadMsgCount) {
		this.unreadMsgCount = unreadMsgCount;
	}
	public String getChatImg() {
		return chatImg;
	}
	public void setChatImg(String chatImg) {
		this.chatImg = chatImg;
	}
	public MultipartFile getChatRoomFile() {
		return chatRoomFile;
	}
	public void setChatRoomFile(MultipartFile chatRoomFile) {
		this.chatRoomFile = chatRoomFile;
	}
	@Override
	public String toString() {
		return "ChatRoom [_id=" + _id + ", chatRoomId=" + chatRoomId + ", chatRoomName=" + chatRoomName
				+ ", chatMemNum=" + chatMemNum + ", creator=" + creator + ", chatMems=" + chatMems + ", createdDate="
				+ createdDate + ", chatImg=" + chatImg + ", chatRoomFile=" + chatRoomFile + ", lastChat=" + lastChat
				+ ", unreadMsgCount=" + unreadMsgCount + "]";
	}

}
