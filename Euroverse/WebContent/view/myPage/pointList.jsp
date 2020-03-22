<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${  empty user }">
	<jsp:forward page="/main.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Euroverse</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<script type="text/javascript">

	var maPageCode = 'P';

	function fncGetUserList(currentPage) {
		$("#currentPage").val(currentPage)
		$("#pointListForm").attr("method" , "POST").attr("action" , "/myPage/pointList").submit();
	}
	
	 $(function() {
		 
		 $("button:contains('적립')").on("click",function(){
			 $("input[name='searchKeyword']").val("save");
			 $("#pointListForm").attr("method" , "POST").attr("action" , "/myPage/pointList").submit();
			 
		 });
		 $("button:contains('차감')").on("click",function(){
			 $("input[name='searchKeyword']").val("use");
			 $("#pointListForm").attr("method" , "POST").attr("action" , "/myPage/pointList").submit();
			 
		 });
	 });
	 

</script>
<style>
    th, td {
        font-size: 0.9em;
    }
    div.info {
        display: none;
/*        display: inline-block;*/
        float: right;
        background-color:#97ebdb;
        border-radius: 10px;
        padding:1em;
        font-size: 10pt;
        font-family:'NIXGONM-Vb';
    }
</style>


</head>
<body>
	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>	
    <!-- <div style="height: 100px;"></div> -->

		<div class="row">
            <jsp:include page="/view/user/userSideBar.jsp"/>
            
        <div style="width:60%;margin-left:5%;">
	<div class="container" style="width:100%;margin:auto;">
	
	
	
		<table class="table table-hover" style="text-align: center;">
			<form id="pointListForm">
			 	<input type="hidden" id="currentPage" name="currentPage" value=0 /> 
			
				<div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;">
					보유포인트
				</div>
				<div class="info">
				    <p>* 포인트 적립 *</p>
				    1. 결제 시 실결제금액의 1%가 적립됩니다.<br/>
				    2. 출석체크 시 100포인트가 적립됩니다.
				</div>
				<!-- <h4 style="">보유포인트</h4> -->
				<h2 style="font-family:'NIXGONM-Vb';padding-left:10px;margin-bottom: 15px;">
					<b>
					<fmt:formatNumber value="${user.totalPoint}" pattern="###,###" />
					 Point</b> 
					<button type="button" class="btn btn-outline-warning waves-effect btn-sm ml-3">적립</button>
					<button type="button" class="btn btn-outline-warning waves-effect btn-sm">차감</button>
					<c:if test="${search.searchKeyword != null}">
						<c:if test="${search.searchKeyword =='save'}">
					 	 	<input type="hidden"  name="searchKeyword" value="save">
						</c:if>
						<c:if test="${search.searchKeyword =='use'}">
					 	 	<input type="hidden"  name="searchKeyword" value="use">
						</c:if>
					</c:if>	
					<c:if test="${search.searchKeyword == null}">
						<input type="hidden"  name="searchKeyword" value="">
					</c:if>  
				</h2>
			</form>
			  <thead>
			    <tr>
			      <!--<th scope="col"></th>-->
			      <th scope="col">사용일시</th>
			      <th scope="col">내용</th>
			      <th scope="col">적립/차감포인트</th>
			      <!--<th scope="col">사용일시</th>-->
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach var="point" items="${pointList}" varStatus="status">
				    <tr>
				     	<!--<th scope="row">${status.count}</th>-->
                        <td>
							<c:set var="pointDate" value="${fn:split(point.usedDate,' ')}"></c:set>
							<c:out value="${pointDate[0]}"></c:out>
						</td>   
				      	<!--<td>${point.usedData}</td>-->
				      	<td>${point.usedContent}</td>
				      	<c:if test="${point.usedData=='적립'}">
				      		<td><i class="fas fa-plus" style="font-size: 10px; vertical-align: middle;"></i><fmt:formatNumber value="${point.usedPoint}" pattern="###,###" /></td>
				      	</c:if>
			      		<c:if test="${point.usedData=='차감'}">
			      			<td><i class="fas fa-minus" style="font-size: 10px; vertical-align: middle;"></i><fmt:formatNumber value="${point.usedPoint}" pattern="###,###" /></td>
			      		</c:if>
					  
				    </tr>
			  	</c:forEach>
			  	
			  	<c:if test="${ empty pointList}">
				    <tr><td colspan="5" style="padding: 40px;">포인트 내역이 없습니다</td></tr>
				</c:if>
				
			  </tbody>
		</table>
	
		<jsp:include page="../../common/pageNavigator_new.jsp"/>
            </div>
            </div>
	</div>
</body>
	<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>