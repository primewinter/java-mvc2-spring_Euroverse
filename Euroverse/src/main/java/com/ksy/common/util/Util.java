package com.ksy.common.util;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.ksy.service.domain.City;
import com.ksy.service.domain.Day;


public class Util {

	///Field
	
	///Constructor
		
	///Method
	public static List<Day> cityListToDayList(List<City> cityList, Timestamp startDateOrigin) {
		
		List<Day> dayList = new ArrayList<Day>();
		City[] cityArray = cityList.toArray(new City[cityList.size()]);		//리스트로 받은 City 목록을 Array로 변환
		
		Timestamp startDate = (Timestamp)startDateOrigin.clone();
		System.out.println("\n\n\n\n   cityListToDayList Start => startDate = "+startDate);
		
		int dayNoo = 0;
		Day day = new Day();
		
		for(int i=0; i<cityArray.length; i++) {
			for(int j=0; j<cityArray[i].getCityDuration(); j++) {
				
				
				// 해당 도시의 첫번째 체류일자이면서 체류일수가 1보다 큰 경우 = 무박이 아닌 경우	
				if( j==0 && cityArray[i].getCityDuration() != 1 ) {	
					if( i==0 ) {	//첫번째 도시인 경우 
						day.setCityNames(cityArray[i].getCityName());
					}else {		//첫번째 도시가 아닌 경우
						day.setCityNames(day.getCityNames()+", "+cityArray[i].getCityName());	
						
					}
					//원래 cityList의 시작일자 세팅
					cityList.get(i).setStartDateStr(startDate.toString().substring(0,10));
					
					day.setDate((Timestamp)startDate.clone());
					startDate.setTime(startDate.getTime() + (1000*60*60*24));
					dayNoo++;
					day.setDayNo(dayNoo);
					
					dayList.add(day);
					day = new Day();
					day.setCityNames(cityArray[i].getCityName());	//다음 도시에게 현재 도시이름 넘겨주기 위해....세팅
				}
				
				// 해당 도시의 마지막 체류일자인 경우 (첫번째 도시 포함)
				else if(j == cityArray[i].getCityDuration()-1 ) {	
					
					//해당도시의 마지막 체류일자 && 체류일수=1  =>>  무박인 경우(첫번째체류일자=마지막체류일자)
					if(cityArray[i].getCityDuration() == 1) {	//== if(j==0) 
						
						if( i==0 ) {	//첫번째 도시인 경우
							day.setCityNames(cityArray[i].getCityName());
						}else {			//첫번째가 아닌 도시의 첫번째 체류일인 경우 = 앞에 도시 하나 더 있음!
							day.setCityNames(day.getCityNames()+", "+cityArray[i].getCityName());
							if( i==cityArray.length-1 ) {
								//day.setCityNameList(cityNames);
								day.setDate((Timestamp)startDate.clone());
								dayNoo++;
								//startDate.setTime(startDate.getTime() + (1000*60*60*24));
								day.setDayNo(dayNoo);
								dayList.add(day);
								day = new Day();
							}
						}
						
						//원래 cityList의 시작일자 세팅
						cityList.get(i).setStartDateStr(startDate.toString().substring(0,10));
						
					}else {		//해당도시의 마지막 체류일자 && 체류일수!=1  =>  무박이 아닌 경우
						
						if(i+1 < cityArray.length) {	//뒤에 도시가 남은 경우
							day.setCityNames(cityArray[i].getCityName());
							
						}else if( i+1 == cityArray.length){	//도시 끝인 경우
							//day.setCityNameList(cityNames);
							day.setDate((Timestamp)startDate.clone());
							dayNoo++;
							//startDate.setTime(startDate.getTime() + (1000*60*60*24));
							day.setDayNo(dayNoo);
							dayList.add(day);
							day = new Day();
						}
					}
					//원래 cityList의 종료일자 세팅 :: fullCalendar의 마지막 일자는 달력에 표시가 안돼서 실제 종료일자 + 1 해서 셋팅!
					//cityList.get(i).setEndDateStr(  new Timestamp( ((Timestamp)startDate.clone()).getTime() + (1000*60*60*24) ).toString().substring(0,10) );
					cityList.get(i).setEndDateStr(  new Timestamp( ((Timestamp)startDate.clone()).getTime()  ).toString().substring(0,10) );
				}
				
				// 해당 도시의 마지막 체류일 전.....이면서 첫번째 체류일이 아닌 경우
				else if( j < cityArray[i].getCityDuration()-1 && j!=0 ) {	
					//cityNames = cityArray[i].getCityName();
					day.setCityNames(cityArray[i].getCityName());
					day.setDate((Timestamp)startDate.clone());
					dayNoo++;
					startDate.setTime(startDate.getTime() + (1000*60*60*24));
					day.setDayNo(dayNoo);
					dayList.add(day);
					day = new Day();
					day.setCityNames(cityArray[i].getCityName());	//다음 도시에게 현재 도시이름 넘겨주기 위해....세팅
				}
			}
		}

		return dayList;
	}
	
	
//public static List<Day> cityListToDayList(List<City> cityList, Timestamp startDate) {
//		
//		List<Day> dayList = new ArrayList<Day>();
//		City[] cityArray = cityList.toArray(new City[cityList.size()]);		//리스트로 받은 City 목록을 Array로 변환
//		
////		Date today = new Date();
////		Timestamp todayStamp = new Timestamp(today.getTime());
//		
//		int dayNoo = 0;
//		Day day = new Day();
//		
//		for(int i=0; i<cityArray.length; i++) {
//			for(int j=0; j<cityArray[i].getCityDuration(); j++) {
//				
//				if(j == cityArray[i].getCityDuration()-1 ) {	//해당 도시의 마지막 체류일자인 경우 (첫번째 도시 포함)
//					if(cityArray[i].getCityDuration() == 1) {	//== if(j==0) //해당도시의 마지막 체류일자 && 체류일수=1  =>>  무박인 경우(첫번째체류일자=마지막체류일자)
//						
//						if( i==0 ) {	//첫번째 도시인 경우
//							day.setCityNames(cityArray[i].getCityName());
//						}else {			//첫번째가 아닌 도시의 첫번째 체류일인 경우 = 앞에 도시 하나 더 있음!
//							day.setCityNames(day.getCityNames()+", "+cityArray[i].getCityName());
//						}
//					}else {		//해당도시의 마지막 체류일자 && 체류일수!=1  =>  무박이 아닌 경우
//						
//						if(i+1 < cityArray.length) {	//뒤에 도시가 남은 경우
//							day.setCityNames(cityArray[i].getCityName());
//							
//						}else if( i+1 == cityArray.length){	//도시 끝인 경우
//							//day.setCityNameList(cityNames);
//							day.setDate((Timestamp)todayStamp.clone());
//							dayNoo++;
//							todayStamp.setTime(todayStamp.getTime() + (1000*60*60*24));
//							day.setDayNo(dayNoo);
//							dayList.add(day);
//							day = new Day();
//						}
//					}
//					
//				}else if( j < cityArray[i].getCityDuration()-1 && j!=0 ) {	//해당 도시의 마지막 체류일 전.....이면서 첫번째 체류일이 아닌 경우
//					//cityNames = cityArray[i].getCityName();
//					day.setCityNames(cityArray[i].getCityName());
//					day.setDate((Timestamp)todayStamp.clone());
//					dayNoo++;
//					todayStamp.setTime(todayStamp.getTime() + (1000*60*60*24));
//					day.setDayNo(dayNoo);
//					dayList.add(day);
//					day = new Day();
//					day.setCityNames(cityArray[i].getCityName());	//다음 도시에게 현재 도시이름 넘겨주기 위해....세팅
//				
//					
//				}else if( j==0 && cityArray[i].getCityDuration() != 1 ) {	//해당 도시의 첫번째 체류일자이면서 체류일수가 1보다 큰 경우=무박이 아닌 경우
//					if( i==0 ) {	//첫번째 도시인 경우 
//						day.setCityNames(cityArray[i].getCityName());
//
//					}else {		//첫번째 도시가 아닌 경우
//						day.setCityNames(day.getCityNames()+", "+cityArray[i].getCityName());	
//						
//					}
//					day.setDate((Timestamp)todayStamp.clone());
//					dayNoo++;
//					todayStamp.setTime(todayStamp.getTime() + (1000*60*60*24));
//					day.setDayNo(dayNoo);
//					dayList.add(day);
//					day = new Day();
//					day.setCityNames(cityArray[i].getCityName());	//다음 도시에게 현재 도시이름 넘겨주기 위해....세팅
//				}
//			}
//		}
//
//		return dayList;
//	}
	
