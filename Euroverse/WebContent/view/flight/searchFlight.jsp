<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<html lang="ko">
<head>
<title>항공권 검색</title>
<meta charset="EUC-KR">
	
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
	
	<!-- 달력 CDN -->
	<!-- <link rel="stylesheet" href="/resources/css/kronos.css" />
	<script src="/resources/javascript/kronos.js"></script> -->
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>

	
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
	
	
       /* 인원수 */
       row.justify-content-around {
         position:absolute;
 		 top:50%;
		 left:50%;
		}
	  /* 도착지역 table css */
	   td{
		  font-size:11px;
		  text-align: center;
		  width : 100px;
	  }
	  #domestic ,  #europe  {
	  	z-index: 3;
	  }
	  #to , #from , div{
	  	z-index: 2;
	  }
	  /* 도착지역 table css */
	  #europe, #domestic {
	   text-ailgn : center;
	   background-color: white;
		/*  border-collapse: separate;  */
		border:5px solid white;
	  }

	  /* 왕복 , 편도 배경 */
		#roundTrip {
			position: relative;
		}
		#roundTrip.basic:after {
			content : "";
		    display: block;
		    position: absolute;
		    top: 0;
		    left: 0;
		    background-color: lightgray; 
		    width: 225px;
		    height: 50px;
		    opacity : 0.7;
		    z-index: -2;
		    margin-left: -5px;
		}
		
		#roundTrip.change:after {
		content : "";
	    display: block;
	    position: absolute;
	    top: 0;
	    left: 0;
	    background-color: lightgray; 
	    width: 0;
	    height: 50px;
	    opacity : 0.7;
	    z-index: -2;
	    margin-left: -5px;
		}
		
		#right {
		position: relative;
		}
		#right.basic:after {
		content : "";
	    display: block;
	    position: absolute;
	    top: 0;
	    left: 0;
	    background-color: lightgray; 
	    width: 225px;
	    height: 50px;
	    opacity : 0.7;
	    z-index: -2;
	    margin-left: -60px;
		}
		
		#right.change:after {
		content : "";
	    display: block;
	    position: absolute;
	    top: 0;
	    left: 0;
	    background-color: lightgray; 
	    width: 0;
	    height: 50px;
	    opacity : 0.7;
	    z-index: -2;
	    margin-left: -60px;
		}
	  
	  /* div 전체 container 배경 */
	  #total{
	  	position:relative;
	  }
	  #total:after{
	  		content : "";
		    display: block;
		    position: absolute;
		    top: 0;
		    left: 0;
		    background-color: lightgray; 
		    width: 90%;
		    height: 200px;
		    opacity : 0.7;
		    z-index: -3;
		    margin-top:80px;
	  }
	  
	  /* 이미지 배경 css */
	  .wrapper {
		   position: relative; /* #wrapper에 투명도를 주면 컨텐츠도 같이 투명해지기 때문에.. */
		}
		.wrapper:after {
		
		    content : "";
		    display: block;
		    position: absolute;
		    top: 0;
		    left: 0;
		    background-image: url('/resources/images/orderImg/1.jpg'); 
		    width: 100%;
		    height: 460px;
		    opacity : 0.7;
		    z-index: -2;
		}
		
		/* 인원 수량 */
		#decreaseQuantity , #decreaseQuantity2 , #decreaseQuantity3{
		word-break: break-all;
		list-style: none;
		cursor: pointer;
		padding: 0;
		margin: 0;
		font-family: "Nanum Gothic", malgun Gothic, dotum;
		letter-spacing: -.3px;
		width: 43px;
		height: 43px;
		color: #e25147;
		border: 0;
		vertical-align: top;
		position: relative;
		font-size: 0;
		line-height: 0;
		background: url("//openimage.interpark.com/tourpark/tour_ui/common/btn/btn_del.png") no-repeat 0 0;
		}
		#increaseQuantity , #increaseQuantity2 , #increaseQuantity3{
		word-break: break-all;
		list-style: none;
		cursor: pointer;
		padding: 0;
		margin: 0;
		font-family: "Nanum Gothic", malgun Gothic, dotum;
		letter-spacing: -.3px;
		width: 43px;
		height: 43px;
		color: #e25147;
		border: 0;
		vertical-align: top;
		position: relative;
		font-size: 0;
		line-height: 0;
		background: url("//openimage.interpark.com/tourpark/tour_ui/common/btn/plus.png") no-repeat 0 0;
		
		}
	
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">

