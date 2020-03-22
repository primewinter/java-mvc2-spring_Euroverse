<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	
	<!-- fontAsome icon CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />	

	<!-- sweetalert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    
  	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
        image {
        	border : 1px solid lightpink;
        }
        h3{
        	color: white;
        	font-family : Consolas;
        }
      
        
        
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

		

 $(function() {
	 $( '.btn.btn-info' ).on("click" , function() {
	 	 var airline = $(this).next().val();
		 var depCity = $(this).next().next().val();
		 var arrCity = $(this).next().next().next().val();
		 var price = $(this).next().next().next().next().val();
		 var depDate = $(this).next().next().next().next().next().val();
		 var arrDate = $(this).next().next().next().next().next().next().val();
		 var stopOver = $(this).next().next().next().next().next().next().next().val();
		 var leadTime = $(this).next().next().next().next().next().next().next().next().val();
		 var tripCourse = $(this).next().next().next().next().next().next().next().next().next().val();
		 var seatGrade = $(this).next().next().next().next().next().next().next().next().next().next().val();
		 var depTime = $(this).next().next().next().next().next().next().next().next().next().next().next().val();
		 var arrTime = $(this).next().next().next().next().next().next().next().next().next().next().next().next().val();
		 var infantNum = $(this).next().next().next().next().next().next().next().next().next().next().next().next().next().val();
		 var adultNum = $(this).next().next().next().next().next().next().next().next().next().next().next().next().next().next().val();
		 var childNum = $(this).next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().val(); 
		//var a = $(this).children().find(".flight").val();
		/* var airline = flight;
		var b = flight.find($("#airline")).val()
		 alert("a : "+airline);
		alert("b : "+b);
		var b = $(".flight").siblings().val();
		
		//$(this).next().val().siblings().val(); */
		 
			//  $("form").attr("method" , "GET").attr("action" , "/order/addFlightOrder").submit();
			  self.location ="/order/addFlightOrder?airline="+airline+"&depCity="+depCity+"&arrCity="+arrCity+"&price="+price
					  +"&depDate="+depDate+"&arrDate="+arrDate+"&stopOver="+stopOver+"&leadTime="+leadTime
					  +"&tripCourse="+tripCourse+"&seatGrade="+seatGrade+"&depTime="+depTime+"&arrTime="+arrTime
					  +"&infantNum="+infantNum+"&adultNum="+adultNum+"&childNum="+childNum;
			  
	} );
});	 

 

 $(function () {
	 $(".heart").click(function () {
		 var bookMark = $(this).prev().val();
		 var flightId = $(this).val();
		 console.log(bookMark);
		 console.log("flightId : "+flightId);
		 var airline = $(this).next().val();
		 jQuery.trim(airline);
		 var depCity = $(this).next().next().val();
		 var arrCity = $(this).next().next().next().val();
		 var price = $(this).next().next().next().next().val();
		 var depDate = $(this).next().next().next().next().next().val();
		 var arrDate = $(this).next().next().next().next().next().next().val();
		 var stopOver = $(this).next().next().next().next().next().next().next().val();
		 var leadTime = $(this).next().next().next().next().next().next().next().next().val();
		 var tripCourse = $(this).next().next().next().next().next().next().next().next().next().val();
		 var seatGrade = $(this).next().next().next().next().next().next().next().next().next().next().val();
		 var depTime = $(this).next().next().next().next().next().next().next().next().next().next().next().val();
		 var arrTime = $(this).next().next().next().next().next().next().next().next().next().next().next().next().val();
		 var infantNum = $(this).next().next().next().next().next().next().next().next().next().next().next().next().next().val();
		 var adultNum = $(this).next().next().next().next().next().next().next().next().next().next().next().next().next().next().val();
		 var childNum = $(this).next().next().next().next().next().next().next().next().next().next().next().next().next().next().next().val(); 
		 //alert(depDate+arrDate+stopOver+leadTime+tripCourse);
		 $.ajax({
			url : '/flight/json/addFlight' ,
			type : "POST" ,
			cache : false ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				flightId : flightId,
				airline : airline,
 	     		depCity : depCity,
				arrCity : arrCity,
				price : price,
				depDate : depDate,
				arrDate : arrDate,
				stopOver : stopOver,
				leadTime : leadTime,
				tripCourse : tripCourse,
				seatGrade : seatGrade,
				depTime : depTime,
				arrTime : arrTime,
				infantNum : infantNum,
				adultNum : adultNum,
				childNum : childNum  
				
			}),
			success : function(data) {
				var msg = '';
				msg += data.msg;
				//alert(msg);
				//alert(data.refId);
				//alert(price)
				$("#"+bookMark).val(data.refId);
				if(data.likeCheck == 'F'){
					swal({
           		  	    icon : 'success',
           			    title : "찜 취소",
           			    text : " ",
           			    button : false,
           			    timer : 700
            	  	});
				  $("#"+bookMark).attr('class','btn btn-outline-danger heart');
				}else{
					swal({
  	               		icon : 'success',
  	               		title : "찜 추가",
  	               		text : " ",
  	               		button : false,
  	               		timer : 700
  	               	});
					
				  $("#"+bookMark).attr('class','btn btn-danger heart');
				}      
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		}); 
		 
	 });
 });



	
