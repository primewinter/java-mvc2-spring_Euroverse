<%@page import="com.ksy.service.domain.User"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${  empty user }">
	<jsp:forward page="/main.jsp"/>
</c:if>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Euroverse</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
     <!-- sweetalert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />


	<!-- 풀캘린더 cdn -->
	<link href='https://unpkg.com/@fullcalendar/core@4.3.1/main.min.css' rel='stylesheet' />
  	<link href='https://unpkg.com/@fullcalendar/daygrid@4.3.0/main.min.css' rel='stylesheet' />
  	<link href='https://unpkg.com/@fullcalendar/timegrid@4.3.0/main.min.css' rel='stylesheet' />
	<link href='https://unpkg.com/@fullcalendar/list@4.3.0/main.min.css' rel='stylesheet' />
	
	<script src='https://unpkg.com/@fullcalendar/core@4.3.1/main.min.js'></script>
	<script src='https://unpkg.com/@fullcalendar/daygrid@4.3.0/main.min.js'></script>
	<script src='https://unpkg.com/@fullcalendar/interaction@4.3.0/main.min.js'></script>
	<script src='https://unpkg.com/@fullcalendar/timegrid@4.3.0/main.min.js'></script>
	<script src='https://unpkg.com/@fullcalendar/list@4.3.0/main.min.js'></script>


	<!-- ICON 사용을 위한 스크립트 임포트 -->
	<!-- https://feathericons.com/ -->
	<script src="https://unpkg.com/feather-icons"></script>
	


<style>
    #calendar > div.fc-view-container > div > table > thead > tr > td > div > table > thead > tr {
        background-color: rgb(151,235,219);
    }
    #calendar > div.fc-view-container > div > table {
        font-size: 0.8em;
    }
    .fc-unthemed td.fc-today {
        background : #cbf5ed;
    }
    .fc-event {
        border:0px;
    }
    td.fc-event-container {
        background-color: aqua;
        text-align: center;
    }
    .fc-title {
        font-size: 2em;
        color: #0086ad;
    }
    .fc-content {
        width:3em;
        height:3em;
        border:0px;
/*        border: 1px solid #0086ad;*/
        border-radius:50%;
/*        background-color: pink;*/
        margin:0px;
        
    }
    a.fc-day-grid-event {
        width: 3em;
        height: 3em;
        display:inline-block;
        background-color: transparent;
    }
    .fc .fc-row .fc-content-skeleton table, .fc .fc-row .fc-content-skeleton td, .fc .fc-row .fc-mirror-skeleton td {
        background-color:transparent;
    }
    .fc-unthemed .fc-content, .fc-unthemed .fc-divider, .fc-unthemed .fc-list-heading td, .fc-unthemed .fc-list-view, .fc-unthemed .fc-popover, .fc-unthemed .fc-row, .fc-unthemed tbody, .fc-unthemed td, .fc-unthemed th, .fc-unthemed thead {
        border-color: #f0f0f0;
    }

	#userInfoDiv .allInfo{
		display: inline-block;
		width: 208px;
		height: 100px;
		text-align: center;
		
	}
	
		
	#userInfoDiv .allInfo  p{
	/* font-family: 'Noto Sans KR', sans-serif; */
	font-size: 23px;
	border-right: thin;
	}
	
	#userInfoProfile h4{
	/* font-family: 'Noto Sans KR', sans-serif; */
	font-size: 23px;
	/* position: relative; */
	}
	
	
	 .nicknameClass{
	/* font-family: 'Noto Sans KR', sans-serif; */
	}
	.badge{
	/* font-family: 'Noto Sans KR', sans-serif; */
	align-content: center;
	}
	
	
	
	
	
	
	
	/* entire container, keeps perspective */
	.flip-container {
	margin:15px 20px;
	    perspective: 1000px;
	   border:2px solid rgba(0,0,0,0) !important;
	   
	}
	
	
	/* front pane, placed above back */
	.front{
	  z-index:2;
	  /* for firefox 31 */
	  transform: rotateY(0deg);
	 /*  background-size:100% 100%; */
	 //box-shadow: 5px 5px 7px gray;
	 border-radius :4px; 
	  border: 1px solid #F7F0F0;
	}
	/* back, initially hidden pane */
	.back {
	    transform: rotateY(180deg);
	  /* background-size:100% 100%; */
	  //box-shadow: 5px 5px 7px gray;
	  border-radius :4px;
	   border: 1px solid #F7F0F0;
	  
	}
	
	/* flip the pane when hovered */
	.flip-container:hover .flipper, .flip-container.hover .flipper {
	    transform: rotateY(180deg);
	}
	
	.flip-container, .front, .back {
	    width: 120px;
	    height: 120px;
	   /*border:1px solid lightgray;*/
	}
	/* flip speed goes here */
	.flipper {
	    transition: 0.6s;
	   /* 하위요소에 3D 좌표값 지정 */
	    transform-style: preserve-3d;
	    position: relative;
	}
	/* hide back of pane during swap */
	.front, .back{
	  position: absolute;
	  backface-visibility:hidden;
	}

	.modal {
          text-align: center;
    }
        
	@media screen and (min-width: 768px) {
          .modal:before {
            display: inline-block;
            vertical-align: middle;
            content: " ";
            height: 100%;
          }
	}
    .modal-dialog {
	    display: inline-block;
	    text-align: left;
	    vertical-align: middle;
    }
	 .col{
		font-size: 12px;
	}
	.h6Class{
		color: red;
	}
    
    .fc-choolCheck-button {
        width: 7em;
        color: black;
        font-family:'NIXGONM-Vb';
        border: 0px;
        background: #97ebdb;
        font-size:0.8em;
    }
    .fc-left h2 {
        font-family: 'NIXGONM-Vb';
    }
    
	

