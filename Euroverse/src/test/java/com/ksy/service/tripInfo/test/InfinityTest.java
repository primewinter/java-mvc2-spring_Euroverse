package com.ksy.service.tripInfo.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ksy.service.domain.TripInfo;
import com.ksy.service.tripInfo.TripInfoService;
import com.ksy.web.tripInfo.InfinityClick;


@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data 를 다양하게 Wiring 하자...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration(locations = { "classpath:config/context-common.xml", 
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml", 
									"classpath:config/context-transaction.xml" })
public class InfinityTest {

	@Autowired
	@Qualifier("tripInfoServiceImpl")
	private TripInfoService service;

//	@Test
	public void addinfinityTest() throws Exception {

		System.out.println("infinityClickTest 시작!");
		
		Map<Integer, String> imgMap = null;
		Map<Integer, String> infoMap = null;
		
//		for (int i = 1; i < 2; i++) {
			
			//크롤링 생성자 생성 크롤링 시작
			InfinityClick selTest = new InfinityClick();//
			
			imgMap = selTest.imgCrawl();//크롤링 이미지를  map에 put
			infoMap = selTest.infoCrawl();//크롤링 info map에 put
			
			//디버깅
			System.out.println("imgMap 디버깅 ==>"+imgMap.size());
			System.out.println("infoMap 디버깅 ==>"+infoMap.size());
//		}
		

		
		//비즈니스 로직과 연결 바인딩
		for (int i = 0; i < imgMap.size(); i++) {
			
			//크롤링해온 정보를 DB에 넣기위한 도메인생성
			TripInfo tripInfo = new TripInfo();
			
			//디버깅
			System.out.println("imgMap ==>"+imgMap);
			System.out.println("infoMap ==>"+infoMap);
			
			//click에 img주소와 info 바인딩
//			tripInfo.setUrl(imgMap.get(i));
//			tripInfo.setInfo(infoMap.get(i));
			
			//디버깅
			System.out.println("tripInfo 도메인 디버깅 ==>"+tripInfo);
			
			//디비에 저장
            service.addUrl(tripInfo);
		}

	}

//	@Test
	public void infinityTest() throws Exception {

		TripInfo tripInfo = new TripInfo();

		List<TripInfo> list = service.getUrl("GBR");
		list.get(1);
		System.out.println("list===>"+list);

//		Assert.assertEquals(59, tripInfo.getConId());
	}
}
