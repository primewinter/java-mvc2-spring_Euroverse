<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>


 <!-- : http://getbootstrap.com/css/  -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	
	
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- =========================================================================================  -->
	
	
	
	<!-- 글씨체 때문에 걸어둔 link -->
	<link href='https://fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
	 <!-- =========================================================================================  -->
	 
	 
	 
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<!-- <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" ></script> -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- ===================================================================================  -->
	<!-- =================================================================================== -->
	
	

	<!-- fontawesome CDN -->
	<!-- <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
	<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
	 -->
 
	 <!-- 부트스트랩 아이콘 사용 cdn fontawesome.com  -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />


	<!-- CSS 속성값 -->
	<style>
		
		/*include한 툴바 ui 설정값  */
		.tollbar{
			padding: 15px;
		}
		
		h3{
		font-size: 27px;
		}
		/* 이거 왜안되지?????????  */
		table thead > tr{
			border-color: blue;
		}
		.text-right{
			padding : 8px;
		}
		.table-hover{
		}
		
		.text-primary{
			font-size: 14px;
		}
        .badge {
            font-size: 100%;
        }
	</style>


	<script type="text/javascript">

	/* //=============    검색 / page 두가지 경우 모두  Event  처리 =============	 */
	 function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "POST").attr("action" , "/admin/getUserList").submit();
	};//end of getUserList(CurrentPage)
	 
	
	/*======== 검색시 페이지를 1페이지로 돌리기위해] =============  */
	$(function() {
		 $( ".fas.fa-search" ).on("click" , function() {
		 	fncGetUserList(1);
		 }); 
	});//end of function
	
	/*===== 회원상제정보 조회 ===========  */
	$(function() {
		 $( "td:nth-child(2)" ).on("click" , function() {
			 alert('click?');
			 var userId = $(this).find($("input[name='userId']")).val();
			 self.location = "/admin/getUser?userId="+userId;
		 }); 
	});/*========= end of function =========*/
	
	
	/*===== 회원상제정보 조회 ajax 처리시 ajax처리가 tag append방식이여서 기본 설정으로 읽을수가 없음....===========  */
	function getUser(userId){
			 self.location = "/admin/getUser?userId="+userId;
	}/*========= end of function =========*/
	
	
	$(function() {
		 
		$(".form-control").keyup(function(){
			
			var searchCondition = $(".form-control option:selected").val();
			var searchKeyword = $("#searchKeyword").val();
			
			// 회원목록을 검색할 경우 
			$.ajax({
				url: "/admin/json/getUserList",
				method: "POST",
				dataType: "json",
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				data: JSON.stringify({
					searchKeyword: searchKeyword,
			 		searchCondition: searchCondition  
				}),
				success: function(JSONData, status){
					if( JSONData==null || JSONData=="" ){
						console.log("리턴데이터 없음");	
					}else{
						console.log("리턴데이터 있음! => "+JSONData);	
						
						//html을 새로 append하기위해 ""만듬
						$('.userTab').children().remove();
						
						for(var i=0; i<JSONData.list.length; i++){
							
							//milliSeconds 시간을 date에 담아서 재대로된 시간으로 표현하기 위한 방법
							var regdate = new Date(JSONData.list[i].regDate);
							var splitDate = regdate.getFullYear()+"-";
							if(parseInt(regdate.getMonth())<9){
								splitDate += "0"+parseInt(regdate.getMonth()+1)+"-";
							}else{
							splitDate += regdate.getMonth()+1+"-";
							}
							if(parseInt(regdate.getDate())<9){
								splitDate += "0"+parseInt(regdate.getDate());
							}else{
								splitDate += regdate.getDate();
							}
							
							//var splitDate = regDate.split(' ');
							//alert(splitDate);
							
							//회원등급 플래그 값을 결과값으로 넣기위한  if문
							
							var stringRole = '';
							
							if(JSONData.list[i].role == 'Q'){
								stringRole = '<div style=": #17a2b8;" class="badge badge-info">인증회원</div>'; 
							}else if(JSONData.list[i].role = 'G'){
								stringRole = '<div class="badge badge-light">비인증회원</div>';
							}else if(JSONData.lsit[i].role == 'A') {
								stringRole = '<div class="badge badge-warning">관리자</div>';
							}else if(JSONData.list[i].role == 'X' ){
								stringRole = '<div class="badge badge-dark">탈퇴회원</div>'
							}
							
							var appendHtml = "<tr>"+
												"<th style='text-align:right;' scope='row'>"+(i+1)+"</th>"+
												"<td style='text-align:center; font-weight: bold; color: dimgray;'>"+JSONData.list[i].userId+
												"</td>"+
												"<td>"+JSONData.list[i].userName+"</td>"+
												"<td>"+stringRole+"</td>"+
												"<td>"+JSONData.list[i].nickname+"</td>"+
												"<td>"+JSONData.list[i].totalPoint+"</td>"+
												"<td>"+JSONData.list[i].sex+"</td>"+
												"<td>"+splitDate+"</td></tr>";
												
							$('.userTab').append(appendHtml);
						}/* end of for  */
					}/* end of else  */
					
				},/* end of seccess  */
				
				error:function(request,status,error){
			        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
			    }/* end of error  */
			});/* end of ajax  */
		}); /* keyUp event end  */
		
	}); /* function end  */
		
