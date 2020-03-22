<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        
<!DOCTYPE html>

<html lang="ko">

<head>
	<meta charset="EUC-KR">
	<title>${plan.planTitle} : 여행루트 변경</title>
	
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
	
	<!-- jquery Ui 링크 (datePicker)  -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!--datePicker CDN  -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	
	<!-- ICON 사용을 위한 스크립트 임포트 : https://feathericons.com/ -->
	<script src="https://unpkg.com/feather-icons"></script>
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */=
      #map {
        height: 500px;
        width: 70%;
        background-color: grey;
      }
      /* Optional: Makes the sample page fill the window. */
      
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      #floating-panel {
        width: 440px;
      }
      #place-id {
        width: 250px;
      }
      
      .modal{
	    background-color: rgb(0,0,0); /* Fallback color */
		background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
      }
      
      
      
      
      
      .tran_icon {
      	font-size: 32px;
      }
      .city_route{
      	margin: 0px 15px; 
      	padding: 6px;
      }
      .cr_cityName{
      	font-weight: 600;
      	font-size: 17px;
      }
      .cr_term{
      	font-size: 13px;
      }
      
      .tran_icon2 {
      	font-size: 45px;
      	margin: 5px;
      }
      .tran_circle{
      	width: 100px;
      	height: 100px;
      	//border: 1px solid gray;
      	border-radius: 100%;
      	align-content: center;
      	text-align: center;
      	padding-top: 10px;
      	margin: 10px;
      }
      .dura_circle{
      	width: 100px;
      	height: 100px;
      	//border: 1px solid gray;
      	border-radius: 100%;
      	align-content: center;
      	text-align: center;
      	font-size:x-large;
      	padding-top: 30px;
      	margin: 10px;
      }
      
      
      .tran_a, .tran_a:hover, .tran_a:focus{
      	 color:inherit; 
      	 text-decoration: none;
      }
      .city_duration_wrap, .city_duration_wrap:hover, .city_duration_wrap:focus{
      	 color:inherit; 
      	 text-decoration: none;
      }
      
      .cr_cityDuration_parent{
      	 border:2px solid #71BED1; 
      	 padding: 12px; 
      	 font-weight: 600;"
      }
      
	</style>
	
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding|Noto+Sans+KR:300,400,500&display=swap&subset=korean" rel="stylesheet">
	<style>
	    body {
	        font-family: 'Noto Sans KR', sans-serif;
	        font-weight: 400;
	    }
	</style>
	
	<!-- 함수들 모음집 -->
	<script type="text/javascript">
	
		var planId = ${plan.planId};	//현재 조회중인 plan의 아이디 박아두기
	
		var routeList = [];
		routeList = ${cityMarkerList};
		
		//alert("routeList => "+routeList);
		
		$(function(){
			$('#updatePlanButton').on('click', function(){
				alert('#updatePlanButton 클릭! 플래너 수정 함수 호출');
			});
			
			$('#deletePlanButton').on('click', function(){
				alert('#deletePlanButton 클릭! 플래너 삭제 함수 호출');
			});
			
			$('#exitPlanButton').on('click', function(){
				alert('#exitPlanButton 클릭! 플래너 탈퇴 함수 호출');
			});
			
			$('#planCompleteButton').on('click', function(){
				alert('#planCompleteButton 클릭! 플래너 여행완료 함수 호출');
			});
			
			
			/* $('.tran_type').on('click', function(){
				alert(".tran_type 클릭 => "+ ($('.tran_type').index($(this)) ) );
				$('#updateTranModal').show();
			});
			$('.cr_cityDuration_parent').on('click', function(){
				alert( ".cr_cityDuration_parent 클릭 => "+ ( $('.cr_cityDuration_parent').index($(this)) )   );
				//alert( "cityId = " );
			}); */
			
			$('.close.hide').hide();
			
			/* $('.city_route').hover(
		        function() {
		            //$(this).find('.media').css('backgroundColor', '#F4FAFA');
		            $(this).find('.media').css('outline', '2px solid #CDD8D8');
		            $(this).find('.close').show();
		        },
		        function() {
		            //$(this).find('.media').css('background', 'none');
		            $(this).find('.media').css('outline', 'none');
		            $(this).find('.close').hide();
		        }
		    ); */
			
			
			$(document).on('mouseover', '.city_route', 
				function() {
					$(this).find('.media').css('outline', '2px solid #CDD8D8');
		            $(this).find('.close').show();
		    	}
			);
		    $(document).on('mouseout', '.city_route', 
		        function() {
			    	$(this).find('.media').css('outline', 'none');
		            $(this).find('.close').hide();
		        }
			);
			
			
			//updateTranType을 위한 클릭이벤트 걸어주기...
			$('.tran_circle').on('click', function(){
				var getCityId = $('#update_city_id').text();
				var tranType = $(this).attr('id').substring(10,11);
      			console.log( "update tran_type="+tranType+", cityId="+getCityId );
      			
      			updateTranType( getCityId, tranType);
      			
      			$('.tran_circle').css('background', 'none').css('color', 'black');
      			$('#tran_type_'+tranType).css('backgroundColor', '#7CECE5').css('color', 'white');
      		});
      	
			$('.dura_circle').on('click', function(){
				var getCityId = $('#update_city_id').text();
				var duration = $(this).attr('id').substring(5,6);
      			console.log( "update dura_="+duration+", cityId="+getCityId );
      			
      			updateCityDuration( getCityId, duration );
      			
      			$('.dura_circle').css('background', 'none').css('color', 'black');
      			$('#dura_'+duration).css('backgroundColor', '#7CECE5').css('color', 'white');
      		});
			
		});
		
		
		function showUpdateCityDuration( cityId, currDuration ){
			console.log("updateCityDuration('"+ cityId +"','"+ currDuration +"')");
			
			var index = $('.city_id').index( $('.city_id:contains("'+cityId+'")') );
			
			$('#update_city_id').text(cityId);
			$('#durationCityName').text( $($('.cr_cityName')[index]).text() );
			$('#dura_'+currDuration).css('backgroundColor', '#7CECE5').css('color', 'white');
			
			//$('#updateDurationModal').show();
			$('#updateDurationModal').modal();
		}
		
		function showUpdateTranType( cityId, currTranType ) {
			console.log("showUpdateTranType('"+cityId+"','"+ currTranType+"')");
			
			var index = $('.city_id').index( $('.city_id:contains("'+cityId+'")') );
			var startCity = $($('.cr_cityName')[index-1]).text();
			$('#startCity').text(startCity);
			$('#endCity').text( $($('.cr_cityName')[index]).text() );
			
			$('#update_city_id').text(cityId);
			$('#tran_type_'+currTranType).css('backgroundColor', '#7CECE5').css('color', 'white');

			//$('#updateTranModal').show();
			$('#updateTranModal').modal();
		}
		
		
		function updateCityDuration( cityId, duration ){
			var index = $('.city_id').index( $('.city_id:contains("'+cityId+'")') );

			$.ajax({
				url: "/planSub/json/updateCityDuration",
				method: "POST",
				dataType: "json",
				data: JSON.stringify({
					planId: planId,
					cityId: cityId,
					cityDuration: duration
				}),
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				success: function(JSONData, status){
					//console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );
				},
				error:function(request,status,error){
			        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			    } 
			}); //ajax
			
			var jsStr = "javascript:showUpdateCityDuration('"+cityId+"','"+duration+"')";
			
			var nights = duration - 1 ;
			$($('.city_duration_wrap')[index]).attr('href',jsStr);
			$($('.city_duration_wrap')[index]).find('span').text( nights );
			
			$('#updateDurationModal').modal('hide');
			reorder();
		}
		
		function updateTranType( cityId, tranType ){
			var index = $('.city_id').index( $('.city_id:contains("'+cityId+'")') );
			
			$.ajax({
				url: "/planSub/json/updateTranType",
				method: "POST",
				dataType: "json",
				data: JSON.stringify({
					planId: planId,
					cityId: cityId,
					tranType: tranType
				}),
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				success: function(JSONData, status){
					//console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );
				},
				error:function(request,status,error){
			        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			    } 
			}); //ajax
			
			//$($('.trans')[index]).html('!!!!!');
			
			var jsStr = "javascript:showUpdateTranType('"+cityId+"','"+tranType+"')";
			
			var fontHtml;
			if( tranType == 'T' ){
				fontHtml = "기차 <i class='tran_icon fas fa-train'></i>";
			}else if( tranType == 'B' ){
				fontHtml = "버스 <i class='tran_icon fas fa-bus'></i>";
			}else if( tranType == 'A' ){
				fontHtml = "항공 <i class='tran_icon fas fa-plane'></i>";
			}else if( tranType == 'F' ){
				fontHtml = "페리 <i class='tran_icon fas fa-ship'></i>";
			}else if( tranType == 'E' ){
				fontHtml = "기타 <i class='tran_icon fas fa-guitar'></i>";
			}
			
			$($('.trans')[index]).find('a').attr('href',jsStr);
			$($('.trans')[index]).find('font').html(fontHtml);
			
			/* $('.tran_circle').css('background', 'none').css('color', 'black');
			closeModal('updateTranModal'); */
			$('#updateTranModal').modal('hide');
			
		}
		
		
		
		
		function prependZero( number ){
			
			if( number < 10 ){
				return '0'+number;
			}else{
				return number;
			}
		}
		
		
		function reorder() {
			console.log("reorder() 실행")
			
			var startDate = new Date('${plan.startDate}');
			var planTotalDays = 1;
			
		    $(".city_route").each(function(i, box) {
		    	var cityId = $(box).find(".city_id").text().trim();
		    	//var index = $(".city_route").index($(box));
		    	var visitOrder = i+1;
		    	
		        $(box).find(".visit_order").html(visitOrder);
		        console.log(" reorder 실행! => "+$(box)+"/cityId="+ cityId +", i="+i+", visitOrder="+visitOrder );
		        if( i == 0){
		        	$(box).find(".tran_type").hide();
		        }else{
		        	$(box).find(".tran_type").show();
		        }
		        
		        
		        /* var mm = startDate.getMonth()+1;
		        mm = ( mm < 10 ) ? '0'+ mm : mm;
		        
		        var dd = startDate.getDate(); 
		        dd = (dd < 10) ? '0' + dd : dd; */

		        var cr_term_string = startDate.getFullYear()+"-"+ prependZero(startDate.getMonth()+1) +"-"+ prependZero(startDate.getDate()) + " ~ ";
		        
		        var cityDuration = $(box).find('.cr_cityDuration').text();
		        //alert(cityDuration)
		        planTotalDays = planTotalDays + parseInt(cityDuration);
		        
		        startDate.setDate( startDate.getDate() + parseInt(cityDuration) );
		        
		        cr_term_string = cr_term_string + startDate.getFullYear()+"-"+prependZero(startDate.getMonth()+1)+"-"+prependZero(startDate.getDate());
		        
		        $(box).find('.cr_term').text(cr_term_string);
		        
		        updateVisitOrder( cityId, visitOrder );
		    });
		    $('#plan-total-days').text(planTotalDays);
			
			setTimeout(function(){
				getCityRouteList( planId );
			},20);
			
		}
		
		function updateVisitOrder( cityId, visitOrder ){
			//console.log("updateVisitOrder("+ cityId +", "+ visitOrder +") 실행");
			$.ajax({
				url: "/planSub/json/updateVisitOrder",
				method: "POST",
				dataType: "json",
				data: JSON.stringify({
					planId: planId,
					cityId: cityId,
					visitOrder: visitOrder
				}),
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				success: function(JSONData, status){
					if( JSONData==null || JSONData=="" ){
						console.log("리턴데이터 없음");	
					}else{
						console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );	
					}
				},
				error:function(request,status,error){
			        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			    } 
			}); //ajax
		} //updateVisitOrder( )
		
		
		
		function deleteCityRoute( cityId, visitOrder ){
			var visitOrderNew  = visitOrder+1;	//삭제 후 이미 부여된 순서 오류... 필요없음!!!!!!
			var indexNew = $(".city_id").index( $(".city_id:contains('"+cityId+"')") );
			
			/* if(confirm( "삭제된 경로는 복구가 불가능합니다.\n정말 삭제하시겠습니까? " ))
			{
				console.log( indexNew + "번째 cityRoute 삭제"  );
				$($(".city_route")[indexNew] ).remove();
				//$("#cityblock"+idx).remove();
				
				console.log("cityId="+ cityId +" 삭제됨");
				
				$.ajax({
					url: "/planSub/json/deleteCityRoute/"+cityId+"/"+planId ,	//planId 필요없지만..
					method: "GET",
					dataType: "json",
					headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
					success: function(JSONData, status){
						if( JSONData==null || JSONData=="" ){
							console.log("리턴데이터 없음");	
						}else{
							console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );	
						}
					},
					error:function(request,status,error){
				        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				    } 
				}); //ajax
				
				reorder();
			} */
			
			swal({
				title:"경로 삭제",
				text:"삭제된 경로는 복구가 불가능합니다.\n정말 삭제하시겠습니까? ",
				icon:"warning",
				buttons: [ "아니오", "예"]
			}).then((YES) => {
				if(YES){
					swal({
						  icon : 'success',
						  title : "삭제되었습니다!",
						  text:" ",
						  button : false,
						  timer: 1000
						});
					//swal("삭제되었습니다!", "", "success");
					
					console.log( indexNew + "번째 cityRoute 삭제"  );
					$($(".city_route")[indexNew] ).remove();
					//$("#cityblock"+idx).remove();
					
					console.log("cityId="+ cityId +" 삭제됨");
					
					$.ajax({
						url: "/planSub/json/deleteCityRoute/"+cityId+"/"+planId ,	//planId 필요없지만..
						method: "GET",
						dataType: "json",
						headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
						success: function(JSONData, status){
							if( JSONData==null || JSONData=="" ){
								console.log("리턴데이터 없음");	
							}else{
								console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );	
							}
						},
						error:function(request,status,error){
					        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					    } 
					}); //ajax
					
					reorder();
				}
			});
			
		}
		

		$(function(){
			$('.city_route_list').sortable({
				items: ".city_route",
				
				/* 드래그 시작시 호출되는 이벤트 핸들러 */
				start: function(event, ui){	
					console.log("sortable start!");
					
					ui.item.data('start_pos', ui.item.index());		
					// ui.item.index() <- 드래그하는 아이템의 위치를 가져옴 (첫번째 아이템=0)
					// ui.item.data(key, value) <- 아이템에 키,값 쌍으로 데이터를 저장
				},
				/* 드랍시 호출되는 이벤트 핸들러 */
				stop: function(event, ui){	// = stop: function(e,ui) ????
					console.log("sortable stop!");
					var spos = ui.item.data('start_pos');
					var epos = ui.item.index();
					
					reorder();	//순서 변경시 모든 itemBox 내의 itemNum(입력필드 앞의 숫자)의 번호를 순서대로 다시 붙임
					//getCityRouteList( planId );
				}
			});
			
			$('.city_route_list').disableSelection();
		});
		
		
		function addCityRoute(cityName){
			var nextVisitOrder = $(".city_route").length + 1;
			
			/* if(confirm( "\n 경로를 추가하시겠습니까?" ))
			{	
				$.ajax({
					url: "/planSub/json/addCityRoute",
					method: "POST",
					dataType: "json",
					data: JSON.stringify({
						planId: planId,
						cityName: cityName,
						visitOrder: nextVisitOrder
					}),
					headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
					success: function(JSONData, status){
						if( JSONData==null || JSONData=="" ){
							console.log("리턴데이터 없음");	
						}else{
							console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );	
							
							var crHtml = '<div class="city_route">';
							crHtml = crHtml + '<div class="trans d-flex justify-content-center">';
							crHtml = crHtml + '<a class="tran_a" href="javascript:showUpdateTranType(\''+ JSONData.cityId +'\' , \''+ JSONData.tranType +'\')">';
							crHtml = crHtml + '<font class="tran_type" style="font: 7px gray;">';
							
							if( JSONData.tranType == 'T' ){
								crHtml = crHtml + '기차 <i class="tran_icon fas fa-train"></i>';
							}else if( JSONData.tranType == 'B' ){
								crHtml = crHtml + '버스 <i class="tran_icon fas fa-bus"></i>';
							}else if( JSONData.tranType == 'A' ){
								crHtml = crHtml + '항공 <i class="tran_icon fas fa-plane"></i>';
							}else if( JSONData.tranType == 'F' ){
								crHtml = crHtml + '페리 <i class="tran_icon fas fa-ship"></i>';
							}else if( JSONData.tranType == 'E' ){
								crHtml = crHtml + '기타 <i class="tran_icon fas fa-guitar"></i>';
							}else if( JSONData.tranType == null || JSONData.tranType == '' ){
								crHtml = crHtml + '선택 <i class="tran_icon fas fa-plus"></i>';
							}
							crHtml = crHtml + '</font>';
							crHtml = crHtml + '</a>';
							crHtml = crHtml + '</div>';
							
							crHtml = crHtml + '<button type="button" class="close hide" aria-label="Close" onclick="deleteCityRoute(\''+ JSONData.cityId +'\', 0 )"> <span aria-hidden="true">&times;</span> </button>';
												
							crHtml = crHtml + '<div class="media mt-4" style="border: 1px solid #CDD8D8; border-radius:3px; padding: 12px 30px 5px 30px;">';
							crHtml = crHtml + '<div hidden="hidden">방문순서: <span class="visit_order">'+ JSONData.visitOrder +'</span> , 도시ID: <span class="city_id">'+ JSONData.cityId +'</span></div>';
							crHtml = crHtml + '<img alt="" src="/resources/images/planImg/defaultPlanImage.jpg" class="align-self-center mr-3 city_img" style="width: 50px; height: auto;" hidden="hidden">';
							crHtml = crHtml + '<div class="media-body">';
							crHtml = crHtml + '<div class="cr_cityName mt-0">'+ JSONData.cityName +'</div>';
							crHtml = crHtml + '<p class="cr_term">'+ JSONData.startDateStr +' ~ '+ JSONData.endDateStr +'</p>';
							crHtml = crHtml + '</div>';
							crHtml = crHtml + '<a href="javascript:showUpdateCityDuration(\''+ JSONData.cityId +'\' ,\' '+ JSONData.cityDuration + '\')" class="city_duration_wrap">';
							crHtml = crHtml + '<div class="cr_cityDuration_parent rounded-circle">';
							crHtml = crHtml + '<span class="cr_cityDuration">'+ (JSONData.cityDuration-1) +'</span>박';
							crHtml = crHtml + '</div>';
							crHtml = crHtml + '</a>';
							crHtml = crHtml + '</div>';
							crHtml = crHtml + '</div>';
							
							$(crHtml).appendTo('.city_route_list');
							$('.close.hide').hide();
							
						}
					},
					error:function(request,status,error){
				        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				    } 
				}); //ajax
				
				setTimeout(function(){
					reorder();
				}, 50); // 날짜 null ~ null 로 떠서 셋타임아웃 해줌
				
				prv_infowindow.close();
			}//confirm if
			 */
			
			swal({
				title:"경로 추가",
				text:"경로를 추가하시겠습니까?",
				//icon:"warning",
				buttons: [ "아니오", "예"]
			}).then((YES) => {
				if(YES){
					//swal("추가되었습니다!", "", "success");
					swal({
						  icon : 'success',
						  title : "추가되었습니다!",
						  text:" ",
						  button : false,
						  timer: 1000
						});
					
					$.ajax({
						url: "/planSub/json/addCityRoute",
						method: "POST",
						dataType: "json",
						data: JSON.stringify({
							planId: planId,
							cityName: cityName,
							visitOrder: nextVisitOrder
						}),
						headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
						success: function(JSONData, status){
							if( JSONData==null || JSONData=="" ){
								console.log("리턴데이터 없음");	
							}else{
								console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );	
								
								var crHtml = '<div class="city_route">';
								crHtml = crHtml + '<div class="trans d-flex justify-content-center">';
								crHtml = crHtml + '<a class="tran_a" href="javascript:showUpdateTranType(\''+ JSONData.cityId +'\' , \''+ JSONData.tranType +'\')">';
								crHtml = crHtml + '<font class="tran_type" style="font: 7px gray;">';
								
								if( JSONData.tranType == 'T' ){
									crHtml = crHtml + '기차 <i class="tran_icon fas fa-train"></i>';
								}else if( JSONData.tranType == 'B' ){
									crHtml = crHtml + '버스 <i class="tran_icon fas fa-bus"></i>';
								}else if( JSONData.tranType == 'A' ){
									crHtml = crHtml + '항공 <i class="tran_icon fas fa-plane"></i>';
								}else if( JSONData.tranType == 'F' ){
									crHtml = crHtml + '페리 <i class="tran_icon fas fa-ship"></i>';
								}else if( JSONData.tranType == 'E' ){
									crHtml = crHtml + '기타 <i class="tran_icon fas fa-guitar"></i>';
								}else if( JSONData.tranType == null || JSONData.tranType == '' ){
									crHtml = crHtml + '선택 <i class="tran_icon fas fa-plus"></i>';
								}
								crHtml = crHtml + '</font>';
								crHtml = crHtml + '</a>';
								crHtml = crHtml + '</div>';
								
								crHtml = crHtml + '<button type="button" class="close hide" aria-label="Close" onclick="deleteCityRoute(\''+ JSONData.cityId +'\', 0 )"> <span aria-hidden="true">&times;</span> </button>';
													
								crHtml = crHtml + '<div class="media mt-4" style="border: 1px solid #CDD8D8; border-radius:3px; padding: 12px 30px 5px 30px;">';
								crHtml = crHtml + '<div hidden="hidden">방문순서: <span class="visit_order">'+ JSONData.visitOrder +'</span> , 도시ID: <span class="city_id">'+ JSONData.cityId +'</span></div>';
								crHtml = crHtml + '<img alt="" src="/resources/images/planImg/defaultPlanImage.jpg" class="align-self-center mr-3 city_img" style="width: 50px; height: auto;" hidden="hidden">';
								crHtml = crHtml + '<div class="media-body">';
								crHtml = crHtml + '<div class="cr_cityName mt-0">'+ JSONData.cityName +'</div>';
								crHtml = crHtml + '<p class="cr_term">'+ JSONData.startDateStr +' ~ '+ JSONData.endDateStr +'</p>';
								crHtml = crHtml + '</div>';
								crHtml = crHtml + '<a href="javascript:showUpdateCityDuration(\''+ JSONData.cityId +'\' ,\' '+ JSONData.cityDuration + '\')" class="city_duration_wrap">';
								crHtml = crHtml + '<div class="cr_cityDuration_parent rounded-circle">';
								crHtml = crHtml + '<span class="cr_cityDuration">'+ (JSONData.cityDuration-1) +'</span>박';
								crHtml = crHtml + '</div>';
								crHtml = crHtml + '</a>';
								crHtml = crHtml + '</div>';
								crHtml = crHtml + '</div>';
								
								$(crHtml).appendTo('.city_route_list');
								$('.close.hide').hide();
								
							}
						},
						error:function(request,status,error){
					        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
					    } 
					}); //ajax
					
					setTimeout(function(){
						reorder();
					}, 50); // 날짜 null ~ null 로 떠서 셋타임아웃 해줌
					
					prv_infowindow.close();
				}
			});
		}
		
		
		/* GoogleMap control 버튼 클릭 */
		function controlClick(){
			var string = '/plan/getPlan?planId='+planId;
			$(self.location).attr("href", string);
		}
	
	
	</script>


	<script>
	
		/* 모달창 닫기 */
		function closeModal(modalName) {
			$('.dura_circle').css('background', 'none').css('color', 'black');
			$('.tran_circle').css('background', 'none').css('color', 'black');
			
			console.log("closeModal : modalName="+modalName);
			if( typeof $("."+modalName)[0] != "undefined" ){
				$("."+modalName)[0].reset();		//form에 모달 이름과 같은 클래스명 주기
			}
			$("#"+modalName).hide();
		}
		
		/* 스크롤 부드럽게 */
		jQuery(document).ready(function($) { 
			$(".scroll").click(function(event){ 
				event.preventDefault(); 
				$('html,body').animate({
					scrollTop:$(this.hash).offset().top
					}, 500); 
			}); 
		});
		
		//.show() -> .modal() 로 변경하면서 closeModal시 수행할 기능들 다시 이벤트 걸어주기...
		$(function() {
			
			$('#updateTranModal').on('hidden.bs.modal', function(){
				$('.tran_circle').css('background', 'none').css('color', 'black');
			});
			
			$('#updateDurationModal').on('hidden.bs.modal', function(){
				$('.dura_circle').css('background', 'none').css('color', 'black');
			});
			
		});
		
		
		
	</script>
	
	
	
	
	
	
	<!-- body 로드 후 실행되어야 하는 스크립트 모음  -->
	<!-- Map 관련 스크립트 -->
	<script>
	
	 	/* ------------------------------------ Google Map Script ------------------------------------ */
		var map;
		var geocoder;
		var overlay;
		var marker=[];
		var routeLines=[];
		
		var allMarkers = [];
		var myMarkers = [];
		var prv_infowindow;
		
		var korea = {lat:37.497957 , lng:127.027780};
		var frankfurt = {lat:49.7901184, lng:4.8896333 };
		
		
 		var lineSymbol2;
		
	
		/* initMap !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! */
		function initMap(){
			
			geocoder = new google.maps.Geocoder();
		    map = new google.maps.Map(document.getElementById('map'), {
		        center: korea,
		        zoom: 3,			/* zoom: 1:World, 5:Landmass/continent, 10:City, 15:Streets, 20:Buildings */
		        //mapTypeId :'terrain',
		        //styles: [
		        	/* { "elementType": "geometry", "stylers": [ { "color": "#ffffff" } ] }, */
		        	  /* { "elementType": "labels.icon", "stylers": [ { "color": "#e5e5e5" }, { "visibility": "off" } ] },
		        	  { "elementType": "labels.text.fill", "stylers": [ { "color": "#c3c3c3" } ] },
		        	  { "featureType": "administrative", "elementType": "geometry", "stylers": [ { "visibility": "off" } ] }, */
		        	  /* { "featureType": "administrative.land_parcel", "stylers": [ { "visibility": "off" } ] },
		        	  { "featureType": "administrative.locality", "stylers": [ { "visibility": "simplified" } ] },
		        	  { "featureType": "administrative.neighborhood", "stylers": [ { "visibility": "off" } ] },
		        	  { "featureType": "poi", "stylers": [ { "visibility": "off" } ] },
		        	  /* { "featureType": "road", "stylers": [ { "visibility": "off" } ] }, */
		        	 /*  { "featureType": "transit", "stylers": [ { "visibility": "off" } ] },
		        	  { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#DAF8F6" } ] }, */
		        	  /* { "featureType": "water", "elementType": "labels.text", "stylers": [ { "visibility": "off" } ] } */
		        //]
		    	styles:[
		    		  {
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#ebe3cd"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#79524f"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "elementType": "labels.text.stroke",
		    			    "stylers": [
		    			      {
		    			        "color": "#f5f1e6"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "administrative",
		    			    "elementType": "geometry.stroke",
		    			    "stylers": [
		    			      {
		    			        "color": "#c9b2a6"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "administrative.land_parcel",
		    			    "elementType": "geometry.stroke",
		    			    "stylers": [
		    			      {
		    			        "color": "#dcd2be"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "administrative.land_parcel",
		    			    "elementType": "labels",
		    			    "stylers": [
		    			      {
		    			        "visibility": "off"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "administrative.land_parcel",
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#ae9e90"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "landscape.natural",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#fcf9f5"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#e7dec2"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi",
		    			    "elementType": "labels.text",
		    			    "stylers": [
		    			      {
		    			        "visibility": "off"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi",
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#93817c"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi.business",
		    			    "stylers": [
		    			      {
		    			        "visibility": "off"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi.park",
		    			    "elementType": "geometry.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#e8edde"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi.park",
		    			    "elementType": "labels.text",
		    			    "stylers": [
		    			      {
		    			        "visibility": "off"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "poi.park",
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#447530"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road",
		    			    "stylers": [
		    			      {
		    			        "visibility": "off"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#f5f1e6"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.arterial",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#fdfcf8"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.highway",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#f8c967"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.highway",
		    			    "elementType": "geometry.stroke",
		    			    "stylers": [
		    			      {
		    			        "color": "#e9bc62"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.highway.controlled_access",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#e98d58"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.highway.controlled_access",
		    			    "elementType": "geometry.stroke",
		    			    "stylers": [
		    			      {
		    			        "color": "#db8555"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.local",
		    			    "elementType": "labels",
		    			    "stylers": [
		    			      {
		    			        "visibility": "off"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "road.local",
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#806b63"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "transit.line",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#dfd2ae"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "transit.line",
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#a0938b"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "transit.line",
		    			    "elementType": "labels.text.stroke",
		    			    "stylers": [
		    			      {
		    			        "color": "#ebe3cd"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "transit.station",
		    			    "elementType": "geometry",
		    			    "stylers": [
		    			      {
		    			        "color": "#dfd2ae"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "water",
		    			    "elementType": "geometry.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#daedec"
		    			      }
		    			    ]
		    			  },
		    			  {
		    			    "featureType": "water",
		    			    "elementType": "labels.text.fill",
		    			    "stylers": [
		    			      {
		    			        "color": "#83a39e"
		    			      }
		    			    ]
		    			  }
		    			]
		    });
		    
	    	 
	    	/* 스크롤(zoom) 할때마다 도시리스트 가져와서 뿌려주는 이벤트 발생 */
	    	google.maps.event.addListener(map, 'tilesloaded', function(){
	    		
	    		zoomLevel = map.getZoom();
	    		console.log("tilesloaded : zoomLevel="+zoomLevel);
	    		
	    		$.ajax({
	    			url: "/planSub/json/getCityListByScroll/"+zoomLevel ,
					method: "GET",
					dataType: "json",
					headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
					success: function(JSONData, status){
						//console.log("리턴데이터 있음! => JSONData = "+JSON.stringify(JSONData));	
						//console.log("리턴데이터 리스트...\n cityLat="+JSONData[0].cityLat+"/ cityLng="+JSONData[0].cityLat+"/ cityName="+JSONData[0].cityName);
						
						clearAllMarkers();
						
						var cityList = JSONData;
						for( var i in cityList ){
							var getPosition = new google.maps.LatLng( cityList[i].cityLat , cityList[i].cityLng );
							
							var getMarker = createMarker( cityList[i].cityName, cityList[i].country, getPosition, cityList[i].cityImg, cityList[i].cityInfo );
							getMarker.setMap(map);
							allMarkers.push(getMarker);
							
							//마커 만들기
							/* var getMarker = new google.maps.Marker({ position: getPosition, map: map, icon: myIcon, shape: shape, title: cityList[i].cityName }); */
						} //for문
					},
					error:function(request,status,error){
				        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				    } 
	    		});	//ajax(getCityListByScroll) 끝
	    		
	    	});	//addListener : tilesloaded
	    	 
	    	
	    	/* function clearAllMarkers() {
	    		for(i=0;i<allMarkers.length;i++){ allMarkers[i].setMap(null);} 
	    		allMarkers=[];
	    	} 
	    	function clearMyMarkers() {
	    		for(i=0;i<myMarkers.length;i++){ myMarkers[i].setMap(null); }
	    		myMarkers=[];
	    	} */
	    	/* function clearRouteLines() {
	    		for(i=0;i<routeLines.length;i++){ routeLines[i].setMap(null); }
	    		routeLines=[];
	    	} */
	    	
	    	
	    	/* 도구모음! */
	    	var shape = {
		    			coords: [1, 1, 1, 12, 12, 12, 12, 1],
		    	        type: 'poly'
	    	        };
		 	var lineSymbol_TRAIN_RL = {
		 			    path: google.maps.SymbolPath.FORWARD_OPEN_ARROW,
		 			    fillColor: '#696969',
		 			    fillOpacity: 1,
		 			    strokeWeight: 1,
		 			    scale: 1
		 			}
		 	var lineSymbol = {
		 			    path: google.maps.SymbolPath.FORWARD_OPEN_ARROW,
		 			    fillColor: '#8A8A8A',
		 			    fillOpacity: 1,
		 			    strokeWeight: 2,
		 			    scale: 2,
		 				rotation: 0,
		 				anchor: new google.maps.Point(0,0)
		 			}
		 	
		 	var markerIcon = new google.maps.MarkerImage("/resources/images/icon/lb-circle.png", null, null, null, new google.maps.Size(9,9));
		 	var myIcon = new google.maps.MarkerImage("/resources/images/icon/circle_blue.png", null, null, null, new google.maps.Size(12,12));
			var seagullImg = new google.maps.MarkerImage("/resources/images/icon/seagull.png", null, null, null, new google.maps.Size(12,12));
			
			/* 마커 생성 */
	    	function createMarker( city, country, mPosition, img, cityInfo ){
	    		//console.log("create Marker........ city="+city+", country="+country+", mPosition="+mPosition+", img="+img+", cityInfo="+cityInfo );
	    		
	    		//var markerIcon = new google.maps.MarkerImage("/resources/images/icon/circle_red.png", null, null, null, new google.maps.Size(9,9));
	    		
	    		var makingMarker = new google.maps.Marker({
					position: mPosition,
					//icon: markerIcon,
					icon: {
						path: google.maps.SymbolPath.CIRCLE,
			            scale: 5,
			            strokeWeight:0.5,
			            strokeColor: 'white',
			            fillColor: '#0D84F5',
			            fillOpacity: 0.9
					},
					shape: shape,
					title: city
					, zIndex: 1000 
				}); 
	    		
	    		google.maps.event.addListener(makingMarker, 'click', function() {
					console.log("city name = "+makingMarker.title);
					
					if(prv_infowindow){ prv_infowindow.close(); }
					
					var markerLatLng = new google.maps.LatLng( mPosition.lat() , mPosition.lng() );		//구글의 함수로 만든 LatLng 객체라서 lat() 이런식의 함수로 수 뽑아줘야 함
					
					var infowindow = new google.maps.InfoWindow();
					
					var contentHtml = '<div class="media" style="width:340px; height:130px; padding:5px;">';
					contentHtml = contentHtml + '<img class="align-self-start mr-3" src="/resources/images/cityImg/'+img+'" width="60px" height="60px">';
					contentHtml = contentHtml + '<div class="media-body">';
					contentHtml = contentHtml + '<h5 class="mt-0">'+ makingMarker.title +  '<div class="badge badge-primary text-wrap" style="width: 3rem; margin-left:10px; margin-top:0;" onClick="addCityRoute(\'' + makingMarker.title + '\' )">'+'추가'+'</div>'  +'</h5>';
					contentHtml = contentHtml + '<p>'+  cityInfo  +'</p>';
					contentHtml = contentHtml + '</div>';
					contentHtml = contentHtml + '</div>';
					
					infowindow.setContent(contentHtml);
					infowindow.setPosition(markerLatLng);
					infowindow.open(map);
					
					prv_infowindow = infowindow;
				}); 
	    		
	    		return makingMarker;
	    	} //createMarker( city, country, mPosition, img, cityInfo )
	    	
	    	
	    	/* 시티루트 리스트의 마커 생성... 나중에 함수 취합 */
	    	function createMyMarker( city, country, mPosition, img, cityInfo ){
	    		console.log("create My Marker.... city="+city+", country="+country+", mPosition="+mPosition+", img="+img+", cityInfo="+cityInfo );
	    		
	    		//var myIcon = new google.maps.MarkerImage("/resources/images/icon/circle_blue.png", null, null, null, new google.maps.Size(12,12));
	    		var myIconn = new google.maps.MarkerImage("/resources/images/icon/pin-red2.png", null, null, null, new google.maps.Size(27,27));
	    		
	    		var myMarker = new google.maps.Marker({
					position: mPosition,
					//icon: myIcon,
					icon: myIconn,
					//shape: shape,
					title: city
					, zIndex: 3000
					, animation: google.maps.Animation.DROP
				});
	    		
	    		google.maps.event.addListener(myMarker, 'click', function() {
					console.log("city name = "+myMarker.title);
					
					if(prv_infowindow){ prv_infowindow.close(); }
					
					//var markerLatLng = new google.maps.LatLng( mPosition.lat() , mPosition.lng() );		//구글의 함수로 만든 LatLng 객체라서 lat() 이런식의 함수로 수 뽑아줘야 함
					//console.log(mPosition.lat()+"/"+mPosition.lng() );
					
					var infowindow = new google.maps.InfoWindow();
					
					var contentHtml = '<div class="media" style="width:340px; height:130px; padding:5px;">';
					contentHtml = contentHtml + '<img class="align-self-start mr-3" src="/resources/images/cityImg/'+img+'" width="60px" height="60px">';
					contentHtml = contentHtml + '<div class="media-body">';
					contentHtml = contentHtml + '<h5 class="mt-0">'+ city +  '<div class="badge badge-primary text-wrap" style="width: 3rem; margin-left:10px; margin-top:0;" onClick="addCityRoute(\'' + myMarker.title + '\' )">'+'추가'+'</div>'  +'</h5>';
					
					contentHtml = contentHtml + '<p style="font-weight:900;font-size:14px;"> 여행루트에 추가된 도시입니다</p>';
					contentHtml = contentHtml + '<p>'+  cityInfo  +'</p>';
					contentHtml = contentHtml + '</div>';
					contentHtml = contentHtml + '</div>';
					
					infowindow.setContent(contentHtml);
					infowindow.setPosition(myMarker.position);	//infowindow.setPosition(markerLatLng);
					infowindow.open(map);
					
					prv_infowindow = infowindow;
				}); 
	    		
	    		return myMarker;
	    	} //createMyMarker( city, country, mPosition, img, cityInfo )
	    	
	  
	 		
	 		var seagull = {
	 			path: google.maps.SymbolPath.CIRCLE,
	 	        scale: 8,
	 	        strokeColor: '#393'
	 		};
	    	
	 		var busIcon = new google.maps.MarkerImage("https://www.pngfind.com/pngs/m/82-822378_icono-bus-png-bus-png-icon-transparent-png.png", null, null, null, new google.maps.Size(20,20));
    		
	    	
		    /* GoogleMap 에 뿌릴 것들  */
			function initMapItems(){
				
				var bounds = new google.maps.LatLngBounds();
				
				clearMyMarkers();
				
				var cityMarkerList = ${cityMarkerList};
				
				//받아온 마커리스트를 통해 뿌려주기
				for( var i in cityMarkerList ){
					//console.log("cityMarkerList[i] = "+cityMarkerList[i].title)
					//var getPosition = new google.maps.LatLng( cityMarkerList[i].cityLat , cityMarkerList[i].cityLng );
					
					var getMyMarker = createMyMarker( cityMarkerList[i].title, cityMarkerList[i].country, cityMarkerList[i].position, cityMarkerList[i].cityImg, cityMarkerList[i].cityInfo );
					getMyMarker.setMap(map);
					myMarkers.push(getMyMarker);
					
					if( i > 0 ){
						var path = [ myMarkers[i-1].getPosition() , myMarkers[i].getPosition() ];
						routeLines[i-1] = new google.maps.Polyline({
							map: map,
							strokeColor: '#8A8A8A',
					        strokeOpacity: 1.0,
					        strokeWeight:2,
					        geodesic: false,
					        icons: [{
					            icon: lineSymbol,
					            offset: '95%'
					        }/*,
					        {
					        	icon: "https://www.pngfind.com/pngs/m/82-822378_icono-bus-png-bus-png-icon-transparent-png.png",
					        	offset: '100%'
					        }*/
					        ]
						});
						routeLines[i-1].setPath(path);
					}
					bounds.extend(getMyMarker.getPosition()); 
					
				} //for문 
				map.fitBounds(bounds);
				
				if( cityMarkerList.length == 0 ){
					setTimeout(function(){
						map.setCenter(frankfurt);
						map.setZoom(5);
					}, 30);
				}else if( cityMarkerList.length < 2 ){
					setTimeout(function(){
						//map.setCenter(korea);
						map.setZoom(5);
					}, 30);
				}
			} //initMapItems 끝
			
			
			
			initMapItems();
			
			/* setTimeout(function(){
				map.setCenter(korea);
				map.setZoom(5);
			}, 50); */
			
			/* 지도 내에 버튼 만들기 */ 
			var leftControlDiv = document.createElement('div');
			var thtml = '<div class="text-center" style="margin:20px; font-weight:bold; background-color:#024B5D; color: white; font-size:10pt;border:solid thin #DDDDDD ; border-radius:5px; padding:10px;" onClick="controlClick()"><i class="fas fa-door-open" style="font-size: 35px; margin:5px;"></i><br/>플래너 페이지로</div>';
			leftControlDiv.innerHTML = thtml;
			map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(leftControlDiv);
		    
			var rightControlDiv = document.createElement('div');
			var thtml2 = '<div class="text-center rounded-circle" style="margin:18px;font-weight:900; color:white; font-size:12pt;border:solid 1.3px #A6A6A6; padding:10px; background-color:#007592;"><div style="margin:5px;"><span style="font-size:27px;" id="plan-total-days">'+ ${plan.planTotalDays} +'</span> 일</div></div>';
			rightControlDiv.innerHTML = thtml2;
			map.controls[google.maps.ControlPosition.RIGHT_TOP].push(rightControlDiv);
			
			
	 		lineSymbol2 = {
		 			//path: google.maps.SymbolPath.FORWARD_OPEN_ARROW,
	 			    path: google.maps.SymbolPath.FORWARD_OPEN_ARROW,
	 			    fillColor: '#8A8A8A',
	 			    fillOpacity: 1,
	 			    strokeWeight: 2,
	 			    scale: 2,
	 				rotation: 0,
	 				anchor: new google.maps.Point(0,0)
	 			};
			
	 		
	 		animateCircle(routeLines);
	 		
			
		};	//initMap()
		/* ------------------------------------ Google Map Script ------------------------------------ */
		
		
		
		function clearAllMarkers() {
    		for(i=0;i<allMarkers.length;i++){ 
    			allMarkers[i].setMap(null); 
    		}
    		allMarkers=[];
    	} 
    	function clearMyMarkers() {
    		console.log("clearMyMarkers......");
    		for(i=0;i<myMarkers.length;i++){
    			myMarkers[i].setMap(null);	
    		}
    		myMarkers=[];
    	}
		function clearRouteLines() {
    		console.log("clearRouteLines......");
    		for(i=0;i<routeLines.length;i++){
    			routeLines[i].setMap(null);
    		}
    		routeLines=[];
    	}
		
		
		function getCityRouteList( planId ){
			console.log("getCityRouteList("+ planId +") 실행! ");
			
			$.ajax({
				url: "/planSub/json/getCityRouteList/"+planId ,
				method: "GET",
				dataType: "json",
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				success: function(JSONData, status){
					if( JSONData==null || JSONData=="" ){
						console.log("리턴데이터 없음");	
						clearMyMarkers();
						clearRouteLines();
						
					}else{
						console.log("리턴데이터 있음! => "+JSON.stringify(JSONData) );	
						
						var bounds = new google.maps.LatLngBounds();
						clearMyMarkers();
						clearRouteLines();
						
						var cityMarkerList = JSONData;
						
						for( var i in JSONData ){
							
							var getPosition = new google.maps.LatLng( JSONData[i].cityLat , JSONData[i].cityLng );
							
							var getMyMarker = createMyMarker2( JSONData[i].cityName, JSONData[i].country, getPosition, JSONData[i].cityImg, JSONData[i].cityInfo );
							getMyMarker.setMap(map);
							myMarkers.push(getMyMarker);
							
							if( i > 0 ){
								var path = [ myMarkers[i-1].getPosition() , myMarkers[i].getPosition() ];
								routeLines[i-1] = new google.maps.Polyline({
									map: map,
									strokeColor: '#8A8A8A',
							        strokeOpacity: 1.0,
							        strokeWeight:2,
							        geodesic: false,
							        icons: [{
							            icon: lineSymbol2,
							            offset: '95%'
							        }
							        /*,{
							            icon: seagull,
							            offset: '100%'
							        }*/
							        ]
								});
								routeLines[i-1].setPath(path);
							}
							bounds.extend(getMyMarker.getPosition()); 
						}
						map.fitBounds(bounds);
						
						if( cityMarkerList.length == 0 ){
							setTimeout(function(){
								map.setCenter(frankfurt);
								map.setZoom(5);
							}, 30);
						}else if( cityMarkerList.length < 2 ){
							setTimeout(function(){
								map.setZoom(5);
							}, 30);
						}
						
					}
					animateCircle(routeLines);
				},
				error:function(request,status,error){
					console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			    } 
			}); //ajax
			
		} //getCityRouteList( planId )
		
		
		var shape2 = {
	    			coords: [1, 1, 1, 12, 12, 12, 12, 1],
	    	        type: 'poly'
    	        };
	 	
		
		
		function createMyMarker2( city, country, mPosition, img, cityInfo ){
    		console.log("create My Marker2.... city="+city+", country="+country+", mPosition="+mPosition+", img="+img+", cityInfo="+cityInfo );
    		
    		var myIcon2 = new google.maps.MarkerImage("/resources/images/icon/circle_blue.png", null, null, null, new google.maps.Size(12,12));
    		var myIconn = new google.maps.MarkerImage("/resources/images/icon/pin-red2.png", null, null, null, new google.maps.Size(22,22));
    		
    		
    		var myMarker = new google.maps.Marker({
				position: mPosition,
				icon: myIconn,
				/* icon: {
		            path: google.maps.SymbolPath.CIRCLE,
		            scale: 5,
		            strokeWeight:1
		        }, */
				//shape: shape2,
				title: city
				, zIndex: 2000 
				, animation: google.maps.Animation.BOUNCE
			});
    		
    		
    		
    		google.maps.event.addListener(myMarker, 'click', function() {
				console.log("city name = "+myMarker.title);
				
				if(prv_infowindow){ prv_infowindow.close(); }
				
				//var markerLatLng = new google.maps.LatLng( mPosition.lat() , mPosition.lng() );		//구글의 함수로 만든 LatLng 객체라서 lat() 이런식의 함수로 수 뽑아줘야 함
				//console.log(mPosition.lat()+"/"+mPosition.lng() );
				
				var infowindow = new google.maps.InfoWindow();
				
				var contentHtml = '<div class="media" style="width:300px; height:120px; padding:5px;">';
				contentHtml = contentHtml + '<img class="align-self-start mr-2" src="/resources/images/cityImg/'+img+'" width="60px" height="60px">';
				contentHtml = contentHtml + '<div class="media-body">';
				contentHtml = contentHtml + '<h5 class="mt-0">'+ city +  '<div class="badge badge-primary text-wrap" style="width: 3rem; margin-left:10px; margin-top:0;" onClick="addCityRoute(\'' + myMarker.title + '\' )">'+'추가'+'</div>'  +'</h5>';
				
				contentHtml = contentHtml + '<p style="font-weight:900;font-size:14px;"> 여행루트에 추가된 도시입니다</p>';
				contentHtml = contentHtml + '<p>'+  cityInfo  +'</p>';
				contentHtml = contentHtml + '</div>';
				contentHtml = contentHtml + '</div>';
				
				infowindow.setContent(contentHtml);
				infowindow.setPosition(myMarker.position);	//infowindow.setPosition(markerLatLng);
				infowindow.open(map);
				
				prv_infowindow = infowindow;
			}); 
    		
    		return myMarker;
	    } //createMyMarker( city, country, mPosition, img, cityInfo )
		
	    
	    // Use the DOM setInterval() function to change the offset of the symbol
	    // at fixed intervals.
	    function animateCircle(routeLines) {
	        var count = 0;
	        var index = 0;
	        
	        /*
	        window.setInterval(function() {
	        	
	        	
	        	count = (count + 1) % 200;
	
		          var icons = routeLines[index].get('icons');
		          
		          
		          
		          
		          console.log( " icons : "+JSON.stringify(icons) );
		          //icons : [{"icon":{"path":2,"fillColor":"#8A8A8A","fillOpacity":1,"strokeWeight":2,"scale":2,"rotation":0,"anchor":{"x":0,"y":0}},"offset":"95%"},{"icon":{"path":0,"scale":8,"strokeColor":"#393"},"offset":"33.5%"}]
		          
		          var newOffset = (count / 2);
		          
		          if( newOffset >= 99.5 ){
		        	  if( index < routeLines.length ){
		        		  var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon":{"path":0,"scale":0},"offset":"'+ newOffset + '%' +'"}'+"]";
		        		  //var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon":"seagullImg","offset":"'+ newOffset + '%' +'"}'+"]";
		        		  
				          //icons = JSON.parse(jsonStr);
		        		  
				          icons[1].offset = (count / 2) + '%';
				          
				          routeLines[index].set('icons', icons );
			        	  
			        	  index = index + 1;
			        	  if( index == routeLines.length ){
			        		  index = 0;
			        	  }
			        	  newOffset = 0;
		        	  }
		          }
		          
		          //var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon":{"path":0,"scale":9,"strokeColor":"#00CDD5"},"offset":"'+ newOffset + '%' +'"}'+"]";
		          //var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon": "http://192.168.0.60:8080/resources/images/icon/_logo.png" ,"offset":"'+ newOffset + '%' +'"}'+"]";
		          
		          //icons = JSON.parse(jsonStr);
		          
		          
		          icons[1].offset = (count / 2) + '%';
		          routeLines[index].set('icons', icons);
		          
	      	}, 20);
	        */
	        
	        
	        window.setInterval(function() {
	        	  count = (count + 1) % 200;
		          var icons;
		          icons = routeLines[index].get('icons');
		          //console.log( " icons : "+JSON.stringify(icons) );
		          //icons : [{"icon":{"path":2,"fillColor":"#8A8A8A","fillOpacity":1,"strokeWeight":2,"scale":2,"rotation":0,"anchor":{"x":0,"y":0}},"offset":"95%"},{"icon":{"path":0,"scale":8,"strokeColor":"#393"},"offset":"33.5%"}]
		          
		          var newOffset = (count / 2);
		          
		          if( newOffset >= 99.5 ){
		        	  if( index < routeLines.length ){
		        		  var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon":{"path":0,"scale":0},"offset":"'+ newOffset + '%' +'"}'+"]";
		        		  
				          icons = JSON.parse(jsonStr);
		        		  routeLines[index].set('icons', icons );
			        	  
			        	  index = index + 1;
			        	  if( index == routeLines.length ){
			        		  index = 0;
			        	  }
			        	  newOffset = 0;
		        	  }
		          }
		          
		          var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon":{"path":0,"scale":9,"strokeColor":"#00CDD5"},"offset":"'+ newOffset + '%' +'"}'+"]";
		          //var jsonStr = "[ "+JSON.stringify(icons[0]) + ',{"icon": "http://192.168.0.60:8080/resources/images/icon/_logo.png" ,"offset":"'+ newOffset + '%' +'"}'+"]";
		          
		          icons = JSON.parse(jsonStr);
		          routeLines[index].set('icons', icons);
		          
	      	}, 20);
	        
	    }
		
		
		/* icon 사용을 위한 스크립트 */
		/* https://github.com/feathericons/feather#feather 참고 */
		feather.replace();
		
		//$($('.tran_type')[0]).hide();	//맨 밑으로 보내야함(초기설정 위해)
		
		
	</script>
	
	<!-- Google Map API -->
	<!-- <script async defer src="https://maps.googleapis.com/maps/api/js?key=" type="text/javascript"></script> -->
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCMoE1_1g-id6crD_2M4nCDF4IsmcncLU4&callback=initMap" type="text/javascript"></script>


</head>
<body ><!-- onload="initializeMap()" -->

	<!-- 화면구성 div Start ///////////////////////////// -->
	<!-- <div class="container"> -->
		<!-- 다단 레이아웃 Start ///////////////////////////// -->
		<div class="boxx">
		
			
			<!-- 좌측 컨테이너 Start ///////////////////////////// -->
			<div id="city_route_list_container" style="width: 25%; height:100%; float: left; border-right: 1 #C9C9C9 solid; margin-left: 0px;margin-top: 0px;">
				
				<!-- 좌측 컨테이너 상단 plan_info Start ///////////////////////////// -->
				<div class="plan_info" style="background-color: #E1F4F9; width: 100%; padding: 5px; height: 16%; border: 2px solid white;">
				
					<div class="media" style="width: 100%;height:100%; padding: 10px;">
					
						<img src="/resources/images/planImg/${plan.planImg}" class="align-self-center mr-2" alt="img loading.." style="border-width: 1px; border-color: #D1D1D1; border-style: solid; width: 90px; height: 90px;">

						<div class="media-body">	
						
						    <div style="margin-left: 13px;height: 100px; font-size: 13px;">
						    	<span style="color: #EE0D0D; font-weight: bolder;"><c:if test="${plan.planStatus == 'C'}">여행완료!</c:if> </span>
						    	<div class="plan_type plan_buttons">
									<c:choose>
										<c:when test="${plan.planType == 'A'}">여자혼자</c:when>
										<c:when test="${plan.planType == 'B'}">남자혼자</c:when>
										<c:when test="${plan.planType == 'C'}">여자끼리</c:when>
										<c:when test="${plan.planType == 'D'}">남자끼리</c:when>
										<c:when test="${plan.planType == 'E'}">단체</c:when>
										<c:when test="${plan.planType == 'F'}">부모님과</c:when>
										<c:when test="${plan.planType == 'G'}">커플</c:when>
									</c:choose>
									
									<%-- <span class="float-right">
										<i id="updatePlanButton" class="fas fa-globe-europe" style="font-size: 15px;"></i>
										<c:if test="${ user.userId == plan.planMaster.userId }">
											<i id="deletePlanButton" class="fas fa-globe-asia" style="font-size: 15px;"></i>
										</c:if>
										<c:if test="${ user.userId != plan.planMaster.userId }">
											<i id="exitPlanButton" class="fas fa-globe-asia" style="font-size: 15px;"></i>
										</c:if>
										<i id="planCompleteButton" class="fas fa-globe-asia" style="font-size: 15px;"></i>
									</span> --%>
								</div>
								
							      <div style="margin: 3px 0;">
							      		<div style="font-weight: bolder; font-size: 19px; display: inline-block;">${plan.planTitle} </div> &emsp;
							      			<c:if test="${plan.planPartySize > 1}"><span data-feather="users"></span></c:if>
							                <c:if test="${plan.planPartySize == 1}"><span data-feather="user"></span></c:if> ${plan.planPartySize}
							      </div>
							      ${plan.startDateString.substring(0,10)} <c:if test="${plan.endDate != null}"> ~ ${plan.endDate.substring(0,10)}</c:if> <!--  ( ${plan.planTotalDays}일 ) &nbsp;&nbsp;&nbsp;&nbsp;  -->
							      <c:if test="${plan.planDday == 0}"> D-Day </c:if>
							      <c:if test="${plan.planDday > 0}"> D - ${plan.planDday} </c:if>
						    </div>
						    
						</div> <!-- media body -->
						
					</div>
					
				</div>
				<!-- 좌측 컨테이너 상단 plan_info End ///////////////////////////// -->
				
				
				<!-- 좌측 컨테이너 하단 city_route Start ///////////////////////////// -->
				<div class="city_route_container" style="background-color: #FFFFFF; width: 100%; height: 84%; overflow: hidden auto;">
				
					<div class="city_route_list ui-sortable">
						<c:if test="${!empty plan.cityList}">
							<c:forEach var="cityRoute" items="${plan.cityList}">
								
								<!-- city_route item  start /////////////////////////////////////////////////////// -->
								<%-- <div class="city_route"  style="margin: 5px; padding: 5px; border: 1px solid gray; background-color: white;">
									<span class="float-right" onclick="deleteCityRoute('${cityRoute.cityId}',${plan.cityList.indexOf(cityRoute)} )">X</span>
									<button type="button" class="close" aria-label="Close" onclick="deleteCityRoute('${cityRoute.cityId}',${plan.cityList.indexOf(cityRoute)} )"> <span aria-hidden="true">&times;</span> </button>
									<div class="trans">
										<div class="tran_type" style="border-bottom: 1px solid red;">
											<c:choose>
												<c:when test="${cityRoute.tranType == 'T'}">기차 <i class="fas fa-train" style="font-size: 30px;"></i></c:when>
												<c:when test="${cityRoute.tranType == 'B'}">버스 <i class="fas fa-bus" style="font-size: 30px;"></i></c:when>
												<c:when test="${cityRoute.tranType == 'A'}">항공 <i class="fas fa-plane" style="font-size: 30px;"></i></c:when>
												<c:when test="${cityRoute.tranType == 'F'}">페리 <i class="fas fa-ship" style="font-size: 30px;"></i></c:when>
												<c:when test="${cityRoute.tranType == 'E'}">기타 <i class="fas fa-guitar" style="font-size: 30px;"></i></c:when>
												<c:when test="${empty cityRoute.tranType || cityRoute.tranType == ''}">ㄴㄴ<i class="fas fa-plus" style="font-size: 30px;"></i></c:when>
											</c:choose>
										</div>
									</div>
									<div>
										<div class="cr_cityName">${cityRoute.cityName}</div>
										방문순서: <span class="visit_order">${cityRoute.visitOrder}</span> , 도시ID: <span class="city_id">${cityRoute.cityId}</span>
										<div class="cr_term">${cityRoute.startDateStr} ~ ${cityRoute.endDateStr}</div>
									</div>
									<div class="cr_cityDuration">city_duration: ${cityRoute.cityDuration}</div> 
								</div> --%>
								<!-- city_route item   end ////////////////////////////////////////////////////////// -->
								<!-- ---------------------------------------------------------------------------------------------------------------------- -->
								
								
								<!-- city_route item  NEW  start /////////////////////////////////////////////////////// -->
								<div class="city_route">
									
									<!-- tran_type -->
									<div class="trans d-flex justify-content-center"><!-- 가운데 정렬 -->
										<a class="tran_a" href="javascript:showUpdateTranType('${cityRoute.cityId}','${cityRoute.tranType}')">
											<font class="tran_type" style="font: 7px gray;"><!-- div 안들어가서 font로.. -->
												<c:choose>
													<c:when test="${cityRoute.tranType == 'T'}">기차 <i class="tran_icon fas fa-train"></i></c:when>
													<c:when test="${cityRoute.tranType == 'B'}">버스 <i class="tran_icon fas fa-bus"></i></c:when>
													<c:when test="${cityRoute.tranType == 'A'}">항공 <i class="tran_icon fas fa-plane"></i></c:when>
													<c:when test="${cityRoute.tranType == 'F'}">페리 <i class="tran_icon fas fa-ship"></i></c:when>
													<c:when test="${cityRoute.tranType == 'E'}">기타 <i class="tran_icon fas fa-guitar"></i></c:when>
													<c:when test="${empty cityRoute.tranType || cityRoute.tranType == ''}">선택<i class="tran_icon fas fa-plus"></i></c:when>
												</c:choose>
											</font>
										</a>
									</div>
									
									<!-- X 버튼 -->
									<button type="button" class="close hide" aria-label="Close" onclick="deleteCityRoute('${cityRoute.cityId}',${plan.cityList.indexOf(cityRoute)} )"><span aria-hidden="true">&times;</span></button>
									
									
									<!-- city_route 정보 -->
									<div class="media mt-4" style="border: 1px solid #CDD8D8; border-radius:3px; padding: 12px 30px 5px 30px;"> <!-- 상 우 하 좌 -->
										<!-- hidden 정보 (방문순서, 도시ID) -->
										<div hidden="hidden">방문순서: <span class="visit_order">${cityRoute.visitOrder}</span> , 도시ID: <span class="city_id">${cityRoute.cityId}</span></div>
										<img alt="" src="/resources/images/planImg/defaultPlanImage.jpg" class="align-self-center mr-3 city_img" style="width: 50px; height: auto;" hidden="hidden">
										
										<div class="media-body">
											<div class="cr_cityName mt-0">${cityRoute.cityName}</div>
											<p class="cr_term">${cityRoute.startDateStr} ~ ${cityRoute.endDateStr}</p>
										</div> <!-- media-body -->
									
										<a href="javascript:showUpdateCityDuration('${cityRoute.cityId}','${cityRoute.cityDuration}')" class="city_duration_wrap">
										<div class="cr_cityDuration_parent rounded-circle">
											<span class="cr_cityDuration">${cityRoute.cityDuration-1}</span>박
										</div>
										</a>
									</div> <!-- media -->
								
								</div>
								<!-- city_route item  NEW  end ////////////////////////////////////////////////////////// -->
								
								
							</c:forEach>
						</c:if>
						
						
					</div> 
					<!-- city_route_list end -->
					
					<div style="height: 50px;">
					
					</div>
					
					<!-- <div id="addCityRoute_here" class="text-center" style="margin: 20px 40px; padding: 20px; border: 1px solid white; border-radius:5px; background-color: #7DCFCA;">
						도시 추가하기
					</div> -->
					
				</div>
				<!-- 좌측 컨테이너 하단 city_route End ///////////////////////////// -->
				
			</div>
			<!-- 좌측 컨테이너 End ///////////////////////////// -->
			
			
			
			<!-- 지도 컨테이너 Start ///////////////////////////// -->
			<div id="map_container" style="width: 75%;height:100%;float: left;">
				<div id="map" style="border:1px solid #e5e5e5;width:100%;height: 100%;"></div>
			</div>
			<!-- 지도 컨테이너 End ///////////////////////////// -->
			
			
			
		</div>
		<!-- 다단 레이아웃 End ///////////////////////////// -->
	<!-- </div> -->
	<!-- 화면구성 div End ///////////////////////////// -->



	<!-- /////////////////////	Modal : updateTranModal 	///////////////////// -->
	<div class="modal fade" id="updateTranModal" >
	  <div class="modal-dialog modal-lg">
	  <h4 style="color: #FFFFFF; margin-top: 100px;">이동수단 변경</h4>
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <div class="modal-title">
	       		<span id="startCity"></span> - <span id="endCity"></span> 교통편 선택
	        </div>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="closeModal('updateTranModal')">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
	      	<div hidden="hidden" id="update_city_id"></div>
	      	<div class="container">
	      		<div class="row d-flex justify-content-center">
	      			<div class="tran_circle" id="tran_type_T"><i class="tran_icon2 fas fa-train"></i><br/>기차</div>
					<div class="tran_circle" id="tran_type_B"><i class="tran_icon2 fas fa-bus"></i><br/>버스</div>
					<div class="tran_circle" id="tran_type_A"><i class="tran_icon2 fas fa-plane"></i><br/>항공</div>
					<div class="tran_circle" id="tran_type_F"><i class="tran_icon2 fas fa-ship"></i><br/>페리</div>
					<div class="tran_circle" id="tran_type_E"><i class="tran_icon2 fas fa-guitar"></i><br/>기타</div>
					<!-- <div class="tran_circle"><i class="tran_icon2 fas fa-plus"></i><br/>선택</div> -->
	      		</div>
	      	</div>
	      </div>
	      <!-- <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('updateTranModal')">Close</button>
	        <button type="button" class="btn btn-primary" id="submitDaily">Edit Daily</button>
	      </div> -->
	    </div>
	  </div>
	</div>
	<!-- /////////////////////	Modal : updateTranModal 끝	///////////////////// -->


	<!-- /////////////////////	Modal : updateDurationModal 	///////////////////// -->
	<div class="modal fade" id="updateDurationModal" >
	  <div class="modal-dialog modal-lg">
	  <h4 style="color: #FFFFFF; margin-top: 100px;">체류기간 변경</h4>
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <div class="modal-title">
	       		<span id="durationCityName"></span> 체류기간 선택
	        </div>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="closeModal('updateDurationModal')">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
	      	<!-- <div hidden="hidden" id="update_city_id"></div> -->
	      	<div class="container">
	      		<div class="row d-flex justify-content-center">
	      			<div class="dura_circle" id="dura_1">무박</div>
	      			<div class="dura_circle" id="dura_2">1박</div>
	      			<div class="dura_circle" id="dura_3">2박</div>
	      			<div class="dura_circle" id="dura_4">3박</div>
	      			<div class="dura_circle" id="dura_5">4박</div>
	      			<div class="dura_circle" id="dura_6">5박</div>
	      			<!-- <div class="dura_circle" id="dura_n">선택</div> -->
	      		</div>
	      	</div>
	      </div>
	      <!-- <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('updateDurationModal')">Close</button>
	      </div> -->
	    </div>
	  </div>
	</div>
	<!-- /////////////////////	Modal : updateDurationModal 끝	///////////////////// -->
	


	<!-- <div style="position: absolute; top: 10px; right: 20px; background-color: white; border: 1px solid; width: 200px; height: 300px;"> 
		테스트용 창<br/> 
		00: <span id="s00">01</span><br/>
		<div id="click" style="border: 1px solid gray; background-color: black; padding: 10px;" onclick="clearRouteLines()">clearButton</div>
	</div> -->
	
	

	<script type="text/javascript">
	
		/* icon 사용을 위한 스크립트 */
		/* https://github.com/feathericons/feather#feather 참고 */
		feather.replace();
	
		$($('.tran_type')[0]).hide();
		
	</script>
	
	
	
	
	
	
	<script type="text/javascript">
	
		var windowHeight = $(window).height();
		console.log(windowHeight)
		$('.boxx').height(windowHeight);
		
		$(function() {
			$(window).resize( function(){
				windowHeight = $(window).height();
				$('.boxx').height(windowHeight);
			});
			
		});
		
		
	</script>
	
	
</body>
</html>