package com.ksy.web.user;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Session;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.AuthCache;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.auth.BasicScheme;
import org.apache.http.impl.client.BasicAuthCache;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.DefaultHttpClient;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.common.Config;
import com.ksy.common.MailUtils;
import com.ksy.service.domain.LoginUser;
import com.ksy.service.domain.Point;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.user.UserService;

import java.io.File;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;




@RestController
@RequestMapping("/user/*")
public class UserRestController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("myPageServiceImpl")
	private MyPageService myPageService;
	
	@Autowired
	private JavaMailSender mailSender;	
	
	public UserRestController() {
		System.out.println(this.getClass() + "default Constructor");
	}

	@RequestMapping(value = "json/login" , method = RequestMethod.POST )
	public synchronized Map login(@RequestBody User user , HttpSession session )throws Exception {
//		System.out.println("로그인 레스트 컨트롤러!");
		System.out.println("가지고 온 정보는~");
		System.out.println(user.getUserId());
		System.out.println(user.getPwd());
		
		User dbUser = userService.getUser(user.getUserId());
		
		Map<String, String> returnMap = new HashMap<String, String>();
		
		if ( dbUser == null ) { 
			returnMap.put("result", "errorId");
		}else {
			
			
			if(dbUser.getRole().equals("X")) {
				returnMap.put("result", "unReg");
				returnMap.put("userId",dbUser.getUserId());
				
				if(dbUser.getPwd().equals(user.getPwd())) {
					returnMap.put("checkPwd", "errorPwd");
				}
				
				return returnMap;
				
			}
			
			
			if(!dbUser.getPwd().equals(user.getPwd())) {
				returnMap.put("result", "errorPwd");
			}
			else {
				//탐캣의 디폴트 세션 유지시간은 30분
				session.setAttribute("user", dbUser);
				returnMap.put("result", "ok");
				returnMap.put("userId", dbUser.getUserId());
				//get 먼저하고 없으면 바로 add하고 있으면 업데이하고 add하기
				LoginUser loginUser = (LoginUser)myPageService.getLoginUser(dbUser.getUserId());
				if(loginUser == null) {
					LoginUser newLoginUser = new LoginUser();
					newLoginUser.setUserId(user.getUserId());
					newLoginUser.setSessionId(session.getId());
					myPageService.addLoginUser(newLoginUser);
				}else {
					if(loginUser.getSessionId().equals(session.getId())) {
						System.out.println("똑같은 세션에서 같은 아이디로 로그인 되있는거 확인했으니 노 프라블럼");
					}else if(!loginUser.getSessionId().equals(session.getId())) {
						LoginUser updateLoginUser = new LoginUser();
						updateLoginUser.setUserId(user.getUserId());
						updateLoginUser.setSessionId(session.getId());
						myPageService.updateLoginUser(updateLoginUser);
					}
					
				}
				
			}
		}
		return returnMap;
	}
	
	@RequestMapping(value="json/logout")
	public void logout(HttpSession session) throws Exception {
		session.removeAttribute("user");
		session.invalidate();
	}
	
	@RequestMapping(value="json/updateRole")
	public Map updateRole(HttpSession session)throws Exception{
		User user = (User)session.getAttribute("user");
		
		userService.updateRole(user.getUserId());
		
		User reloadUser = userService.getUser(user.getUserId());
		
		
		
		
		session.setAttribute("user", reloadUser);
		Map<String, String> returnMap = new HashMap<String, String>();
		
		returnMap.put("returnMsg", "ok");
		
		return returnMap;
	}
	
	
	@RequestMapping(value = "json/checkUser")
	public Map checkUser(@RequestBody Map jsonMap)throws Exception {
		System.out.println("checkUser========");
		ObjectMapper objectMapper = new ObjectMapper();
		String mapString = objectMapper.writeValueAsString(jsonMap);
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		Map<String, String> profileMap = objectMapper.readValue(jsonObject.toString(), new TypeReference<Map<String, String>>(){});
		System.out.println("userID"+profileMap.get("userId"));
		System.out.println("userName"+profileMap.get("userName"));
		System.out.println("email"+profileMap.get("email"));
		System.out.println("phone"+profileMap.get("phone"));
		
		Map<String, String> returnMap = new HashMap<String, String>();
		
		User dbUser = userService.getUser(profileMap.get("userId"));
		System.out.println("디비속 유저!"+dbUser);
		
		
		
		if(dbUser != null) {
			if(dbUser.getUserName().equals(profileMap.get("userName"))) {
				System.out.println("뭐야? 이거 찍히면 좀 이상한데?");
			
				if(profileMap.get("phone")=="" || profileMap.get("phone")==null) {
				
					if(dbUser.getEmail().equals(profileMap.get("email"))) {
						returnMap.put("result", "ok");
						return returnMap;
					}else{
						returnMap.put("result", "이메일이 일치하지 않습니다.");
						return returnMap;
					}
					
				}else if(profileMap.get("email")==""|| profileMap.get("email")==null) {
					if(dbUser.getPhone().equals(profileMap.get("phone"))){
						returnMap.put("result","ok");
						return returnMap;
					}else {
						returnMap.put("result", "휴대폰번호가 일치하지 않습니다.");
						return returnMap;
					}
					
				}else {
					returnMap.put("result","휴대폰 또는 이메일을 다시 확인 하세요.");
					return returnMap;
				}

			}else {
				returnMap.put("result","이름을 잘못 입력하였습니다.");
				return returnMap;
			}
		}else {
			returnMap.put("result", "일치하는 회원이 없습니다.");
			return returnMap;
		}
		
	}
	
	
	
	@RequestMapping(value = "json/checkDuplicate")
	public Map Checkduplicate(@RequestBody Map jsonMap) throws Exception {
		ObjectMapper objMap = new ObjectMapper();
		String mapString = objMap.writeValueAsString(jsonMap);
		JSONObject jsonObj = (JSONObject)JSONValue.parse(mapString);
		
		
		Map<String, String> checkMap = objMap.readValue(jsonObj.toString(), new TypeReference<Map<String, String>>(){});
		Map<String, String> returnMap = new HashMap<String, String>();
		
		
		if(checkMap.get("userId") != null) {
				System.out.println("userId로 중복체크");
				System.out.println(checkMap.get("userId"));
				String dbUserId = userService.checkUserId(checkMap.get("userId"));
				if(dbUserId == null) {
					returnMap.put("result","ok");
					return returnMap;
				}else {
					returnMap.put("result","error");
					return returnMap;
				}
				
		}
		
		if(checkMap.get("nickname") != null) {
				System.out.println("nickname으로 중복체크");
				System.out.println(checkMap.get("nickname"));
				String dbNickname = userService.checkNickname(checkMap.get("nickname"));
				if(dbNickname == null) {
					returnMap.put("result","ok");
					return returnMap;
				}else {
					returnMap.put("result","error");
					return returnMap;
				}
			
		}
		return returnMap;
	}
	
	
	@RequestMapping(value = "json/getUserId")
	public List<String> getUserId(@RequestBody Map jsonMap) throws Exception{
		System.out.println("userIdList==========================================================");
		System.out.println(jsonMap);
		ObjectMapper objectMapper = new ObjectMapper();
		String mapString = objectMapper.writeValueAsString(jsonMap);
		System.out.println(mapString);
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		System.out.println("jsonObject~!=="+jsonObject);
		Map<String, String> profileMap = objectMapper.readValue(jsonObject.toString(), new TypeReference<Map<String, String>>(){});

		List<String> idList = new ArrayList<String>();

		User settingUser = new User();
		settingUser.setUserName(profileMap.get("userName"));
		if(profileMap.get("email") == null||profileMap.get("email").equals(" @ ") || profileMap.get("email").equals("@") || profileMap.get("email").equals("") ){//<< 이거 원래 null 체크를 맨 뒤에서 했는데 앞에부터 체크하니깐 ㅈㄴ 빡쳐서 바꿧더니 됬음 주의하셈
			System.out.println("핸드폰으로 리스트 뽑기");
			settingUser.setPhone(profileMap.get("phone"));
			idList = userService.getUserIdList(settingUser);
		}else if(profileMap.get("phone") == null || profileMap.get("phone").equals("--") ||profileMap.get("phone").equals(" - - ") || profileMap.get("phone").equals("") ) {
			System.out.println("이메일로 리스트 뽑기");
			settingUser.setEmail(profileMap.get("email"));
			idList = userService.getUserIdList(settingUser);
		}else {
			System.out.println("띠용....");
		}
		
		if(idList.size()==0) {
			System.out.println("아무것도 없습니다!!");
			idList.add("error");
		}
		System.out.println("아이디 리스트~="+idList);
		
		return idList;
	}
	
	
	
	@RequestMapping(value = "json/googleLoginUrlMake")
	public Map googleLogin(HttpSession session) throws UnsupportedEncodingException {
		String clientId = "474522905430-f6nkrljp2qocnq1mop0ve2oc5ng91q38.apps.googleusercontent.com";
		String redirectUrl = "http://localhost:8080/user/googleLoginLogic&";

		StringBuffer googleLoginUrl = new StringBuffer();
		googleLoginUrl.append("https://accounts.google.com/o/oauth2/v2/auth?");
		googleLoginUrl.append("scope=https://www.googleapis.com/auth/analytics.readonly&");
		googleLoginUrl.append("access_type=offline&");
		googleLoginUrl.append("include_granted_scopes=true&");
		googleLoginUrl.append("state=state_parameter_passthrough_value&");
		googleLoginUrl.append("redirect_uri=");
		googleLoginUrl.append(redirectUrl);
		googleLoginUrl.append("response_type=code&");
		googleLoginUrl.append("client_id=");
		googleLoginUrl.append(clientId);
		
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("url", googleLoginUrl.toString());
		System.out.println(map.get("url"));
		
		return map;
	}
	
	
	@RequestMapping( value = "json/naverLoginUrlMake" )
	public Map naverLogin( HttpSession session ) throws Exception {
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130, random).toString(32);
		session.setAttribute("state", state); 
		
		String clientId = "zmMH7F27NTAzH6EBj4dk";
		
		String redirectUrl = URLEncoder.encode("http://192.168.0.70:8080/user/naverLoginLogic", "UTF-8");
		
		String naverLoginUrl = 	"https://nid.naver.com/oauth2.0/authorize?response_type=code" + 
								"&client_id=" + clientId + 
								"&redirect_uri=" + redirectUrl + 
								"&state="+(String)session.getAttribute("state");
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("url", naverLoginUrl);
		
		return map;
	}
	
	
	
	@RequestMapping( value = "json/kakaoLoginUrlMake" )
	public Map loginKakao( HttpSession session ) throws Exception {
		String clientId = "0813ef39292fbdbe6ad4d20b0a049724";

		String redirectUrl = "http://192.168.0.70:8080/user/kakaoLoginLogic";
		
		String kakaoLoginUrl = 	"https://kauth.kakao.com/oauth/authorize?" + 
								"client_id=" + clientId + 
								"&redirect_uri=" + redirectUrl + 
								"&response_type=code";
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("url", kakaoLoginUrl);
		
		return map;

		
	}
	
	
	
	@RequestMapping(value="json/checkPhone")
	public Map checkPhoneValue(@RequestBody Map jsonMap )throws Exception {
		ObjectMapper objectMapper2 = new ObjectMapper();
		System.out.println("여기는 체크폰!!!!");
		System.out.println(jsonMap);
		String mapString = objectMapper2.writeValueAsString(jsonMap);
		System.out.println(mapString);
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		
		Map<String, String> phoneMap = objectMapper2.readValue(jsonObject.toString(), new TypeReference<Map<String, String>>(){});
		String phone = phoneMap.get("phone");
		
		String[] receiverPhone = phone.split("-");
		phone="";
		for(int i = 0 ; i<receiverPhone.length;i++) {
			phone+=receiverPhone[i];
		}
		
		
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(45, random).toString(36);//36까지하면0~9 a~z까지 출력
		
		String hostname = "api.bluehouselab.com";
	    String url = "https://"+hostname+"/smscenter/v1.0/sendsms";

	        CredentialsProvider credsProvider = new BasicCredentialsProvider();
	        credsProvider.setCredentials(
	            new AuthScope(hostname, 443, AuthScope.ANY_REALM),
	            new UsernamePasswordCredentials(Config.appid, Config.apikey)
	        );

	        // Create AuthCache instance
	        AuthCache authCache = new BasicAuthCache();
	        authCache.put(new HttpHost(hostname, 443, "https"), new BasicScheme());

	        // Add AuthCache to the execution context
	        HttpClientContext context = HttpClientContext.create();
	        context.setCredentialsProvider(credsProvider);
	        context.setAuthCache(authCache);

	        DefaultHttpClient client = new DefaultHttpClient();
	        System.out.println("트라이전!");
	        try {
	            HttpPost httpPost = new HttpPost(url);
	            httpPost.setHeader("Content-type", "application/json; charset=utf-8");
	            
	            Map<String, Object> smsMap = new HashMap<String, Object>();
	            smsMap.put("sender",Config.sender);
	            smsMap.put("content", Config.content+state);
	           // smsMap.put("receivers","01066614577");
	            List<String> receivers = new ArrayList<String>();
	            receivers.add(phone);
	            smsMap.put("receivers", receivers);
	            
	            ObjectMapper objectMapper = new ObjectMapper();
	            String jsonbefore = objectMapper.writeValueAsString(smsMap);
	            
	            System.out.println("-----------jsonbefore ? : " + jsonbefore);
	            
	            
	            StringEntity se = new StringEntity(jsonbefore, "UTF-8");
	            httpPost.setEntity(se);

	            HttpResponse httpResponse = client.execute(httpPost, context);
	            System.out.println(httpResponse.getStatusLine().getStatusCode());

	            InputStream inputStream = httpResponse.getEntity().getContent();
	            if(inputStream != null) {
	                BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
	                String line = "";
	                while((line = bufferedReader.readLine()) != null)
	                    System.out.println(line);
	                inputStream.close();
	            }
	        } catch (Exception e) {
	        	System.out.println("에러...");
	            System.err.println("Error: "+e.getLocalizedMessage());
	        } finally {
	            client.getConnectionManager().shutdown();
	        }
		
		
	        System.out.println("여기는 폰 레스트~");
	        System.out.println("랜덤번호는="+state);
	    	Map<String, String> returnMap = new HashMap<String, String>();
			returnMap.put("result", "done");
			
			// 본인인증을 위한 state를 반환
			returnMap.put("phoneCheck", state);
			
		
		return returnMap;
	}
	
	
	@RequestMapping( value = "json/checkMail" )
	public Map checkMailValue( @RequestBody Map jsonMap ) throws Exception {
		ObjectMapper objectMapper = new ObjectMapper();
		System.out.println("여기는 체크메일!!!");
		System.out.println(jsonMap);
		String mapString = objectMapper.writeValueAsString(jsonMap);
		System.out.println(mapString);
		JSONObject jsonObject = (JSONObject)JSONValue.parse(mapString);
		
		Map<String, String> mailMap = objectMapper.readValue(jsonObject.toString(), new TypeReference<Map<String, String>>(){});
		String email = mailMap.get("email");

		String userId = mailMap.get("userId");
		if(userId != null) {
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+userId);
		}else {
			System.out.println("유저아이디는!!!!!! 널입니다@!@!#@@!@");
		}
		
		System.out.println("===================="+email);
		// 메일 인증 시 입력할 값을 생성 
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(45, random).toString(36);//36까지하면0~9 a~z까지 출력
//		
//		// Autowired된 JavaMailSender로 MailUtils 객체 생성 
//		MailUtils sendMail = new MailUtils(mailSender);
//		
//		// JavaMailSender.setSubject(title) :: 메일 제목 설정 
//		sendMail.setSubject("[Model2 MVC Shop] 회원가입 이메일 인증");
//		
//		// JavaMailSender.setText(text) :: 메일 내용 설정 
//		// StringBuffer로 작성 
//		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증호호호홓!!!]</h1>")
//				.append("<p>아래 글자를 입력하시면 이메일 인증이 완료됩니다.</p>")
//				.append("<p>입력 문자 :: </p>&nbsp;")
//				// 본인인증을 위한 state를 메일로 발송 
//				.append("<h2><b>" + state +"</b></h2>")
//				.toString());
//		
//		// JavaMailSender.setFrom(senderEmail, senderName) :: 메일 작성자 설정 
//		//sendMail.setFrom("jiseong4577@gmail.com", "Model2 MVC Shop");
//		
//		// JavaMailSender.setTo(receiverEmail) :: 메일 수신자 설정 
//		sendMail.setTo(email);
		
		// JavaMailSender.send :: 설정한 내용을 바탕으로 메일 전송
		System.out.println("흐아아아아아아아!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		//sendMail.send();
		System.out.println("하하하하!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		Map<String, String> returnMap = new HashMap<String, String>();
		String host = "smtp.gmail.com";
		int port=465;
		
		
		Properties prop  = System.getProperties();
		
		prop.put("mail.smtp.host", host);
		prop.put("mail.smtp.port",port);
		prop.put("mail.smtp.auth","true");
		prop.put("mail.smtp.ssl.enable","true");
		prop.put("mail.smtp.ssl.trust",host);
		
		Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
					String un = "jiseong4577@gmail.com";
					String pw = "qkrwltjd1";
					protected PasswordAuthentication getPasswordAuthentication(){
						return new PasswordAuthentication(un, pw);
					}			
		});
		
		session.setDebug(true);
		
		MimeMessage mimemessage = new MimeMessage(session);
		mimemessage.setFrom(new InternetAddress("jiseong4577@gmail.com"));
		mimemessage.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
		mimemessage.setSubject("Euroverse 이메일 인증");
		mimemessage.setText("");
		
		String goUrl = "/user/updatePwd?userId="+userId;//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 소영누나 이게 url이야... 많이 못해서 미안해
		
		Multipart	multi = new MimeMultipart("related");
		MimeBodyPart mbp = new MimeBodyPart();
		StringBuffer str = new StringBuffer();
		String tag = " <div style=\"width:1000px;height:800px;border-radius: 10px;background-color:#b2ecee;padding: 1em;text-align: center;\">\r\n" + 
				"                <img src=\"resources/images/icon/euroverse_text3.png\" style='width:500px;height:auto;'>\r\n" + 
				"            <div style=\"font-size:30px;margin:20px;text-align: center;background-color:white;border-radius: 10px;padding: 1em;\">\r\n" + 
				"                <h4>Euroverse, 유럽 여행의 시작</h4>\r\n" + 
				"                <span style=\"font-size:12pt;\">당신을 기다리는 백만 개의 플래너와 함께하세요. <br>\r\n" + 
				"                <br>\r\n" + 
				"                <hr>\r\n" + 
				"                <br>인증번호는 다음과 같습니다.</span><br><br>\r\n" + 
				"                <span style=\"font-size:12pt;\">"+state+"</span>\r\n" + 
				"                <br><br>\r\n" + 
				"            </div>";