/* $(function() {
	 $( '#searchButton' ).on("click" , function() {
			

	});
});	 */
	/* ---------------- 로딩......  ---------------- */
	

	
	$(function(){
 
 	$("#searchButton").on("click",function(){
		
 		 if ($("#tripCourses").val() == "O") {
			 $("#to").val("0000-00-00");
 		 }
					var loading = document.getElementById("loading");
					
					loading.style.display = 'block';
					$("form").attr("method" , "POST").attr("action" , "/flight/searchFlight").submit();
					setTimeout(function() {
						loading.style.display = 'none';
						 $('#loading').hide();  
							}, 100000);
		
						
	 
	 	})
	})
	/* ---------------- 로딩......끝!!!  ---------------- */


/* ---------------- 달력  ---------------- */

var rangeDate = 500; // set limit day
var setSdate, setEdate;
$(function() {
$("#from").datepicker({
    dateFormat: 'yy-mm-dd',
    minDate: 2,
    onSelect: function(selectDate){
        var stxt = selectDate.split("-");
        console.log("stxt : "+stxt);
            stxt[1] = stxt[1] - 1;
        var sdate = new Date(stxt[0], stxt[1], stxt[2]);
        var edate = new Date(stxt[0], stxt[1], stxt[2]);
            edate.setDate(sdate.getDate() + rangeDate);
        $('#to').datepicker('option', {
            minDate: selectDate,
            beforeShow : function () {
                $("#to").datepicker( "option", "maxDate", edate );                
                setSdate = selectDate;
                console.log(setSdate)
        }});
        //to 설정
    }
    //from 선택되었을 때
});
});
$(function() {
	$("#to").datepicker({ 
	    dateFormat: 'yy-mm-dd',
	    onSelect : function(selectDate){
	        setEdate = selectDate;
	        console.log(setEdate)
	    }
		
	});
	 $('#searchButton').on('click', function(e){
		 if ($("#tripCourses").val() == "2") {
				 if($('input#from').val() == ''){
				        alert('시작일을 선택해주세요.');
				        $('input#from').focus();
				        window.location.reload(true);
				        return;
				    }
		}else{
		    if($('input#from').val() == ''){
		        alert('시작일을 선택해주세요.');
		        $('input#from').focus();
		        window.location.reload(true);
		        return;
		    }else if($('input#to').val() == ''){
		        alert('종료일을 선택해주세요.');
		        $('input#to').focus();
		        window.location.reload(true);
		        return;
		    }
		}
	 });
 
	
});

/* ---------------- 달력  끝---------------- */

/* ---------------- 도시 테이블 숨기기 , 보이기 ---------------- */
function doShow() { 
		if ($('#domestic').css("display","none")) { 
			$("#domestic").css("display","block");
			$("#europe").css("display", "none");
			$("#depIcon").hide();
			$("#arrIcon").hide();
			$("#search").show();
			$("#peopleChoice").show();
			$('footer').css("margin-top","-8");
		}
}
function Show() { 
	if ($('#europe').css("display","none")) { 
		$("#europe").css("display","block");
		$("#domestic").css("display","none");
		$("#depIcon").show();
		if ($("#tripCourses").val() == "O") {
			$("#arrIcon").hide();	
		}else{
			$("#arrIcon").show();
		}
		$("#search").hide();
		$("#peopleChoice").hide();
		$('footer').css("margin-top","-132");
	}
}

