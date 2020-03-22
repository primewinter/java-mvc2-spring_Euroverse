package com.ksy.web.chat.socket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.ksy.common.util.Util;
import com.ksy.service.domain.Chat;
import com.ksy.service.domain.Push;
import com.ksy.service.user.UserService;
import com.ksy.web.push.socket.UserSocket;
import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@ServerEndpoint("/accSocket/{roomId}/{userId}")
public class AccChatSocket {

	private static Map<String, List<Session>> accMap = new ConcurrentHashMap<>();
	private static UserSocket webSocket = new UserSocket();
	private Chat chat = new Chat();
	private String msg;
	
	// 웹 소켓이 연결되면 호출되는 이벤트
	@OnOpen
	public void handleOpen(@PathParam("roomId") String roomId, @PathParam("userId") String userId, Session session) throws Exception {
				System.out.println("\n동행채팅 ::: [" + roomId + "]번 채팅방에 ["+userId+"] 입장");
				UserService userService = (UserService)Util.getBean("userServiceImpl");
				List<Session> mapList = accMap.get(roomId); // 같은 roomId의 session 리스트 호출
				if (mapList == null || mapList.size() == 0) { // 없다면 생성
					mapList = new ArrayList<>();
				}
				mapList.add(session); // 생성된 or 호출된 session 리스트에 add
				accMap.put(roomId, mapList);
				
				List<String> userList = getChatMems(roomId);
				if( !userList.contains(userId)) {
					chat.setSenderId("system");
					chat.setChatContent(userId+"님이 입장하셨습니다.");
					chat.setUser(userService.getUser(userId));
					msg = new ObjectMapper().writeValueAsString(chat);
					System.out.println(">> 보낸 메시지 : "+msg);
					sendToRoom(roomId, msg);
					//sendToUser(userList, "chat");
				}
				
				
	}

	@OnMessage
	public void handleMessage(@PathParam("roomId") String roomId, @PathParam("userId") String userId,String message, Session session)
			throws Exception {
				// process booking from the given guest here
				UserService userService = (UserService)Util.getBean("userServiceImpl");
				System.out.println("[동행 채팅] Client > Client : " + message);
				JSONObject jsonobj = (JSONObject)JSONValue.parse(message);
				ObjectMapper objectMapper = new ObjectMapper();
				chat = objectMapper.readValue(jsonobj.get("chat").toString(), Chat.class);
				SimpleDateFormat sdf = new SimpleDateFormat("a hh:mm");
				chat.setSendTime(sdf.format(new Date()));
				if(!userId.equals("system")) {
						chat.setUser(userService.getUser(userId));
				}
				msg = new ObjectMapper().writeValueAsString(chat);
				
				sendToRoom(roomId, msg);
				insertMongo(msg);
				
				List<String> userList = getChatMems(roomId);
				//sendToUser(userList, "chat");

	}

	// 웹 소켓이 닫히면 호출되는 이벤트
	@OnClose
	public void handleClose(@PathParam("roomId") String roomId, @PathParam("userId") String userId, Session session) throws Exception {
				
			System.out.println("[동행 채팅] "+roomId+"번 방 ["+userId+"] 퇴장");
			for (Map.Entry<String, List<Session>> entry : accMap.entrySet()) {
				System.out.println("퇴장하는 getKey :::: " + entry.getKey());
				if (entry.getKey().equals(roomId)) {
					entry.getValue().remove(session);
				}
			}
//			chat.setSenderId("system");
//			chat.setChatContent(userId+"님이 퇴장하셨습니다.");
//			msg = new ObjectMapper().writeValueAsString(chat);
//			System.out.println(">> 보낸 메시지 : "+msg);
//			
//			List<String> userList = getChatMems(roomId);
//			sendToUser(userList, "chat");
		
	}

	//웹 소켓이 에러가 나면 호출되는 이벤트
	@OnError
	public void handleError(Throwable t) {
				t.printStackTrace();
	}
	
	
	private void sendToRoom(String roomId, String message) throws Exception {
		
		for (Map.Entry<String, List<Session>> entry : accMap.entrySet()) {
			System.out.println("[동행 채팅] getKey :::: " + entry.getKey()+" || message : "+message);
			if (entry.getKey().equals(roomId)) {
				for (Session se : entry.getValue()) {
					se.getBasicRemote().sendText(message);
					System.out.println(roomId+"에 보낸 메시지 : "+message);
				}
			}
		}
		
	}
	
