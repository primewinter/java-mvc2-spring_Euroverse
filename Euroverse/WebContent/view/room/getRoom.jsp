<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 가격 콤마 추가 -->
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*" %>

<html lang="ko">
<head>
<title>구매 목록조회</title>
<meta charset="UTF-8">
	
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
	  body {
			font-family: "Nanum Gothic";
        }
        
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

$(function() {
	 $( '#reserve' ).on("click" , function() {
	  	
		 var price = $("#price").val();
	     var roomName = $("#roomName").val();
	     var roomCity = $("#roomCity").val();
	     var adultNum = $("#adultNum").val();
	     var childNum = $("#childNum").val();
	     var checkOut = $("#checkOut").val();
	     var checkIn = $("#checkIn").val();
	     var roomNum = $("#roomNum").val();
	     var roomAddr = $("#roomAddr").val();
	     
	     var mainService = $("#mainService").val();
	     var familyService = $("#familyService").val();
	     var sights = $("#sights").val();
	     var hotelInfo = $("#hotelInfo").val();
	     var roomInfo = $("#roomInfo").val();
	     
	     //alert("price : "+price+"roomName : "+roomName+"adult : "+adultNum+"child : "+childNum+"checkOut : "+checkOut+"checkIn : "+checkIn+"roomNum : "+roomNum)
	     //var location = $("#location").val();
	     //var distance = $("#distance").val();
	     //var grade = $("#grade").val();
	     
	     //$("#checkIn").val(checkIn);
	     
		 self.location ="/order/addRoomOrder?roomName="+roomName+"&price="+price+"&roomCity="+roomCity+"&checkIn="+checkIn
				 +"&roomNum="+roomNum+"&adultNum="+adultNum+"&childNum="+childNum+"&checkOut="+checkOut+"&mainService="+mainService
				 +"&familyService="+familyService+"&sights="+sights+"&hotelInfo="+hotelInfo+"&roomInfo="+roomInfo;
				 
		 
	});
});	


/* ---------------- 관심상품!!! ----------------- */

$(function () {
	 $("#wish").click(function () {
		 
		 var roomId = $(this).val();
		 var price = $("#price").val();
	     var roomName = $("#roomName").val();
	     var roomCity = $("#roomCity").val();
	     var adultNum = $("#adultNum").val();
	     var childNum = $("#childNum").val();
	     var checkOut = $("#checkOut").val();
	     var checkIn = $("#checkIn").val();
	     var roomNum = $("#roomNum").val();
	     var roomAddr = $("#roomAddr").val();
	     
	     var mainService = $("#mainService").val();
	     var familyService = $("#familyService").val();
	     var sights = $("#sights").val();
	     var hotelInfo = $("#hotelInfo").val();
	     var roomInfo = $("#roomInfo").val();
	     
	     
		 $.ajax({
			url : '/room/json/addRoom' ,
			type : "POST" ,
			cache : false ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				roomId : roomId,
				price : price,
				roomName : roomName,
				roomCity : roomCity,
				adultNum : adultNum,
				childNum : childNum,
				checkOut : checkOut,
				checkIn : checkIn,
				roomNum : roomNum,
				roomAddr : roomAddr
				/* mainService : mainService,
				familyService : familyService,
				sights : sights,
				hotelInfo : hotelInfo,
				roomInfo : roomInfo */
				
			}),
			success : function(data) {
				var msg = '';
				msg += data.msg;
				//alert(msg);
				//alert(data.refId);
				$("#wish").val(data.refId);
				if(data.likeCheck == 'F'){
					swal({
           		  	    icon : 'success',
           			    title : "찜 취소",
           			    text : " ",
           			    button : false,
           			    timer : 700
            	  	});
				  $("#wish").attr('class','btn btn-outline-secondary');
				}else{
					swal({
  	               		icon : 'success',
  	               		title : "찜 추가",
  	               		text : " ",
  	               		button : false,
  	               		timer : 700
  	               	});
					
				  $("#wish").attr('class','btn btn-danger');
				}      
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); 
		 
	 });
});





/* ----------------- 끝!! ------------------ */
	
	
	
</script>



</head>


<!-- 폼태크 -> input 안에 link 줌 -> controller 타기  ////link 필드 추가아아 -->