</style>

<script>

$(document).ready(function() {
    
    
	var Calendar = FullCalendar.Calendar;
	var Draggable = FullCalendarInteraction.Draggable;

	var containerEl = document.getElementById('external-events');
	var calendarEl = document.getElementById('calendar');
	var checkbox = document.getElementById('drop-remove');

	var calendar = new Calendar(calendarEl, {
	    plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
	    customButtons: {
	        choolCheck: {
	          text: '출석체크',
	          click: function() {
				var date = new Date();
	          	var currentDate = date.getFullYear() + "-"+ (date.getMonth()+1) + "-" +date.getDate();
	          	var stringDate = date.getFullYear() +""+(date.getMonth()+1) +date.getDate();
				$(function(){
					$.ajax({
						url : "/myPage/json/choolChecking",
						method : "post",
						dataType : "json",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						data : JSON.stringify({
							currentDate : currentDate,
							year : date.getFullYear(),
							month : date.getMonth()+1,
							day : date.getDate(),
							stringDate : stringDate
						}),
						success : function(JSONData, Status) {
								
								if(JSONData.error == 'error'){
									
									swal({
										   icon : 'warning',
										  title : "출석체크 실패!",
										  text:"내일 다시 시도해주세요.",
										 
										})
								}else{
									calendar.addEvent(JSONData);
                                    chulCheckBtn(doc);
									swal({
										   icon : 'success',
										  title : "출석체크 성공!",
										  text:"100Point 적립 ",
										})
								}
							}
					})	
				})
	          }
	        }
	      },
	    header: {
	      left: 'title',
	      right : 'choolCheck'
	    },
        eventSources: [{
	       events: function(start, callback) {
	           $.ajax({
                    url     : '/myPage/json/choolCheck',
                    type    : 'get',
                    dataType: 'json',
                    success : function(doc) {
                        callback(doc);
                        console.log("출첵하고 가져온 데이터 events ");
                        chulCheckBtn(doc);
                    }
                });
           }
        }],
        editable: false,
	    eventLimit : true,
	    cache : true,
	    /*locale: 'ko',*/
	    height: 480 ,
	  });
	calendar.render();
    
    $('.fc-choolCheck-button').on('hover', function() {
        $(this).css('background', '#00c2c7');
    });
    
    

})

    function chulCheckBtn(doc) {
        var date = new Date();
        var year = date.getFullYear();
        var month = date.getMonth()+1
        var day = date.getDate();
        if(month < 10){
            month = "0"+month;
        }
        if(day < 10){
            day = "0"+day;
        }

        var today = year+"-"+month+"-"+day;

         
        $(doc).each(function() {
            console.log('오늘 : '+today);
            if( today == $(this).attr('start')) {
                console.log('담아오는 날짜 : '+$(this).attr('start'));
                $('.fc-choolCheck-button').prop("disabled", true).html('출석 완료').unbind();
            }
        });
        $('.fc-title').html('<i class="fas fa-check"></i>');
    }

