<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        
<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="EUC-KR">
<title>Euroverse</title>

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- 부트스트랩 4.4 쓰려다가 빠꾸...............................했다가 다시 4.4로..  -->
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script> -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link href="https://fonts.googleapis.com/css?family=Monoton" rel="stylesheet">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>



	<!-- boot strap File upload CDN  -->
	<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.js"></script>

	<!-- FontAwesome CDN -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	
	<!-- jquery Ui 링크 (datePicker)  -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!--datePicker CDN  -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	


	<!-- ICON 사용을 위한 스크립트 임포트 -->
	<!-- https://feathericons.com/ -->
	<script src="https://unpkg.com/feather-icons"></script>

	<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
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
      
      .modal .ui-datepicker{
      	z-index: 2147483647!important
      }
      
      
      
       .custom-file-input ~ .custom-file-label::after {
		    content: "image";
		}
		
	</style>


	<script type="text/javascript">
	
		$(function(){
			
			$('.showAddPlanModal').on('click', function(){
				//$('#addPlanModal').show();
			});
			
			$('#addPlan').on('click', function(){
				addPlan();
			});
			
			$('#showUpdateSlotModal').on('click', function(){
				//$('#updateSlotModal').show();
			});
			
			$('#updateUserSlot').on('click', function(){
				updateUserSlot();
			});
			
			$('div.plan').on('click', function(){
				var planId = $(this).children('div .planId').text().trim();
				var string = "/plan/getPlan?planId="+planId;
				$(self.location).attr("href", string);
			});
			
			
			$( "#startDateString" ).datepicker({
			      showOptions: { direction: "up" },
				  //defaultDate : '1995-02-10',
			      changeYear : true ,
			      changeMonth : true ,
			      //buttonImage: "/resources/images/userImages/CalendarICON.png",
			      dateFormat : "yy-mm-dd",
			      showAnim : "bounce",
			      autoclose: true
			});
			
			/* 모달 뒤에 데이트피커가 가려지는 현상... 어거지로 해결 */
			$('#startDateString').on('click', function(){
				 $('#ui-datepicker-div').appendTo($('#addPlanModal'));
				 $(this).datepicker();
				 $(this).datepicker("show");
			});


			//지성이꺼 갖다씀 - 파일용량 체크
			$(".custom-file-input").on("change",function(){
				  var fileSize = this.files[0].size;
				    var maxSize = 600 * 600;
				    if(fileSize > maxSize) {
				        $(".custom-file-label").html("<i class='fas fa-camera-retro'> size 600x600</i>");
				        alert("파일용량을 초과하였습니다.");
				        //$("#preview").html("");
				        return;
				    }else{
						//readImg(this);
				    }
			});
			
			$(document).ready(function() {
				  bsCustomFileInput.init();
			});
			
			//alert-danger에서 x 클릭시 창 닫기
			$(".alert-danger button").on("click",function(){
				$(".alert-danger").prop("style","display:none");			
			})
			
			$(document).on('keyup','#planTitle',function(){
				if($('#planTitle').val().length > 0){
					$(".alert-danger").prop("style","display:none");	
				}
			});
			$(document).on('change','#startDateString',function(){
				if($('#startDateString').val().length > 0){
					$(".alert-danger").prop("style","display:none");	
				}
			});
			
		});
			
		function addPlan(){
			console.log("addPlan 실행");
			
			var submitAlert = $(".alert-danger");
			var alertMessage = $(".alert-danger strong");
			
			var userId = $("input[name='userId']").val();
			var planTitle = $("input[name='planTitle']").val();
			var planImg = $("input[name='planImg']").val();
			var planType = $("input[name='planType']").val();
			var startDateString = $("input[name='startDateString']").val();
			
			//유효성 체크
			if ($.trim(planTitle)=="") {
				submitAlert.prop("style","display : block");
				alertMessage.html("플래너 제목은 필수입니다.");
				return;
			}
			if($.trim(planTitle).length > 20 ){
				submitAlert.prop("style","display : block");
				alertMessage.html("플래너 제목은 20자 이하로 입력해주세요.");
				return;
			}
			if ($.trim(startDateString)=="") {
				submitAlert.prop("style","display : block");
				alertMessage.html("여행 시작일을 지정해주세요.");
				return;
			}
			
			$('form.addPlanModal').attr('method', 'POST').attr("action" , "/plan/addPlan").attr("enctype","multipart/form-data").submit();
		}
		
		
		function showEditPlan(indexOfPlan){
			
			alert(indexOfPlan);
			planId = '10000';
			
			/* $.ajax({
				url: "/plan/json/getPlan/"+planId ,
				method: "GET",
				dataType: "json",
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				success: function(JSONData, status){
					alert("리턴값 있음 => "+JSON.stringify(JSONData));
				},
				error:function(request,status,error){
			        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			    } 
			}); */
			
			$('#editPlan').show();
		}
		
		function updatePlan(){
			alert("updatePlan() 실행!");
		}
		
		
		function updateUserSlot(){
			var userId = '${user.userId}';
			var userSlot = '${user.slot}';
			console.log("updateUserSlot() 실행! userId="+userId+", slot="+userSlot);
			
			var string = "/plan/updateUserSlot?userId="+userId;
			$(self.location).attr("href", string);
		}
		
	</script>
	
	<script>
		
		/* 모달창 닫기 */
		function closeModal(modalName) {
			console.log("closeModal : modalName="+modalName);
			if( typeof $("."+modalName)[0] != "undefined" ){
				$("."+modalName)[0].reset();		//form에 모달 이름과 같은 클래스명 주기
			}
			//$("#"+modalName).hide();
		}
		
	</script>


