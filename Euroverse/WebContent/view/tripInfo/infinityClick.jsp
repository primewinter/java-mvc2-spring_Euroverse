<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="EUC-KR"%>

<!DOCTYPE html>

<html lang="ko">

<head>

<!-- : http://getbootstrap.com/css/  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<!-- 글씨체 때문에 걸어둔 link -->
	<link href='https://fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
	 
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script> -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!-- 스크롤 cdn 걸기  -->
	
	
<style>

</style>


<head>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script src='//code.jquery.com/jquery.min.js'></script>
<script type="text/javascript">

	 $(function() {
		 
		$("#infinityclick").on("click", function() {
	 		$.ajax({

	 		url : "/api/json/infinityClick",
	 		method : "GET",
	 		dataType : "json",
	 		headers : {
	 			"Accept" : "application/json",
	 			"Content-Type" : "application/json"
	 		},

	 			success : function(JSONData, status) {
	 				/* $("#infinityclick").attr("src", JSONData.url); */
	 				$("#infinityclick").css({
	 					'background-image' : 'url(' + JSONData.url + ')'
	 				});
	 				
	 				
	 				
					$(".dialog__title").text(JSONData.info1+JSONData.info2+JSONData.info3+JSONData.info4+JSONData.info5);
					
					
	 			}
	 		})
	 	}); 
	 });

	function dialog() {

		var dialogBox = $('.dialog'), 
		dialogTrigger = $('.fa-question-circle'), 
		dialogClose = $('.dialog__close'), 
		dialogTitle = $('.dialog__title'), 
		dialogContent = $('.dialog__content'), 
		dialogAction = $('.dialog__action');

		// Open the dialog
		dialogTrigger.on('click', function(e) {
			dialogBox.toggleClass('dialog--active');
			e.stopPropagation()
		});

		// Close the dialog - click close button
		dialogClose.on('click', function() {
			dialogBox.removeClass('dialog--active');
		});

		// Close the dialog - press escape key // key#27
		$(document).keyup(function(e) {
			if (e.keyCode === 27) {
				dialogBox.removeClass('dialog--active');
			}
		});

		// Close dialog - click outside
		$(document).on("click", function(e) {
			if ($(e.target).is(dialogBox) === false
				&& $(e.target).is(dialogTitle) === false
				&& $(e.target).is(dialogContent) === false
				&& $(e.target).is(dialogAction) === false) {
				dialogBox.removeClass("dialog--active");
			}
		});

	};

	// Run function when the document has loaded
	$(function() {
		dialog();
	});

</script>
<style>
/* * {
	box-sizing: border-box;
} */

/* body {
	background: #f1f1f1;
	color: #333333;
	font-family: 'Cairo', sans-serif;
	font-size: 30px;
	height: 100vh;

} */

.fa-question-circle, .dialog__action {
	/* border: 3px solid #333333;
	background: #f1f1f1;
	padding: 15px 20px;
	font-size: 1.5rem;
	text-transform: uppercase;
	display: block;
	-webkit-transition: all 150ms ease-out;
	transition: all 150ms ease-out;
	-webkit-transform: translateY(0px);
	transform: translateY(0px); */
	color : #CECECE;
}

/* 물음표 아이콘 애니메이션 속도 및 그림자 속성값 조정 css  */
.fa-question-circle:hover, .dialog__action:hover {
	-webkit-transform: translateY(-5px);
	transform: translateY(-5px);
	-webkit-transition: all 100ms ease-in; /*애니메이션 속도*/
	transition: all 100ms ease-in; /*애니메이션 속도*/
	box-shadow: 0 5px 10px rgba(51, 51, 51, 0.4); /*그림자*/
}

.fa-question-circle:focus, .dialog__action:focus {
	outline: 0;
}

.fa-question-circle:active, .dialog__action:active {
	-webkit-transform: translateY(-3px);
	transform: translateY(-3px);
}

.dialog {
	background: #f1f1f1;
	width: 70%;
	position: absolute;
	left: calc(50% - 35%);
	top: 0;
	padding: 30px;
	box-shadow: 0 10px 30px rgba(51, 51, 51, 0.4);
	border: 3px solid #333333;
	visibility: hidden;
	opacity: 0;
	-webkit-transition: all 180ms ease-in;
	transition: all 180ms ease-in;
}

@media ( max-width : 600px) {
} 
.dialog {
	width: 90%;
	left: calc(50% - 45%);
}

.dialog.dialog--active {
	top: 10%;
	visibility: visible;
	opacity: 1;
	-webkit-transition: all 250ms ease-out;
	transition: all 250ms ease-out;
}

.dialog .dialog__close {
	font-size: 2rem;
	line-height: 2rem;
	position: absolute;
	right: 15px;
	top: 15px;
	cursor: pointer;
	padding: 15px;
	-webkit-transition: color 150ms ease;
	transition: color 150ms ease;
}