function domestic(obj) {
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	var depCity = $("#depCity").val(obj);
	if ($('#domestic').css("display","block")) { 
		$("#domestic").css("display","none");
		$("#depIcon").show();
		if ($("#tripCourses").val() == "O") {
			$("#arrIcon").hide();	
		}else{
			$("#arrIcon").show();
		}
		$('footer').css("margin-top","150");
		//$("#totalNum").css("margin-left","18%");
		
	}
};

function europe(obj) {
	// 현재 클릭된 Row(<tr>)
	var tr = $(this);
	var td = tr.children();
	
	// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
	var arrCity = $("#arrCity").val(obj);
	if ($('#europe').css("display","block")) { 
		$("#europe").css("display","none");
		$("#search").show();
		$("#peopleChoice").show();
		$('footer').css("margin-top","150");
		
	}
};

/* ---------------- 도시 테이블 숨기기 , 보이기 끄으으읕---------------- */

/* ---------------- 인원수 증가, 감소 ---------------- */
	/* 성인 수 */
	$(function(){
		$('#decreaseQuantity').click(function(e){
			e.preventDefault();
			var stat = $('#numberUpDown').val();
			var num = parseInt(stat,10);
			num--;
		if(num<=0){
			alert('더이상 줄일수 없습니다.');
			num =1;
		}
		$('#numberUpDown').val(num);
		
		});
			$('#increaseQuantity').click(function(e){
			e.preventDefault();
			var stat = $('#numberUpDown').val();
			var num = parseInt(stat,10);
			num++;
		
				if(num>10){
					alert('더이상 늘릴수 없습니다.');
					num=10;
				}
			var adult = $('#numberUpDown').val(num);
			
			});
		});
		
	/* 소아수 */
	$(function(){
		$('#decreaseQuantity2').click(function(e){
			e.preventDefault();
			var stat = $('#numberUpDown2').val();
			var num = parseInt(stat,10);
			num--;
		if(num<=-1){
			alert('더이상 줄일수 없습니다.');
			num =0;
		}
		$('#numberUpDown2').val(num);
		});
			$('#increaseQuantity2').click(function(e){
			e.preventDefault();
			var stat = $('#numberUpDown2').val();
			var num = parseInt(stat,10);
			num++;
		
				if(num>10){
					alert('더이상 늘릴수 없습니다.');
					num=10;
				}
			var child = $('#numberUpDown2').val(num);
			});
		});
	/* 유아수 */
	$(function(){
		$('#decreaseQuantity3').click(function(e){
			e.preventDefault();
			var stat = $('#numberUpDown3').val();
			var num = parseInt(stat,10);
			num--;
		if(num<=-1){
			alert('더이상 줄일수 없습니다.');
			num =0;
		}
		$('#numberUpDown3').val(num);
		});
			$('#increaseQuantity3').click(function(e){
			e.preventDefault();
			var stat = $('#numberUpDown3').val();
			var num = parseInt(stat,10);
			num++;
		
				if(num>10){
					alert('더이상 늘릴수 없습니다.');
					num=10;
				}
			var inf = $('#numberUpDown3').val(num);
			});
		});
	
	/* ---------------- 인원수 증가, 감소  끄으으읕---------------- */
	
	/*  ---------------- 왕복 , 편도 function  ---------------- */
	$(function() { //왕복
		$("#roundTrip").click(function() {
			$("#arraw").attr("class","fas fa-arrows-alt-h");
			$('#roundTrip').attr('class','col-sm-3 basic');
			$('#right').attr('class','col-sm-3 change');
			$("#tripCourses").val("R");
			$("#arrIcon").show();
		});
	});
	$(function() { //편도
		$("#right").click(function() {
			$("#arraw").attr("class","fas fa-arrow-right");
			$('#roundTrip').attr('class','col-sm-3 change');
			$('#right').attr('class','col-sm-3 basic');
			$("#tripCourses").val("O");
			$("#arrIcon").hide();
		});
		
	});
	//기본 reload시에 왕복으로 해놓기
	window.onload = function () {
		$('#roundTrip').attr('class','col-sm-3 basic');
		$('#right').attr('class','col-sm-3 change');
	}
	
	/*  ---------------- 왕복 , 편도 function 끝  ---------------- */ 

	/*  ---------------- 달력 사이즈 변경  ---------------- */
	$(function() {
		$("#from").click(function() {
			$(".kronos-inner").css("height","320");
		});
		$("#to").click(function() {
			$(".kronos-inner").css("height","320");
		});
	});
	/*  ---------------- 달력 사이즈 변경  끝!!---------------- */
	
	/*  ---------------- 인원수 modal value  ---------------- */
	$(function() {
		$(".btn.btn-secondary").click(function() {
			var one =$("#numberUpDown").val();
			var two =$("#numberUpDown2").val();
			var three =$("#numberUpDown3").val();
			
			var plus = Number(one)+Number(two)+Number(three);
			var grade = $("#grade option:selected").text();
			$("#peopleChoice").val("총 "+plus+"명 / "+grade)
		})
	});
	
	function closeModal(modalName) {
		if( typeof $("."+modalName)[0] != "undefined" ){
			$("."+modalName)[0].reset();	
		}
		$("#"+modalName).modal("hide");
	}
	/*  ---------------- 인원수 modal value 끝!!  ---------------- */
