package com.ksy.web.tripInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ksy.service.domain.TripInfo;
import com.ksy.service.tripInfo.TripInfoService;



//==> 회占쏙옙占쏙옙占쏙옙 RestController
@Controller
@RequestMapping("/api/*")
public class TripInfoController {
	
	///Field
	@Autowired
	@Qualifier("tripInfoServiceImpl")
	private TripInfoService service;
	
	
	private WebDriver driver;
	private WebElement webElement;
	
	// Properties
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static final String WEB_DRIVER_PATH = "C:\\chromedriver.exe";
	
	private String base_url;
		
	public TripInfoController(){
		System.out.println(this.getClass());
	}
	
	
	@RequestMapping(value="infinityClick", method=RequestMethod.GET)
	public String infinityClick(@ModelAttribute("tripInfo") TripInfo tripInfo, Model model) throws Exception{
		
		System.out.println("infinityClick Controller Start");
		
//		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
//		
//		//검색할 국가를 필드로 설정
//		driver = new ChromeDriver();
//		String dreamCity = "유럽";
//		
//		for (int no = 6; no < 10; no++) {
//		
//		// pixabay 홈페이지에서 크롤링 검색정보는 다이나믹하게
//		base_url = "https://pixabay.com/ko/images/search/" + dreamCity + "/?cat=buildings&pagi="+String.valueOf(no);
//		
//		//WebDriver로 web url 가져와서 실행 
//		driver.get(base_url);
//		//WebDriver로 xpath를 가져와서 click 시키기
//		driver.findElement(By.xpath("//*[@id=\"content\"]/div/div[1]/div/label/input")).click();
//		
//		//selenium에 제공되는 By Class를 이용하여 CssSeletor로 Css접근 
//		By picture = By.cssSelector("div.flex_grid.credits.search_results > div > a > img");
//		
//		//seletor로 접근한 tag를 webElement형태로 list에 저장.
//		List<WebElement> pictures = driver.findElements(picture);
//				
//		//디버깅
//		System.out.println("pictures ==>" + pictures);
//		System.out.println("pictures 디버깅 ==>" + pictures.size());
//		
//		//크롤링해온 값을 넣을 map생성.
//		Map<Integer, String> urlMap = new HashMap<Integer,String>();
//		Map<Integer, String> infoMap = new HashMap<Integer, String>();
//		webElement = driver.findElement(picture);
//		
//			//이미지,정보 크롤링
//			for (int i = 0; i < pictures.size(); i++) {
//						
//				//WebElement에 있는 getAttribute 메서드를 사용하기위해 cssSelector로 select해온 태그를 대입
//				WebElement pic = pictures.get(i);
//				
//				//이미지가 저장되있는 src태그와, alt태그에 값을 String 값으로 넣기
//				String url = pic.getAttribute("src");
//				String info = pic.getAttribute("alt");
//						
//				//각 이미지에 주소와 속성을 디버깅
////				System.out.println("url 디버깅 ==>"+url);
////				System.out.println("info 디버깅 ==>"+info);
//						
//				//크롤링해서 가져오는 data값에 확장자 (.gif)파일은 우리정보에 필요없는 일러스트 파일임 이 정보를 빼고 맵에 담기위한 if문 
//				if (url.contains("blank.gif")) {
//					
//					url =  null;
//					info = null;//blank가 들어간 url은 info도 삭제
//				
//				}else if(url != null && info != null) {
//							
//					urlMap.put(i,url);
//					infoMap.put(i,info);
//					System.out.println("urlMap ==>"+urlMap);
//					System.out.println("infoMap ==>"+infoMap);
//					
//				}//else if
//			}//end of for 
//			
//			for (int i = 0; i < urlMap.size(); i++) {
//				
//				tripInfo.setUrl(urlMap.get(i));
//				tripInfo.setInfo(infoMap.get(i));
//				
//				System.out.println("tripInfo 디버깅 ==>"+tripInfo);
//				
////				busness Losic Connect...
//				service.addUrl(tripInfo);
//				
//			}//end of inner_for
//			
//		}//end of outer_for
		
//			System.out.println("infinityClick 시작");
//			Random random = new Random();
//			
//			int id = random.nextInt(73);//랜덤 난수 발생 67번까지 사진이 67개여서
//			System.out.println("id 디버깅 ==>"+id);
//			
//			tripInfo = service.getUrl(id);//사진마다 부여된 id값을 이용해서 랜덤으로 호출하기
//			
//			System.out.println("TripInfo 디버깅 ==>"+tripInfo);
//			
//			model.addAttribute("tripInfo",tripInfo);
//			System.out.println("model 디버깅==>"+model);
			
		
		return "forward:/view/tripInfo/infinityClick.jsp";
		
	}
	
	@RequestMapping(value="exchange", method=RequestMethod.GET)
	public String exchange() throws Exception{
		
		return "forward:/view/tripInfo/exchange.jsp";
	
	}
	

}