<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page pageEncoding="euc-kr"%>

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
	
 
<script>



function printTime() {
	var clock = document.getElementById("clock");
	var now = new Date();

	clock.innerHTML = now.getFullYear() + "년 " +
	(now.getMonth()+1) + "월 " +
	now.getDate() + "일 " +
	now.getHours() + "시 " +
	now.getMinutes() + "분 " +
	now.getSeconds() + "초";

	setTimeout("printTime()", 1000);
	}

	window.onload = function() {
	printTime();
	};
	
	
	

document.addEventListener("DOMContentLoaded", function() {
	
    var toTime = new Date();

    document.getElementById("toNow").innerHTML = toTime.toString();
});
/* 	$(".list-group-item-action").on('click', function() {
				
		alert($(this).attr('con')); 
		var conName = $(this).attr('con');
		
		conturyInfo(conName);
		
	}) */

$(function(){
	
	$.getJSON('').done('https://earthquake.kr:23490/query/KRWEUR')
	
})

		
$(function(){
 	$(".list-group-item-action").click(function() {
			
		alert($(this).attr('mon'));
		var conCode = $(this).attr('con');
		var conName = $(this).text();
		var conHwa = $(this).attr('hwa');
		alert(conCode);
		alert(conName);
		alert(conHwa);
		conturyInfo(conCode);
		$('input[name="conMoney"]').attr('placeholder', conName.trim());
		$('.text').html(conHwa);
			
	}); 
});

	function conturyInfo(conCode){
		
		alert('conturyInfo Start....');
		
		$.ajax({
			url : "/api/json/exchange/"+conCode ,
			method : "GET" ,
			dataType : "json" ,
			data: JSON.stringify({
				conCode : conCode 
			}),
			contentType: "application/x-www-form-urlencoded; charset=EUC-KR",
			headers : {
				"Accept" : "application/json" ,
				"Content-Type" : "application/json"
			} ,
			success : function(JSONData, status) {
				
				var conInfo = JSONData.response.body.items.item.basic;
				var contury = JSONData.response.body.items.item.countryName;
				var conFlag = JSONData.response.body.items.item.imgUrl;
				/* alert(conName); */
				/* $("#form-group").html(myItem); */
				/* $("img[class='conImg']").attr("src", conFlag);
				$('.title').html(contury); */
				$('.content').html(conInfo);
				
			}
		});
		};
	
	function exchange(data) {
   	
	if ($(".list-group-item-action")) { 	
		$.getJSON('https://api.exchangeratesapi.io/latest?base=KRW').done(

					function(data) {

						var mon = $(".list-group-item-action.active").attr('mon');

						if (mon == undefined){
							alert('국가를 선택하세요');
							$("input[name='conMoney1']").val("")
							.return;
						}
						
						var price = $("input[class='form-control']").val();
						/* var num = price/ data.rates[cur] */
						
						var num = Math.round(price.match(/\d+/)[0]
								/ data.rates[mon]);
						/* alert(num);
						alert(data.rates[abc]); */
						price = price.replace(/(\d)(?=(\d{3})+(?!\d))/g,'$1,')
						num = num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g,'$1,')
					
						$('#result').attr("value",  num);
					})
		 } 
	}
	
	var iscroll = new iScroll("wrapper", {
	    hScroll:false
	});
	
</script>


<!-- CSS 속성값 -->
<style type='text/css'>

/* * { 
	box-sizing: border-box; 
}

body {
	display: flex; 
	align-items: center; 
	justify-content: center;
} */


/* 글씨체 때문에 걸어둔 inport 1.나눔고딕체, 2.유분투체  */
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothiccoding.css);
@import url('https://fonts.googleapis.com/css?family=Lato|Ubuntu&display=swap');

body{

	margin: 0 auto;
	padding-bottom : 30px;
	background-repeat: repeat;
}

.row{
	transform: translate(10%,0%);
}
.container{
	position: absolute;
	top: 50%;
	transform: translate(-50%,-50%);
	left: 50%;
}

.title{
	width:300px;
	height : 300px;
	border: 1px solid teal;
	border-radius : 10px;
	overflow-y:scroll;
	box-shadow:blur;

}

#conturyMoney{
	width:300px;
	height : 300px;
	border: 1px solid teal;
	border-radius : 10px;

}
/* 국가선택창 Box css  */
#wrapper{
	width:300px;
	height : 300px;
	border: 1px solid teal;
	border-radius : 10px;
	box-shadow : 5px 5px grey;
}

/* 국가선택창에 제목때문에 걸어둔 css  */
h5{
	padding-top : 0.6rem;
	text-align: center;
	font-weight: bold;
	font-family: "Noto Sans CJK KR","Helvetica Neue","Apple SD Gothic Neo",sans-serif;
	font-size: 26px;
}


.list-group{
	width:300px;
	overflow:auto;
	height: 250px;
	padding-top: 1rem;
	padding-bottom: 0.1rem;
}

.list-group-item {
	font-weight: bold;
	size : 40px;
	padding-bottom : 0.3rem;
	padding-top : 0.3rem;
	border-radius : 10px;
	
}

.list-group img {
	width : 40px;
	vertical-align: sub;
}
.border-0 {
	width:40px;
	height : 30px;
}

.flex-nowrap{
	height : 300px;
	border: 1px solid teal;
	border-radius : 10px;
	width:300px;
}


/* 금액입력창 css  */
.conturyMoney{
	width:300px;
	top:50px;
	position: relative;
	justify-content: center;
	text-align: right;
	color: #309EFE;
	font-size: 17px;
	
}


</style>

</head>


<body>

<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>

<h3>exchange</h3>



<div class="container">

	  현재 시간은<br/><br/> <span id="clock"></span>

	<div class="row">
	
<!-- ============== 국가선택하는 목록 html ============  -->
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
		
		<!-- ============국가정보출력 box ================ -->
	
		<div class="title">
		<div class="content">
		<img class="conImg" alt="" src=""/>
		</div>
		
		</div>
		 
	   <!-- =========== 환율금액입력 ====================  -->  
	  <div class="input-group flex-nowrap">
	  	<div class="conturyMoney">
  		<input type="text" name='conMoney1' class="form-control" placeholder="대한민국" aria-describedby="addon-wrapping" value="" onkeydown="exchange()">
		원<br/><br/><br/><br/>
		<input type="text" name='conMoney' id="result" class="form-control" placeholder=""  readonly="readonly" value="">
		<div class='text'>
		</div>
		</div>
		</div>
		
		<!-- 현재 한국 시간 구하기 : <span id="toNow"></span> -->
		
	    
	   <!--  <script type="text/javascript">
		    var IScroll = $.AMUI.iScroll;
		    var myScroll = new IScroll('#wrapper', { click: true });
		</script> -->
	</div>
</div>

</body>

</html>