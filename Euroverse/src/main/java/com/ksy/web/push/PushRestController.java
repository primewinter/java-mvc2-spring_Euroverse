package com.ksy.web.push;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.common.Config;
import com.ksy.common.Page;
import com.ksy.common.Search;
import com.ksy.common.util.Util;
import com.ksy.service.domain.Plan;
import com.ksy.service.domain.Push;
import com.ksy.service.domain.Todo;
import com.ksy.service.domain.User;
import com.ksy.service.plan.PlanService;
import com.ksy.service.push.PushService;


@RestController
@RequestMapping("/push/*")
public class PushRestController {
	
	@Autowired
	@Qualifier("pushServiceImpl")
	private PushService pushService;
	@Autowired
	@Qualifier("planServiceImpl")
	private PlanService planService;

	public PushRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="json/addPush")
	public void addPush(@RequestBody Push push) throws Exception {
		System.out.println("json/addPush :: @RequestBody Push : "+push);
		pushService.addPush(push);
	}
	
	@RequestMapping(value="json/getUnreadCount")
	public int getUnreadCount(@RequestBody User user) throws Exception {
		System.out.println("json/getUnreadCount :: @RequestBody User : "+user);
		int unreadCount = pushService.getUnreadCount(user.getUserId());

		return unreadCount;
	}
	
	@RequestMapping(value="json/getPushList/{userId}", method=RequestMethod.GET)
	public Map<String, Object> getPushList(@PathVariable("userId")String userId) throws Exception {
		System.out.println("json/getPushList :: @PathVariable : "+userId);
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(10);
		Map<String , Object> map = pushService.getPushList(search, userId);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", map.get("list"));
		result.put("resultPage", resultPage);
		result.put("totalCount", map.get("totalCount"));
		System.out.println(":: pushService.getPushList(search, userId) 완료");
		return result;
	}
	
	@RequestMapping(value="json/getPushList/{userId}", method=RequestMethod.POST)
	public List<Push> getPushList(@PathVariable("userId")String userId, @RequestBody Map<String, Object> jsonMap) throws Exception {
		System.out.println("json/getScrollList_POST :: @PathVariable : "+userId);
		
		ObjectMapper objectmapper = new ObjectMapper();
		Search search = objectmapper.convertValue(jsonMap.get("search"), Search.class);
		System.out.println("json/getScrollList_POST :: @RequestBody Search: "+search);
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(10);
		Map<String , Object> map = pushService.getPushList(search, userId);
		System.out.println(" :: pushService.getPushList(search, userId) 완료");
		
		return (List<Push>)map.get("list");
	}
	
	@RequestMapping(value="json/readPush/{userId}")
	public void readPush(@PathVariable("userId") String userId) throws Exception {
		System.out.println("json/readPush :: "+userId);
		pushService.readPush(userId);
	}
	
	@RequestMapping(value="json/deletePush")
	public void deletePush(@RequestBody List<String> pushId ) throws Exception {
		System.out.println("json/deletePush :: "+pushId);
		pushService.deletePush(pushId);
	}
	
	@RequestMapping(value="json/getUnreadCount/{userId}")
	public int getUnreadCount(@PathVariable("userId") String userId ) throws Exception {
		System.out.println("json/getUnreadCount :: "+userId);
		return pushService.getUnreadCount(userId);
	}
	
	@RequestMapping(value="json/enterPlan/{planId}")
	public String enterPlan(@PathVariable("planId") String planId ) throws Exception {
		System.out.println("json/enterPlan :: "+planId);
		return planId;
	}
	
	
	@Scheduled(cron = "0 0 10 * * *") //매일 10시에 문자 보내기
	public void pushSMS() throws Exception {
		// 1. d-30 planner
		pushSMSPlan(30);
		// 2. d-7 planner
		pushSMSPlan(7);
		// 3. d-3 planner
		pushSMSPlan(3);
		// 4. d-1 planner
		pushSMSPlan(1);
	}
	
	public void pushSMSPlan(int leftDay) throws Exception {
		PlanService planService = (PlanService)Util.getBean("planServiceImpl");
		List<Plan> planList = planService.getSoonPlan(leftDay);
		
		System.out.println(":::::: Euroverse D-"+leftDay+" 여행 SMS 알림 서비스 실행 ::::::: ");
		String appId = Config.appid;
    	String apiKey = Config.apikey;
    	String sender = Config.sender;
    	String subject = "Euroverse 여행 알리미 : ";

		String hostnamebefore = "api.bluehouselab.com";
        String urlbefore = "https://" + hostnamebefore + "/smscenter/v1.0/sendlms";

        CredentialsProvider credsProviderbefore = new BasicCredentialsProvider();
        credsProviderbefore.setCredentials(
            new AuthScope(hostnamebefore, 443, AuthScope.ANY_REALM),
            new UsernamePasswordCredentials(Config.appid, Config.apikey)
        );

        // Create AuthCache instance
        AuthCache authCachebefore = new BasicAuthCache();
        authCachebefore.put(new HttpHost(hostnamebefore, 443, "https"), new BasicScheme());

        // Add AuthCache to the execution context
        HttpClientContext contextbefore = HttpClientContext.create();
        contextbefore.setCredentialsProvider(credsProviderbefore);
        contextbefore.setAuthCache(authCachebefore);

        DefaultHttpClient clientbefore = new DefaultHttpClient();
        
    	// plan 하나에 담긴 정보 : plan title, 미완료 todo List, phone List 
		List<User> userList = new ArrayList<User>();
		List<String> phoneList = new ArrayList<String>();
		List<Todo> todoList = new ArrayList<Todo>();
		
		for( Plan plan : planList ) {
			userList = plan.getPlanPartyList();
			for(User user : userList) {
				String[] receiverPhone = user.getPhone().split("-");
				String phone = "";
				for(String temp:receiverPhone) {
					phone += temp;
				}
				phoneList.add(phone);
				System.out.println("문자 받는 사람 번호 : "+user.getPhone());
			}
			todoList = plan.getTodoList();
			System.out.println("plan.getStartDateString() : "+plan.getStartDateString());
			System.out.println(plan.getStartDate());
			String content = ""
					+ "여행 예정일("+plan.getStartDateString().substring(0, 10)+")이 "+leftDay+"일 앞으로 다가왔습니다."
					+"잊으신 건 없는지 확인해보세요!";
			for(int i = 0; i<todoList.size();i++) {
			//for(Todo todo : todoList) {
				content += (i+1) +". "+todoList.get(i).getTodoName()+" ";
				//content += todo.getTodoName();
			}
			subject += plan.getPlanTitle();
			System.out.println(" * * * 최종 문자 내용 * * * ");
			System.out.println(subject+content+"");
			
			try {
	            HttpPost httpPostbefore = new HttpPost(urlbefore);
	            httpPostbefore.setHeader("Content-type", "application/json; charset=utf-8");
	            Map<String, Object> smsMap = new HashMap<String, Object>();
	            smsMap.put("sender", sender);
	            smsMap.put("subject", subject);
	            smsMap.put("content", subject+" "+content);
	            smsMap.put("receivers", phoneList);
	            
	            ObjectMapper objectMapper = new ObjectMapper();
	            String jsonbefore = objectMapper.writeValueAsString(smsMap);
	            
	            System.out.println("\t\t\tjsonbefore ? : " + jsonbefore);
	            
	            StringEntity se = new StringEntity(jsonbefore, "UTF-8");
	            httpPostbefore.setEntity(se);
	
	            HttpResponse httpResponsebefore = clientbefore.execute(httpPostbefore, contextbefore);
	            System.out.println(httpResponsebefore.getStatusLine().getStatusCode());
	
	            InputStream inputStream = httpResponsebefore.getEntity().getContent();
	            
	            if(inputStream != null) {
	                BufferedReader bufferedReader = new BufferedReader( new InputStreamReader(inputStream));
	                String line = "";
	                while((line = bufferedReader.readLine()) != null)
	                    System.out.println(line);
	                inputStream.close();
		        }
	       } catch (Exception e) {
	            System.err.println("Error: "+e.getLocalizedMessage());
	       } finally {
	        	clientbefore.getConnectionManager().shutdown();
	       }
	            
		} // end of for문

	}
	

}