</head>
<body>
	
	<!-- ToolBar 시작 -->
	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<!-- ToolBar 끝 -->
	
	<%-- <a href="/index.jsp" >다시 메인으로</a><br/>
	userId = ${user.userId} , userSlot = ${user.slot} , user.totalPoint = ${user.totalPoint} <br/><br/> --%>
	
	<div class="album py-5">
		<div class="container">
			<div class="row">
				<div  class="align-bottom"  style="font-size:20px;margin:0 0 15px 30px;"><b style="font-size:22px;">${user.nickname}</b> 님의 유럽여행  <span style="font-size:13px;color:#838383;margin-left:30px;"> ${list.size()} 개의 플래너</span></div>
			</div>
			
			<div class="row">
			
			
				<c:if test="${list.size() != 0}">
					<c:forEach var="plan" items="${list}">
						
						<div class="col-md-4 plan">
							<div class="planId" hidden="hidden">${plan.planId}</div>
				          
				          <div class="card mb-4 shadow-sm">
				          
				            <%-- <svg class="bd-placeholder-img card-img-top" width="100%" height="200" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: Thumbnail">
					            <rect width="100%" height="100%" fill="#99E1FF"/>
					            <image xlink:href="/resources/images/planImg/${plan.planImg}" x="0" y="0" height="230" width="100%"/>
					            <text x="50%" y="50%" fill="#eceeef" dy=".3em">${plan.planTitle}</text>
					        </svg> --%>
					        
					        <img style="border-top-right-radius:3px;border-top-left-radius:3px;" width="100%" height="200px" src="/resources/images/planImg/${plan.planImg}"/>
					        
				            
				            <div class="card-body">
				              	<div class="d-flex justify-content-between align-items-center">
				              		<div style="font-weight: 500; color: #6D6D6D;">
						              	<c:if test="${plan.planDday < 0}"> &nbsp; </c:if>
							            <c:if test="${plan.planDday == 0}"> D-Day </c:if>
										<c:if test="${plan.planDday > 0}"> D-${plan.planDday} </c:if>
										<c:if test="${plan.planStatus == 'C'}"><span style="color: #EE0D0D; font-weight: bolder;">여행완료!</span></c:if>
						            </div>
						            
						            
									<!-- <div class="plan_type" style="border: 1px solid blue;border-radius: 5px;"> -->
									<span class="badge badge-primary" style="padding: 5px;">
										<c:choose>
											<c:when test="${plan.planType == 'A'}">여자혼자</c:when>
											<c:when test="${plan.planType == 'B'}">남자혼자</c:when>
											<c:when test="${plan.planType == 'C'}">여자끼리</c:when>
											<c:when test="${plan.planType == 'D'}">남자끼리</c:when>
											<c:when test="${plan.planType == 'E'}">단체</c:when>
											<c:when test="${plan.planType == 'F'}">부모님과</c:when>
											<c:when test="${plan.planType == 'G'}">커플</c:when>
										</c:choose>
									</span>
				              	</div>
					            <div class="card-text">
					            	<div style="font-weight: bolder; font-size: large; margin: 15px 3px;"> ${plan.planTitle}</div>
						            <div>${plan.startDateString} <c:if test="${plan.endDate != null}"> ~ ${plan.endDate} </c:if></div>
						            <div> 
						            	 <c:if test="${plan.planTotalDays!=0}"> ${plan.planTotalDays-1} 박 ${plan.planTotalDays} 일 </c:if>&nbsp;
						            </div>
						            <br/>
						        </div>
				              
					            <div class="d-flex justify-content-between align-items-center">
					              	<div class="btn-group">
					                	<%-- <button type="button" class="btn btn-sm btn-outline-secondary" onClick="showEditPlan('${list.indexOf(plan)}')">Edit</button> --%>
					                </div>
					                <div>
						                <c:if test="${plan.planPartySize > 1}"><span data-feather="users"></span></c:if>
						                <c:if test="${plan.planPartySize == 1}"><span data-feather="user"></span></c:if>
						                 ${plan.planPartySize}
					                </div>
					            </div>
				            </div><!-- card-body end -->
				            
				          </div>
				        </div>
				        
					</c:forEach>		
				</c:if>
			
				<!-- 플래너 등록 버튼 -->
				<c:if test="${!empty user.slot }">
					<c:forEach var="i" begin="1" end="${user.slot - list.size()}">
						<div class="col-md-4" >
				          <div class="card mb-4 shadow-sm showAddPlanModal" data-toggle="modal" data-target="#addPlanModal">
				          
				            <div class="card-body">
				              <div class="card-text text-center"><br/><span data-feather="plus-circle"></span><br/><br/>새로운 플래너 만들기<br/><br/> </div>
				            </div>
				            
				          </div>
						</div>
					</c:forEach>
				</c:if>
				
			
				<!-- 슬롯 추가 버튼 -->
				<div class="col-md-4">
		          <div class="card mb-4 shadow-sm" id="showUpdateSlotModal" data-toggle="modal" data-target="#updateSlotModal">
		            <div class="card-body">
		              <p class="card-text text-center"><br/><span data-feather="lock"></span><br/><br/>슬롯 늘리기<br/><br/> </p>
		            </div>
		          </div>
				</div>
			
			</div>
		</div>
	</div>
	
	
	<!-- Footer Start /////////////////////////// -->
	<jsp:include page="/toolbar/footer.jsp"></jsp:include>
	<!-- Footer End	/////////////////////////// -->
	
	
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
	
	<!-- /////////////////////	Modal : addPlan	///////////////////// -->
	<div class="modal fade" id="addPlanModal" >
	  <div class="modal-dialog">
	  <h4 style="color: #FFFFFF; margin-top: 100px;">플래너 만들기</h4>
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <h5 class="modal-title">새로운 플래너 등록해 여행을 준비해보세요</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="closeModal('addPlanModal')">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
	        
	        <form class="form-horizontal addPlanModal">
	        	<br/>
				<div class="form-group row">
				    <label for="planTitle" style="text-align: right;" class="col-sm-4 col-form-label ">플래너 제목</label>
				    <div class="col-sm-7">
				      <input type="text" class="form-control" id="planTitle" name="planTitle" placeholder="플래너 제목">
				    </div>
				</div>
				
				<div class="form-group row">
					<label for="planType" style="text-align: right;" class="col-sm-4 col-form-label ">여행 타입</label>
				    <div class="col-sm-7">
					    <select class="form-control" id="planType" name="planType">
							<option value="A">여자혼자</option>
							<option value="B">남자혼자</option>
							<option value="C">여자끼리</option>
							<option value="D">남자끼리</option>
							<option value="E">단체</option>
							<option value="F">부모님과</option>
							<option value="G">커플</option>
						</select>
					</div>
				</div>
				
				<div class="form-group row">
				    <label for="planImgFile" style="text-align: right;" class="col-sm-4 col-form-label ">플래너 이미지</label>
				    <div class="col-sm-7 custom-file">
				    	<div class="input-group mb-2">
				    		<input type="file" class="form-control custom-file-input" id="planImgFile" name="planImgFile" placeholder="플래너 이미지" accept="image/*">
				      		<label class="custom-file-label" for="customFile"><i class="fas fa-camera-retro"> size 360x360</i></label>  
				    		<div class="input-group-append">
						      	<div class="input-group-text"><i class="fas fa-camera-retro"></i></div>
						    </div>
				    	</div>
				    </div>
				</div>
				
				<div class="form-group row">
				    <label for="startDateString" style="text-align: right;" class="col-sm-4 col-form-label ">여행 시작일</label>
				    
				    <div class="col-sm-7">
					    <div class="input-group mb-2">
					      <input type="text" class="form-control" id="startDateString" name="startDateString" placeholder="여행 시작일" readonly="readonly">
					      <div class="input-group-append">
					      	<div class="input-group-text"><span data-feather="calendar"></span></div>
					      </div>
					    </div>
				    </div>
				</div>
				
				<div class="alert alert-danger alert-dismissable" style="display: none;" >
				    <button type="button" class="close" >×</button>
				    <strong></strong><br/>수정 후 다시 시도해주세요.
				</div>
				
	        </form>
	        
	      </div>
	      
	      <div class="modal-footer">
	        <!-- <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('addPlanModal')">Close</button> -->
	        <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('addPlanModal')">Close</button>
	        <button type="button" class="btn btn-primary" id="addPlan">Add Plan</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
	<!-- /////////////////////	Modal : addPlan	///////////////////// -->
	
	<!-- /////////////////////	Modal : editPlan 	///////////////////// -->
	<!-- 
	<div class="modal" id="editPlan">
	  <div class="modal-dialog" >
	  	<h4 style="color: #FFFFFF; margin-top: 100px;"> 플래너 수정</h4>
	  
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <div class="modal-title">
	        	<h6 style="margin-left:15px; align-self: center; font-weight: bolder;"><br/>플래너를 수정합니다</h6>
	        </div>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="closeModal('editPlan')">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
	        
	        <form class="form-horizontal editPlan" style="margin: 10px;">
	        	
				
	        </form>
	        
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('editPlan')">Close</button>
	        <button type="button" class="btn btn-primary" id="updatePlan">수정</button>
	      </div>
	    </div>
	  </div>
	</div>
	-->
	<!-- /////////////////////	Modal : editPlan 끝	///////////////////// -->
	
	<!-- /////////////////////	Modal : 슬롯 늘리기 	///////////////////// -->	
	<div class="modal fade" id="updateSlotModal">
	  <div class="modal-dialog" >
	  	<h4 style="color: #FFFFFF; margin-top: 100px;"> 슬롯 구매</h4>
	  
	    <div class="modal-content">
	    
	      <div class="modal-header">
	        <!-- <div class="modal-title">
	        	<h6 style="margin-left:15px; align-self: center; font-weight: bolder;"><br/>친구를 초대해 플래너를 함께 작성하고 여행을 떠나보세요</h6>
	        </div> -->
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="closeModal('updateSlotModal')">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body text-center">
	        <br/>
	        <c:if test="${ empty user.totalPoint || user.totalPoint < 500 }">
	        	 <span style="font-size:17px;"> 플래너 슬롯을 구매하기 위해선</span><br/>
				 <span style="font-size:17px;">보유 포인트가 500P 이상이어야 합니다</span><br/><br/>
	        </c:if>
	        <c:if test="${user.totalPoint >= 500 }">
	        	<span style="font-size:17px;"> 플래너 슬롯을 늘리시겠습니까?</span><br/>
	         	<span style="font-size:17px;"> 현재 보유하고 계신 ${user.totalPoint}P 중 500P 를 사용합니다</span><br/><br/>
	        </c:if>
	      </div>
	      
	      <div class="modal-footer">
	      	<c:if test="${user.totalPoint >= 500 }">
	      		<button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('updateSlotModal')">아니오</button>
	      		<button type="button" class="btn btn-primary" id="updateUserSlot">예</button>
	      	</c:if>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- /////////////////////	Modal : 슬롯 늘리기 끝	///////////////////// -->

	
	
	
	<script>
	
		/* icon 사용을 위한 스크립트 */
		/* https://github.com/feathericons/feather#feather 참고 */
		feather.replace();
		
	</script>


</body>
</html>