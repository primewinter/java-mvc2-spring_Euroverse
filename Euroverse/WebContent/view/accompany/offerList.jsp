<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${  empty user }">
	<jsp:forward page="/main.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Euroverse</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

<!-- jquery Ui 링크 (datePicker)  -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!--datePicker CDN  -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<!-- boot strap File upload CDN  -->
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.js"></script>

<!-- swiper CDN -->
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css">
<link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">

<script src="https://unpkg.com/swiper/js/swiper.js"></script>
<script src="https://unpkg.com/swiper/js/swiper.min.js"></script>
<!--========================= -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />


<style>
	.profile-card-3 {
	  position: relative;
	  float: left;
	  overflow: hidden;
	  width: 85%;
	  text-align: center;
	  height:368px;
	  border:none;
	}
	.profile-card-3 .background-block {
	    float: left;
	    width: 100%;
	    height: 200px;
	    overflow: hidden;
	}
	.profile-card-3 .background-block .background {
	  width:40%;
	  vertical-align: top;
	  opacity: 0.9;
	  -webkit-filter: blur(0.5px);
	  filter: blur(0.5px);
	   -webkit-transform: scale(1.8);
	  transform: scale(2.8);
	}
	.profile-card-3 .card-content {
	  width: 100%;
	  padding: 15px 25px;
	  color:#232323;
	  float:left;
	  background:#efefef;
	  height:50%;
	  border-radius:0 0 5px 5px;
	  position: relative;
	  z-index: 2;
	}
	.profile-card-3 .card-content::before {
	    content: '';
	    background: #efefef;
	    width: 120%;
	    height: 100%;
	    left: 1px;
	    bottom: 41px;
	    position: absolute;
	    z-index: -1;
	    transform: rotate(-8deg);
	}
	.profile-card-3 .profile {
	  border-radius: 50%;
	  position: absolute;
	  bottom: 50%;
	  left: 50%;
	  max-width: 100px;
	  opacity: 1;
	  box-shadow: 3px 3px 20px rgba(0, 0, 0, 0.5);
	  border: 2px solid rgba(255, 255, 255, 1);
	  -webkit-transform: translate(-50%, 0%);
	  transform: translate(-50%, 0%);
	  z-index:3;
	}
	.profile-card-3 h2 {
	  margin: 0 0 5px;
	  font-weight: 600;
	  font-size:25px;
	}
	.profile-card-3 h2 small {
	  display: block;
	  font-size: 15px;
	  margin-top:10px;
	}
	.profile-card-3 i {
	  display: inline-block;
	    font-size: 16px;
	    color: #232323;
	    text-align: center;
	    border: 1px solid #232323;
	    width: 30px;
	    height: 30px;
	    line-height: 30px;
	    border-radius: 50%;
	    margin:0 5px;
	}
	.profile-card-3 .icon-block{
	    float:left;
	    width:100%;
	    margin-top:15px;
	}
	.profile-card-3 .icon-block a{
	    text-decoration:none;
	}
	.profile-card-3 i:hover {
	  background-color:#232323;
	  color:#fff;
	  text-decoration:none;
	}
	
	.media img{
		width: 200px;
		height: 200px;
		border-radius: 50%;
		box-shadow: 3px 3px 20px rgba(0, 0, 0, 0.5);
		border: 2px solid rgba(255, 255, 255, 1);
	}
	
	.media-body{
		margin: 40px;
	    padding:0px;
	}
     div.h4{
        opacity:0.5;
    }
    div.h4:hover{
        opacity: 1;
    }



</style>

<script>

var maPageCode = 'O';

function fncGetUserList(currentPage) {
	$("#currentPage").val(currentPage)
	$("#myOfferListForm").attr("method" , "POST").attr("action" , "/myPage/myOfferList").submit();
}
function fncGetUserList2(currentPage2) {
	$("#currentPage2").val(currentPage2)
	$("#keyword").val("party");
	$("#myOfferListForm").attr("method" , "POST").attr("action" , "/myPage/myOfferList").submit();
}