<body>
<form>
	<jsp:include page="/toolbar/toolBar.jsp" />
	 <jsp:include page="/toolbar/pushBar.jsp" />
	<div class="container" style="margin-left:25%;">
		<div class="row">
		<br/>
				
				<div class="col-sm-8" style="background-color:whitesmoke;">
					<div class="row" style="color:gray;margin-top:10px;margin-left:20px;margin-right:25px;margin-bottom:10px;">
						<p style="font-size:18px;"><strong>${room.roomName}</strong></p>
						<address class="contact">
							<span style="font-size:13px;">${room.roomAddr}</span>
						</address>
					</div>
						<br/>
					<div class="row" style="margin-left:10px;margin-top:-20px;">
							<div class="col-sm-8">
								<p style="margin-bottom:5px;font-size:13px;"><i class="fas fa-map-marker-alt" style="margin-left:2px;font-size:15px;"></i>&nbsp;&nbsp;${room.location}</p>
								<p style="margin-bottom:5px;font-size:13px;"><i class="fas fa-road"></i>&nbsp;&nbsp;${room.distance}</p>
								<p style="font-size:18px;"><strong><i class="fas fa-heart"></i>&nbsp;&nbsp;${room.grade}</strong></p>
							</div>
							<div class="col-sm-4" style="Padding-left:30px">
								<div class="row" style="margin-left:10px;">
										<i class="fas fa-won-sign" style="font-size:22px;"><fmt:formatNumber value="${room.price}" pattern="###,###" /> 원</i>
								</div>
								<p></p>
                                 <button type="button" class="btn btn-outline-secondary" id="wish" value="R" style="height:38px"><i class="fas fa-heart"></i></button>
								
								<button type="button" class="btn btn-info" style="" id="reserve">예약하기</button>
									<input type="hidden" name="price" value=" ${room.price}" id="price">
							    	<input type="hidden" name="roomCity" value=" ${room.roomCity}" id="roomCity">
							    	<input type="hidden" name="checkIn" value=" ${room.checkIn}" id="checkIn">
							    	<input type="hidden" name="checkOut" value=" ${room.checkOut}" id="checkOut">
							    	<input type="hidden" name="adultNum" value=" ${room.adultNum}" id="adultNum">
							    	<input type="hidden" name="childNum" value=" ${room.childNum}" id="childNum">
							    	<input type="hidden" name="roomNum" value=" ${room.roomNum}" id="roomNum">
							    	<input type="hidden" name="roomName" value=" ${room.roomName}" id="roomName">
							    	<input type="hidden" name="roomAddr" value=" ${room.roomAddr}" id="roomAddr">
							    	
							    	<input type="hidden" name="mainService" value=" ${room.mainService}" id="mainService">
							    	<input type="hidden" name="familyService" value=" ${room.familyService}" id="familyService">
							    	<input type="hidden" name="sights" value=" ${room.sights}" id="sights">
							    	<input type="hidden" name="hotelInfo" value=" ${room.hotelInfo}" id="hotelInfo">
							    	<input type="hidden" name="roomInfo" value=" ${room.roomInfo}" id="roomInfo">
							    <br/>
							</div>
					</div>
					</div>
							
					<br/>
				</div>
				<br/>
				<div class="row" style="margin-left:-15;">
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel"
							style="width:760px;">
					  <ol class="carousel-indicators">
					    <li data-target="#carouselExampleIndicators"  data-slide-to="0" class="active"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="1"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="2"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="3"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="4"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="5"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="6"></li>
					    <li data-target="#carouselExampleIndicators"  data-slide-to="7"></li>
					  </ol>
					  <div class="carousel-inner">
					   	<div class="carousel-item active" >
					      <img src="/resources/images/roomImg/${room.roomImg}" class="d-block w-100" alt="...">
					    </div>
					  <c:forEach var="room" items = "${roomList}"  begin="1">
					    <div class="carousel-item" >
					      <img src="/resources/images/roomImg/${room.roomImg}" class="d-block w-100" alt="...">
					    </div>
					   </c:forEach>
					  </div>
					  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </a>
					</div>
				</div>
				<br/>
					<div class="row" style="font-size:13px;">
						<div class="col-sm-4" style="background-color:whitesmoke;">
							<div class="row" style="margin-left:10px;">
								<p style="font-size:18px;margin-top:10px;"><strong>주요 편의 시설</strong></p>
								<p>${room.mainService }</p>
							</div>
							<hr/>
							<div class="row" style="margin-left:10px;">
								<p style="font-size:18px;margin-top:10px;"><strong>가족 여행객을 위한 편의 시설</strong></p>
								<p>${room.familyService } </p>
							</div>
						</div>
				    	<div class="col-sm-4" style="background-color:whitesmoke;">
				    		<p style="font-size:18px;margin-top:10px;"><strong>주변 명소</strong></p>
				    		<p>${room.sights } </p>
				    	</div>
					</div>	
					<hr style="margin-left:-10px;width:65%;"/>
					<div class="row" style="font-size:13px;">
						<div class="col-sm-8" style="background-color:whitesmoke;">
						<p style="font-size:18px;margin-top:10px;"><strong>호텔 내 정보</strong></p>
							<p>${room.hotelInfo } </p>
						<p style="font-size:18px;margin-top:10px;"><strong>객실 내 정보</strong></p>
		    				<p>${room.roomInfo } </p>
	    				</div>
					</div>
					<br/><hr/>
					
</div>
</form>

				 <jsp:include page="/toolbar/footer.jsp" />
</body>
</html>