<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.*" %>    

<html>
<head>
<title>Insert title here</title>
<meta charset="EUC-KR">
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	<!--  iamPort -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	<!-- asome icon CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />	

  	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
       body > div.container{
        	border: 3px solid white;
            margin-top: 10px;
            
        }
         .orderForm, table{
            font-size: 11pt;
        }
        div.h4 {
            display: inline-block;
            background-color:#ffde3e;
            font-family: 'NIXGONM-Vb';
            font-weight: bold;
        }
        
        #reserInfo {
        line-height: 1.2;
		color: #646464;
		word-break: break-all;
		font-family: "Nanum Gothic", "Malgun Gothic", "돋움", Dotum, "돋움", Dotum, Arial, Helvetica, sans-serif;
		letter-spacing: -.3px;
		border-spacing: 0;
		empty-cells: show;
		margin-top: 10px;
		text-align: left;
		border-collapse: collapse;
		font-size: 13px;
        }
        .final-pay{
        line-height: 1.2;
		color: #646464;
		word-break: break-all;
		margin: 0;
		font-size: 13px;
		font-family: "Nanum Gothic", "Malgun Gothic", "돋움", Dotum, "돋움", Dotum, Arial, Helvetica, sans-serif;
		letter-spacing: -.3px;
		overflow: hidden;
		display: table;
		width: 100%;
		padding: 0;
		border-bottom: 1px solid #afafaf;
		box-sizing: border-box;
        }
   
    </style>
    <script type="text/javascript">
    

    
    window.onload = function () {
    	/* 회원 기존 정보 값 넣기 */
    	var name = $("#name").val($("#name2").val());
		var email = $("#email").val($("#email2").val());
		var phone = $("#phone").val($("#phone2").val());
		
		/* 결제 및 포인트 part */
    	var price = $("#prices").val(); //상품 가격
    	var total = $("#usertotalPoint").val(); // 원래 있던 총 보유 포인트
    	var payPoint = $("#payPoint").val(); //사용할 포인트
    	
    	console.log("total Point : "+total);
    	console.log("price"+$("#prices").val());
    	
    	var totalAmount = $("#totalAmount").val(price); // 총결제금액
    	var actualAmount = $("#actualAmount").val(price); // 실결제금액
    	
    	console.log("actualAmount : "+actualAmount);
    	
    	var calculation = price - payPoint; //상품가격 - 사용할 포인트 = 실결제금액 계산
    	var addPoint = $("#addPoint").val(Math.floor(calculation * 0.01)); //적립예정 금액
    	
    	$("#usedPoint").val(0);
    	};	
    	
       function call(){
    	
    	var price = $("#prices").val(); //상품가격
 	   	var totalAmount = $("#totalAmount").text(); //총 가격
 	   	var total = $("#usertotalPoint").val();
     	var payPoint = $("#payPoint").val(); //사용할 포인트 
        	
        	console.log("totalAmount"+totalAmount);
        	console.log("payPoint"+payPoint);
        	console.log("price"+price);
        	
        	//사용된 포인트 = 사용할 포인트
    		//document.getElementById("usedPoint").value = document.getElementById("payPoint").value;
        	usedPoint = $("#usedPoint").val(payPoint);
        	
    		var calculation = price - payPoint; //상품가격 - 사용할 포인트 = 실결제금액 계산
    		console.log("calculation"+calculation);
    		var calculation2 = total - payPoint;// 보유 포인트 - 사용포인트 빼기
    		console.log("calculation2"+calculation2); 
    		
    		
    		var actualAmount = $("#actualAmount").val(calculation); //실 결제금액 입력
    		console.log("actualAmount"+actualAmount+"calculation"+calculation);	
    		
    		//$("#totalPoint").text(calculation2);  // 사용할 포인트를 감소한 총 보유한 포인트
    		var addPoint = $("#addPoint").val(Math.floor(calculation * 0.01)); //적립예정 금액
    		console.log("addPoint"+addPoint);
    		
    		if ($("#usedPoint").val() == 0 ) {
    	    	$("#usedPoint").val(0);
    		}
    };	
    
    
    
    $( function () {
    	$('.btn.btn-info').on('click' , function () {
    		var actualAmount = $("#actualAmount").val();
    		var payPoint = $("#payPoint").val(); //사용할 포인트
	    	
    		if ($("#payPoint").val() == null | $("#payPoint").val() == "" | $("#payPoint").val() == 0) {
    			$("#zeroPoint").val(0);
			}else{
				$("#zeroPoint").val(payPoint);
			}
    		 if ($("#name").val() == "" ) {
	    		 var buyerName = $("#newbuyerName").val();
	    		 var buyerEmail = $("#str_email01").val()+$("#middle").text()+$("#selectEmail").val();
	    		 var buyerPhone = $("#mobile0").val()+$("#mobile1").val()+$("#mobile2").val();
	        	
	        	$("#name").val(buyerName);
	        	$("#email").val(buyerEmail);
	        	$("#phone").val(buyerPhone);
				
			}else{
				var buyerName = $("#name").val();
				var buyerEmail = $("#email").val();
				var buyerPhone = $("#phone").val();
					
				
			}
    		
    		//$("form").attr("method" , "POST").attr("action" , "/purchase/addPurchase").submit();
    						 IMP.init('imp15344798');
    						 IMP.request_pay({
    							    pg : 'inicis', // version 1.1.0부터 지원.
    							    pay_method : 'card',
    							    merchant_uid : 'merchant_' + new Date().getTime(),
    							    name : 'Euroverse',
    							    amount : 100 ,
    							    buyer_email : buyerEmail ,
    							    buyer_name : buyerName ,
    							    buyer_tel : buyerPhone ,
    							    buyer_postcode : 1234 ,
    							  
    							    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
    							    
    							}, function(rsp) {
    							    if ( rsp.success ) {
    							        var msg = '결제가 완료되었습니다.';
    							        msg += '고유ID : ' + rsp.imp_uid;
    							        msg += '상점 거래ID : ' + rsp.merchant_uid;
    							        msg += '결제 금액 : ' + rsp.paid_amount;
    							        msg += '카드 승인번호 : ' + rsp.apply_num;
    									msg += '회원 아이디 : ' + '${user.userId}';
    									msg += '결제일시' + rsp.paid_at;
    									msg += 'status '+ rsp.pay_method;
    									msg += '할부'+ rsp.card_quota;
    									
    									var payInstal = rsp.card_quota+1;
    									$("#payInstal").val(payInstal);
    									
    							        var orderId = rsp.imp_uid;
    							        $("#orderId").val(orderId);
    							        
    							        var price = rsp.paid_amount;
    							        $("#price").val(price);
    							        
    							        
    							       /*  var orderDate = rsp.paid_at;
    							        $("#orderDate").val(orderDate); */
    							        
    							        var userId = '${user.userId}';
    							        $("#userId").val(userId);
    							        
    							        

    							    } else {
    							        var msg = '결제를 취소하였습니다.';
    							        window.location.reload(true);
    							        return;
    							    }
    						        //alert(msg);
    						        //alert("input imp_uid : "+$("#userId").val());
    						        
	    							  $("form").attr("method" , "POST").attr("action" , "/order/addRoomOrder").submit();

    					});	
    						 
    				}); 
    	
    			});
    
  /* ================================= 현금결제 ================================================ */
    
    $( function () {
    	$('.btn.btn-info').on('click' , function () {
    		var card = $("input[name='payOpt']:checked").val();
    		//alert(card);
    		var pay = $("#pay").val();
    		
    		if (card == '0' ) {
    		
    		var actualAmount = $("#actualAmount").val();
    		var payPoint = $("#payPoint").val(); //사용할 포인트
    		if ($("#payPoint").val() == null | $("#payPoint").val() == "" | $("#payPoint").val() == 0) {
    			$("#zeroPoint").val(0);
			}else{
				$("#zeroPoint").val(payPoint);
			}
    		
    		 if ($("#name").val() == "" ) {
	    		 var buyerName = $("#newbuyerName").val();
	    		 var buyerEmail = $("#str_email01").val()+$("#middle").text()+$("#selectEmail").val();
	    		 var buyerPhone = $("#mobile0").val()+$("#mobile1").val()+$("#mobile2").val();
	        	
	        	$("#name").val(buyerName);
	        	$("#email").val(buyerEmail);
	        	$("#phone").val(buyerPhone);
				
			}else{
				var buyerName = $("#name").val();
				var buyerEmail = $("#email").val();
				var buyerPhone = $("#phone").val();
					
				
			}
    		
    		
    						 IMP.init('imp15344798');
    						 IMP.request_pay({
    							    pg : 'danal', // version 1.1.0부터 지원.
    							    pay_method : 'card',
    							    merchant_uid : 'merchant_' + new Date().getTime(),
    							    name : 'Euroverse',
    							    amount : 100 ,
    							    buyer_email : buyerEmail ,
    							    buyer_name : buyerName ,
    							    buyer_tel : buyerPhone ,
    							    buyer_postcode : 1234 ,
    							  
    							    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
    							    
    							}, function(rsp) {
    							    if ( rsp.success ) {
    							        var msg = '결제가 완료되었습니다.';
    							        msg += '고유ID : ' + rsp.imp_uid;
    							        msg += '상점 거래ID : ' + rsp.merchant_uid;
    							        msg += '결제 금액 : ' + rsp.paid_amount;
    							        msg += '카드 승인번호 : ' + rsp.apply_num;
    									msg += '회원 아이디 : ' + '${user.userId}';
    									msg += '결제일시' + rsp.paid_at;
    									msg += '??' + rsp.vbank_name;
    									msg += 'status '+ rsp.pay_method;
    									msg += '할부'+ rsp.card_quota;
    									
    									var payInstal = rsp.card_quota+1;
    									$("#payInstal").val(payInstal);
    									
    							        var orderId = rsp.imp_uid;
    							        $("#orderId").val(orderId);
    							        
    							        /* var price = rsp.paid_amount;
    							        $("#price").val(price); */
    							        
    							        
    							       /*  var orderDate = rsp.paid_at;
    							        $("#orderDate").val(orderDate); */
    							        
    							        var userId = '${user.userId}';
    							        $("#userId").val(userId);
    							        
    							    } else {
    							        var msg = '결제에 실패하였습니다.';
    							        window.location.reload(true);
    							        return;
    							    }
    						        //alert(msg);
    						    
    							  $("form").attr("method" , "POST").attr("action" , "/order/addRoomOrder").submit();
    					});	
    						 
    		}// if 끝
    				}); 
    	
    			});
     
   
    /* ================================================================================== */
    
    
    
    
    
    $(function (){
    	$("input[name='info']:checked").click(function (){
    		var check = $("input[name='info']:checked").val();
    		basicInfo 
    		if (check == '0') {
    			$("#newInfo").css("display","none");
				$("#basicInfo").css("display","block");
				
				
				
				var name = $("#name").val($("#name2").val());
				var email = $("#email").val($("#email2").val());
				var phone = $("#phone").val($("#phone2").val());
				console.log("hidden : "+name+email+phone);
			}
    	});
    });
   
    function news(){
    	var name = $("#name").val("");
		var email = $("#email").val("");
		var phone = $("#phone").val("");
    	
    	$("#newInfo").css("display","block");
		$("#basicInfo").css("display","none");
    	
    }
    
    
	$(document).on('keyup','#payPoint',function(){
		var payPoint = $("#payPoint").val();
		var total = $("#totalPoint").val();
		
		//alert(total.length);
		 if (payPoint > total & payPoint.length == total.length) {
			alert("총 포인트 이하로 사용 가능합니다.");
			$("#payPoint").val(total);
			$("#usedPoint").val(total);
		} 
		
	});
    </script>