</script>



</head>




<body>
 	<jsp:include page="/toolbar/toolBar.jsp" />
 	<jsp:include page="/toolbar/pushBar.jsp" />
<form>
<div class="wrapper" style="">	
<br>
<br>
<br>

		<div id="loading" style="display:none;">
			<div class="col-sm-6" style="margin-left:300px;margin-top:300px">
				<img id="loading-image" width="150px" height="150px" 
			
				src="/resources/images/orderImg/Ellipsis-1.4s-200px.gif" alt="Loading..." />
			</div>
		</div>

			<div class="container" id="total">
			<div class="row" style="Padding-left:5px;Padding-top:30px;">
					<div class="col-sm-3" id="roundTrip">
							<p class="roundTrip" style="color:white;margin-left:45px;Padding-top:10px;">왕복 구간 검색</p>
              				<input type="hidden" name="tripCourse" id="tripCourses" value="R" >
              		</div>
              		<div class="col-sm-3" id="right">
              			<p style="color:white;margin-left:-15px;Padding-top:10px;">편도 구간 검색</p>
              		</div>
            </div>
            
			  <div class="row" >
			    <div class="col-md-5" style="margin-top:50px;margin-left:50px;">
			    <div class="row">
			    	 <input type="text" class="form-control" placeholder="출발지역을 입력하세요" name="depCity" id="depCity" style="width:300px;height:30px;font-size:13px;float:left;" onclick="javascript:doShow();">
					 <div class="input-group-append" >
					  <span class="input-group-text" id="basic-addon2" style="background-color:white;" ><i class="fas fa-plane" id="iconf" style="font-size:15px;"></i></span>
			  			<i class="fas fa-arrows-alt-h" id="arraw" style="font-size:25px;Padding-left:80px;"></i>
			  		 </div>
			  		<table class="table" id="domestic" style="width: 300px; display: none;">
						 <tbody>	
							<tr>
							<th rowspan="5" align="center" style="text-align: center;width: 70px;height: 100px;line-height: 100px;">국내</th>
							</tr>			
								<tr>			
									<td onclick="javascript:domestic($(this).closest('td').text());">인천</td>
									<td onclick="javascript:domestic($(this).closest('td').text());">김포</td>
								</tr>
								<tr>
									<td onclick="javascript:domestic($(this).closest('td').text());">부산</td>
									<td onclick="javascript:domestic($(this).closest('td').text());">대구</td>
								</tr>
								<tr>
									<td onclick="javascript:domestic($(this).closest('td').text());">청주</td>
									<td onclick="javascript:domestic($(this).closest('td').text());">제주</td>
								</tr>
								<tr>
									<td onclick="javascript:domestic($(this).closest('td').text());">무안</td>
									<td onclick="javascript:domestic($(this).closest('td').text());"></td>
								</tr>
							</tbody>
						</table>
						</div>
						<br/><br/>
						<div class="row">
						 <div class="col-sm-5" id="depIcon" style="margin-left:-15px;">
				    		<input type="text" class="form-control" readonly="readonly" placeholder="출발날짜 선택" style="background-color:white;width:110px;height:30px;font-size:13px;float:left;" id="from" name="depDate">
					    	<div class="input-group-append">
					    		<span class="input-group-text" id="basic-addon2" style="background-color:white;">
					    		<i class="far fa-calendar-alt" style="font-size:15px;"></i></span>
							</div>
						</div>
				   		 <div class="col-sm-5" id="arrIcon">
				   		 	 <input type="text" class="form-control" readonly="readonly" placeholder="도착날짜 선택"  style="background-color:white;width:110px;height:30px;font-size:13px;float:left;" id="to" name="arrDate">
				   				<div class="input-group-append">
				   					<span class="input-group-text" id="basic-addon2" style="background-color:white;">
				   					<i class="far fa-calendar-alt" style="font-size:15px;"></i></span>
				   		 		</div>
				   		 </div>
						</div>
			    </div>
			    <div class="col-md-6" style="margin-top:50px;margin-left:30px;">
			    <div class="row">
			    	 <input type="text" class="form-control" placeholder="도착지역을 입력하세요" name="arrCity" id="arrCity" style="width:350px;height:30px;font-size:13px;float:left; " onclick="javascript:Show();">
					 <div class="input-group-append" style="height:30px;">
					  <span class="input-group-text" id="basic-addon2" style="background-color:white;">
					  <i class="fas fa-plane" id="iconf" style="font-size:15px;"></i></span>
		  			 </div>
		  			
		  			<table id="europe" class="table" style="width: 350px; display: none;">
					<tbody>	
					<tr>
					<th rowspan="9" align="center" style="text-align: center;width: 70px;Padding-top:100px;line-height: 100px;">유럽</th>
					</tr>			
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">파리</td>
							<td onclick="javascript:europe($(this).closest('td').text());">런던</td>
							<td onclick="javascript:europe($(this).closest('td').text());">아테네</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">로마</td>
							<td onclick="javascript:europe($(this).closest('td').text());">프라하</td>
							<td onclick="javascript:europe($(this).closest('td').text());">이스탄불</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">프랑크푸르트</td>
							<td onclick="javascript:europe($(this).closest('td').text());">마드리드</td>
							<td onclick="javascript:europe($(this).closest('td').text());">밀라노</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">바르셀로나</td>
							<td onclick="javascript:europe($(this).closest('td').text());">취리히</td>
							<td onclick="javascript:europe($(this).closest('td').text());">베르사유</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">나폴리</td>
							<td onclick="javascript:europe($(this).closest('td').text());">헬싱키</td>
							<td onclick="javascript:europe($(this).closest('td').text());">제네바</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">베니스</td>
							<td onclick="javascript:europe($(this).closest('td').text());">부다페스트</td>
							<td onclick="javascript:europe($(this).closest('td').text());">베를린</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">암스테르담</td>
							<td onclick="javascript:europe($(this).closest('td').text());">뮌헨</td>
							<td onclick="javascript:europe($(this).closest('td').text());">리스본</td>
						</tr>
						<tr>
							<td onclick="javascript:europe($(this).closest('td').text());">두브로브니크</td>
							<td onclick="javascript:europe($(this).closest('td').text());">모스크바</td>
							<td onclick="javascript:europe($(this).closest('td').text());">베오그라드</td>
						</tr>
					</tbody>
					</table>
					<br/><br/>
				</div>
				<br/>
				<div class="row">
					<!-- <div class="col-sm-2" id="totalNum">
			   		 	<input type="text" id="peopleChoice" value="성인 1명 / 일반석" style="width:150px;" 
			   		 	 title="인원 및 좌석 등급 선택" class="form-control" readonly="readonly" data-toggle="modal" data-target="#flightNum">
			   		 </div> -->
					<div class="col-sm-4" id="totalNum">
			   		 	<input type="text" id="peopleChoice" value="성인 1명 / 일반석" style="width:150px;" 
			   		 	 title="인원 및 좌석 등급 선택" class="form-control" readonly="readonly" data-toggle="modal" data-target="#flightNum">
			   		 </div>
			   		 <div class="col-sm-4" id="search">
	                  <button type="button" id="searchButton" class="btn btn-info" title="항공권 검색">
	                    <span class="ico-search">항공권 검색</span>
	                  </button>
	                </div>
				</div>
	  		</div> 
			  </div>
			    <br/>
			</div>
			
			

