<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        
        
<!-- ///////////////////////////// 로그인시 Forward  /////////////////////////////////////// -->
	<c:if test="${ ! empty user }">
		<jsp:forward page="/plan/getPlanList"/>
	</c:if>
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////// -->

        
<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="EUC-KR">
<title>Euroverse, 유럽 여행의 시작</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />



<!-- 부트스트랩 4.4 쓰려다가 빠꾸...............................했다가 다시 4.4로..  -->
<!-- Bootstrap CSS -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script> -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- <script src="https://code.jquery.com/jquery-1.12.4.js"></script> -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link href="https://fonts.googleapis.com/css?family=Monoton" rel="stylesheet">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> -->


	<!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />


	<!-- ICON 사용을 위한 스크립트 임포트 -->
	<!-- https://feathericons.com/ -->
	<script src="https://unpkg.com/feather-icons"></script>
	
	
	<script>
		
		/* 모달창 닫기 */
		function closeModal(modalName) {
			console.log("closeModal : modalName="+modalName);
			if( typeof $("."+modalName)[0] != "undefined" ){
				$("."+modalName)[0].reset();		//form에 모달 이름과 같은 클래스명 주기
			}
			$("#"+modalName).hide();
		}
		
		$(function(){
			$("#addUserButton").on("click", function() {
		        location.href = "/user/addUser";
		    });
		});
		
	</script>

	<style type="text/css">
	
	.bg {
	    position:relative;
	    z-index:1;
	    width:100%;
	    margin-left: 0;
	    margin-right: 0;
	}

	.bg:after{
		background-image: url('/resources/images/mainImg/plan_main.jpg');
	    top:0;
	    left:0;
	    position:absolute;
	    background-size:100%;
	    opacity:0.45!important;
	    //filter:alpha(opacity=50);
	    z-index:-1;
	    content:"";
	    width:100%;
	    height:100%;
	}
	
	</style>
</head>
<body>

	<!-- ToolBar 시작 -->
	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<!-- ToolBar 끝 -->

	
		<!-- 다단 레이아웃 Start ///////////////////////////// -->
		<div class="d-flex justify-content-center flex-wrap flex-md-nowrap align-items-center">
		
			<!-- <h4> 플래너 기능을 사용하시려면 로그인 되어있어야 합니다</h4>
			<hr/>
			<div>
				<button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#loginModal">로그인</button>
				<button type="button" class="btn btn-outline-secondary" id="addUserButton">회원가입</button>
			</div> -->
			
			<!--  style="background-image: url('/resources/images/mainImg/venice_main2.jpg');  -->
			<div class="bg" style="">
				<div style="opacity: 100%;padding: 140px 300px; float: right;text-align: right;">
				  <!-- <h1 class="display-4">유로버스에 오신걸 환영합니다!</h1> -->
				  <p class="lead" style="font-weight: 500;">유로버스의 플래너 기능을 사용하시려면<br/>회원으로 로그인 되어있어야 합니다.</p>
				  <hr class="my-4">
				  <p>계정이 있으신가요? 로그인 후 나만의 플래너를 작성해보세요</p>
				  <!-- <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a> -->
					  <div>
						<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#loginModal">로그인</button>
						<button type="button" class="btn btn-secondary" id="addUserButton">회원가입</button>
					</div>
				</div>
			</div>


		</div>
		<!-- 다단 레이아웃 End ///////////////////////////// -->
	
	
	<script>
		/* icon 사용을 위한 스크립트 */
		feather.replace();
	</script>
	
	<jsp:include page="/toolbar/pushBar.jsp" />
    <jsp:include page="/toolbar/footer.jsp" />

</body>
</html>