</head>

<body>
	<jsp:include page="/toolbar/toolBar.jsp" />
	 <jsp:include page="/toolbar/pushBar.jsp" />
<div class="container"><br/>
	
	<form>
	<input type="hidden" name="orderId" value= "" id="orderId"/>
	<input type="hidden" name="price" value= "${room.price }" id="price"/>
	<input type="hidden" name="userId" value= "" id="userId"/>
	<input type="hidden" name="payInstal" value= "" id="payInstal"/>
	<input type="hidden" name="payPoint" value= "" id="zeroPoint"/>
	
	<input type="hidden" name="buyerName" value= "" id="name"/>
	<input type="hidden" name="buyerEmail" value= "" id="email"/>
	<input type="hidden" name="buyerPhone" value= "" id="phone"/>
	
	<input type="hidden" name="name" value= "${user.userName}" id="name2"/>
	<input type="hidden" name="email" value= "${user.email }" id="email2"/>
	<input type="hidden" name="phone" value= "${user.phone }" id="phone2"/>
	
	
	<input type="hidden" name="totalPoint" value= "${user.totalPoint }" id="totalPoint"/>
	<div class="h4">숙소 정보</div>
	<br>
		<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">숙소</th>
			      <th scope="col">체크인</th>
			      <th scope="col">체크아웃</th>
			      <th scope="col">객실수</th>
			      <th scope="col">숙박인원</th>
			      <th scope="col">가격</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <th scope="row">${room.roomName}</th>
			      <td>${fn:trim(room.checkIn).substring(0,4)}/${fn:trim(room.checkIn).substring(4,6)}/${fn:trim(room.checkIn).substring(6,8)}</td>
			      <td>${fn:trim(room.checkOut).substring(0,4)}/${fn:trim(room.checkOut).substring(4,6)}/${fn:trim(room.checkOut).substring(6,8)}</td>
			      <td>${room.roomNum} 개</td>
			      <td>성인 ${room.adultNum} 명 , 유아 ${room.childNum} 명</td>
			      <td><fmt:formatNumber value="${room.price}" pattern="###,###" /> 원</td>
			    </tr>
			  </tbody>
			  
			</table>
			<br/><br/>
			<div class="h4">주문자 정보</div>
			
		
			<div class="input-group input-group-sm">
			  <div class="input-group-prepend">
			      	<input type="radio"  checked="checked" id="basic" value="0" name="info" style="margin-top:5px;margin-right:10px;">기존 정보 가져오기 &nbsp;&nbsp;
 					<input type="radio" name="info" id="new" onclick="news()" value="1" style="margin-top:5px;margin-right:10px;">새로운 정보 입력
			  </div>
			</div>
			
			<hr/>
			
			<div class="row" id="basicInfo" style="Padding-left:40px;display:block;">
				<div class="row">
				<span style="">이름 * &nbsp;&nbsp;&nbsp; <span>${user.userName }</span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
			       			<%-- <input type="text" style="width:100px;height:30px;" class="form-control" value="${user.userName }"
			         maxlength="20" name="buyerName" readonly="readonly" id="buyerName"> --%>
			         
			    <span style="Padding-left:220px;" id="${user.email}">이메일 *&nbsp;&nbsp;&nbsp; ${user.email }</span>
			    
				</div>
				
				<br>
				<hr/>
				<div class="row">
				<span style="" id="${user.phone}">전화번호 * &nbsp;&nbsp;&nbsp; ${user.phone }</span>
							<%-- <input type="text" style="width:170px;" class="form-control" 
							value="${user.phone }" readonly="readonly" name="userPhone" id="userPhone" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'');" onblur="this.value=this.value.replace(/[^-0-9]/g,'');"> --%>
				</div>
			</div>
			
			
				<div class="row" id="newInfo" style="Padding-left:40px;display:none;">
					<div class="row">
            		<p style="">이름 *</p> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  			<input type="text" title="예약자명을 입력하세요" style="width:200px;height:30px;" class="form-control" maxlength="20" id="newbuyerName">
                  		<p style="Padding-left:130px;">이메일 *</p>&nbsp;&nbsp;&nbsp;
                  			<input type="text" title="이메일주소 앞자리를 입력해주세요" style="width:200px;height:30px;"class="form-control" name="str_email01" id="str_email01" >
                  		<P style="Padding-left:10px;" id="middle">@</P>&nbsp;&nbsp;&nbsp;
                   		 <select title="이메일 서비스 도메인을 선택해주세요." class="form-control" style="width:250px;height:30px;font-size:13px;" name="selectEmail" id="selectEmail">
	                          <option value="">선택</option>
	                          <option value="naver.com">naver.com</option>
	                          <option value="gmail.com">gmail.com</option>
	                          <option value="hanmail.net">hanmail.net</option>
	                          <option value="chol.com">chol.com</option>
	                          <option value="freechal.com">freechal.com</option>
	                          <option value="intizen.com">intizen.com</option>
	                          <option value="nate.com">nate.com</option>
                        </select> 
                 	</div>
                 	<hr/>
                 	<div class="row">
                 	<p style="">전화번호 *</p>&nbsp;&nbsp;&nbsp;
	                   		<select title="휴대전화 식별번호를 선택해주세요."  class="form-control form-control-sm" style="width:170px;" id="mobile0">
	                          <option value="">선택</option>
	                          <option value="010">010</option>
	                          <option value="011">011</option>
	                          <option value="016">016</option>
	                          <option value="017">017</option>
	                          <option value="018">018</option>
	                          <option value="019">019</option>
	                        </select>
	                    <p style="Padding-left:10px;">-</p>&nbsp;&nbsp;&nbsp;
	                        <input type="text" title="휴대전화 국번을 입력해주세요." style="width:170px;" class="form-control form-control-sm" maxlength="4" id="mobile1" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'');" onblur="this.value=this.value.replace(/[^-0-9]/g,'');">
	                   	<p style="Padding-left:10px;">-</p>&nbsp;&nbsp;&nbsp;
	                   		<input type="text" title="휴대전화 뒷자리를 입력해주세요." style="width:170px;" class="form-control form-control-sm" maxlength="4" id="mobile2" onkeyup="this.value=this.value.replace(/[^-0-9]/g,'');" onblur="this.value=this.value.replace(/[^-0-9]/g,'');">
                 	</div>
                  </div>
			<br/><br/>
			
			<br/>	
			<div class="h4">결제 정보</div>
			
			<div class="input-group">
			  <div class="input-group-prepend">
			      	<input type="radio"  checked="checked" id="pay" value="0" name="payOpt" style="margin-top:5px;margin-right:10px;">휴대폰 소액 결제 &nbsp;&nbsp;
 					<input type="radio" name="payOpt" id="card"  value="1" style="margin-top:5px;margin-right:10px;">카드 결제
			  </div>
			</div>
			
			<hr/>
			<div class="row" id="pay" style="Padding-left:30px;">
	             <div class="col-sm-2">
	            		 총 결제 금액
	                    <div class="row">
	                    <input	type="text" name="totalAmount" id="totalAmount" class="form-control" value="${room.price}"
                  		 		style="Padding-left:30px;margin-top:10px;height:20px;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" />
	                    <%-- <div id="totalAmount" style="Padding-left:30px;">${flight.price}</div> 원 --%>
	            		</div>
	             </div>
	             <i class="fas fa-minus-circle" style="margin-top:10px;"></i>
	             <div class="col-sm-2" style="Padding-left:70px;">
	             <input type="hidden" name="price" id="prices" value="${room.price }" >
	            		 포인트 할인
	                    <div class="row">
	                    <input	type="text" name="usedPoint" id="usedPoint" class="form-control" value="${point.usedPoint}"
                  		 		style="Padding-left:30px;margin-top:10px;height:20px;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" />
	                    <%-- <div id="usedPoint" style="Padding-left:20px;">${point.usedPoint}</div> --%>
	            		</div>
	             </div>
	             <i class="fas fa-equals" style="margin-left:15px;margin-top:10px;"></i>
	             <div class="col-sm-2" style="Padding-left:40px;">
	            		 실 결제 금액
	                    <div class="row">
	                    <input	type="text" name="actualAmount" id="actualAmount" class="form-control" value="${order.actualAmount}"
                  		 		style="Padding-left:30px;margin-top:10px;height:20px;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" />
	                    <%-- <div id="actualAmount" style="Padding-left:20px;">${order.actualAmount}</div> 원 --%>
	            		
	            		</div>
	             </div>
			</div>
			<br/>
			<hr style="width:50%;float:left;margin-right:700px;" />
			
				<div class="row" style="Padding-left:40px;">
				 포인트 사용 &nbsp;&nbsp;&nbsp;
				<input	type="text" name="payPoint" id="payPoint" class="form-control" 
							style="width:110px;height:30px;font-size:13px;"	placeholder="0" onkeyup="call()">
				&nbsp;&nbsp;&nbsp;
				<p style="font-size:12px;margin-top:5px;"> ( 보유 포인트 ${user.totalPoint} P ) </p>
				<i class="fas fa-equals" style="margin-left:60px;"></i>
					<div class="col" style="Padding-left:40px;">
						<p> 적립 예정</p>
					 	<input	type="text" name="addPoint" id="addPoint" class="form-control" readonly="readonly"
                  		 		style="background-color:white;margin-top:-10px;width:70px;height:30px;border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;" />
					</div>
				</div>
			
		<br/><br/>
		<div class="form-group" align="center">
   		 <div class="col-sm-offset-4  col-sm-4 text-center">
		<button type="button" class="btn btn-info" id="order" >예약하기</button>
		<input type="hidden" name="actualAmount" value= "${order.actualAmount }"/>
		<input type="hidden" name="usedPoint" value= "${point.usedPoint }"/>
		<input type="hidden" name="totalAmount" value= "${order.totalAmount }"/>
		<input type="hidden" name="addPoint" value= "${order.addPoint }"/>
		<input type="hidden" name="payPoint" value= "${order.payPoint }"/>
		<input type="hidden" name="roomName" value= "${room.roomName }"/>
		<input type="hidden" name="roomCity" value= "${room.roomCity }"/>
		<input type="hidden" name="checkIn" value= "${room.checkIn }"/>
		<input type="hidden" name="checkOut" value= "${room.checkOut }"/>
		<input type="hidden" name="detailLink" value= "${room.detailLink }"/>
		<input type="hidden" name="roomImg" value= "${room.roomImg }"/>
		<input type="hidden" name="mainService" value= "${room.mainService }"/>
		<input type="hidden" name="adultNum" value= "${room.adultNum }"/>
		<input type="hidden" name="childNum" value= "${room.childNum }"/>
		<input type="hidden" name="roomNum" value= "${room.roomNum }"/>
		<input type="hidden" name="familyService" value= "${room.familyService }"/>	
		<input type="hidden" name="hotelInfo" value= "${room.hotelInfo }"/>	
		<input type="hidden" name="roomInfo" value= "${room.roomInfo }"/>	
		
		</div>
		</div>
		
	</form>
	
</div>


	 <jsp:include page="/toolbar/footer.jsp" />
</body>
</html>