<br><br><br>

			

		
</div>	




			  
		<!-- Modal 안에 내용 -->
		<div class="modal fade" id="flightNum" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content"  >
		      <div class="modal-header" style="background-color:gray;">
		        <h5 class="modal-title" id="exampleModalLabel" style="color:white;font-size:13px;">> 인원 및 좌석 등급 선택</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        <div class="number">
		        	<li>
					<label for="Adt"><strong>성인</strong><br/>
										만 12세 이상</label>
					<span class="ctrl-num">
			        	<button type="button" id="decreaseQuantity" class="plus"></button>
							 <input style="font-size:15px;width:5%;display: table-cell;margin-bottom:20px;text-align: center;vertical-align: middle;border: none;" 
							 		id="numberUpDown" name="adultNum" type="text" value="1" > 
						<button type="button" id="increaseQuantity" class="del"></button>
					</span>
					<br/>
					<li>
					<label for="Chd"><strong>소아</strong><br/>
										만 12세 미만</label>
					<span class="ctrl-num">
			        	<button type="button" id="decreaseQuantity2" class="plus"></button>
							 <input style="font-size:15px;width:5%;display: table-cell;margin-bottom:20px;text-align: center;vertical-align: middle;border: none;"
							 		 id="numberUpDown2" name="childNum" type="text" value="0" > 
						<button type="button" id="increaseQuantity2" class="del"></button>
					</span>
					</li>
					<li>
					<label for="Inf"><strong>유아</strong><br/>
										만 2세 미만</label>&nbsp;
					<span class="ctrl-num">
			        	<button type="button" id="decreaseQuantity3" class="plus"></button>
							 <input style="font-size:15px;width:5%;display: table-cell;margin-bottom:20px;text-align: center;vertical-align: middle;border: none;"
							 		 id="numberUpDown3" name="infantNum" type="text" value="0" > 
						<button type="button" id="increaseQuantity3" class="del"></button>
					</span>
					</li>
					<hr/>
						<div class="input-group">
						  <label for="seatGrade" id="seatGrade" style="text-align: center; font-size:14px;">좌석 등급 선택</label>
						 &nbsp;&nbsp;&nbsp;&nbsp;
						  <div class="input-group-append">
							   <select class="form-control" id="grade" name="seatGrade" style="width:80%;">
								 	<option value="O">일반석</option>
									<option value="R">프리미엄 일반석</option>
									<option value="C">비즈니스석</option>
									<option value="F">일등석</option>
								</select>
						</div>
						
		           </div>
				</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary"  data-dismiss="modal">확인</button>
		        <button type="button" class="btn btn-primary" onclick="closeModal('flightNum');" data-dismiss="modal">취소</button>
		      </div>
		    </div>
		  </div>
		</div>
	
</form>

<jsp:include page="/toolbar/footer.jsp" />			
</body>
</html>