//		str.append("<div style='width:1000px;height:800px;border:1px solid'>");
//			str.append("<div style='font-size:30px;margin:20px;text-align:center'>");
//			str.append("<img alt='에러러럴' src='cid:image' width='500px' height='auto'><br>");
//			str.append("<b>유럽여행의 시작</b><br>" + 
//					"당신을 기다리는 백만 개의 플래너와 함께하세요.<br>");
//			str.append("<small>인증번호</small> : <b>"+state+"</b>");
//			str.append("</div>");
//		str.append("</div>");
		str.append(tag);
		
		
		
		
		mbp.setContent(str.toString(), "text/html; charset=utf-8");
		multi.addBodyPart(mbp);
		
		mbp = new MimeBodyPart();
		FileDataSource fds = new FileDataSource("C:\\Users\\User\\git\\Euroverse\\ksy\\WebContent\\resources\\images\\icon\\euroverse_text3.png");
		
		mbp.setDataHandler(new DataHandler(fds));
		mbp.setHeader("Content-ID", "<image>");
		
		multi.addBodyPart(mbp);
		mimemessage.setContent(multi);		
		
		System.out.println("mimemessage::::::::::::::::::::::::::::::::::::::::"+mimemessage);
		Transport.send(mimemessage);	
		
		
		
		returnMap.put("result", "done");
		
		// 본인인증을 위한 state를 반환
		returnMap.put("mailCheck", state);
		
		return returnMap;
	}
	
	@RequestMapping(value="json/getUser")
	public String getUser(@RequestParam(value="userId") String userId ) throws Exception {
		User user = userService.getUser(userId);
		ObjectMapper mapper = new ObjectMapper();
		String jsonString = mapper.writeValueAsString(user);
		System.out.println("json/getUser ::"+jsonString);
		return jsonString;
	}
	
	
	
	
	
	
	
	
	
}
