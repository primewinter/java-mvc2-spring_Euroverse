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

.a{
	padding: 3px;
}
.b{
	padding: 3px;
}


.inner{
	display: inline-block;
	background-color: white;
	border-bottom-left-radius : 15px;
	border-bottom-right-radius : 15px;
	box-shadow : 5px 5px 7px #C3C0C0;
	height: 100%;
	width:100%;
	margin-bottom: 10px;
}
</style>


<script type="text/javascript">

	/* ss초전 mm분전 hh시간전 구하는 코드  */
	/* function fn_dateTimeToFormatted(dt) {
		var min = 60 * 1000;
		var c = new Date()
		var d = new Date(dt);
		var minsAgo = Math.floor((c - d) / (min));

		var result = {
			'raw': d.getFullYear() + '-' + (d.getMonth() + 1 > 9 ? '' : '0') + (d.getMonth() + 1) + '-' + (d.getDate() > 9 ? '' : '0') +  d.getDate() + ' ' + (d.getHours() > 9 ? '' : '0') +  d.getHours() + ':' + (d.getMinutes() > 9 ? '' : '0') +  d.getMinutes() + ':'  + (d.getSeconds() > 9 ? '' : '0') +  d.getSeconds(),
			'formatted': '',
		};

		if (minsAgo < 60) { // 1시간 내
			result.formatted = minsAgo + '분 전';
		} else if (minsAgo < 60 * 24) { // 하루 내
			result.formatted = Math.floor(minsAgo / 60) + '시간 전';
		} else { // 하루 이상
			result.formatted = Math.floor(minsAgo / 60 / 24) + '일 전';
		};

		return formatDate;
	};
	//end 시간구하기

	/* //=============    검색 / page 두가지 경우 모두  Event  처리 =============	 */
	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method" , "GET").attr("action" , "/admin/getAdminQnAList").submit();
	};//end of getUserList(CurrentPage)
	
	
	/*======== 검색시 페이지를 1페이지로 돌리기위해] =============  */
	$(function() {
		 $( ".form-control" ).change(function() {
		 	fncGetUserList(1);
		 }); 
	});//end of function */
	
	
	 function close(){
     	$("#con").remove();
     }
	
	//관리자가 리스트를 클릭했을경우 상세보기
		function getAdminQnaList(postId,postContent,qnaFirstCate,postWriterId) {
			
			if(qnaFirstCate == "A"){
				
				qnaFirstCate = '주문관련';
			}
			if(qnaFirstCate == "B"){
				
				qnaFirstCate = '상품관련';
			}
			if(qnaFirstCate == "C"){
				
				qnaFirstCate = '기타';
			}
        
			var display = 
				'<div id="con" class="container">'+
			        '<div class="inner" id="inner'+postId+'">'+
			            '<div style="padding:10px 25px" class="row">'+
			                '<div style="margin:8px;text-align:right;display: inline-block; height: auto; width: 105px;">'+
			                    '<img id="qimg" style="width:40px; "alt="" src=\"/resources/images/admin/Qicon.png"\></div>'+
//            '<div>'+
			                    '<div style="width: 600px; height:20px; margin: 10px 5px 5px 29px;">'+postContent+'</div>'+
//			                    '<div style="height:20px; font-size:9pt;font-family:돋움; color:#4EC2F8; height:20px; margin: 2px 5px 5px 5px;">'+qnaFirstCate+'</div>'+
//			                    '<div style="font-size:11pt; color: rgb(240, 168, 72);"><i class="fas fa-clock"></i>'+postWriterId+'님이 ㅇ분전에 질문하셨습니다.</div>'+
//                                '</div>'+
                        '</div></div>';
			           
        
	    	$("#con").remove();//다른 게시글을 클릭할경우 이전태그 지움
	        $("#"+postId+"").html(display);//게시글을 클릭할경우 태그 어펜드
			 
	        	$.ajax({
					url: "/admin/json/getQnaCommentList/"+postId,
					method: "GET",
					dataType: "json",
					headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
					success: function(JSONData, status){
						
						if( JSONData==null || JSONData=="" ){
							console.log("리턴데이터 없음");	
						}else{
							console.log("리턴데이터 있음! => ");
                            console.log(JSONData.list.length);
							if(JSONData.list.length != 0){
                                var date = new Date(JSONData.list[0].cmtDate);
                                
					            var appendHtml =
									'<div id="delCmt" style="padding:5px 25px" class="row">'+
									'<div style="display: inline-block; height: auto; width: 110px;"></div>'+
									'<div style="margin:8px;text-align:right;display: inline-block; height: 70px; width: 70px;">'+
						            '<img style="width:40px;" src="/resources/images/admin/Aicon.png"></div>'
                                    +'<div>'+
						            '<div class="qnaComment" style="width: 600px; height:auto; margin: 10px 5px 5px 20px;">'+JSONData.list[0].cmtContent+
						            '<br><br><span style="color:darkgray">'+
                                    date.getFullYear()+"년 "+parseInt(date.getMonth()+1)+"월 "+date.getDate()+"일 "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+'</span><button type="button" class="btn btn-outline-danger btn-sm" style="margin-left:5px;" onclick="deleteCmt('+JSONData.list[0].cmtId+','+JSONData.list[0].postId+')">삭제</button></div>'+'</div></div>';
//						            '<div style="height:20px; font-size:9pt;font-family:돋움; color:#4EC2F8; height:20px; margin: 2px 5px 5px 5px;">관련</div>'+
//						            '<div style="font-size:11pt; color: rgb(240, 168, 72);"><i class="fas fa-user-clock"></i>분전에 답변하셨습니다.</div>'+
						        	
                                
						         	
							 $("#inner"+postId).append(appendHtml);
                            
							} else {
                                
                                var adminReply = '<div id="append" style=" height: auto; padding:15px 25px" class="row">'+
                                    '<div style="display: inline-block; height: auto; width: 110px;"></div>'+
			                         '<div style="text-align:right;display: inline-block; height: 70px; width: 70px;">'+
			                         '<img style="width:40px;" src=\"/resources/images/admin/Aicon.png"\></div><div>'+
			                         '<div style="width: 600px; height:100%; margin: 0px 5px 5px 10px;"><textarea id="content" class="form-control" style="min-height: 100px;margin-left:20px;">'+
			                         '</textarea></div></div><div>'+
			                         '<button type="button" class="btn btn-info btn-sm" onclick="answer('+postId+')" style=" margin-left:20px; height:auto; display: inline-block">등록</button></div>'+
			                         '</div></div></div></div>';
                                $("#inner"+postId).append(adminReply);
                            }
						}//end of else
					    
					},//end of success
						
					error:function(request,status,error){
				        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
				    }// end of error  
					    
				 });// end of ajax
		};//end of getAdminQnaList
					            
	
	
	
	//관리자의 1:1문의 답변 관리자가 한 문의당 답변을 한개만 달수있도록 로직짜놓음
	function answer(postId){ 
		
       	var cmtContent = $('#content').val().replace(/\n/g,"<br>");
       	$('#content').val('');	
       	
       	 $.ajax({
			url: "/admin/json/addQnaComment",
			method: "POST",
			dataType: "json",
			headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
			data:JSON.stringify({
				postId: postId,
				cmtWriterId : 'admin',
				nickName:'Euroverse',
		 		cmtContent : cmtContent
			}),
			success: function(JSONData, status){
				//restController에서 comments에 값이 이미 존재하면 error메세지를 보냄 
				if(JSONData.returnMsg=='error'){
					
					alert("답변은 한개만 가능합니다.")
				
				//답글이 하나도 없으면 ajax 실행
				}else if(JSONData.returnMsg=='ok'){
					
					if( JSONData==null || JSONData=="" ){
						console.log("리턴데이터 없음");	
					}else{
						console.log("리턴데이터 있음! => "+JSONData);
                        var date = new Date(JSONData.list[0].cmtDate);
				        var appendHtml =
									'<div id="delCmt" style="padding:5px 25px" class="row">'+
									'<div style="display: inline-block; height: auto; width: 110px;"></div>'+
									'<div style="margin:8px;text-align:right;display: inline-block; height: 70px; width: 70px;">'+
						            '<img style="width:40px;" src="/resources/images/admin/Aicon.png"></div>'
                                    +'<div>'+
						            '<div class="qnaComment" style="width: 600px; height:auto; margin: 10px 5px 5px 20px;">'+JSONData.list[0].cmtContent+
						            '<br><br><span style="color:darkgray">'+
                                    date.getFullYear()+"년 "+parseInt(date.getMonth()+1)+"월 "+date.getDate()+"일 "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+'</span><button type="button" class="btn btn-outline-danger btn-sm" style="margin-left:5px;" onclick="deleteCmt('+JSONData.list[0].cmtId+','+JSONData.list[0].postId+')">삭제</button></div>'+'</div></div>';
						         	
                        $("#append").hide();
                        $("#inner"+postId).append(appendHtml);
                        $("#badge"+postId).removeClass('badge-secondary');
                        $("#badge"+postId).addClass('badge-success');
                        $("#badge"+postId).html('답변완료');
					
					}// end of else
				}//end of elseIf
						
			},// end of success
			error:function(request,status,error){
		        console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
		    }// end of error  
					
		});// end of ajax
			
	};//end of fuction
        
		
	function deleteCmt(cmtId, postId){
        $('#delCmt').hide();
		$.ajax({
			url: "/admin/json/deleteQnaComm",
			method: "POST",
			headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
			data: JSON.stringify({
				postId: postId,
				cmtId : cmtId
			}),
            success : function() {
                
                var adminReply = '<div id="append" style=" height: auto; padding:15px 25px" class="row">'+
                                    '<div style="display: inline-block; height: auto; width: 110px;"></div>'+
			                         '<div style="text-align:right;display: inline-block; height: 70px; width: 70px;">'+
			                         '<img style="width:40px;" src=\"/resources/images/admin/Aicon.png"\></div><div>'+
			                         '<div style="width: 600px; height:100%; margin: 0px 5px 5px 10px;"><textarea id="content" class="form-control" style="min-height: 100px;margin-left:20px;">'+
			                         '</textarea></div></div><div>'+
			                         '<button type="button" class="btn btn-info btn-sm" onclick="answer('+postId+')" style=" margin-left:20px; height:auto; display: inline-block">등록</button></div>'+
			                         '</div></div></div></div>';
                $("#inner"+postId).append(adminReply);
                $("#badge"+postId).removeClass('badge-success');
                $("#badge"+postId).addClass('badge-secondary');
                $("#badge"+postId).html('답변없음');
            },
            error : function(err, status) {
                console.log(err+status);
            }

		});
		
	};//end deleteCmt()
	
