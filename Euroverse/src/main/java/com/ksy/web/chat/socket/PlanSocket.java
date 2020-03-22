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

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import com.ksy.common.util.Util;
import com.ksy.service.domain.Chat;
import com.ksy.service.domain.User;
import com.ksy.service.user.UserService;



@ServerEndpoint("/planSocket/{planId}/{userId}")
public class PlanSocket {

			private static Map<String, List<Session>> slMap = new ConcurrentHashMap<>();
			private static Map<String, List<User>> users = new ConcurrentHashMap<>();
			private Chat chat = new Chat();
			private String msg;
			private UserService userService = (UserService)Util.getBean("userServiceImpl");
			
			// 웹 소켓이 연결되면 호출되는 이벤트
			@OnOpen
			public void handleOpen(@PathParam("planId") String planId, @PathParam("userId") String userId, Session session) throws Exception {
				System.out.println("\n==================="+planId+"번 플래너채팅 ::: [" + userId + "] 접속");
				
				List<Session> mapList = slMap.get(planId); // 같은 userId의 session 리스트 호출
				if (mapList == null || mapList.size() == 0) { // 없다면 생성
					mapList = new ArrayList<>();
				}
				mapList.add(session); // 생성된or호출된 session 리스트에 add
				slMap.put(planId, mapList);
				
				chat.setSenderId("system");
				chat.setChatContent(userId+"님이 입장하셨습니다.");
				msg = new ObjectMapper().writeValueAsString(chat);
				System.out.println(">> 보낸 메시지 : "+msg);
				sendToPlan(planId, msg);
				
				// 현재 입장인원 목록
				List<User> userList = users.get(planId);
				if( userList == null || userList.size() == 0 ) {
					userList = new ArrayList<>();
				}
				userList.add(userService.getUser(userId));
				System.out.println(planId+"에 현재 입장한 회원 ::");
				for(User user : userList ) {
					System.out.println(user);
				}
				System.out.println("===========");
				users.put(planId, userList);
				msg = new ObjectMapper().writeValueAsString(userList);
				sendToPlan(planId, msg);
						
			}
		
			//웹 소켓으로부터 메시지가 오면 호출되는 이벤트
			@OnMessage
			public void handleMessage(@PathParam("planId") String planId, @PathParam("userId") String userId, String message, Session session)
					throws Exception {
						JSONObject jsonobj = (JSONObject)JSONValue.parse(message);
						
						ObjectMapper objectMapper = new ObjectMapper();
						chat = objectMapper.readValue(jsonobj.get("chat").toString(), Chat.class);
						chat.setUser(userService.getUser(chat.getSenderId()));
						SimpleDateFormat sdf = new SimpleDateFormat("a hh:mm");
						chat.setSendTime(sdf.format(new Date()));
						msg = new ObjectMapper().writeValueAsString(chat);
						sendToPlan(planId, msg);
	
			}
		
			// 웹 소켓이 닫히면 호출되는 이벤트
			@OnClose
			public void handleClose(@PathParam("planId") String planId, @PathParam("userId") String userId, Session session) throws Exception {
						System.out.println("[PLANSOCKET] "+userId+"퇴장");
						System.out.print("remove 시작 : "+slMap.get(planId).size());
						for (Map.Entry<String, List<Session>> entry : slMap.entrySet()) {
							if (entry.getKey().equals(planId)) {
								entry.getValue().remove(session);
							}
						}
						System.out.println(" >> remove 완료 : "+slMap.get(planId).size());
						
						chat.setSenderId("system");
						chat.setChatContent(userId+"님이 퇴장하셨습니다.");
						msg = new ObjectMapper().writeValueAsString(chat);
						for (Map.Entry<String, List<Session>> entry : slMap.entrySet()) {
							if (entry.getKey().equals(planId)) {
								for (Session se : entry.getValue()) {
									se.getBasicRemote().sendText(msg);
								}
							}
						}
						 System.out.print("채팅방 인원 ("+users.get(planId).size()); 
						 users.get(planId).removeIf( (u) -> u.getUserId().equals(userId));
						 System.out.print(") >> ("+users.get(planId).size()+") 으로 감소");
						 
						 msg = new ObjectMapper().writeValueAsString(users.get(planId)); 
						 sendToPlan(planId, msg);
		 
			}
			
			
			//웹 소켓이 에러가 나면 호출되는 이벤트
			@OnError
			public void handleError(Throwable t) {
						t.printStackTrace();
			}
			
			
			private void sendToPlan(String planId, String message) throws Exception {
				
				for (Map.Entry<String, List<Session>> entry : slMap.entrySet()) {
					System.out.println("[동행 채팅] 플래너ID :::: " + entry.getKey()+" || 메시지 : "+message);
					if (entry.getKey().equals(planId)) {
						for (Session se : entry.getValue()) {
							se.getBasicRemote().sendText(message);
							System.out.println(planId+"에 보낸 메시지 : "+message);
						}
					}
				}
				
			}

}

