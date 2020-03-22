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
		$(".nav-link:contains('비밀번호찾기')").addClass("disabled");
	});

	window.onload = function(){
		var pwd = document.getElementById("pwd");
		var pwdConfirm = document.getElementById("pwdConfirm");
		var h6 = document.getElementsByTagName("h6");
		var updatePwd = document.getElementById("updatePwd");
		var firstPwd = $("#firstPwd");
		var secondPwd = $("#secondPwd");
		pwd.onkeyup = function(event) {
			if(pwd.value.length<6 || pwd.value.length>20){
				firstPwd.html("비밀번호는 6자~20자 입니다.");
				return;
			}else if(/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/.test(pwd.value) == false){
					firstPwd.html( "비밀번호는 최소 하나의 소문자,대문자 와 숫자가 포함되어야 합니다.");
				return;
			}else{
				firstPwd.html("");
			}
			
		}
		pwdConfirm.onkeyup = function(event){
			if(pwd.value != pwdConfirm.value){
				secondPwd.html("비밀번호가 일치하지 않습니다.");
			}else{
			    h6[1].innerHTML = " ";
			    if(pwdConfirm.value.length<6 || pwdConfirm.value.length>20){
			    
			    }else{
			    	secondPwd.html("");
			    }
			}
			
		}	
		document.getElementById('updatePwd').onclick = function() {
			
			if(pwd.value != pwdConfirm.value){
				swal({
					  icon : 'warning',
					  title : "비밀번호가 일치하지 않습니다.",
					  text:" ",
					  button : false,
				})
			}else if( pwd.value.length < 6 || pwd.value.length > 20){
				swal({
					  icon : 'warning',
					  title : "비밀번호는 6~20자입니다.",
					  text:" ",
					  button : false,
				})
			}else if(/^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,20}$/.test(pwd.value) == false){
				swal({
					  icon : 'warning',
					  title : "비밀번호는 최소 하나의 소문자,대문자 와 숫자가 포함되어야 합니다.",
					  text:" ",
					  button : false,
				})
			}else{
				var form = $("#pwdUpdateForm")
				form.attr("action","/user/updatePwd");
				form.attr("method","post");
				form.submit();
			}
		}
	}
</script>

</head>
<body>
	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>

	<div class="container" style="margin-top: 70px;">
		<p style="font-size:30px;margin-left:300px; margin-top: 50px; margin-bottom: -20px" >
			비밀번호변경
			<br><hr style="width: 530px;margin-bottom: -5px;">
			<small style="margin-left:300px; ">새로운 비밀번호를 입력해주세요.</small>
		</p>

		<form  id="pwdUpdateForm">
			<div class="row">
				<div style="width: 300px;"></div>
				<div class="form-group" style="width: 540px;">
					<input type="hidden" name="userId" id="userId" value="${userId}">
					변경할 비밀번호<input type="password" class="form-control"  name="pwd" id="pwd">
					<div id="firstPwd" style="height: 20px; color: red;"></div>
					<br>				
					변경할 비밀번호 확인<input type="password" class="form-control"  id="pwdConfirm">
					<div id="secondPwd" style="height: 20px; color: red;"></div>
					<br>
									
					<div style="text-align: center;">
					<input type="button"  class="btn btn-outline-primary" id="updatePwd" value="비밀번호 변경">
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
	<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>