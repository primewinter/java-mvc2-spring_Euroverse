<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

<script>
	var maPageCode = 'B';


	$(function(){
		$("tr.bookMark").on("click" , function() {
			var postId =  $(this).find('input[name="postId"]').val();
			var boardName = $(this).find('input[name="boardName"]').val();
            //alert('postId : '+postId+" , boardName = "+boardName);
			self.location ="/community/getPost?postId="+postId+"&boardName="+boardName;
		});
	})

	
	function getPost(postId , boardName){
		self.location ="/community/getPost?postId="+postId+"&boardName="+boardName;
	} 
	
	
	function deleteBookMark(postId){
		$.ajax({
			url : '/myPage/json/deleteBookMark/'+postId ,
			type : "GET" ,
			cache : false ,
			dataType : "json" ,
			success : function(JSONData) {
                $('#'+postId).css('display','none');
                
				/*var bookMarkList = JSONData.bookMarkList;
					$("tbody").html("");
				for(var i=0;i<bookMarkList.length;i++){
					$("tbody").append("<tr>");
					$("tbody").append("<th scope='row'>"+(i+1)+"</th>");
					var boardName= bookMarkList[i].boardName;
					var postId = bookMarkList[i].postId;
					$("tbody").append("<td><span onclick='javascript:getPost("+postId+",\""+boardName+"\")'>"+bookMarkList[i].postTitle.substring(0,35)+"</span> </td>");
					$("tbody").append("<td>"+bookMarkList[i].nickName+"</td>");
					$("tbody").append("<td><i id=deleteBookMark"+i+" class='fas fa-bookmark fa-2x' onclick='javascript:deleteBookMark("+bookMarkList[i].postId+")'></i></td>");
					$("tbody").append("<input type='hidden' value="+i+">");
					$("tbody").append("<input type='hidden' name='postId' value="+bookMarkList[i].postId+"/>");
					$("tbody").append("<input type='hidden' value="+bookMarkList[i].boardName+"/>");
					$("tbody").append("</tr>");
				}*/
				     
			},
			error: function(request, status, error){
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
</script>
<style>
    font.post-sm {
        font-size:9pt;
    }
</style>
</head>
<body>

	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>	
	
		<div class="row">
            <jsp:include page="/view/user/userSideBar.jsp"/>
            
        <div style="width:60%;margin-left:5%;">
        	<div class="container" style="width:100%;margin:auto;">
	
	
	    <!-- <h3  style="margin-left: 320px; width: 1000px"><b>나의 북마크목록</b></h3> -->
		<div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;">
			나의 북마크
		</div>
		
		
		<form id="myBookMarkListForm">
	 		<input type="hidden" id="currentPage" name="currentPage" value=0 /> 
		</form>
		
		<table class="table table-hover" style="font-size: 14px;text-align: center; ">
			  <thead>
			    <tr>
			      <th scope="col">게시판</th>
			      <th scope="col">제목</th>
			      <th scope="col">닉네임</th>
			      <th scope="col">작성일</th>
			      <th scope="col"></th>
			    </tr>
			  </thead>
	  			<tbody>
				  	<c:forEach var="bookMarkPost" items="${bookMarkList}" varStatus="status">
				  		<tr class="bookMark" id="${bookMarkPost.postId}">
				  			<td style="width:10%;">
                                <c:if test="${bookMarkPost.boardName=='A'}">
                                    자유게시판
                                </c:if>
                                <c:if test="${bookMarkPost.boardName=='B'}">
                                    여행정보
                                </c:if>
                                <c:if test="${bookMarkPost.boardName=='D'}">
                                    동행찾기
                                </c:if>
                                <c:if test="${bookMarkPost.boardName=='E'}">
                                    플래너 공유
                                </c:if>
                                <c:if test="${bookMarkPost.boardName=='F'}">
                                    여행후기
                                </c:if>
                                <c:if test="${bookMarkPost.boardName=='G'}">
                                    QnA
                                </c:if>
				  			</td>
				  			<c:set var="title" value="${bookMarkPost.postTitle}"/>
							<td style="width:50%;text-align: left;">${fn:substring(title,0,35)}
								<c:if test="${fn:length(title)>35}">
									......
								</c:if>
								<!--(${bookMarkPost.comments})-->
							</td>
				  			<td style="width:12%">${bookMarkPost.nickName}</td>
                            <td style="width:10%"><font class="post-sm">
                            <fmt:formatDate value="${bookMarkPost.postDate}" pattern="yyyy-MM-dd"/>
                            </font></td>
                            <td style="width:8%;padding:6px;"><font size="5px"><i id="deleteBookMark${status.index}" class="fas fa-bookmark" onclick="javascript:deleteBookMark(${bookMarkPost.postId})"></i></font></td>
				  			<input type="hidden" value="${status.index}">
				  			<input type="hidden" name="postId" value="${bookMarkPost.postId}"/>
				  			<input type="hidden" name="boardName" value="${bookMarkPost.boardName}"/>
				  		</tr>
				  	</c:forEach>
				  	
				  	<c:if test="${ empty bookMarkList}">
					    <tr><td colspan="4" style="padding: 40px;">북마크한 게시글이 없습니다</td></tr>
					</c:if>
				  	
				 </tbody>
		</table>
            </div>
            </div>
	</div>

</body>
	<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>