</script>



</head>


<body>

    <jsp:include page="/toolbar/toolBar.jsp"></jsp:include> 
    <jsp:include page="/toolbar/pushBar.jsp"></jsp:include> 


	<div onclick='close()' class="container" style="width:70%;margin:auto;">
	
	<div class="page-header text-info">

		<div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;color:black;">
        1:1 문의 목록
		</div><span style="font-size: 15px;font-family: 'NIXGONM-Vb';color:black;"> >>전체 ${resultPage.totalCount}개</span>
	
	 </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
	    	<!-- 검색조건 총 몇 건, 현재 페이지 나타내는 글씨  -->
		    <div class="col-md-6 text-left">
<!--
		    	<p style="font-size:10pt;">
		    		Total  ${resultPage.totalCount }
		    	</p>
-->
		    </div>
		    
		    
		    <div class="col-md-6 text-right d-flex justify-content-end">
		    
		    <!-- =========================== 검색조건 선택창 =========================== -->
		     <form class="form-inline" name="detailForm">
			      <input type="hidden" id="qnaFirstCate" name="qnaFirstCate" value="${param.qnaFirstCate}"/>
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" style="height: 30px; width: 120px; font-size: 13px; margin-right: 2px;" >
						<c:if test="${empty search.searchCondition }">
						<option class="from-option" value="" >전체</option>
						<option class="from-option" value="A" >주문관련</option>
						<option class="from-option" value="B" >상품관리</option>
						<option class="from-option" value="C" >기타</option>
						</c:if>
						
						<c:if test="${!empty search.searchCondition }">
						<option class="from-option" value="" >전체</option>
						<option class="from-option" value="A"  ${ ! empty search.searchCondition && search.searchCondition=='A' ? "selected" : "" }>주문관련</option>
						<option class="from-option" value="B"  ${ ! empty search.searchCondition && search.searchCondition=='B' ? "selected" : "" }>상품관련</option>
						<option class="from-option" value="C"  ${ ! empty search.searchCondition && search.searchCondition=='C' ? "selected" : "" }>기타</option>
						</c:if>
					</select>
				  </div>
				   <!-- ======================== 검색조건 선택창 끝  ========================= -->
		    
		      		<!-- 돋보기 아이콘  fontawesome.com-->
				  &nbsp;&nbsp;<i class="fas fa-search" style="font-size: x-large"></i>
				  
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
	    	 </form>
	    	</div>
		</div>
		
		
		
		
		<div class="table-responsive">
		
			<table class="table table-hover">
	        <thead>
		        <tr class="top shadow-sm p-3 mb-5 bg-white rounded " style="font-size:small;">
		            <th scope="col" style= "width:7%;">번호</th>
		            <th scope="col" style= "width:7%;">상태</th>
		            <th scope="col" style= "width:50%; text-align:center;">제목</th>
		            <th scope="col" style= "width:10%;">분류</th>
		            <th scope="col" style= "width:10%;">글쓴이</th>
		            <th scope="col"	style="width:10%;">날짜</th>
		          </tr>
	        </thead>
	        
		<!-- ========테이블 내용 시작 ========== -->
			<tbody class="userTab" style="font-size: small;">
			  <c:set var="i" value="0" />
			  <c:forEach var="post" items="${list }">
				<c:set var="i" value="${i+1 }" />
				<tr>
				
				<!-- 게시글번호 -->
				  <td class="no" >${ i }</td>
				    
				  <td class="state" style="font-weight: bold; color: dimgray;">
					  <c:if test="${post.postGrade != 'Q' }">
			   				<span id="badge${post.postId}" class="badge badge-pill badge-secondary">답변없음</span>
			   			 </c:if>	
						<c:if test="${post.postGrade == 'Q' }">
			   			<span id="badge${post.postId}" class="badge badge-pill badge-success">답변완료</span>
				   		</c:if>
				  </td>
				  
				  <td class="postclick"  onclick="getAdminQnaList('${post.postId}','${post.postContent}','${post.qnaFirstCate}','${post.postWriterId}')" style="text-align: left;">
				  <input type="hidden" id="postId" name="postId" value="${post.postId}"/>
				  <input type="hidden" id="postContent" name="postContent" value="${post.postContent}"/>
				  <input type="hidden" id="qnaCate" name="qnaCate" value="${post.qnaFirstCate}"/>
				  <input type="hidden" id="userId" name="userId" value="${post.postWriterId}"/>
				  ${post.postTitle}</td>
				  <td> 
				   <c:if test="${post.qnaFirstCate == 'A' }">
                                        주문관련 >
                    </c:if>
                    <c:if test="${post.qnaFirstCate == 'B' }">
                        상품관련 >
                    </c:if>
                    <c:if test="${post.qnaFirstCate == 'C' }">
                        기타
                    </c:if>
                    <c:if test="${post.qnaSecondCate=='D'}">
                        결제
                    </c:if>
                    <c:if test="${post.qnaSecondCate=='E'}">
                        환불
                    </c:if>
                    <c:if test="${post.qnaSecondCate=='F'}">
                        항공권
                    </c:if>
                    <c:if test="${post.qnaSecondCate=='G'}">
                        숙소
                    </c:if>
					</td>  
				  <td>${post.postWriterId }</td>
				  <td><c:set var="regDate" value="${fn:split(post.postDate,' ')}"></c:set>
					<c:out value="${regDate[0]}"></c:out></td>
				</tr>
				<tr>
	          		<td id="${post.postId}" colspan="6" bgcolor="#E6E2E2" style="margin:0px;padding:0px 0px 0px 0px;"></td>
	          	</tr>
	          </c:forEach>
	     		
			</tbody>
			</table>
				<!-- ========== 테이블 내용 끝 ============ -->
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