</script>



</head>



<body>
	<jsp:include page="/toolbar/toolBar.jsp" />
	 <jsp:include page="/toolbar/pushBar.jsp" />
	<div class="container">
	<form id="addFlight">
		<br><br>
			<table class="table">
			  <thead>
			    <tr>
			      <th scope="col">항공사</th>
			      <th scope="col">출발시간</th>
			      <th scope="col">도착시간</th>
			      <th scope="col">경유</th>
			      <th scope="col">소요시간</th>
			      <th scope="col">가격</th>
			      <th scope="col"></th>
			      <th scope="col"></th>
			    </tr>
			  </thead>
			  <tbody>
			  <c:set var="i" value="0"/>
			  <c:forEach var="flight" items = "${flightList}" >
			  <c:set var="i" value="${i+1}"/>
			  
			    <tr>
			      <th scope="row">${flight.airline}</th>
			      <td>${flight.depTime}</td>
			      <td>${flight.arrTime}</td>
			      <td>${flight.stopOver}</td>
			      <td>${flight.leadTime}</td>
			      <td><fmt:formatNumber value="${flight.price}" pattern="###,###" />원</td>
			      <td>
			      
			     <!--<i class="far fa-heart"  onclick="addWish('${flight.price }');" id="${flight.price }" style="font-size:15px;"></i>-->
			     	<input type="hidden" id="addBookMark" value="flight${i}"/>
                    <button type="button" class="btn btn-outline-danger heart" id="flight${i}" value="T" style="width:30px;height:30px;padding:initial;" onclick="addWish('${flight.price }');"><i class="fas fa-heart" style="width:30px;height:auto;"></i></button>
			     	<input type="hidden"  name="airline" value="${flight.airline }" />
					<input type="hidden"  name="depCity"  value="${flight.depCity }" />
					<input type="hidden"  name="arrCity" value="${flight.arrCity }" />
					<input type="hidden" name="price"  value="${flight.price }" />
					<input type="hidden"  name="depDate"  value="${flight.depDate }" >
					<input type="hidden"  name="arrDate"  value="${flight.arrDate }" >
					<input type="hidden"  name="stopOver"  value="${flight.stopOver }" >
					<input type="hidden"  name="leadTime"  value="${flight.leadTime }" >
					<input type="hidden"  name="tripCourse" value="${flight.tripCourse }" >
					<input type="hidden"  name="seatGrade"  value="${flight.seatGrade }" >
					<input type="hidden" name="depTime"  value="${flight.depTime }" >
					<input type="hidden"  name="arrTime"  value="${flight.arrTime }" >
					<input type="hidden"  name="infantNum" value="${flight.infantNum }" >
					<input type="hidden"  name="adultNum"  value="${flight.adultNum }" >
					<input type="hidden"  name="childNum"  value="${flight.childNum }" >
			     
			      </td>
			      <td><button type="button" class="btn btn-info btn-sm"  style="width:100px;">예약하기</button>
			      	<input type="hidden"  name="airline"  value="${flight.airline }" />
					<input type="hidden"  name="depCity"  value="${flight.depCity }" />
					<input type="hidden"  name="arrCity"  value="${flight.arrCity }" />
					<input type="hidden" name="price"  value="${flight.price }" />
					<input type="hidden"  name="depDate"  value="${flight.depDate }" >
					<input type="hidden"  name="arrDate"  value="${flight.arrDate }" >
					<input type="hidden"  name="stopOver"  value="${flight.stopOver }" >
					<input type="hidden"  name="leadTime"  value="${flight.leadTime }" >
					<input type="hidden"  name="tripCourse"  value="${flight.tripCourse }" >
					<input type="hidden"  name="seatGrade"  value="${flight.seatGrade }" >
					<input type="hidden" name="depTime"  value="${flight.depTime }" >
					<input type="hidden"  name="arrTime"  value="${flight.arrTime }" >
					<input type="hidden"  name="infantNum" value="${flight.infantNum }" >
					<input type="hidden"  name="adultNum" value="${flight.adultNum }" >
					<input type="hidden"  name="childNum"  value="${flight.childNum }" >
					</td>
			    </tr>
			  </c:forEach>
			  </tbody>
			  
			</table>
		</form>
		</div>

		 <jsp:include page="/toolbar/footer.jsp" />
</body>
</html>