var maPageCode = 'M';

	$(function(){
		
		$("#cancle").on("click",function(){
			$(self.location).attr("href","/user/getUser");
		})
		
		$("#pwdCheck").on("click",function(){
			var pwd = $("input[id='pwdId']");
			var main = $("#main");
			var errorMsg = $("#pwdMessage");
			if('${user.pwd}' == pwd.val()){
				$("#checkPwd").modal("hide");
				
				$(self.location).attr("href","/user/updateUser");
				
			}else{
				errorMsg.text("비밀번호가 틀렸습니다.");
			}
		})
		
		$("#pwdId").keydown(function (key) {
			enterConfirm(key);
		})
		
		
		
		$("#updateMyProfile").on("click",function(){
			$("#checkPwd").modal({keyboard: false,backdrop: 'static'});
			$("#checkPwd").modal("show");
			
			
			
		})
		
		$("#pointCard").on("click",function(){
			$(self.location).attr("href","/myPage/pointList");
		})
		
		$("#planCard").on("click",function(){
			$(self.location).attr("href","/plan/getPlanList");
		})
		
		$("#slotCard").on("click",function(){
			$(self.location).attr("href","/plan/getPlanList");
		})
		
		$("#postCard").on("click",function(){
			$(self.location).attr("href","/myPage/myPostCommentList");
		})
		
		$("#commentCard").on("click",function(){
			$(self.location).attr("href","/myPage/myPostCommentList");
		})
		
		$("#partyCard").on("click",function(){
			 $(self.location).attr("href", "/community/getPostList?boardName=D");
		})
		
	})
	
	
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})
	
	function country(country){
		$("#appendCountry").html("");
		
		$("#appendCountry").append(country);
	
	}
	
	
	function tripStyle(tripStyle){
		$("#appendStyle").html("");
		
		$("#appendStyle").append(tripStyle);
	
	}
	
	
	function enterConfirm(key){
		var pwd = $("input[id='pwdId']");
		var main = $("#main");
		var errorMsg = $("#pwdMessage");
		if(key.keyCode == 13){
			if('${user.pwd}' == pwd.val()){
				$("#checkPwd").modal("hide");
				$(self.location).attr("href","/user/updateUser");
				
			}else{
				errorMsg.text("비밀번호가 틀렸습니다.");
			}
		}
	}
    
	
	
	
	
	
	
	
</script>

</head>
<body>

	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
		<div class="row">
            <jsp:include page="/view/user/userSideBar.jsp"/>
            
        <div style="width:70%;margin-left:0%;">
		
		