	public static int getDday(Timestamp startDate) {
		
		Date today = new Date();

		long diff = startDate.getTime()/(1000*60*60*24) - today.getTime()/(1000*60*60*24);
		//diff = diff / (1000*60*60*24);
		
		int dday = (int)diff + 1;
		
//		Date datee  = new Date();
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//		try {
//			datee = sdf.parse( today.toString().substring(0, 10) );
//		}catch (ParseException e) {
//			e.printStackTrace();
//		} 
		
		return dday;
	}
	
	public static String getEndDate(Timestamp startDate, int planTotalDays) {
		
		Timestamp endDate = (Timestamp)startDate.clone();
		endDate.setTime(startDate.getTime() + (1000*60*60*24*(planTotalDays-1)) );	//여행 종료일자 = 여행시작일자  + (총여행일수-1)
		
		return toDateStr(endDate);
	}
	
	

	
	
	public static String toDateStr(Timestamp date) {
		if (date == null)
			return "";
		else {
			Date dateForDay = new Date(date.getTime());		//요일을 위한 dateForDay
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.format( new Date(date.getTime()) ) + ", "+dateForDay.toString().substring(0,3);
		}
	}
	
	
//	Calendar calendar = Calendar.getInstance();
//	int year = calendar.get(calendar.YEAR);
//	int month = calendar.get(calendar.MONTH);
//	int day = calendar.get(calendar.DAY_OF_MONTH);
	
	
	/*		한자리 숫자의 앞에 0을 붙여 두자리 숫자로 만들기 위한 노오력... (월,일 해당)
	 * 		Timestamp는 toString하면 yyyy-MM-dd 형태로 출력돼서 substring으로 일단 해결함
	 * 		if(date != null) {
				Date dateForDay = new Date(date.getTime());		//요일을 위한 dateForDay
				this.dateString = date.toString().substring(0,10) + " : "+dateForDay.toString().substring(0,3);
			}
	if(date != null) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		
		String month = ""+(cal.get(cal.MONTH)+1);
		if( cal.get(cal.MONTH) < 9) {
			month = "0"+month;
		}
		
		String day = ""+cal.get(cal.DAY_OF_MONTH);
		if( cal.get(cal.DAY_OF_MONTH) <10 ) {
			day = "0"+day;
		}
		
		this.dateString = cal.get(cal.YEAR)+"-"+month+"-"+day;
	}
	*/
	
	public static Object getBean(String beanName) {
        WebApplicationContext context = ContextLoader.getCurrentWebApplicationContext();
        return context.getBean(beanName);
    }
	
	
}