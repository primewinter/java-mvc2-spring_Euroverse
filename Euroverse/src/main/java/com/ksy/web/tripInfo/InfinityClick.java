package com.ksy.web.tripInfo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.remote.internal.WebElementToJsonConverter;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class InfinityClick {
	
	public static void main(String[] args) throws Exception {
		
		System.out.println("main 메소드 실행???");
		//페이지마다 크롤링을 하기위해 for문 작동 
//		for(int i=1; i<2; i++) {
			InfinityClick selTest = new InfinityClick();
			selTest.imgCrawl();
			selTest.infoCrawl();
//		}
	}

	// WebDriver
	private WebDriver driver;
	private WebElement webElement;

	// Properties
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static final String WEB_DRIVER_PATH = "C:\\chromedriver.exe";

	private String base_url;
	
	//int값을 넘겨받아서 한페이지 한페이지 크롤링을 할수있음
	public InfinityClick() {

		// System Property SetUp
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
		
		//검색할 국가를 필드로 설정
		driver = new ChromeDriver();
		String dreamCity = "유럽";
		
		// pixabay 홈페이지에서 크롤링 검색정보는 다이나믹하게
		base_url = "https://pixabay.com/ko/images/search/" + dreamCity + "/?cat=buildings";
		//&pagi=+String.valueOf(no); 
	
	}

	public Map<Integer,String> imgCrawl() throws Exception {


		System.out.println("crawling start!!!!");
		
		//크롤링 해올 url 가져오기
		driver.get(base_url);
		driver.findElement(By.xpath("//*[@id=\"content\"]/div/div[1]/div/label/input")).click();
//		WebDriverWait wait = new WebDriverWait(driver,10000); 
		
		//selenium에 제공되는 By Class를 이용하여 CssSeletor로 Css접근 
		By picture = By.cssSelector("div.flex_grid.credits.search_results > div > a > img");
		
		//seletor로 접근한 tag를 webElement형태로 list에 저장.
		List<WebElement> pictures = driver.findElements(picture);
		
//				wait.until(ExpectedConditions.presenceOfAllElementsLocatedBy(picture)); // 화면 로딩시간을 기다려주는 메소드
		System.out.println("pictures ==>" + pictures);
		
		//디버깅
		System.out.println("pictures 디버깅 ==>" + pictures.size());
		
		//크롤링해온 값을 넣을 map생성.
		Map<Integer,String> urlMap = new HashMap<Integer,String>();
		webElement = driver.findElement(picture);
		
		for (int i = 0; i < pictures.size(); i++) {
			
			//WebElement에 있는 getAttribute 메서드를 사용하기위해 cssSelector로 selct해온 태그를 대입
			WebElement pic = pictures.get(i);
			
			//이미지가 저장되있는 src태그와, alt태그에 값을 String 값으로 넣기
			String url = pic.getAttribute("src");
			
			//각 이미지에 주소와 속성을 디버깅
			System.out.println("url 디버깅 ==>"+url);
			
			//크롤링해서 가져오는 data값에 확장자 (.gif)파일은 우리정보에 필요없는 일러스트 파일임 이 정보를 빼고 맵에 담기위한 if문 
			if (url.contains("blank.gif")) {
				
			}else {
				
				urlMap.put(i,url);
			}
			
		}
		
		//디버깅용
		System.out.println("urlMap==>"+urlMap);
		
		return urlMap;
	}
	
	public Map<Integer,String> infoCrawl() throws Exception {

		System.out.println("crawling start!!!!");
		//크롤링 해올 url 가져오기
		driver.get(base_url);
		driver.findElement(By.xpath("//*[@id=\"content\"]/div/div[1]/div/label/input")).click();
		
		//selenium에 제공되는 By Class를 이용하여 CssSeletor로 Css접근 
		By picture = By.cssSelector("div.flex_grid.credits.search_results > div > a > img");
		
		//seletor로 접근한 tag를 webElement형태로 list에 저장.
		List<WebElement> pictures = driver.findElements(picture);
		
		//디버깅
		System.out.println("pictures 디버깅 ==>" + pictures.size());
		
		//크롤링해온 값을 넣을 map생성.
		Map<Integer,String> infoMap = new HashMap<Integer,String>();
		
//		for(WebElement pic : pictures)
		for (int i = 0; i < pictures.size(); i++) {
			
			//WebElement에 있는 getAttribute 메서드를 사용하기위해 cssSelector로 selct해온 태그를 대입
			WebElement pic = pictures.get(i);
			
			//이미지가 저장되있는 src태그와, alt태그에 값을 String 값으로 넣기
			String url = pic.getAttribute("src");
			String info = pic.getAttribute("alt");
			
			//각 이미지에 주소와 속성을 디버깅
//			System.out.println("url 디버깅 ==>"+url);
//			System.out.println("info 디버깅==>"+info);
			
			//크롤링해서 가져오는 data값에 확장자 (.gif)파일은 우리정보에 필요없는 일러스트 파일임 이 정보를 빼고 맵에 담기위한 if문 
			if (url.contains("blank.gif")) {
				
				info=null; //String 값에 blank.gif 라는 문자가 있으면 그 사진의 정보도 null 변환.
				
			}else {
				
				infoMap.put(i,info);// map에 image의 info 넣기
			}
		}
		
//		//디버깅용
		System.out.println("map==>"+infoMap);
		
		return infoMap;
	}
}