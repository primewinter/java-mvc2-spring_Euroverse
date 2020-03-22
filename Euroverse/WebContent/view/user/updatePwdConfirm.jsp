<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Euroverse</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script>
	$(function(){
		$("#goMain").on("click",function(){
			$(self.location).attr("href","/main.jsp");
		})
	})
</script>

</head>
<body>
	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
	<div class="container" style="margin-top: 70px;">
		<p style="font-size:30px;text-align:center; margin-top: 50px; margin-bottom: -20px" >
		비밀번호변경완료했습니다.
		<br><hr style="width: 530px;margin-bottom: -5px;">
		<small style="margin-left:300px; "></small>
		</p>
		<div >
			<div style="text-align: center;">
				<button type="button" class="btn btn-outline-primary" id="goMain">메인화면</button>
			</div>
		</div>
	</div>
</body>
	<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>