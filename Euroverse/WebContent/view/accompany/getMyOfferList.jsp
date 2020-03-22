<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">
	<title>Euroverse</title>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.4/examples/carousel/">
    <!-- sweetalert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link href="https://fonts.googleapis.com/css?family=Monoton" rel="stylesheet">
    
    <!-- Use Swiper from CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
    <script src="https://unpkg.com/swiper/js/swiper.js"></script>
    <script src="https://unpkg.com/swiper/js/swiper.min.js"></script>

    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <!-- AOS CDN2 :: https://michalsnik.github.io/aos/-->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

    <!--owl carousel CDN-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

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
			width: 150px;
			height: 150px;
			border-radius: 50%;
			box-shadow: 3px 3px 20px rgba(0, 0, 0, 0.5);
			border: 2px solid rgba(255, 255, 255, 1);
		}
		
		.media-body{
			margin: 10px 30px 30px 50px;
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
	
		 function fncGetUserList(currentPage) {
	         $("#currentPage").val(currentPage)
	         $("form[id='myOfferListForm']").attr("method", "POST").attr("action", "/community/getMyOfferList").submit();
	     }
		 
		 $(function(){
			$(".fas.fa-times").on("click",function(){
				
				var offerId = $(this).next().val();
				
				 swal({
						title:"목록에서 삭제하시겠습니까?",
						text:" ",
						icon:"warning",
						buttons: [ "아니오", "예"]
				}).then((YES) => {
					if(YES){
						
						swal({
							icon : 'success',
							title : "삭제되었습니다!",
							text:" ",
							button : false,
						})
				    	setTimeout(function() {     
				    		self.location = "/community/deleteOffer?offerId="+offerId;
				    	}, 700);
					}
			    });
			});
		 });
		 
	</script>

</head>
<body>

    <!-- ToolBar Start /////////////////////////////////////-->
    <jsp:include page="/toolbar/toolBar.jsp" />
    <jsp:include page="/toolbar/pushBar.jsp" />
    <!-- ToolBar End /////////////////////////////////////-->

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
		 		<input type="hidden" id="currentPage" name="currentPage" value="" />
		 		<c:if test="${!empty keyword}">
		 			<input type="hidden" id="keyword" name="searchKeyword" value="${keyword}"/>
		 		</c:if>
			</form>
		
		    <!-- <h1  style="margin-left: 240px; width: 1000px">플래너 초대목록</h1> -->
		    
				<div id="partyTable" style="display: block;">
	               
		       		<div class="h4 viewParty" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;opacity: 1;">
						동행 제안목록
					</div>
					<span style="font-size: 14px;color: #838383;margin-left: 10px;">${resultPage.totalCount}개 신청 중</span>
					<ul class="list-unstyled" style="margin-left: 10px;">
						<c:forEach var="offer" items="${list}" varStatus="status" >
							<li class="media" style="width: 100%;padding-top: 20px;">
						   		<div style="font-size:11pt;">
						   		    <img src="/resources/images/userImages/${offer.userImg}" class="mr-3" alt="..." >
						   		</div>
						    	
						    	<div class="media-body" style="font-size:11pt;">
	                               ${offer.postTitle}
	                               <c:if test="${offer.offerStatus == 'R'}">
	                               &ensp;<i class="fas fa-times" style="color: #838383"></i>
	                               <input type="hidden" name="offerId" value="${offer.offerId}"/>
	                               </c:if>
	                               <br>
	                                ${offer.toUserNickname} 님께 동행을 신청하였습니다.<br><br>
						      		<h5 class="mt-0 mb-1">${offer.offerMsg}</h5>
					     			
					  				<br>
					     	 		<c:set var="offerDate" value="${fn:split(offer.offerDate,' ')}"></c:set>
							   		<c:out value="${offerDate[0]}"></c:out>
					      			<br>
						    	</div>
					  		</li>
						</c:forEach>
					</ul>
					
					<c:if test="${ empty list}">
					    <div class="text-center" style="margin-bottom: 70px;margin-top: 36px;">제안받은 동행 신청이 없습니다</div>
					</c:if>
					<br>
				<jsp:include page="../../common/pageNavigator_new.jsp"/>
			</div><!-- partyTable EndDiv  -->
	            </div>
		</div>

	 <jsp:include page="/toolbar/footer.jsp" />

</body>
</html>