$(function(){
	$(".planAccept").on("click",function(){
		var offerId = $(this).next().next().val();
		var num = $(this).next().next().next().val();
		$.ajax({
			url : '/myPage/json/planOfferAccept/'+offerId ,
			type : "GET" ,
			cache : false ,
			dataType : "json" ,
			success : function(JSONData) {
				if(JSONData.resultMsg =='ok'){
					swal({
						   icon : 'success',
						  title : "성공적으로 플래너에 참여했습니다.",
						  text:" ",
						  button : false,
					})
					var planId = JSONData.planId;
					var string = "/plan/getPlan?planId="+planId;
					setTimeout(function() {     
					$(self.location).attr("href", string);
				    	}, 700);
					
				}else if(JSONData.resultMsg == 'over'){
					swal({
						   icon : 'warning',
						  title : "이미 참여중인 플래너입니다.",
						  text:" ",
						  button : false,
					})
					return;	
					
				}else if(JSONData.resultMsg == 'error'){
					swal({
						   icon : 'warning',
						  title : "슬롯이 부족합니다.",
						  text:"포인트로 구매해주세요.(500Point)",
						  button : false,
					})
					return;
				}
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	})
	
	$(".partyAccept").on("click",function(){
		var offerId = $(this).next().next().val();
		var num = $(this).next().next().next().val();
		$.ajax({
			url : '/myPage/json/partyOfferAccept/'+offerId ,
			type : "GET" ,
			cache : false ,
			dataType : "json" ,
			success : function(JSONData) {
				if(JSONData.resultMsg =='ok'){
					swal({
						   icon : 'success',
						  title : "동행신청을 수락했습니다.",
						  text:" ",
						  button : false,
					})
					var postId = JSONData.postId;
					var string = "/community/getPost?postId="+postId+"&boardName=D";
					setTimeout(function() {     
						$(self.location).attr("href", string);
				    }, 700);

				}else if(JSONData.resultMsg == 'error'){
					swal({
						   icon : 'warning',
						  title : "에러.",
						  text:" ",
						  button : false,
					})
					return;
				}else if(JSONData.resultMsg=='overLap'){
					swal({
						   icon : 'warning',
						  title : "이미 참여중인 동행입니다.",
						  text:" ",
						  button : false,
					})
					return;
				}else if(JSONData.resultMsg == 'over'){
					swal({
						   icon : 'warning',
						  title : "모집이 마감되었습니다.",
						  text:" ",
						  button : false,
					})
					return;
				}
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	})
	
	
	$(".planReject").on("click",function(){
		swal({
			   icon : 'success',
			  title : "거절하셨습니다.",
			  text:" ",
			  button : false,
		})
		var offerId = $(this).next().val();
		var num = $(this).next().next().val();
		
		setTimeout(function() {     
			$(self.location).attr("href", "/myPage/offerReject?offerId="+offerId);
	    }, 700);
	})
	
	
	$(".partyReject").on("click",function(){
		swal({
			   icon : 'success',
			  title : "거절하셨습니다.",
			  text:" ",
			  button : false,
		})
		var offerId = $(this).next().val();
		var num = $(this).next().next().val();
		
		setTimeout(function() {     
			$(self.location).attr("href", "/myPage/offerReject?offerId="+offerId);
	    }, 700);
	})
	$("div.viewPlan").on("click",function(){
		$("#planTable").css("display","block");
		$("#partyTable").css("display","none"); 
		$("#keyword").val("plan");
	})
	$("div.viewParty").on("click",function(){
	 	$("#partyTable").css("display","block");
		$("#planTable").css("display","none"); 
		$("#keyword").val("party");
	})
	
})



</script>
</head>
<body>

	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
		
		
 <div>
        <div class="row">
            <jsp:include page="/view/accompany/accSidebar.jsp"/>
            
        <div style="width:60%;margin-left:5%">
		
		<!--<div>
			<div class="btn-group" role="group" aria-label="Basic example" style="margin-left: 10px;">
				<button type="button" class="btn btn-outline-primary" id="viewPlan">플래너</button>
				<button type="button" class="btn btn-outline-primary" id="viewParty">동 행</button>
			</div>
		</div>-->
	
	
		<form id="myOfferListForm">
	 		<input type="hidden" id="currentPage" name="currentPage" value=0 />
	 		<input type="hidden" id="currentPage2" name="currentPage2" value=0 /> 
	 		<c:if test="${!empty keyword}">
	 			<input type="hidden" id="keyword" name="searchKeyword" value="${keyword}"/>
	 		</c:if>
		</form>
	
	    <!-- <h1  style="margin-left: 240px; width: 1000px">플래너 초대목록</h1> -->
	    
			<div id="partyTable" style="display: block;">
               
	       		<div class="h4 viewParty" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;opacity: 1;">
					동행 신청목록
				</div>
		
				<ul class="list-unstyled" style="margin-left: 0px;">
					<c:forEach var="partyOffer" items="${partyOfferList}" varStatus="status" >
						<li class="media" style="width: 100%;">
					   		<div style="font-size:11pt;">
					   		    <img src="/resources/images/userImages/${partyOffer.userImg}" class="mr-3" alt="..." >
					   		</div>
					    	
					    	<div class="media-body" style="font-size:11pt;">
                               ${partyOffer.postTitle}<br>
                                ${partyOffer.fromUserNickname}님께서 동행 신청을 하셨습니다.<br><br>
					      		<h5 class="mt-0 mb-1">${partyOffer.offerMsg}</h5>
				     			
				  				<br>
				     	 		<c:set var="partyOfferDate" value="${fn:split(partyOffer.offerDate,' ')}"></c:set>
						   		<c:out value="${partyOfferDate[0]}"></c:out>
				      			<br>
								<button id="partyOfferAccept${status.index}" type="button" class="btn btn-info partyAccept">수락</button>
								<button id="partyOfferReject${status.index}" type="buttony" class="btn btn-secondary partyReject">거절</button>			      
						   		<input type="hidden" value="${partyOffer.offerId}">
								<input type="hidden" value="${status.index}">
					    	</div>
				  		</li>
					</c:forEach>
				</ul>
				
				<c:if test="${ empty partyOfferList}">
				    <div class="text-center" style="margin-bottom: 70px;margin-top: 36px;">제안받은 동행 신청이 없습니다</div>
				</c:if>
			<jsp:include page="../../common/pageNavigator_new2.jsp"/>
		</div><!-- partyTable EndDiv  -->
            </div>
	</div>
	
</body>
	<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>