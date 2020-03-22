package com.ksy.web.user;

import java.awt.PageAttributes.MediaType;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpEntity;
import org.apache.http.HttpRequest;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.net.HttpHeaders;
import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.service.community.CommunityService;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.TripSurvey;
import com.ksy.service.domain.User;
import com.ksy.service.myPage.MyPageService;
import com.ksy.service.plan.PlanService;
import com.ksy.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	@Autowired
	@Qualifier("myPageServiceImpl")
	private MyPageService myPageService;
	
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;
	
	@Autowired
	@Qualifier("communityServiceImpl")
	private CommunityService communityService;
	

	String uploadPath = "C:\\Users\\User\\git\\Euroverse\\ksy\\WebContent\\resources\\images\\userImages";
	
	
	public UserController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="autoLogout")
	public String autoLogout() {
		System.out.println(this.getClass()+"AutoLogin");
		return "redirect:/view/user/autoLogout.jsp";
	}
	
	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		System.out.println(this.getClass()+"logout");
		session.removeAttribute("user");
		session.invalidate();
		return "redirect:/main.jsp";
	}
	
	@RequestMapping(value="unRegUser")
	public String unRegUser(HttpSession session)throws Exception{
		User user = (User)session.getAttribute("user");
		userService.unRegister(user.getUserId());
		session.removeAttribute("user");
		session.invalidate();
		return "redirect:/view/user/unRegUserConfirm.jsp";
	}
	
	@RequestMapping(value="comeBack",method = RequestMethod.GET)
	public String comeBack(@RequestParam("userId")String userId , Model model)throws Exception{
		model.addAttribute("userId",userId);
		return"forward:/view/user/comeBack.jsp";
	}
	
	@RequestMapping(value="comeBack" ,method = RequestMethod.POST)
	public String comeBack(@ModelAttribute("user")User user , HttpSession session)throws Exception {
		userService.comeBackUser(user);
		User dbUser = userService.getUser(user.getUserId());
		return "redirect:/main.jsp";
	}
	
	
	@RequestMapping(value="addUser" , method = RequestMethod.GET)
	public String addUser(Model model , HttpSession session)throws Exception{
		System.out.println(this.getClass()+"addUser");
		if(session.getAttribute("user")!=null) {
			return"redirect:/main.jsp";
		}
		List<TripSurvey> countryList = countryList();
		List<TripSurvey> tripStyleList = tripStyleList();
		model.addAttribute("countryList",countryList);
		model.addAttribute("tripStyleList",tripStyleList);
		return "forward:/view/user/addUser.jsp";
	}
	
	@RequestMapping(value = "addUser" , method=RequestMethod.POST)
	public String addUser(@ModelAttribute("user")User user ,Model model , HttpSession session) throws Exception {
		System.out.println("addUser POST Start");
		System.out.println(user);
		//		파일업로드다른방법
		//		if(user.getImage().isEmpty()==false) {
		//			MultipartFile mhsr = (MultipartFile)user.getImage();
		//			String path = "C:\\Users\\User\\git\\Euroverse\\ksy\\WebContent\\resources\\images\\userImages";
		//			String originalName = "";
		//			originalName = new String(mhsr.getOriginalFilename().getBytes("8859_1"),"UTF-8");
		//			System.out.println(originalName);
		//			user.setUserImg("\\resources\\images\\userImages\\"+originalName);
		//			System.out.println("유저이미지"+user.getUserImg());
		//			File serverFile = new File(path+File.separator + originalName);
		//			mhsr.transferTo(serverFile);
		//		}else {
		//			user.setUserImg("\\resources\\images\\userImages\\defaultUserImage.jpg");
		//		}
				
	if(user.getImage() !=null) {
		MultipartFile mhsr = (MultipartFile)user.getImage();
		if( mhsr.isEmpty() == false) {	//null 체크로 잡을 수 없음! 
			String fileName = mhsr.getOriginalFilename();
			fileName = uploadFile(fileName, mhsr.getBytes());
			//mpFile.transferTo( new File(path, fileName) );
			user.setUserImg(fileName);
			
		}else {
			user.setUserImg("defaultUserImage.jpg");
		}
	}else {
		user.setUserImg("defaultUserImage.jpg");
	}
		userService.addUser(user);
		myPageService.deleteTripSurvey(user.getUserId());
		
		if(user.getDreamCountry()!=null) {
			for(int i=0;i<(user.getDreamCountry().size());i++) {
				TripSurvey tripSurvey = new TripSurvey();
				tripSurvey.setUserId(user.getUserId());
				tripSurvey.setSurveyChoice(user.getDreamCountry().get(i));
				tripSurvey.setSurveyImg(user.getCountryImg().get(i));
				tripSurvey.setSurveyType("D");
				myPageService.addTripSurvey(tripSurvey);
			}
		}
		
		if(user.getTripStyle()!=null) {
			
			for(int j=0;j<(user.getTripStyle().size());j++) {
				TripSurvey tripSurvey = new TripSurvey();
				tripSurvey.setUserId(user.getUserId());
				tripSurvey.setSurveyChoice(user.getTripStyle().get(j));
				tripSurvey.setSurveyImg(user.getStyleImg().get(j));
				tripSurvey.setSurveyType("T");
				myPageService.addTripSurvey(tripSurvey);
			}
		}
		
		return "redirect:/main.jsp";
	}
	
	@RequestMapping(value = "getUser" , method=RequestMethod.GET)
	public String getUser(HttpSession session , Model model) throws Exception {
		if(session.getAttribute("user")==null) {
			return "redirect:/main.jsp";
		}
		
		System.out.println(this.getClass()+"getUser Start");
		User user = (User)session.getAttribute("user");
		List<Plan> planList = planService.getEndPlanList(user.getUserId());
		List<Plan> endPlanList = new ArrayList<Plan>();
		int travelDate =0;
		
		for(int i=0;i<planList.size();i++) {
			System.out.println(planService.getPlan(planList.get(i).getPlanId()));
			endPlanList.add(planService.getPlan(planList.get(i).getPlanId()));
		}
		
		for(int j=0;j<endPlanList.size();j++) {
			System.out.println(endPlanList.get(j).getPlanTotalDays());
			travelDate += endPlanList.get(j).getPlanTotalDays();
		}
		
		System.out.println(user.getUserId());
		List<TripSurvey> tripSurveyList = myPageService.getTripSurveyList(user.getUserId());
		
		
		Search search = new Search();
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		if(search.getCurrentPage2()==0) {
			search.setCurrentPage2(1);
		}
		
		search.setPageSize(10);
		
		Map<String,Object> postMap = communityService.getMyPostList(search, user.getUserId());
		Map<String , Object> commentMap = communityService.getMyCommentList(search, user.getUserId());
		int postCount = (int) postMap.get("totalCount");
		int commentCount = (int)commentMap.get("totalCount");
		
		int partyCount = myPageService.partyCount(user.getUserId());
		
		model.addAttribute("travelDate",travelDate);
		model.addAttribute("travelHour",travelDate*24);
		model.addAttribute("travelMin",travelDate*24*60);
		model.addAttribute("tripSurveyList",tripSurveyList);
		model.addAttribute("postCount",postCount);
		model.addAttribute("commentCount",commentCount);
		model.addAttribute("partyCount",partyCount);

		return "forward:/view/user/getUser.jsp";
	}
	
	
	@RequestMapping(value = "searchId",method=RequestMethod.GET)
	public String searchUserId(HttpSession session) {
		System.out.println("UserController GET searchUserId!");
		if(session.getAttribute("user")!=null) {
			return"redirect:/main.jsp";
		}
		
		
		return"redirect:/view/user/searchId.jsp";
	}
	
	@RequestMapping(value="searchId",method=RequestMethod.POST)
	public String searchUserId(@ModelAttribute("user") User user , Model model , HttpSession session) throws Exception {
		System.out.println("UserController POST searchUserId");
		List<String> idList = new ArrayList<String>();
		
		String authType="";
		User settingUser = new User();
		
		if(user.getPhone().equals("") || user.getPhone().equals("--") || user.getPhone().equals(" - - ")||user.getPhone()==null) {
			settingUser.setUserName(user.getUserName());
			settingUser.setEmail(user.getEmail());
			idList = userService.getUserIdList(settingUser);
			authType = "email";
		}else if(user.getEmail().equals("") || user.getEmail().equals(" @ ") || user.getEmail().equals("@") || user.getEmail()==null) {
			settingUser.setUserName(user.getUserName());
			settingUser.setPhone(user.getPhone());
			idList = userService.getUserIdList(settingUser);
			authType = "phone";
		}
		
		List<String> starIdList = new ArrayList<String>();
		for(int i=0;i<idList.size();i++) {
			String star="";
			for(int j=0;j<idList.get(i).length()-3;j++) {
				star+="*";
			}
			starIdList.add(idList.get(i).substring(0,3)+star);
		}
		
		model.addAttribute("authType",authType);
		model.addAttribute("starIdList" , starIdList);
		model.addAttribute("user",user);
		
		return"forward:/view/user/searchIdConfirm.jsp";
	}
	
	@RequestMapping(value="updateUser" , method = RequestMethod.GET)
	public String updateUser(Model model , HttpSession session) {
		System.out.println("userController updateUser GET");
		if(session.getAttribute("user")==null) {
			return"redirect:/main.jsp";
		}
		
		List<TripSurvey> countryList = countryList();
		List<TripSurvey> tripStyleList = tripStyleList();
		
		model.addAttribute("countryList",countryList);
		model.addAttribute("tripStyleList",tripStyleList);
		
		
		return"forward:/view/user/updateUser.jsp";
	}
	
	
	@RequestMapping(value="updateUser",method=RequestMethod.POST)
	public String updateUser(@ModelAttribute("user") User user ,HttpSession session, Model model) throws Exception {
		System.out.println("userController updateUser POST");
		
		User currentUser = (User)session.getAttribute("user");
		currentUser.setNickname(user.getNickname());
		currentUser.setEmail(user.getEmail());
		currentUser.setPhone(user.getPhone());
		currentUser.setPushAgree(user.getPushAgree());
		myPageService.deleteTripSurvey(currentUser.getUserId());
		
		
		MultipartFile mhsr = (MultipartFile)user.getImage();
		if( mhsr.isEmpty() == false) {	//null 체크로 잡을 수 없음! 
			
			String fileName = mhsr.getOriginalFilename();
			fileName = uploadFile(fileName, mhsr.getBytes());
			
			currentUser.setUserImg(fileName);
			
		}
		userService.updateUser(currentUser);
		
		if(user.getDreamCountry()!=null) {
			
			for(int i=0;i<(user.getDreamCountry().size());i++) {
				if(user.getDreamCountry().get(i).equals("")) {
					continue;
				}
				
				TripSurvey tripSurvey = new TripSurvey();
				tripSurvey.setUserId(currentUser.getUserId());
				tripSurvey.setSurveyChoice(user.getDreamCountry().get(i));
				tripSurvey.setSurveyImg(user.getCountryImg().get(i));
				tripSurvey.setSurveyType("D");
				myPageService.addTripSurvey(tripSurvey);
			}
		
		}
		
		if(user.getTripStyle()!=null) {
			
			for(int j=0;j<(user.getTripStyle().size());j++) {
				if(user.getTripStyle().get(j).equals("")) {
					continue;
				}
				
				TripSurvey tripSurvey = new TripSurvey();
				tripSurvey.setUserId(currentUser.getUserId());
				tripSurvey.setSurveyChoice(user.getTripStyle().get(j));
				tripSurvey.setSurveyImg(user.getStyleImg().get(j));
				tripSurvey.setSurveyType("T");
				myPageService.addTripSurvey(tripSurvey);
			}
		
		}
		
		User reloadUser = userService.getUser(currentUser.getUserId());
		session.setAttribute("user", reloadUser);
		
		
		return "redirect:/user/getUser";
	}
	
	
	private String uploadFile(String originalName, byte[] fileData) throws Exception{
		//uuid 생성 (Universal Unique IDentifier, 범용 고유 식별자)
		UUID uuid = UUID.randomUUID();
		
		String savedName = uuid.toString()+"_"+originalName;
		File target = new File(uploadPath, savedName);
		//임시 디렉토리에 저장된 업로드된 파일을 지정된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}
	
	
	@RequestMapping( value = "googleLoginLogic")
	public String googleLoginLogic(@RequestParam("code")String code , HttpSession session ,Model model) throws Exception {
		String clientId = "474522905430-f6nkrljp2qocnq1mop0ve2oc5ng91q38.apps.googleusercontent.com";
		String clientSecret = "sQXO8VNc55wULLrJHNhg0GHi";
		String googleTokenurl =	"https://accounts.google.com/o/oauth2/token?";
		
		  URL googleTokenURL = new URL(googleTokenurl);
		  HttpURLConnection googleTokenCon = (HttpURLConnection)googleTokenURL.openConnection();
		  googleTokenCon.setRequestMethod("POST");
		  googleTokenCon.setDoOutput(true);
		  
		  BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(googleTokenCon.getOutputStream()));
		  String postData = 	"grant_type=" + "authorization_code" + 
				  	"&client_secret="+clientSecret+
					"&client_id=" + clientId + 
					"&redirect_uri=" + "http://localhost:8080/user/googleLoginLogic" + 
					"&code=" + code;
		  
		  bw.write(postData);
		  bw.flush();
		  int googleTokenResponseCode = googleTokenCon.getResponseCode();
		  BufferedReader googleTokenBr =  null;
		  if( googleTokenResponseCode == 200 ) {
				googleTokenBr = new BufferedReader(new InputStreamReader(googleTokenCon.getInputStream(), "UTF-8"));
			}
			else {
				googleTokenBr = new BufferedReader(new InputStreamReader(googleTokenCon.getErrorStream()));
			}
		  
		  String googleTokenLine = "";
			StringBuffer googleTokenResponse = new StringBuffer();
			
		  while( (googleTokenLine = googleTokenBr.readLine()) != null ) {
			  googleTokenResponse.append(googleTokenLine);
			}
		  
		 googleTokenBr.close(); 
		  
		 JSONObject googleTokenJSONObject = (JSONObject)JSONValue.parse(googleTokenResponse.toString());
		  
		 ObjectMapper objectMapper = new ObjectMapper();
		 Map<String , String> tokenMap = objectMapper.readValue(googleTokenJSONObject.toString(),new TypeReference<Map<String,String>>(){}); 
		 
		 String token = tokenMap.get("access_token");
		 String header = "Bearer " + token;
		 
		 String googleLoginUrl = "https://www.googleapis.com/oauth2/v1/userinfo?";
		 
		 URL googleLoginURL = new URL(googleLoginUrl);
		 
		  HttpURLConnection googleLoginCon = (HttpURLConnection)googleLoginURL.openConnection();
          
          googleLoginCon.setRequestMethod("GET");
          
          googleLoginCon.setRequestProperty("Authorization", header);
          
          int googleLoginResponseCode = googleLoginCon.getResponseCode();
          
          BufferedReader googleLoginBr;
         
          if( googleLoginResponseCode == 200 ) { 
          	googleLoginBr = new BufferedReader(new InputStreamReader(googleLoginCon.getInputStream(), "UTF-8"));
          } else {  
          	googleLoginBr = new BufferedReader(new InputStreamReader(googleLoginCon.getErrorStream()));
          }
          
          String googleLoginLine = "";
          
          StringBuffer googleLoginResponse = new StringBuffer();
          
          while ((googleLoginLine = googleLoginBr.readLine()) != null) {
          	googleLoginResponse.append(googleLoginLine);
          }
          
          googleLoginBr.close();
          
          JSONObject googleLoginJSONObject = (JSONObject)JSONValue.parse(googleLoginResponse.toString());
          Map<String,String> googleProfile = objectMapper.readValue(googleLoginJSONObject.toString(),new TypeReference<Map<String,Object>>(){});
          System.out.println("=============구글로그인 정보!================");
          System.out.println(googleProfile);
          System.out.println("id="+googleProfile.get("id"));
          System.out.println("name= "+googleProfile.get("name"));
          System.out.println("email= "+googleProfile.get("email"));
          System.out.println("thumbnail= "+googleProfile.get("picture"));
		  System.out.println("=========================================");
		  User user = new User();
		  user.setUserName(googleProfile.get("name"));
		  user.setUserId(googleProfile.get("email"));
		  user.setNickname(googleProfile.get("given_name"));
		  user.setEmail(googleProfile.get("email"));
		  user.setEmailId(googleProfile.get("email").split("@")[0]);
		  user.setChoiceEmail(googleProfile.get("email").split("@")[1]);
		  user.setUserImg(googleProfile.get("picture"));
		  
		  model.addAttribute("snsUser" , user);
		  model.addAttribute("loginType" , "sns");
		  session.setAttribute("snsLogin", user);
		  return "forward:/view/user/pathLoginInfo.jsp";
	}
	
	
	@RequestMapping(value="findPwd")
	public String findPwd(HttpSession session) {
		if(session.getAttribute("user")!=null) {
			return"redirect:/main.jsp";
		}
		return "redirect:/view/user/findPwd.jsp";
	}
	
	@RequestMapping(value="updatePwd" , method=RequestMethod.GET)
	public String updatePwd(@RequestParam("userId") String userId , Model model,HttpSession session) {
		if(session.getAttribute("user")!=null) {
			return"redirect:/main.jsp";
		}
		model.addAttribute("userId" , userId);
		return "forward:/view/user/updatePwd.jsp";
	}
	
	@RequestMapping(value="updatePwd" , method=RequestMethod.POST)
	public String updatePwd(@ModelAttribute("user")User user , Model model , HttpSession session)throws Exception {
		System.out.println("updatePwd");
		System.out.println(user);
		
		if(session.getAttribute("user")!=null) {
			return"redirect:/main.jsp";
		}
		
		if(userService.getUser(user.getUserId())==null){
			System.out.println("일치하는 데이터가 없음");
		}else {
			userService.updatePwd(user);
			System.out.println("업데이트 완료했음다~");
		}
		
		
		return "redirect:/view/user/updatePwdConfirm.jsp";
	}
	
	@RequestMapping( value = "naverLoginLogic" )
	public String naverLoginLogic( @RequestParam("code") String code, @RequestParam("state") String state, HttpSession session , Model model) throws Exception {
		String clientId = "zmMH7F27NTAzH6EBj4dk";
		String clientSecret = "eNa1m8zS0g";
		String tokenUrl = 	"https://nid.naver.com/oauth2.0/token?" + 
								"grant_type=authorization_code" + 
								"&client_id=" + clientId + 
								"&client_secret=" + clientSecret + 
								"&code=" + code + 
								"&state=" + state;
		URL tokenURL = new URL(tokenUrl);
		User user = new User();
		HttpURLConnection tokenCon = (HttpURLConnection)tokenURL.openConnection();
		tokenCon.setRequestMethod("GET");
		
		int tokenResponseCode = tokenCon.getResponseCode();
		
		BufferedReader tokenBr =  null;
		
		if( tokenResponseCode == 200 ) { // Http 200 OK일 때 tokenCon.getInputStream() UTF-8 인코딩해서 읽음 
			tokenBr = new BufferedReader(new InputStreamReader(tokenCon.getInputStream(), "UTF-8"));
		}
		else { // 에러 발생시 tokenCon.getErrorStream()을 읽음 
			tokenBr = new BufferedReader(new InputStreamReader(tokenCon.getErrorStream()));
		}
		
		String tokenJsonData = "";
		StringBuffer tokenResponse = new StringBuffer();
		while( ( tokenJsonData = tokenBr.readLine() ) != null ) {
			tokenResponse.append(tokenJsonData);
		}
		tokenBr.close();
		JSONObject jsonObject = (JSONObject)JSONValue.parse(tokenResponse.toString());
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> tokenMap = objectMapper.readValue(jsonObject.toString(), new TypeReference<Map<String, String>>(){});
		
		
		String accessToken = tokenMap.get("access_token");
		
        Map<String, String> profileMap = new HashMap<String, String>();
        
        try {
            String naverLoginUrl = "https://openapi.naver.com/v1/nid/me";
            
            URL naverLoginURL = new URL(naverLoginUrl);
            
            HttpURLConnection naverLoginCon = (HttpURLConnection)naverLoginURL.openConnection();
            
            naverLoginCon.setRequestMethod("GET");
            
            String header = "Bearer " + accessToken;
            
            naverLoginCon.setRequestProperty("Authorization", header);
            
            int naverLoginResponseCode = naverLoginCon.getResponseCode();
            
            BufferedReader naverLoginBr;
            
            if( naverLoginResponseCode == 200 ) { 
            	naverLoginBr = new BufferedReader(new InputStreamReader(naverLoginCon.getInputStream(), "UTF-8"));
            } else {  
            	naverLoginBr = new BufferedReader(new InputStreamReader(naverLoginCon.getErrorStream()));
            }
            
            String inputLine;
            
            StringBuffer naverLoginResponse = new StringBuffer();
            
            while ( ( inputLine = naverLoginBr.readLine() ) != null ) {
            	naverLoginResponse.append(inputLine);
            }
            
            naverLoginBr.close();
            
            
            
            jsonObject = (JSONObject)JSONValue.parse(naverLoginResponse.toString());
            profileMap = objectMapper.readValue(jsonObject.get("response").toString(), new TypeReference<Map<String, String>>(){});
        } catch (Exception e) {
            System.out.println(e);
        }
		
        System.out.println("------------------profileMap" + profileMap);
        String id = profileMap.get("id");
		System.out.println("-------------------profileMap.get(id) : " + id);
		
		String name = profileMap.get("name");
		String email = profileMap.get("email");
		System.out.println("==================================================");
		
		user.setUserId(profileMap.get("email"));
		user.setNickname(profileMap.get("nickname"));
		user.setEmail(profileMap.get("email"));
		user.setEmailId(profileMap.get("email").split("@")[0]);
		user.setChoiceEmail(profileMap.get("email").split("@")[1]);
		user.setUserImg(profileMap.get("profile_image"));
		
		
		
		
		int index = email.indexOf("@");
		
		String userId = email.substring(0, index);
		
		session.setAttribute("snsLogin", user);
		model.addAttribute("snsUser",user);
		model.addAttribute("loginType","sns");
		
		
		return "forward:/view/user/pathLoginInfo.jsp";
	}
	
	
	@RequestMapping( value = "kakaoLoginLogic" )
	public String kakaoLoginLogic( @RequestParam("code") String code, HttpSession session ,Model model) throws Exception {
		String clientId = "0813ef39292fbdbe6ad4d20b0a049724";
		
		String kakaoTokenUrl = 	"https://kauth.kakao.com/oauth/token";
        User user = new User();

		URL kakaoTokenURL = new URL(kakaoTokenUrl);
		HttpURLConnection kakaoTokenCon = (HttpURLConnection)kakaoTokenURL.openConnection();
		kakaoTokenCon.setRequestMethod("POST");
		kakaoTokenCon.setDoOutput(true);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(kakaoTokenCon.getOutputStream()));
		
		String postData = 	"grant_type=" + "authorization_code" + 
							"&client_id=" + clientId + 
							"&redirect_uri=" + "http://192.168.0.70:8080/user/kakaoLoginLogic" + 
							"&code=" + code;
		
		bw.write(postData);
		bw.flush();
		
		int kakaoTokenResponseCode = kakaoTokenCon.getResponseCode();
		
		BufferedReader kakaoTokenBr =  null;
		
		if( kakaoTokenResponseCode == 200 ) {
			kakaoTokenBr = new BufferedReader(new InputStreamReader(kakaoTokenCon.getInputStream(), "UTF-8"));
		}
		else {
			kakaoTokenBr = new BufferedReader(new InputStreamReader(kakaoTokenCon.getErrorStream()));
		}
		
		String kakaoTokenLine = "";
		StringBuffer kakaoTokenResponse = new StringBuffer();
		
		while( (kakaoTokenLine = kakaoTokenBr.readLine()) != null ) {
			kakaoTokenResponse.append(kakaoTokenLine);
		}
		
		kakaoTokenBr.close();
		
			
		JSONObject kakaoTokenJSONObject = (JSONObject)JSONValue.parse(kakaoTokenResponse.toString());
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		Map<String, String> tokenMap = objectMapper.readValue(kakaoTokenJSONObject.toString(), new TypeReference<Map<String, String>>(){});
		
		String token = tokenMap.get("access_token");
		
		
		session.setAttribute("accessToken", token);
		session.setAttribute("refreshToken", tokenMap.get("refresh_token"));
       
        Map<String, Object> profileMap = new HashMap<String, Object>();
        Map<String, Object> kakaoAccount = new HashMap<String, Object>();
        Map<String, String> b = new HashMap<String, String>();
        String kakaoId = "";
        
        try {
        	String header = "Bearer " + token;
            String kakaoLoginUrl = "https://kapi.kakao.com/v2/user/me";
            
            URL kakaoLoginURL = new URL(kakaoLoginUrl);
            
            HttpURLConnection kakaoLoginCon = (HttpURLConnection)kakaoLoginURL.openConnection();
            
            kakaoLoginCon.setRequestMethod("GET");
            
            kakaoLoginCon.setRequestProperty("Authorization", header);
            
            int kakaoLoginResponseCode = kakaoLoginCon.getResponseCode();
            
            BufferedReader kakaoLoginBr;
            
            if( kakaoLoginResponseCode == 200 ) { 
            	kakaoLoginBr = new BufferedReader(new InputStreamReader(kakaoLoginCon.getInputStream(), "UTF-8"));
            } else {  
            	kakaoLoginBr = new BufferedReader(new InputStreamReader(kakaoLoginCon.getErrorStream()));
            }
            
            String kakaoLoginLine = "";
            
            StringBuffer kakaoLoginResponse = new StringBuffer();
            
            while ((kakaoLoginLine = kakaoLoginBr.readLine()) != null) {
            	kakaoLoginResponse.append(kakaoLoginLine);
            }
            
            kakaoLoginBr.close();
            
            
            JSONObject kakaoLoginJSONObject = (JSONObject)JSONValue.parse(kakaoLoginResponse.toString());
            
            
            
            profileMap = objectMapper.readValue(kakaoLoginJSONObject.get("properties").toString(), new TypeReference<Map<String, Object>>(){});
            kakaoId = objectMapper.readValue(kakaoLoginJSONObject.get("id").toString(), String.class);
            kakaoAccount = objectMapper.readValue(kakaoLoginJSONObject.get("kakao_account").toString(), new TypeReference<Map<String, Object>>(){});
            
            b=(Map<String, String>)kakaoAccount.get("profile");
            System.out.println("===========================");
            System.out.println(b.get("nickname"));
            System.out.println(kakaoAccount.get("email"));
            System.out.println(profileMap.get("profile_image"));
            //System.out.println(profileMap.get("email"));
            
            System.out.println("==========================");
            user.setUserId(((String)kakaoAccount.get("email")));
            user.setNickname(b.get("nickname"));
            user.setUserImg(b.get("thumbnail_image_url"));
            user.setEmail((String)kakaoAccount.get("email"));
            user.setEmailId(((String)kakaoAccount.get("email")).split("@")[0]);
            user.setChoiceEmail(((String)kakaoAccount.get("email")).split("@")[1]);
            
        } catch (Exception e) {
            System.out.println(e);
        }
        
        String userName = (String)profileMap.get("nickname");
        
        // DB에 카카오 아이디를 생성할 때 구분할 수 있도록 앞에 kakao 문자열 추가 
        String userId = "kakao" + kakaoId;
        
        
        
        User kakaoUser = new User();
        System.out.println(kakaoAccount.get("profile"));
        
        
        model.addAttribute("snsUser",user);
        model.addAttribute("loginType","sns");
        session.setAttribute("snsLogin", user);
		return "forward:/view/user/pathLoginInfo.jsp";
	}
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	public List<TripSurvey> tripStyleList(){
		List<TripSurvey> tripStyleList = new ArrayList<TripSurvey>();
		
		TripSurvey tripSurvey1 = new TripSurvey();
		tripSurvey1.setSurveyChoice("술");
		tripSurvey1.setSurveyImg("sul.jpg");
		tripStyleList.add(tripSurvey1);
		
		TripSurvey tripSurvey2 = new TripSurvey();
		tripSurvey2.setSurveyChoice("커피");
		tripSurvey2.setSurveyImg("coffee.jpeg");
		tripStyleList.add(tripSurvey2);
		
		TripSurvey tripSurvey3 = new TripSurvey();
		tripSurvey3.setSurveyChoice("관광");
		tripSurvey3.setSurveyImg("guanguang.jpeg");
		tripStyleList.add(tripSurvey3);
		
		TripSurvey tripSurvey4 = new TripSurvey();
		tripSurvey4.setSurveyChoice("힐링");
		tripSurvey4.setSurveyImg("heeling.jpeg");
		tripStyleList.add(tripSurvey4);
		
		TripSurvey tripSurvey5 = new TripSurvey();
		tripSurvey5.setSurveyChoice("먹방");
		tripSurvey5.setSurveyImg("mukbang.jpeg");
		tripStyleList.add(tripSurvey5);
		
		TripSurvey tripSurvey6 = new TripSurvey();
		tripSurvey6.setSurveyChoice("종교");
		tripSurvey6.setSurveyImg("cross.jpeg");
		tripStyleList.add(tripSurvey6);
		
		TripSurvey tripSurvey7 = new TripSurvey();
		tripSurvey7.setSurveyChoice("숙소");
		tripSurvey7.setSurveyImg("sukso.jpeg");
		tripStyleList.add(tripSurvey7);
		
		TripSurvey tripSurvey8 = new TripSurvey();
		tripSurvey8.setSurveyChoice("렌트카");
		tripSurvey8.setSurveyImg("car.jpeg");
		tripStyleList.add(tripSurvey8);
		
		TripSurvey tripSurvey9 = new TripSurvey();
		tripSurvey9.setSurveyChoice("스포츠");
		tripSurvey9.setSurveyImg("sport.jpeg");
		tripStyleList.add(tripSurvey9);
		
		TripSurvey tripSurvey10 = new TripSurvey();
		tripSurvey10.setSurveyChoice("쇼핑");
		tripSurvey10.setSurveyImg("shoping.jpeg");
		tripStyleList.add(tripSurvey10);
		
		TripSurvey tripSurvey11= new TripSurvey();
		tripSurvey11.setSurveyChoice("와인");
		tripSurvey11.setSurveyImg("wine.jpeg");
		tripStyleList.add(tripSurvey11);
		
		TripSurvey tripSurvey12 = new TripSurvey();
		tripSurvey12.setSurveyChoice("디저트");
		tripSurvey12.setSurveyImg("desert.jpeg");
		tripStyleList.add(tripSurvey12);
		
		TripSurvey tripSurvey13 = new TripSurvey();
		tripSurvey13.setSurveyChoice("그림");
		tripSurvey13.setSurveyImg("draw.jpeg");
		tripStyleList.add(tripSurvey13);
		
		TripSurvey tripSurvey14 = new TripSurvey();
		tripSurvey14.setSurveyChoice("축제");
		tripSurvey14.setSurveyImg("festival.jpeg");
		tripStyleList.add(tripSurvey14);
		
		TripSurvey tripSurvey15 = new TripSurvey();
		tripSurvey15.setSurveyChoice("게임");
		tripSurvey15.setSurveyImg("game.jpeg");
		tripStyleList.add(tripSurvey15);
		
		TripSurvey tripSurvey16 = new TripSurvey();
		tripSurvey16.setSurveyChoice("IT");
		tripSurvey16.setSurveyImg("it.png");
		tripStyleList.add(tripSurvey16);
		
		TripSurvey tripSurvey17 = new TripSurvey();
		tripSurvey17.setSurveyChoice("만남");
		tripSurvey17.setSurveyImg("mannam.jpeg");
		tripStyleList.add(tripSurvey17);
		
		TripSurvey tripSurvey18 = new TripSurvey();
		tripSurvey18.setSurveyChoice("영화");
		tripSurvey18.setSurveyImg("movie.png");
		tripStyleList.add(tripSurvey18);
		
		TripSurvey tripSurvey19 = new TripSurvey();
		tripSurvey19.setSurveyChoice("바다");
		tripSurvey19.setSurveyImg("sea.jpeg");
		tripStyleList.add(tripSurvey19);
		
		TripSurvey tripSurvey20 = new TripSurvey();
		tripSurvey20.setSurveyChoice("산");
		tripSurvey20.setSurveyImg("mountain.jpeg");
		tripStyleList.add(tripSurvey20);
		
		return tripStyleList;
	}
	
	
	public List<TripSurvey> countryList(){
	List<TripSurvey> dreamCountryList = new ArrayList<TripSurvey>();
		
		TripSurvey tripSurvey1 = new TripSurvey();
		tripSurvey1.setSurveyChoice("그리스");
		tripSurvey1.setSurveyImg("Greece.gif");
		dreamCountryList.add(tripSurvey1);
		
		TripSurvey tripSurvey2 = new TripSurvey();
		tripSurvey2.setSurveyChoice("네덜란드");
		tripSurvey2.setSurveyImg("Netherlands.gif");
		dreamCountryList.add(tripSurvey2);
		
		TripSurvey tripSurvey3 = new TripSurvey();
		tripSurvey3.setSurveyChoice("노르웨이");
		tripSurvey3.setSurveyImg("norway.gif");
		dreamCountryList.add(tripSurvey3);
		
		TripSurvey tripSurvey4 = new TripSurvey();
		tripSurvey4.setSurveyChoice("덴마크");
		tripSurvey4.setSurveyImg("Denmark.gif");
		dreamCountryList.add(tripSurvey4);
		
		TripSurvey tripSurvey5 = new TripSurvey();
		tripSurvey5.setSurveyChoice("라트비아");
		tripSurvey5.setSurveyImg("Latvia.gif");
		dreamCountryList.add(tripSurvey5);

		TripSurvey tripSurvey6 = new TripSurvey();
		tripSurvey6.setSurveyChoice("독일");
		tripSurvey6.setSurveyImg("Germany.gif");
		dreamCountryList.add(tripSurvey6);
		
		TripSurvey tripSurvey7 = new TripSurvey();
		tripSurvey7.setSurveyChoice("루마니아");
		tripSurvey7.setSurveyImg("Romania.gif");
		dreamCountryList.add(tripSurvey7);
		
		TripSurvey tripSurvey8 = new TripSurvey();
		tripSurvey8.setSurveyChoice("룩셈부르크");
		
		tripSurvey8.setSurveyImg("Luxembourg.gif");
		dreamCountryList.add(tripSurvey8);
		
		TripSurvey tripSurvey9 = new TripSurvey();
		tripSurvey9.setSurveyChoice("리투아니아");
		tripSurvey9.setSurveyImg("Lithuania.gif");
		dreamCountryList.add(tripSurvey9);
		
		TripSurvey tripSurvey10 = new TripSurvey();
		tripSurvey10.setSurveyChoice("리히텐슈타인");
		tripSurvey10.setSurveyImg("Liechtenstein.gif");
		dreamCountryList.add(tripSurvey10);
		
		TripSurvey tripSurvey11 = new TripSurvey();
		tripSurvey11.setSurveyChoice("모나코");
		tripSurvey11.setSurveyImg("Monaco.gif");
		dreamCountryList.add(tripSurvey11);

		TripSurvey tripSurvey12 = new TripSurvey();
		tripSurvey12.setSurveyChoice("몬테네그로");
		tripSurvey12.setSurveyImg("Montenegro.gif");
		dreamCountryList.add(tripSurvey12);
		
		TripSurvey tripSurvey13 = new TripSurvey();
		tripSurvey13.setSurveyChoice("몰도바");
		tripSurvey13.setSurveyImg("Moldova.gif");
		dreamCountryList.add(tripSurvey13);
		
		TripSurvey tripSurvey14 = new TripSurvey();
		tripSurvey14.setSurveyChoice("몰타");
		tripSurvey14.setSurveyImg("Malta.gif");
		dreamCountryList.add(tripSurvey14);
		
		TripSurvey tripSurvey15 = new TripSurvey();
		tripSurvey15.setSurveyChoice("벨기에");
		tripSurvey15.setSurveyImg("Belgium.gif");
		dreamCountryList.add(tripSurvey15);
		
		TripSurvey tripSurvey16 = new TripSurvey();
		tripSurvey16.setSurveyChoice("벨라루스");
		tripSurvey16.setSurveyImg("Belarus.gif");
		dreamCountryList.add(tripSurvey16);
		
		TripSurvey tripSurvey17 = new TripSurvey();
		tripSurvey17.setSurveyChoice("보스니아");
		tripSurvey17.setSurveyImg("BosniaHerzegovina.gif");
		dreamCountryList.add(tripSurvey17);
		
		TripSurvey tripSurvey18 = new TripSurvey();
		tripSurvey18.setSurveyChoice("북마케도니아");
		tripSurvey18.setSurveyImg("Macedonia.gif");
		dreamCountryList.add(tripSurvey18);
		
		TripSurvey tripSurvey19 = new TripSurvey();
		tripSurvey19.setSurveyChoice("불가리아");
		tripSurvey19.setSurveyImg("Bulgaria.gif");
		dreamCountryList.add(tripSurvey19);
		
		TripSurvey tripSurvey20 = new TripSurvey();
		tripSurvey20.setSurveyChoice("사이프러스");
		tripSurvey20.setSurveyImg("Cyprus.gif");
		dreamCountryList.add(tripSurvey20);
		
		TripSurvey tripSurvey21 = new TripSurvey();
		tripSurvey21.setSurveyChoice("산마리노");
		tripSurvey21.setSurveyImg("SanMarino.gif");
		dreamCountryList.add(tripSurvey21);
		
		TripSurvey tripSurvey22 = new TripSurvey();
		tripSurvey22.setSurveyChoice("세르비아");
		tripSurvey22.setSurveyImg("Serbia.gif");
		dreamCountryList.add(tripSurvey22);
		
		TripSurvey tripSurvey23 = new TripSurvey();
		tripSurvey23.setSurveyChoice("스웨덴");
		tripSurvey23.setSurveyImg("Sweden.gif");
		dreamCountryList.add(tripSurvey23);
		
		TripSurvey tripSurvey24 = new TripSurvey();
		tripSurvey24.setSurveyChoice("스위스");
		tripSurvey24.setSurveyImg("Swiss.gif");
		dreamCountryList.add(tripSurvey24);
		
		TripSurvey tripSurvey25 = new TripSurvey();
		tripSurvey25.setSurveyChoice("스페인");
		tripSurvey25.setSurveyImg("Spain.gif");
		dreamCountryList.add(tripSurvey25);
		
		TripSurvey tripSurvey26 = new TripSurvey();
		tripSurvey26.setSurveyChoice("슬로바키아");
		tripSurvey26.setSurveyImg("Slovak.gif");
		dreamCountryList.add(tripSurvey26);
		
		TripSurvey tripSurvey27 = new TripSurvey();
		tripSurvey27.setSurveyChoice("슬로베니아");
		tripSurvey27.setSurveyImg("Slovenia.jpeg");
		dreamCountryList.add(tripSurvey27);
		
		TripSurvey tripSurvey28 = new TripSurvey();
		tripSurvey28.setSurveyChoice("아르메니아");
		tripSurvey28.setSurveyImg("Armenia.gif");
		dreamCountryList.add(tripSurvey28);
		
		TripSurvey tripSurvey29 = new TripSurvey();
		tripSurvey29.setSurveyChoice("아이슬란드");
		tripSurvey29.setSurveyImg("Iceland.gif");
		dreamCountryList.add(tripSurvey29);
		
		TripSurvey tripSurvey30 = new TripSurvey();
		tripSurvey30.setSurveyChoice("아일랜드");
		tripSurvey30.setSurveyImg("Ireland.gif");
		dreamCountryList.add(tripSurvey30);
		
		TripSurvey tripSurvey31 = new TripSurvey();
		tripSurvey31.setSurveyChoice("아제르바이잔");
		tripSurvey31.setSurveyImg("Azerbaijan.gif");
		dreamCountryList.add(tripSurvey31);
		
		TripSurvey tripSurvey32 = new TripSurvey();
		tripSurvey32.setSurveyChoice("안도라");
		tripSurvey32.setSurveyImg("Andorra.gif");
		dreamCountryList.add(tripSurvey32);
		
		TripSurvey tripSurvey33 = new TripSurvey();
		tripSurvey33.setSurveyChoice("알바니아");
		tripSurvey33.setSurveyImg("Albania.gif");
		dreamCountryList.add(tripSurvey33);
		
		TripSurvey tripSurvey34 = new TripSurvey();
		tripSurvey34.setSurveyChoice("에스토니아");
		tripSurvey34.setSurveyImg("Estonia.gif");
		dreamCountryList.add(tripSurvey34);
		
		TripSurvey tripSurvey35 = new TripSurvey();
		tripSurvey35.setSurveyChoice("영국");
		tripSurvey35.setSurveyImg("England.gif");
		dreamCountryList.add(tripSurvey35);
		
		TripSurvey tripSurvey36 = new TripSurvey();
		tripSurvey36.setSurveyChoice("오스트리아");
		tripSurvey36.setSurveyImg("Austria.gif");
		dreamCountryList.add(tripSurvey36);
		
		TripSurvey tripSurvey37= new TripSurvey();
		tripSurvey37.setSurveyChoice("우크라이나");
		tripSurvey37.setSurveyImg("Ukraine.gif");
		dreamCountryList.add(tripSurvey37);
		
		TripSurvey tripSurvey38 = new TripSurvey();
		tripSurvey38.setSurveyChoice("이탈리아");
		tripSurvey38.setSurveyImg("Italian.gif");
		dreamCountryList.add(tripSurvey38);
		
		TripSurvey tripSurvey39 = new TripSurvey();
		tripSurvey39.setSurveyChoice("조지아");
		tripSurvey39.setSurveyImg("Georgia.gif");
		dreamCountryList.add(tripSurvey39);
		
		TripSurvey tripSurvey40 = new TripSurvey();
		tripSurvey40.setSurveyChoice("체코");
		tripSurvey40.setSurveyImg("Czech.gif");
		dreamCountryList.add(tripSurvey40);
		
		TripSurvey tripSurvey41 = new TripSurvey();
		tripSurvey41.setSurveyChoice("크로아티아");
		tripSurvey41.setSurveyImg("Croatia.gif");
		dreamCountryList.add(tripSurvey41);
		
		TripSurvey tripSurvey42 = new TripSurvey();
		tripSurvey42.setSurveyChoice("터키");
		tripSurvey42.setSurveyImg("Turkey.gif");
		dreamCountryList.add(tripSurvey42);
		
		TripSurvey tripSurvey43 = new TripSurvey();
		tripSurvey43.setSurveyChoice("포르투갈");
		tripSurvey43.setSurveyImg("Portugal.gif");
		dreamCountryList.add(tripSurvey43);
		
		TripSurvey tripSurvey44 = new TripSurvey();
		tripSurvey44.setSurveyChoice("폴란드");
		tripSurvey44.setSurveyImg("Poland.png");
		dreamCountryList.add(tripSurvey44);
		
		TripSurvey tripSurvey45 = new TripSurvey();
		tripSurvey45.setSurveyChoice("프랑스");
		tripSurvey45.setSurveyImg("France.gif");
		dreamCountryList.add(tripSurvey45);
		
		TripSurvey tripSurvey46 = new TripSurvey();
		tripSurvey46.setSurveyChoice("핀란드");
		tripSurvey46.setSurveyImg("Finland.gif");
		dreamCountryList.add(tripSurvey46);
		
		TripSurvey tripSurvey47 = new TripSurvey();
		tripSurvey47.setSurveyChoice("헝가리");
		tripSurvey47.setSurveyImg("Hungary.gif");
		dreamCountryList.add(tripSurvey47);
		
		return dreamCountryList;
	}
	

}
