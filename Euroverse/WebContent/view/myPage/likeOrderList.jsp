<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${  empty user }">
	<jsp:forward page="/main.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Euroverse</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<script>

	var maPageCode = 'L';
	$(document).ready(function(){
		Show();
	})
	 function addFlightOrder(id){
		 self.location ="/order/flightOrder?flightId="+id;
	 }
	function addRoomOrder(id){
		self.location ="/order/roomOrder?roomId="+id;
	}

	$( function () {
		
		$("td:nth-child(2)").on("click",function(){
			var id = $(this).next().val();
			var type = $(this).next().next().val();
			if( type=="F" ){
		  		self.location ="/order/flightOrder?flightId="+id;
			}else if(type!="F"){
				 self.location ="/order/roomOrder?roomId="+id;
			}
		})
	})

	function doShow() { 
        $('div.h4').toggleClass('on');
	    if ($('#flight').is(":visible")) { 
	        $('#flight').hide();
	        $('#iconf').hide();
	        $('#room').show();
	        $('#iconr').show();// id값을 받아서 숨기기 
	    } 
	} 

	function Show() { 
         $('div.h4').toggleClass('on');
	    if ($('#room').is(":visible")) { 
	        $('#room').hide(); 
	        $('#iconr').hide();
	        $('#flight').show();
	        $('#iconf').show();// id값을 받아서 숨기기 
	    } 
	} 
	

	function deleteLike(refId,likeType){
		$.ajax({
			url : '/myPage/json/deleteLike/'+refId+'/'+likeType+'/' ,
			type : "GET" ,
			cache : false ,
			dataType : "json" ,
			success : function(JSONData) {
                $('#'+likeType+refId).css('display', 'none');
				/*var flightList = JSONData.flightList;
				var roomList = JSONData.roomList;
				var flight = "F";
				var room = "R";
				if(JSONData.likeType=='F'){
					$("#flightBody").html("");
					for(var i=0;i<flightList.length;i++){
						$("#flightBody").append("<tr>");
						$("#flightBody").append("<th scope='row'>"+(i+1)+"</th>");
						$("#flightBody").append("<td onclick='javascript:addFlightOrder("+flightList[i].flightId+")'>"+flightList[i].airline+"</td>");
						$("#flightBody").append("<td>"+flightList[i].depCity+"/"+flightList[i].arrCity+"</td>");
						$("#flightBody").append("<td>"+flightList[i].depTime+"-"+flightList[i].arrTime+" </td>");
						$("#flightBody").append("<td>"+flightList[i].stopOver+"/"+flightList[i].leadTime+" </td>");
						$("#flightBody").append("<td>"+flightList[i].price+"원</td>");
						$("#flightBody").append("<td><i class='fas fa-heart deleteFlight' onclick='javascript:deleteLike("+flightList[i].flightId+",\"F\")'></i></td> ");
						$("#flightBody").append("</tr>");
					}
				 	$('#room').hide(); 
			        $('#iconr').hide();
			        $('#flight').show();
			        $('#iconf').show();
				}
				if(JSONData.likeType=='R'){
					$("#roomBody").html("");
		 			for(var j=0;j<roomList.length;j++){
						$("#roomBody").append("<tr>");
						$("#roomBody").append("<th scope='row'>"+(j+1)+"</th>");
					 	$("#roomBody").append("<td onclick='javascript:addRoomOrder("+roomList[j].roomId+")'>"+roomList[j].roomCity+"</td>"); 
						$("#roomBody").append("<td>"+roomList[j].roomName+"</td>");
						$("#roomBody").append("<td>"+roomList[j].checkIn+"-"+roomList[j].checkOut+"</td>");
						$("#roomBody").append("<td>"+roomList[j].roomNum+"개/ 성인"+roomList[j].adultNum+"명 , 유아"+roomList[j].childNum+"명</td>");
						$("#roomBody").append("<td>"+roomList[j].price+"원</td>");
						$("#roomBody").append("<td><i class='fas fa-heart deleteFlight' onclick='javascript:deleteLike("+roomList[j].roomId+",\"R\")'></i></td> ");
						$("#roomBody").append("</tr>");
					 	$('#flight').hide();
				        $('#iconf').hide();
				        $('#room').show();
				        $('#iconr').show();
					}  
				}*/
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

</script>
<style>
    div.h4{
        opacity:0.5;
    }
    div.h4.on{
        opacity:1;
    }
    div.h4:hover{
        opacity: 1;
    }
    table {
        font-size: 10pt;
    }
</style>
</head>
<body>
	<jsp:include page="/toolbar/toolBar.jsp" />
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
	
		<div class="row">
            <jsp:include page="/view/user/userSideBar.jsp"/>
            
        <div style="width:60%;margin-left:5%;">
	<div class="container" style="width:100%;">
	
		<!--<div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;opacity: 1;">
			내가 찜한 상품:
		</div>-->
        <div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;" onclick="javascript:Show();">
        내가 찜한 항공
		</div>
        <div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;font-weight: bold; margin-top: 40px;margin-bottom:20px;opacity: 1;">
        |
		</div>
        <div class="h4 on" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;" onclick="javascript:doShow();">
        내가 찜한 숙소
		</div>

		<table class="table table-hover" id="flight" style="text-align: center;">
		  <thead>
		    <tr>
		      <th scope="col"></th>
		      <th scope="col">항공사</th>
		      <th scope="col">출발도시 - 도착도시</th>
		      <th scope="col">출발일시 - 도착일시</th>
		      <th scope="col">소요시간(경유)</th>
		      <th scope="col">가격</th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		 
		  <tbody id="flightBody">
		   
				<c:forEach var="flight" items = "${flightList}" varStatus="status" >
					 <tr id="F${flight.flightId}">
					      <th scope="row">
					      ${status.count}
					      </th>
						      <td>${flight.airline}
						      </td>
						      	<input type="hidden"  value="${flight.flightId }" />
						      	<input type="hidden" value="F"/>
						      <td>${flight.depCity} - ${flight.arrCity }</td>
						      <td>${flight.depDate.substring(0,4)}/${flight.depDate.substring(4,6)}/${flight.depDate.substring(6,8)} ${flight.depTime} - ${flight.arrDate.substring(0,4)}/${flight.arrDate.substring(4,6)}/${flight.arrDate.substring(6,8)} ${flight.arrTime }</td>
						      <td>${flight.leadTime}(${flight.stopOver})</td>
						      <td><fmt:formatNumber value="${flight.price}" pattern="###,###" />원</td>
							 	<td>
							 	    <i class="fas fa-heart deleteFlight" onclick="javascript:deleteLike(${flight.flightId},'F')"></i>
							 	</td> 
							 
				   	 </tr>
		    	 </c:forEach>
		    	 <c:if test="${ empty flightList}">
				    <tr><td colspan="7" style="padding: 40px;">찜한 상품이 없습니다</td></tr>
				</c:if>
		    	 
		  </tbody>
		</table>
	
		 
	
	
		 <table class="table table-hover" id="room" style="text-align: center;" >
		 
		  <thead>
		    <tr>
		      <th scope="col"></th>
		      <th scope="col">여행지</th>
		      <th scope="col">숙소</th>
		      <th scope="col">체크인 - 체크아웃</th>
		      <th scope="col">객실수/숙박인원</th>
		      <th scope="col">가격</th>
		      <th scope="col"></th>
		    </tr>
		  </thead>
		 
		  <tbody id="roomBody">
		   
			<c:forEach var="room" items = "${roomList}" varStatus="status" >
				 <tr id="R${room.roomId}">
				    <th scope="row"  id="refund2" >
				    ${status.count }
				    </th>
				    <td>${room.roomCity }</td>
						<input type="hidden"  value="${room.roomId }" />
				      	<input type="hidden" value="R"/>

				    <td>${room.roomName}</td>
				    <td>${room.checkIn.substring(0,4)}.${room.checkIn.substring(4,6)}.${room.checkIn.substring(5,7)} - ${room.checkOut.substring(0,4)}.${room.checkOut.substring(4,6)}.${room.checkOut.substring(5,7)}</td>
				    <td>${room.roomNum} 개 / 성인 ${room.adultNum} 명 , 유아 ${room.childNum} 명</td>
				    <td><fmt:formatNumber value="${room.price}" pattern="###,###" />원 </td>
				    <td> 
				        <i class="fas fa-heart deleteFlight" onclick="javascript:deleteLike(${room.roomId},'R')"></i>
				    </td>
			   	 </tr>
		     </c:forEach> 
		     
		     <c:if test="${ empty roomList}">
			    <tr><td colspan="7" style="padding: 40px;">찜한 상품이 없습니다</td></tr>
			</c:if>
		     
		  </tbody>
		</table>
		
	</div>	
            </div>
        </div>
	
	
</body>
<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>