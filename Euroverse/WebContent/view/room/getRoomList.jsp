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
	
	<!-- asome icon CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />	

  	<!-- jQuery UI toolTip 사용 CSS-->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- jQuery UI toolTip 사용 JS-->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
/*			font-family: "Nanum Gothic", "Malgun Gothic", "돋움", Dotum, "돋움", Dotum, Arial, Helvetica, sans-serif;*/
          font-family: "Nanum Gothic";
        }
        
       /* 로딩용 css */
	
			#loading {
			 width: 100%;   
			 height: 100%;   
			 top: 0px;
			 left: 0px;
			 position: fixed;   
			 display: block;   
			 opacity: 0.7;   
			 background-color: #fff;   
			 z-index: 99;   
			 text-align: center; }  
			  
			#loading-image {   
			 position: absolute;   
			 top: 50%;   
			 left: 50%;  
			 z-index: 100; } 
		
		/* 로딩 css 끝... */ 
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">


/* $(function() {
	 $( 'button' ).on("click" , function() {
		 
	        
	        //$("#merchant_uid").val()
		 var detailLink = $(this).val();
	     var price = $(this).next().val();
	     var roomCity = $(this).next().next().val();
	     var roomNum = $(this).next().next().next().val();
	     var checkIn = $(this).next().next().next().next().val();
	     var adultNum = $("#adultNum").val();
	     var childNum = $("#childNum").val();
	     var checkOut = $("#checkOut").val();
	     var location = $("#location").val();
	     var distance = $("#distance").val();
	     var grade = $("#grade").val();
	     var roomAddr = $("#roomAddr").val();
	     
	     $("#checkIn").val(checkIn);
	     
		 alert(detailLink+"price"+price+"room : "+roomCity+"checkIn : "+checkIn);
		 self.location ="/room/getRoom?detailLink="+detailLink+"&price="+price+"&roomCity="+roomCity+"&checkIn="+checkIn
				 +"&roomNum="+roomNum+"&adultNum="+adultNum+"&childNum="+childNum+"&checkOut="+checkOut+"&location="+location
				 +"&distance="+distance+"&grade="+grade+"&roomAddr="+roomAddr;
	  //$("form").attr("method" , "POST").attr("action" , "/room/getRoom").submit();

	});
});	 */

/* ---------------- 로딩......  ---------------- */



$(function(){

	$(".btn.btn-info").on("click",function(){
					
				var loading = document.getElementById("loading");
				loading.style.display = 'block';
				
				
				/* 값 보내는 부분.... */
				 var detailLink = $(this).val();
			     var price = $(this).next().val();
			     var roomCity = $(this).next().next().val();
			     var roomNum = $(this).next().next().next().val();
			     var checkIn = $(this).next().next().next().next().val();
			     var adultNum = $("#adultNum").val();
			     var childNum = $("#childNum").val();
			     var checkOut = $("#checkOut").val();
			     var location = $("#location").val();
			     var distance = $("#distance").val();
			     var grade = $("#grade").val();
			     var roomAddr = $("#roomAddr").val();
			     
			     $("#checkIn").val(checkIn);
			     
				 //alert(detailLink+"price"+price+"room : "+roomCity+"checkIn : "+checkIn);
				 self.location ="/room/getRoom?detailLink="+detailLink+"&price="+price+"&roomCity="+roomCity+"&checkIn="+checkIn
						 +"&roomNum="+roomNum+"&adultNum="+adultNum+"&childNum="+childNum+"&checkOut="+checkOut+"&location="+location
						 +"&distance="+distance+"&grade="+grade+"&roomAddr="+roomAddr;
				
				
				/* ------- 끝! -------*/
				
				setTimeout(function() {
					loading.style.display = 'none';
					 $('#loading').hide();  
						}, 100000);
	
					
 
 	})
})
/* ---------------- 로딩......끝!!!  ---------------- */





</script>



</head>


<!-- 폼태크 -> input 안에 link 줌 -> controller 타기  ////link 필드 추가아아 -->

<body>
<jsp:include page="/toolbar/toolBar.jsp" />
 <jsp:include page="/toolbar/pushBar.jsp" />
	<div class="container">
			<div id="loading" style="display:none;">
				<div class="col-sm-6" style="margin-left:300px;margin-top:300px">
					<img id="loading-image" width="150px" height="150px" 
				
					src="/resources/images/orderImg/Ellipsis-1.4s-200px.gif" alt="Loading..." />
				</div>
			</div>
			
		<c:forEach var="room" items = "${roomList}" >
		<hr style="width:830px;margin-left:80px;float:left;margin-right:600px;" />
		<div class="row" style="margin-left:13px;">
		<br/>
				<div class="col-sm-2" style="margin-left:50px;margin-right:20px;">
					<img src = "/resources/images/roomImg/${room.roomImg}" width="180" height="120"/>
				</div>
				<div class="col-sm-7" style="background-color:whitesmoke;">
					<div class="row" style="color:gray;margin-top:10px;margin-left:20px;margin-right:20px;margin-bottom:10px;">
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
							<div class="col-sm-4">
								<div class="row" id="price" style="margin-left:10px;">
										<i class="fas fa-won-sign" style="font-size:22px;"><fmt:formatNumber value="${room.price}" pattern="###,###" /> 원</i>
								</div>
								<br/>
								<button type="button" class="btn btn-info"  value="${room.detailLink}" style="margin-top:-10px;width:120px;">상세보기</button>
									<input type="hidden" name="price" value=" ${room.price}">
							    	<input type="hidden" name="roomCity" value=" ${room.roomCity}">
							    	<input type="hidden" name="roomNum" value=" ${room.roomNum}">
							    	<input type="hidden" name="checkIn" value=" ${room.checkIn}">
							    	<input type="hidden" name="adultNum" value=" ${room.adultNum}" id="adultNum">
							    	<input type="hidden" name="childNum" value=" ${room.childNum}" id="childNum">
							    	<input type="hidden" name="checkOut" value=" ${room.checkOut}" id="checkOut">
							    	<input type="hidden" name="location" value=" ${room.location}" id="location">
							    	<input type="hidden" name="distance" value=" ${room.distance}" id="distance">
							    	<input type="hidden" name="roomAddr" value=" ${room.roomAddr}" id="roomAddr">
							    	<input type="hidden" name="grade" value=" ${room.grade}" id="grade">
							</div>
					</div>
					</div>
							
					<br/>
				</div>
				
		</c:forEach>
			<%-- 
			      <td><button type="button" class="btn btn-info" style="width:40px;">상세보기</button>
			    	<input type="hidden" name="price" value=" ${room.price}">
			    	<input type="hidden" name="roomCity" value=" ${room.roomCity}">
			    	<input type="hidden" name="roomNum" value=" ${room.roomNum}">
			    	<input type="hidden" name="checkIn" value=" ${room.checkIn}">
			    	<input type="hidden" name="adultNum" value=" ${room.adultNum}" id="adultNum">
			    	<input type="hidden" name="childNum" value=" ${room.childNum}" id="childNum">
			    	<input type="hidden" name="checkOut" value=" ${room.checkOut}" id="checkOut">
    				<input type="hidden" name="detailLink" value="${room.detailLink}">
    			<input href="${purchase.merchant_uid }" type="button" value="상세보기" />
    			</td>
			    </tr>
			  </c:forEach>
			  </tbody>
			</table> --%>
		</div>
		 <jsp:include page="/toolbar/footer.jsp" />
</body>
</html>