<div id="main">	
	<div class="container" style="width:100%;margin:auto;">
					
		<div id="userProfileDiv" style="width:100%;height:230px;padding-top: 30px;">
			<div class="d-flex justify-content-between" style="padding: 0px 70px;">
			
				<!-- 유저이미지 / 유저정보 ////////////////////////////////////////// -->
				<div class="row" style="font-family: 'NIXGONM-Vb';">
					<!-- 유저이미지 -->
			   		<div>
			   			<img alt="" src="/resources/images/userImages/${user.userImg}" style="border-radius: 180px;width:210px;height: 210px;border: 1px solid #DBE0E5;">
				 	</div>
				 	<!-- 유저정보 -->
				 	<div style="margin-left: 30px;margin-top: 20px;">
				 	
				 		<c:if test="${user.role == 'G' }">
			                 <div class="badge badge-secondary">비인증회원</div>
	                 	</c:if>
	                 	<c:if test="${user.role == 'Q' }">
	                 		<div class="badge badge-info">인증회원</div>
	                 	</c:if>
	                 	<c:if test="${user.role == 'A' }">
	                 		<div class="badge badge-success" >관리자</div>
	                 	</c:if>
	                 	
	                 		 <!--badge End  -->
	                 	<span data-toggle="tooltip" data-placement="top" title="내정보 수정">&nbsp;<span data-feather="settings" style="cursor: help" id="updateMyProfile"></span></span>
	                 	
					    <div class="nicknameClass" style="font-size: 25px;margin:  5px 0px 15px 0px;">
							 ${user.nickname} <span style="font-size: 18px;">님 안녕하세요!</span>
							<!-- <i class="far fa-address-card" style=" text-decoration: underline; cursor: help;">상세보기</i> -->
			  			</div> 
			  			
			  			<div style="font-size: 16px;display: inline-block;">
				  			<div style="">
				  				<span data-feather="user"></span> &nbsp; 
				  				${user.userName}&nbsp;
				  				<c:if test="${user.sex == 'M'}">
					  				<i class="fas fa-mars" style="color: #106ABD;"></i>
					  			</c:if>
					  			<c:if test="${user.sex == 'F'}">
					  				<i class="fas fa-venus" style="color: #BD1010;"></i>
					  			</c:if>
				  			</div>
				  			<div style="font-size: 16px;">
				  				<span data-feather="mail"></span> &nbsp; ${user.email}
				  			</div>
				  			
				  			<div style="font-size: 16px;">
				  				<span data-feather="phone"></span> &nbsp; ${user.phone}
				  			</div>
				  			
				  			<div style="font-size: 16px;">
				  				<i class="far fa-calendar-alt"></i> &nbsp; <fmt:formatDate value="${user.regDate}" pattern="yyyy-MM-dd"/> 가입
				  			</div>
				  			
				  			
			  			</div>
			  			
			  		</div>
			  	</div>
		  		<!-- 유저이미지 / 유저정보 ////////////////////////////////////////// -->
		  		
		  		
		  		<!-- 가고싶은나라 / 여행스타일 /////////////////////////////// -->
		  		<div style="font-family: 'NIXGONM-Vb';width: 290px;border-left: 1px solid #E7E7E7; padding-left: 20px;margin-top: 30px;margin-bottom: 10px;float: right;">
					<div style="margin-bottom: 20px;">
						<div style="margin-bottom: 5px;">
							<span data-feather="flag"></span> &nbsp;가고싶은 나라
						</div>
						<div style="margin-left: 20px;">
				  			<c:forEach var="tripSurvey" items="${tripSurveyList}" varStatus="status" >
								<c:if test="${tripSurvey.surveyType=='D'}">
									 <%-- <img src="/resources/images/tripInfoimges/${tripSurvey.surveyImg}" alt="..." width="60px" height="47px" onmouseover="country('${tripSurvey.surveyChoice}')" onmouseout="country('')" style="margin:3px;cursor: help;" title="${tripSurvey.surveyChoice}"  > --%>
									<span data-toggle="tooltip" data-placement="top" title="${tripSurvey.surveyChoice}"><img src="/resources/images/tripInfoimges/${tripSurvey.surveyImg}" alt="..." width="42px" height="28px" onmouseover="country('${tripSurvey.surveyChoice}')" onmouseout="country('')" style="margin:3px;cursor: help"></span>
								</c:if>
							</c:forEach> 
						</div>
					</div>
					
					<div>
						<div style="margin-bottom: 5px;font-family: 'NIXGONM-Vb';">
							<span data-feather="compass"></span> &nbsp;여행스타일
						</div>
						<div style="margin-left: 20px;">
							<c:forEach var="tripSurvey" items="${tripSurveyList}" varStatus="status" >
								<c:if test="${tripSurvey.surveyType=='T'}">
									<span data-toggle="tooltip" data-placement="top" title="${tripSurvey.surveyChoice}"><img src="/resources/images/tripInfoimges/${tripSurvey.surveyImg}" alt="..." width="40px" height="37px" onmouseover="tripStyle('${tripSurvey.surveyChoice}')" onmouseout="tripStyle('')" style="margin: 3px;cursor: help;" ></span>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<!-- 가고싶은나라 / 여행스타일 /////////////////////////////// -->
		  		
	  		</div>
	  		
		</div>  
		<div style="height: 60px;"></div>		
		<div class="row">
			<div style="width: 625px;font-family: 'NIXGONM-Vb';"><!-- 카드들 묶어놓음 -->
				<!-- 카드 여섯장 ///////////////////////////////////////////////// -->
				<div style="text-align: center;margin-top: 60px;">
			      	<div class="flip-container" ontouchstart="this.classList.toggle('hover');" style="display: inline-block;cursor:pointer" id="pointCard">
						  <div class="flipper">
			   					<div class="front" style="border: 1px solid; text-align: center; padding-top: 45px;">
			      					  <!-- front content -->
			    					<p style="font-size: 20px;"><i class="fas fa-coins"></i> 포인트</p>
			  					</div>
				    			<div class="back" style="border: 1px solid; text-align: center;padding-top: 45px;" id="totalPoint">
				        			<!-- back content -->
			 						<p style="font-size: 20px;">
			 					 	<fmt:formatNumber value="${user.totalPoint}" pattern="###,###" />P
			 						</p>
				   				</div>
							</div>
					</div>
			
			      	<div class="flip-container" ontouchstart="this.classList.toggle('hover');" style="display: inline-block;cursor:pointer" id="planCard">
						  <div class="flipper">
			   					 <div class="front" style="border: 1px solid; text-align: center; padding-top: 45px;">
			      					  <!-- front content -->
			    					<p style="font-size: 20px;"><i class="far fa-flag"></i> 유럽에서</p>
			  					  </div>
			      				<div class="back" style="border: 1px solid; text-align: center;padding-top: 45px;">
			         				 <!-- back content -->
			   						<p style="font-size: 20px;">${travelDate}일</p>
			     				</div>
			  				</div>
					</div>
			       
			      	<div class="flip-container" ontouchstart="this.classList.toggle('hover');" style="display: inline-block;cursor:pointer" id="slotCard">
							  <div class="flipper">
		     					 <div class="front" style="border: 1px solid; text-align: center; padding-top: 45px;">
		        					  <!-- front content -->
		      						<p style="font-size: 20px;"><i class="fab fa-buromobelexperte"></i> 슬롯</p>
		   					  </div>
		      				  <div class="back" style="border: 1px solid; text-align: center;padding-top: 45px;">
		         					 <!-- back content -->
		   						<p style="font-size: 20px;">${user.slot}개</p>
		   					 </div>
		  				</div>
					</div>
			     </div>
			     
			     <div style="text-align: center;">
			      	<div class="flip-container" ontouchstart="this.classList.toggle('hover');" style="display: inline-block;cursor:pointer" id="postCard">
					    <div class="flipper">
		   					 <div class="front" style="border: 1px solid; text-align: center; padding-top: 45px;">
		      					  <!-- front content -->
		    						<p style="font-size: 20px;"><i class="far fa-clipboard"></i> 게시글</p>
		  					  </div>
		   					  <div class="back" style="border: 1px solid; text-align: center;padding-top: 45px;">
		        				<!-- back content -->
		 							<p style="font-size: 20px;">${postCount}개</p>
		   					 </div>
		  				</div>
					</div>
			    
					<div class="flip-container" ontouchstart="this.classList.toggle('hover');" style="display: inline-block;cursor:pointer" id="commentCard">
			  			<div class="flipper">
			       			 <div class="front" style="border: 1px solid; text-align: center; padding-top: 45px;">
			          					  <!-- front content -->
			        			<p style="font-size: 20px;"><i class="far fa-copy"></i> 댓글</p>
			      			</div>
			        		<div class="back" style="border: 1px solid; text-align: center;padding-top: 45px;">
			          				  <!-- back content -->
			     				<p style="font-size: 20px;">${commentCount}개</p>
			       			</div>
		   				</div>
					</div>
							
			      	<div class="flip-container" ontouchstart="this.classList.toggle('hover');" style="display: inline-block;cursor:pointer" id="partyCard">
					 	 <div class="flipper">
		   					 <div class="front" style="border: 1px solid; text-align: center; padding-top: 45px;">
		         					  <!-- front content -->
		       					<p style="font-size: 20px;"><i class="fas fa-user-friends"></i> 동행</p>
		  					  </div>
		       				 <div class="back" style="border: 1px solid; text-align: center;padding-top: 45px;">
		           					<!-- back content -->
		   						<p style="font-size: 20px;">${partyCount}개</p>
		   					 </div>
		   				</div>
					</div>
				</div>
			</div><!-- 카드들 묶어놓음  -->
				<div style="width: 375px;">
						<div id="calendar"></div>
				</div>
			
        </div>
		</div><!-- class ROW END -->		
			
	</div><!-- main Div End -->
			
        </div>
    </div>
	<script>
		/* icon 사용을 위한 스크립트 */
		feather.replace();
	</script>

</body>
<jsp:include page="/toolbar/footer.jsp"></jsp:include>




	<div class="modal fade " id="checkPwd">
		  <!-- <div class="modal-dialog modal-lg"> -->
		  <div class="modal-dialog ">
		  	<!-- <h2 style="color : #FFFFFF">Sign In</h2> -->
			<div class="modal-content" style="border-radius: 5px; padding:  10px 20px;">
				<div class="modal-body" >
					<form>
						<div class="form-group  text-center">
							<label for="pwd" style="margin-bottom: 15px;">회원정보 수정</label>
							 <input type="password"	class="form-control" placeholder="비밀번호를 입력하세요" id="pwdId" name="pwd" style="width: 180px;">
							 <input type="text" style="display: none;" >
							 <div id="pwdMessage" style="color: red;"></div>
						</div>
						<div class="form-group text-center" style="padding-top: 5px;">
							<button type="button" class="btn btn-outline-primary" style="margin-right: 5px;" id="pwdCheck">확인</button>
							<button type="button" class="btn btn-outline-secondary" id="cancle">취소</button>
						</div>
					</form>
				</div><!--modal body End  -->
	
			</div><!--modal content End  --> 
		  </div><!--modal dialog End  -->
	</div><!--myModal End  -->




</html>