</script>



</head>


<body>

	<!-- =============== 유로버스 툴바 인클루드  ========== -->
		<jsp:include page="/toolbar/toolBar.jsp"></jsp:include> 
	<!-- =========== 이까지  ================ -->
	
	<!-- 푸쉬바 인클루드  -->
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
	<!-- 인클루드 end--> 
		

	<div class="container" style="width:70%;margin:auto;">
		
	<div class="page-header">

		<div class="h4 viewPost" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;opacity: 1;border-bottom: 1px solid white;">
              회원 목록
            </div><span style="font-size: 15px;font-family: 'NIXGONM-Vb';color:black;"> >>전체 ${resultPage.totalCount}명</span>
	
	 </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
	    	<!-- 검색조건 총 몇 건, 현재 페이지 나타내는 글씨  -->
		    <div class="col-md-6 text-left">
		    	<p class="">
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right d-flex justify-content-end">
		    
		     <!-- =========================== 검색조건 선택창 =========================== -->
			    <form class="form-inline" name="detailForm">
			      <input type="hidden" id="boardName" name="boardName" value="${param.boardName}"/>
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" style="height: 30px; width: 85px; font-size: 13px; margin-right: 2px;" >
						<c:if test="${empty search.searchCondition }">
						<option class="from-option" value="0" selected="selected" >아이디</option>
						<option class="from-option" value="1" >닉네임</option>
						<option class="from-option" value="2" >이름</option>
						</c:if>
						
						<c:if test="${!empty search.searchCondition }">
						<option class="from-option" value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>아이디</option>
						<option class="from-option" value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>닉네임</option>
						<option class="from-option" value="2"  ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>이름</option>
						</c:if>
					</select>
				  </div>
				  <!-- ======================== 검색조건 선택창 끝  ========================= -->
				  
				  <!-- ========================== 유저를 검색할수 있는 검색창 ================================   -->
				  <div class="form-group ">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }" 
				    			 style="height: 30px; font-size: 13px;" onkeydown="javascript:if(event.keyCode == 13) {fncGetUserList(1)}">
				  </div>
				  <!--======================== 유저검색창 끝  =========================================== -->
				
				  <!-- 돋보기 아이콘  fontawesome.com-->
				  &nbsp;&nbsp;<i class="fas fa-search" style="font-size: x-large"></i>
				 
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		
		<div class="table-responsive">
		
		<!-- =============================== 유저목록 게시판 테이블  시작 ============================-->
			<table class="table table-hover">
	        <thead>
		        <tr class="top shadow-sm p-3 mb-5 bg-white rounded " style="font-size:small;">
		            <th style="text-align:right;" scope="col">번호</th>
		            <th style="text-align:center;" scope="col">회원아이디</th>
		            <th scope="col">회원이름</th>
		            <th scope="col">회원등급</th>
		            <th scope="col">닉네임</th>
		            <th scope="col">포인트</th>
		            <th scope="col">성별</th>
		            <th scope="col">등록일자</th>
		          </tr>
	        </thead>
		
			<tbody class="userTab" style="font-size: small;">
			  <c:set var="i" value="0" />
			  <c:forEach var="user" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <th style="text-align:right;" scope="row">${ i }</th>
				  <td style="text-align:center; font-weight: bold; color: dimgray;">
				  ${user.userId}
				  <input type="hidden" id="userId" name="userId" value="${user.userId}"/></td>
				  <td>${user.userName}</td>
				  <c:if test="${user.role == 'Q' }">
				  <td><div style=": #17a2b8;" class="badge badge-info">인증회원</div></td>
				  </c:if>
				  <c:if test="${user.role == 'G' }">
				  <td><div class="badge badge-light">비인증회원</div></td>
				  </c:if>
				  <c:if test="${user.role == 'A' }">
				  <td><div class="badge badge-warning">관리자</div></td>
				  </c:if>
				  <c:if test="${user.role == 'X' }">
				  <td><div class="badge badge-dark">탈퇴회원</div></td>
				  </c:if>
				  <td>${user.nickname }</td>
				  <td>${user.totalPoint }</td>
				  <td>${user.sex }</td>
				  <td>
				  <c:set var="regDate" value="${fn:split(user.regDate,' ')}"></c:set>
					<c:out value="${regDate[0]}"></c:out></td>
				</tr>
	          </c:forEach>
		
			</tbody>

			</table>
			</div>
			<!--================================ 테이블끝   =====================================-->
		
	</div>
	<!-- ================== div : Container End  ================-->	
	
		<!-- pageNavigator include  -->
		<jsp:include page="../../common/pageNavigator_new.jsp"/>
		
		<!-- 푸터 인클루드  -->
		<jsp:include page="/toolbar/footer.jsp"></jsp:include>
		<!-- 인클루드 end--> 

</body>

</html>