.dialog .dialog__close:hover {
	color: #E74C3C;
}

.dialog .dialog__title {
	font-size: 2rem;
	font-family: 'Slabo 27px', serif;
	font-weight: 100;
	margin: 0;
	padding: 0 0 15px 0;
	border-bottom: 2px solid #333333;
}

.dialog .dialog__content {
	font-size: 1.1rem;
	line-height: 2rem;
}

.dialog .dialog__action {
	margin: 0;
	font-size: 1rem;
}

	.container{
		position: absolute;
	transform: translate(0%,0%);
	background-color: yellow;
	}
	#infinityclick {
		position: absolute;
		height: 300px;
		width : 1600px;
		/* background-repeat: repeat; */
		transform: translate(0%,0%);
	}
	
	#infinityclick i{
	position : absolute;
	left : 13px;
	top: 13px;
	}
</style>

</head>
<body>

<%-- <jsp:include page="/toolbar/toolBar.jsp"></jsp:include> --%>

	<h3>infinityClick</h3>
	
	<div class="container">
	
	<div class="row">
	
	<div id="infinityclick" style="background-image:url(${tripInfo.url})">
		<%-- <img id="LSH" alt="" src="${tripInfo.url}"> --%>
		 <i class="far fa-question-circle"></i>
		<!-- <button class="dialog__trigger">상세정보</button> -->
	</div>
	</div>
	

	<div class="dialog">
		<span class="dialog__close">&#x2715;</span>
		<h2 class="dialog__title"> ${tripInfo.info1}, ${tripInfo.info2},
									${tripInfo.info3}, ${tripInfo.info4}</h2>
		<p class="dialog__content">Lorem ipsum dolor sit amet, consectetur
			adipisicing elit. Impedit necessitatibus illo deleniti doloremque
			culpa voluptas recusandae, sunt eligendi amet, ut modi voluptatibus
			ipsa quas voluptatem consectetur atque, velit reprehenderit debitis.</p>
		<button class="dialog__action">Read more &#8594;</button>

	</div>
	</div>
	
	<div id="wrapper" class="wrapper" style="overflow:hidden;">	
	<h5>오늘의 환율</h5>	  
	    <div class="list-group" id="list-tab" role="tablist" >
	      <a class="list-group-item list-group-item-action" id="a" data-toggle="list" href="#list-home" hwa='유로' mon="EUR" con="GBR">
	      <img src='/resources/images/tripInfoimges/Europe.png'/>&nbsp;  유럽</a>
	      <a class="list-group-item list-group-item-action" id="b" data-toggle="list" href="#list-profile" hwa='포린트' mon="HUF" con="HUN">
	      <img src='/resources/images/tripInfoimges/Hungary.gif'/>&nbsp; 헝가리</a>
	      <a class="list-group-item list-group-item-action" id="c" data-toggle="list" href="#list-messages"hwa='코루나' mon="CZK" con="CZE">
	      <img src='/resources/images/tripInfoimges/Czech.gif'/>&nbsp; 체코</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='크로네' mon="DKK" con="DNK">
	      <img src='/resources/images/tripInfoimges/Denmark.gif'/>&nbsp; 덴마크</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='파운드' mon="GBP" con="GBR">
	      <img src='/resources/images/tripInfoimges/England.gif'/>&nbsp; 영국</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='레우' mon="RON" con="ROU">
	     <img src='/resources/images/tripInfoimges/Lithuania.gif'/>&nbsp; 루마니아</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='크로나' mon="SEK" con="SWE">
	     <img src='/resources/images/tripInfoimges/Sweden.gif'/>&nbsp; 스웨덴</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='쿠나' mon="HRK" con="HRV">
	     <img src='/resources/images/tripInfoimges/Croatia.gif'/>&nbsp; 크로아티아</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='프랑' mon="CHF" con="CHE">
	     <img src='/resources/images/tripInfoimges/Swiss.gif'/>&nbsp; 스위스</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='레바' mon="BGN" con="BGR">
	     <img src='/resources/images/tripInfoimges/Bulgaria.gif'/>&nbsp; 불가리아</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='리라' mon="TRY" con="TUR">
	     <img src='/resources/images/tripInfoimges/Turkey.gif'/>&nbsp; 터키</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='크로네' mon="NOK" con="NOR">
	      <img src='/resources/images/tripInfoimges/norway.gif'/>&nbsp; 노르웨이</a>
	      <a class="list-group-item list-group-item-action" id="d" data-toggle="list" href="#list-settings" hwa='즈워티' mon="PLN" con="POL">
	     <img src='/resources/images/tripInfoimges/Poland.png'/>&nbsp; 폴란드</a>
	     </div>
		</div>

<!-- 	<script async
		src="https://cse.google.com/cse.js?cx=015063284203154978978:emahxddazvy"></script>
	<div class="gcse-search"></div> -->


</body>


</html>