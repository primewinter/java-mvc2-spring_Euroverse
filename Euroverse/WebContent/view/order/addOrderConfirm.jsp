<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.*" %>    

<html>
<head>
<meta charset="EUC-KR">
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	
	<!-- asome icon CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />	

  	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	
        .getOrder {
            width: 60%;
            margin: auto;
            font-size: 10pt;
        }
        
        div.h4  {
            font-family: 'NIXGONM-Vb';
            font-weight: bold;
            display: inline-block;
            background-color: #ffde3e;
        }
        
        table  {
            font-size: 10pt;
        }
   
    </style>
    <script type="text/javascript">
    $( function () {
	$('#home').on('click' , function () {
		self.location ="/main.jsp";
		
		//  $("form").attr("method" , "POST").attr("action" , "/order/addOrderConfirm?orderId=${order.orderId}").submit();
	});
	$("#list").click(function (){
		self.location = "/order/getOrderList";
	})
});
    </script>

</head>

<body>
	<jsp:include page="/toolbar/toolBar.jsp" />
	 <jsp:include page="/toolbar/pushBar.jsp" />
	<form>

<div class="container getOrder" >
<br/>

	<div >
	  <h3 align="center">${user.userName}님 예약이 정상적으로 완료되었습니다.</h3>
	</div>
	
		 <c:if test="${room.roomCity == null }">
		 	<hr/>
		 	<div class="row">
                    <div class="h4">항공 정보</div>
            </div>
			<!-- <i class="fas fa-plane" id="iconf" style="Padding-left:20px;font-size:40px;" ></i> -->
				<br/>
				<table class="table">
					  <thead>
					    <tr>
					      <th scope="col">항공사</th>
					      <th scope="col">출발시간</th>
					      <th scope="col">도착시간</th>
					      <th scope="col">경유</th>
					      <th scope="col">소요시간</th>
					      <th scope="col">구간</th>
					      <th scope="col">가격</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th scope="row">${flight.airline}</th>
					       <td>${flight.depDate.substring(0,4)}/${flight.depDate.substring(4,6)}/${flight.depDate.substring(6,8)} &nbsp;&nbsp;${flight.depTime}</td>
					      <c:if test="${flight.tripCourse == 'R' }" >
					      <td>${flight.arrDate.substring(0,4)}/${flight.arrDate.substring(4,6)}/${flight.arrDate.substring(6,8)} &nbsp;&nbsp;${flight.arrTime}</td>
					      </c:if>
					      <td>${flight.stopOver}</td>
					      <td>${flight.leadTime}</td>
					       <c:if test="${flight.tripCourse == 'R' }">
					     	 <td>왕복 구간</td>
					      </c:if>
					       <c:if test="${flight.tripCourse == 'O' }">
					     	 <td>편도 구간</td>
					      </c:if>
					      <td><fmt:formatNumber value="${flight.price}" pattern="###,###" />원</td>
					    </tr>
					  </tbody>
				</table>
		</c:if>
		 <c:if test="${flight.depDate == null }">
		 	<hr/>
			<!-- <i class="fas fa-bed" id="iconr" style="Padding-left:20px;font-size:40px;"></i> -->
			<div class="row">
                    <div class="h4">숙소 정보</div>
            </div>
				<br/>
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
					      <td><fmt:formatNumber value="${room.price}" pattern="###,###" />원</td>
					    </tr>
					  </tbody>
				</table>
		</c:if>
		
		<br/>
		
		<div class="row">
			<!-- <i class="fas fa-won-sign" style="Padding-left:20px;font-size:40px;"></i> -->
			<div class="h4">결제 완료 내역</div>
		</div>	
			<hr/>
			<div class="row">
	             <div class="col-sm-2">
	            		 총 결제 금액
	                    <div class="row">
	                    	<c:if test="${flight.depCity == null }">	
	                   			<div id="totalAmount" style="Padding-left:30px;"><fmt:formatNumber value="${room.price}" pattern="###,###" />원</div> 
	            			</c:if>
	            			<c:if test="${room.roomCity == null }">	
	                   			<div id="totalAmount" style="Padding-left:30px;"><fmt:formatNumber value="${flight.price}" pattern="###,###" />원</div>
	            			</c:if>
	            		</div>
	             </div>
	             <div class="col-sm-1">
	             	<i class="fas fa-minus-circle" style="margin-top:10px;"></i>
	             </div>
	             <%--  <c:if test="${point.usedType == 'U'}"> --%>
		             <div class="col-sm-2" style="Padding-left:30px;">
		            		 포인트 할인
		                    <div class="row">
		                    	<div id="usedPoint" style="Padding-left:20px;"> -${order.payPoint} P</div>
		            		</div>
		             </div>
	             <div class="col-sm-1">
	             	<i class="fas fa-equals" style="margin-left:15px;margin-top:10px;"></i>
	             </div>
	             <div class="col-sm-2" style="Padding-left:40px;">
	            		 실 결제 금액
	                    <div class="row">
	                    	<div id="actualAmount" style="Padding-left:20px;"><fmt:formatNumber value="${order.actualAmount}" pattern="###,###" />원</div>
	            		</div>
	             </div>
			</div>
			<br/>
			<hr style="width:50%;float:left;margin-right:700px;" />
			
				<div class="row" style="Padding-left:190px;">
					<div class="col-sm-1" style="margin-top:10px;">
						<i class="fas fa-plus"></i>
					</div>
					
					  <%-- <c:if test="${point.usedType == 'R' || point.usedType == 'F' }"> --%>
					<div class="col-sm-2" style="margin-left:30px;">
						<p>적립 된 포인트</p>
					 			<div id="addPoint" style="Padding-left:20px;">${order.addPoint} P </div>
					</div>
					<div class="col-sm-1" style="margin-left:10px;">
						<i class="fas fa-equals" style="margin-left:15px;margin-top:10px;"></i>
					</div>
					<div class="col-sm-2" style="margin-left:50px;">
						<p>총 포인트</p>
							<div id="totalPoint" style="margin-left:10px;">${user.totalPoint} P </div>
					</div>
				</div>
			<br/>
		<div class="row">
			<!-- <i class="fas fa-user" style="Padding-left:20px;font-size:40px;"></i> -->
			 <div class="h4">구매자 정보</div>
		</div>
		<hr/>
			<div>
				<div class="row" style="margin-bottom: 15px" >
						  <div class="col-md-3">구매자</div>
						  <div class="col-md-9">${order.buyerName}</div>
				</div>
				<div class="row" style="margin-bottom: 15px" >
						  <div class="col-md-3">연락처</div>
						  <div class="col-md-9">${order.buyerPhone}</div>
				</div>
				<div class="row" style="margin-bottom: 15px" >
						  <div class="col-md-3">Email</div>
						  <div class="col-md-9">${order.buyerEmail}</div>
				</div>
				<div class="row" style="margin-bottom: 15px" >
						  <div class="col-md-3">할부</div>
						  <div class="col-md-9">${order.payInstal} 개월</div>
				</div>
				<div class="row" style="margin-bottom: 15px" >
						  <div class="col-md-3">결제방식</div>
						  <c:if test="${order.payOpt == '0' }">
							  <div class="col-md-9">휴대폰 소액 결제</div>
						  </c:if>
						   <c:if test="${order.payOpt == '1'}">
							  <div class="col-md-9">카드결제</div>
						  </c:if>
				</div>
			</div>
		<hr/>
	
	   		 <div class="form-group" align="center">
			<button type="button" class="btn btn-info"  id="home" style="color:white;">확인</button>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<button type="button" class="btn btn-outline-info" id="list" >주문목록 바로가기</button>
			</div>
			
</div>
			
	</form>
			 <jsp:include page="/toolbar/footer.jsp" />
</body>
</html>
