package com.ksy.web.order;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.ksy.service.domain.Order;
import com.ksy.service.flight.FlightService;
import com.ksy.service.order.OrderService;
import com.ksy.service.room.RoomService;
import com.siot.IamportRestHttpClientJava.IamportClient;
import com.siot.IamportRestHttpClientJava.request.CancelData;
import com.siot.IamportRestHttpClientJava.response.IamportResponse;
import com.siot.IamportRestHttpClientJava.response.Payment;

@RestController
@RequestMapping("/order/*")
public class OrderRestController {

	@Autowired
	@Qualifier("flightServiceImpl")
	private FlightService flightService;
	
	@Autowired
	@Qualifier("roomServiceImpl")
	private RoomService roomService;
	
	@Autowired
	@Qualifier("orderServiceImpl")
	private OrderService orderService;
	
	public OrderRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['postPageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['postPageSize']}")
	int pageSize;

	
	
	@RequestMapping(value="/json/updateOrderStatus/{orderId}", method=RequestMethod.GET )
	public Map updateOrderStatus(@PathVariable String orderId, HttpSession session, Model model ) throws Exception {
	  
		System.out.println("/order/json/updateOrderStatus : GET");
		Order order = new Order();
		order.setOrderId(orderId);
		order.setOrderStatus("R");
		
		
		Map<String, Object> map = orderService.getOrderRefund(order);
		
		map.put("orderId", orderId);
		map.put("order", order);
		
		return map;
	}	
	
	@RequestMapping(value = "/json/getOrderRefund/{orderId}/{orderStatus}", method = RequestMethod.GET)
	public Map getOrderRefund(
								@PathVariable("orderId")String orderId, 
								@PathVariable("orderStatus")String orderStatus,
						HttpSession session, Model model) throws Exception {
		System.out.println("/getOrderRefund : GET");
		Order order = new Order();
		order.setOrderStatus(orderStatus);
		order.setOrderId(orderId);
		Map<String, Object> map = orderService.getOrderRefund(order);
		
		map.put("order", order);

		return map;
	}
	
///////////////////////////////////환불////////////////////////////////////////

	IamportClient client;
	
	public void setup() throws Exception {
		String api_key = "1083818024539221";
		String api_secret = "gzVUKM3QNUfC53Ciu8FsqXEwv0Z0NZQ4yLZiy29mWpY1sBkXJZqaW4Gs4GtSFjXd5WvDZF0V4YXxzhuj";
		
		client = new IamportClient(api_key, api_secret);
	}
	
	public void testGetToken() throws Exception {
		String token = client.getToken();
		System.out.println("token : " + token);
	}
	
	@RequestMapping(value = "/json/payRefund/{orderId}")
	public Map payRefund(@PathVariable String orderId ) throws Exception {
		// 이미 취소된 거래 imp_uid
		System.out.println("testCancelPaymentByImpUid --- Start!---");
		
		Order order = new Order();
		order.setOrderId(orderId);
		order.setOrderStatus("C");
		
		Map<String, Object> map =  orderService.getOrderRefund(order);
		
		setup();
		testGetToken();
		setup();
		//Order order = orderService.getFlightOrder(orderId);
		
		CancelData cancel = new CancelData(orderId, true);
		System.out.println("imp_uid : " + orderId);
		IamportResponse<Payment> cancelpayment = client.cancelPayment(cancel);
		System.out.println(cancelpayment.getMessage());
		System.out.println("testCancelPaymentByImpUid --- End!---");
		
		
		//환불 일시를 controller에서 할지 Mapper에서 할지 수정,,
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
				
		String time1 = format1.format(System.currentTimeMillis());
		order.setRefundDate(time1);
		System.out.println("time : "+time1);
		System.out.println("order : "+order);
		map.put("orderId", orderId);
		map.put("order", order);
		
		return map;
	}
	
	///////////////////////////////환불 끝///////////////////////////////////////////////
}