	private void sendToUser(List<String> users, String type) throws Exception {
		Push push = new Push();
		push.setPushType(type);
		webSocket.sendChat(users, push);
	}
	
	private void insertMongo(String json) throws Exception {
				
				// 몽고디비랑 연결 있으면 가져오고 없으면 만들기
				MongoClient mongoConn = new MongoClient("127.0.0.1", 27017);
				MongoDatabase mongoDB = mongoConn.getDatabase("Euroverse");
				System.out.println("insertMongo :: String json = "+json);
				Chat chat = jsonToChat(json);
				System.out.println("insertMongo :: Chat chat = "+chat);
				// 컬렉션 있으면 가져오고 없으면 새로만들기 
				MongoCollection<Document> coll = mongoDB.getCollection("Chat");
				List<String> readers = new ArrayList<String>();
				readers.add(chat.getSenderId());
				Document chatToDB = new Document("chatContent", chat.getChatContent())
						.append("chatDate", new Date())
						.append("senderId", chat.getSenderId())
						.append("readers", readers)
						.append("sendTime", chat.getSendTime())
						.append("chatRoomId", chat.getChatRoomId()
						);
				System.out.println("\n\t\t MongoDB 들어가기 전 Chat ::: "+chat);
				coll.insertOne(chatToDB);  // 이놈은 73번부터 77번까지 오라클에있는 내용을 그대로  몽고db에 넣음.
				//coll.updateOne(filter, update, options);  // 이놈은 84번부터 90번까지에 있는놈인데 중복된건 업데이트하고 없던건 insert 하면서 몽고db에 넣음 .. 이게짱임
				System.out.println("업데이투");
				
				mongoConn.close();
	}
	
	private List<String> getChatMems(String roomId) throws Exception {
		
		MongoClient mongoConn = new MongoClient("127.0.0.1", 27017);
		MongoDatabase mongoDB = mongoConn.getDatabase("Euroverse");

		MongoCollection<Document> coll = mongoDB.getCollection("ChatRoom");
		BasicDBObject query = new BasicDBObject("_id", new ObjectId(roomId));
		FindIterable<Document> fit = coll.find(query);
		Document doc = fit.first();
		List<String> userIdList = (List<String>)doc.get("chatMems");
		
		for(String userId : userIdList ) {
			System.out.println(roomId +"에 참여하고 있는 회원 : "+userId);
		}
		mongoConn.close();
		return userIdList;
	}
	
	private Chat jsonToChat(String json) throws Exception {
		//JSONObject jsonobj = (JSONObject)JSONValue.parse(json);
		
		ObjectMapper objectMapper = new ObjectMapper();
		Chat chat = objectMapper.readValue(json, Chat.class);
		System.out.println(":: json > Chat : "+chat);
		
		return chat;
	}
	
//	private String chatToJson(Chat chat) throws Exception {
//		return new ObjectMapper().writeValueAsString(chat);
//	}
	
	
	public void sendChat(Chat chat) throws Exception {
		System.out.println("chat/json/sendChat :: @RequestBody Chat : "+chat);
		
//		// 몽고디비랑 연결 있으면 가져오고 없으면 만들기
//		MongoClient mongoConn = new MongoClient("localhost", 27017);
//		MongoDatabase mongoDB = mongoConn.getDatabase("Euroverse");
//		
//		// 컬렉션 있으면 가져오고 없으면 새로만들기 
//		MongoCollection<Document> coll = mongoDB.getCollection("chat");
//		Bson filter = Filters.eq("_id",chat.getChatId());
//		Bson update = new Document("$set", new
//				Document("_id", chat.getChatId()) 
//				.append("chatContent", chat.getChatContent())
//				.append("chatDate", chat.getChatDate())
//				.append("senderId", chat.getSenderId())
//				.append("chatRoomId", chat.getChatRoomId()));
//		
//		UpdateOptions options = new UpdateOptions().upsert(true); // 있으면 update, 없으면 insert
//		System.out.println("들어감2");
//		
//		//coll.insertOne(doc);  // 이놈은 73번부터 77번까지 오라클에있는 내용을 그대로  몽고db에 넣음.
//		coll.updateOne(filter, update, options);  // 이놈은 84번부터 90번까지에 있는놈인데 중복된건 업데이트하고 없던건 insert 하면서 몽고db에 넣음 .. 이게짱임
//		System.out.println("업데이투");
//		
//		mongoConn.close();
		msg = new ObjectMapper().writeValueAsString(chat);
		sendToRoom(chat.getChatRoomId(), msg);
		insertMongo(msg);
	}
	
}