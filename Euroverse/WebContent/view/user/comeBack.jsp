<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ ! empty user }">
	<jsp:forward page="/main.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Euroverse</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />


<script type="text/javascript">
	$(function(){
		var userId = $("#comeBackUserId");
		var pwd = $("#comeBackPwd");
		
		$("#comeBack").on("click",function(){
			$.ajax({
				url : "/user/json/login",
				method : "post",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					userId : userId.val(),
					pwd : pwd.val()
				}),
				success : function(JSONData){
					if(JSONData.result == 'ok'){
						swal({
						   icon : 'warning',
						  title : "탈퇴한 회원이 아닙니다.",
						  text:" ",
						  button : false,
						})
						return;
									
					}else if(JSONData.result=='unReg'){
						if(JSONData.checkPwd == null||JSONData.checkPwd==""){
							swal({
								   icon : 'warning',
								  title : "비밀번호가 틀렸습니다.",
								  text:" ",
								  button : false,
							})
							return;
						}
						pwd.attr("readonly","true");
						$("#comeBackDiv").css("display","none");
						$("#nicknameDiv").css("display","block");
						$("#realComeBackDiv").css("display","block");
						
					}else if(JSONData.result =='errorId'){
						alert("존재하지 않는 아이디입니다.");
					}else if(JSONData.result =='errorPwd'){
						alert("비밀번호가 틀렸습니다.");
					}else{
						alert("띠용");
					}
				}//success
			})//ajax
			
		})
	})

	$(function(){
		$("#realComeBack").on("click",function(){
		var nickname = 	$("#comeBackNickname");
			 $.ajax({
				url : "/user/json/checkDuplicate",
				method : "post",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data : JSON.stringify({
					nickname : nickname.val()
				}),
				success : function(JSONData){
					if(JSONData.result == 'ok'){
				
						 
						swal({
							   icon : 'success',
							  title : "복구 완료했습니다.",
							  text:" ",
							  button : false,
							})
				    	setTimeout(function() {     
							$("#comeBackForm").attr("action","/user/comeBack").attr("method","post").submit();
				    	}, 700);
						
						
				}else{
						swal({
						   icon : 'warning',
						  title : "중복된 닉네임입니다.",
						  text:" ",
						  button : false,
						})
					}
				}//success
			})//ajax 
		})
		
		$(document).on('keyup','#comeBackNickname',function(){
			var nickname = 	$("#comeBackNickname");
			var errorNickname = $("#errorNickname")
			for(var i=0;i<nickname.val().length;i++){
				if(nickname.val()[i] == " "){
					nickname.val(nickname.val().replace(" ", ""));
				}
			}
			if(nickname.val().length <2 || nickname.val().length > 10){
				errorNickname.html("닉네임은 2~10자 입니다.");
			}else{
				errorNickname.html("");
			}
			
			if(nickname.val().length >=2 || nickname.val().length <= 10){
	
				$.ajax({
					url : "/user/json/checkDuplicate",
					method : "post",
					dataType : "json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data : JSON.stringify({
						nickname : nickname.val()
					}),
					success : function(JSONData){
						if(JSONData.result == 'ok'){
							//h6[4].innerHTML ="";
						}else{
							/* swal({
								   icon : 'warning',
								  title : "중복된 닉네임입니다.",
								  text:" ",
								  button : false,
								}) */
							errorNickname.html("중복된 닉네임입니다.");
						}
					}//success
				})//ajax
			}
		})
	})

</script>


</head>


<body>
	<jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
	<jsp:include page="/toolbar/pushBar.jsp"></jsp:include>
	
	<form id="comeBackForm" >
		<div class="container" style="margin-top: 70px;">
			<p style="font-size:30px;margin-left:300px; margin-top: 50px; margin-bottom: -20px" >
				아이디 복구하기<br>
				<hr style="width: 530px;margin-bottom: -5px;">
				<small style="margin-left:300px; ">기존에 사용하던 아이디를 복구합니다.</small>
			</p>
		
			<div class="row">
					<div style="width: 300px;"></div>
					<div class="form-group" style="width: 540px;">
						아이디
						<input type="text" class="form-control" readonly="readonly"  name="userId" id="comeBackUserId" value="${userId}">
						<div id="errorId" style="height: 20px; color: red;"></div>
						<br>				
						
						비밀번호
						<input type="password" class="form-control" placeholder="기존에 사용하던 비밀번호를 입력해주세요." id="comeBackPwd"  name="pwd">
						<div id="errorPwd" style="height: 20px; color: red;"></div>
						<br>
						
						<div id="nicknameDiv" style="display: none;">
							닉네임
							<input type="text" class="form-control"  name="nickname" id="comeBackNickname">
							<div id="errorNickname" style="height: 20px; color: red;"></div>
							<br>	
						</div>
						
						<div id="comeBackDiv" style="text-align: center;">
							<input type="button"  class="btn btn-outline-primary" id="comeBack" value="확인">
							<button type="button" class="btn btn-outline-secondary">취소</button>
						</div>
						
						<div id="realComeBackDiv" style="display: none;">
							<input type="button"  class="btn btn-outline-primary" id="realComeBack" value="복구">
							<button type="button" class="btn btn-outline-secondary">취소</button>
						</div>
					</div>
			</div>
		</div>
	</form>
</body>
<jsp:include page="/toolbar/footer.jsp"></jsp:include>
</html>