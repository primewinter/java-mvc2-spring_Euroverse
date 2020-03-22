<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   
<!DOCTYPE html>

<style>

.input-container{
	position:relative;
	margin-bottom:25px;
}
.input-container label{
	position:absolute;
	top:0px;
	left:0px;
	font-size:16px;
    pointer-event:none;
	transition: all 0.5s ease-in-out;
}
.input-container input{ 
  border:0;
  border-bottom:1px solid #555;  
  background:transparent;
  width:100%;
  padding:8px 0 5px 0;
  font-size:16px;
}
.input-container input:focus{ 
 border:none;	
 outline:none;
 border-bottom:1px solid #e74c3c;	
}
/* .btn{
	color:#fff;
	background-color:#e74c3c;
	outline: none;
    border: 0;
    color: #fff;
	padding:10px 20px;
	text-transform:uppercase;
	margin-top:50px;
	border-radius:2px;
	cursor:pointer;
	position:relative;
} */
/*.btn:after{
	content:"";
	position:absolute;
	background:rgba(0,0,0,0.50);
	top:0;
	right:0;
	width:100%;
	height:100%;
}*/
.input-container input:focus ~ label,
.input-container input:valid ~ label{
	top:-12px;
	font-size:12px;
	
}











#loginModal {
        text-align: center;
}
 
@media screen and (min-width: 768px) { 
        #loginModal:before {
                display: inline-block;
                vertical-align: middle;
                content: " ";
                height: 100%;
        }
}
 
#loginModalDialog {
        display: inline-block;
        text-align: left;
        vertical-align: middle;
}
   
</style>


<script>

    $(function() {
        // 네이버 아이디로 로그인 이미지 클릭 시 
        $("#naverLogin").on("click", function() {
        	
    		window.open("/view/user/openNaver.jsp",
					"popWin",
					"left=500, top=100, width=537, height=750, marginwidth=0, marginheight=0, fullscreen=no, scrollbars=yes, scrolling=yes, menubar=no, resizable=no");
/*             $.ajax({
                url: "/user/json/naverLoginUrlMake",
                method: "get",
                dataType: "json",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(JSONData) {
                    self.location = JSONData.url;
                }
            }) */
        })

        $("#googleLogin").on("click", function() {
        	window.open("/view/user/openGoogle.jsp",
					"popWin",
					"left=500, top=100, width=537, height=750, marginwidth=0, marginheight=0, fullscreen=no, scrollbars=yes, scrolling=yes, menubar=no, resizable=no");
          //  $(self.location).attr("href", "https://accounts.google.com/o/oauth2/v2/auth?scope=https://www.googleapis.com/auth/analytics.readonly&access_type=offline&include_granted_scopes=true&state=state_parameter_passthrough_value&redirect_uri=http://localhost:8080/user/googleLoginLogic&response_type=code&client_id=474522905430-f6nkrljp2qocnq1mop0ve2oc5ng91q38.apps.googleusercontent.com");
        
        
        })

/*         $("#kakaoLogin").on("click", function() {
            $.ajax({
                url: "/user/json/kakaoLoginUrlMake", // 단순 URL을 만들기 위한 UserController 
                method: "get", // 넘겨 줄 Data가 없으므로 get
                dataType: "json", // 받아 올 data의 Type을 json으로 설정 
                headers: { // dataType이 json이므로 받을 때(Accept)와 보낼 때(Content-Type)을 모두 application/json으로 설정  
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(JSONData) { // success 시, 
                    self.location = JSONData.url; // json/kakaoLoginUrlMake에서 return을 Map<String, String>으로 했으며
                }
            })
        }) */
        
        
        $("#kakaoLogin").on("click", function(){
				// 새로 팝업창에서 카카오 로그인을 진행하기 위해 아무 의미없는 jsp로 연결
				window.open("/view/user/openKakao.jsp",
						"popWin",
						"left=500, top=100, width=537, height=750, marginwidth=0, marginheight=0, fullscreen=no, scrollbars=yes, scrolling=yes, menubar=no, resizable=no");
			})
    })

 /*    $(document).ready(function() {      //아이디 저장하는 함수
        var userInputId = getCookie("userInputId"); //저장된 쿠기값 가져오기
        $("#loginUserId").val(userInputId);

        if ($("#loginUserId").val() != "") { // 그 전에 ID를 저장해서 처음 페이지 로딩
            // 아이디 저장하기 체크되어있을 시,
            $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
        }

        $("#idSaveCheck").change(function() { // 체크박스에 변화가 발생시
            if ($("#idSaveCheck").is(":checked")) { // ID 저장하기 체크했을 때,
                var userInputId = $("#loginUserId").val();
                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            } else { // ID 저장하기 체크 해제 시,
                deleteCookie("userInputId");
            }
        });

        // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
        $("#loginUserId").keyup(function() { // ID 입력 칸에 ID를 입력할 때,
            if ($("#idSaveCheck").is(":checked")) { // ID 저장하기를 체크한 상태라면,
                var userInputId = $("#loginUserId").val();
                setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
            }
        });
    }); 
    function setCookie(cookieName, value, exdays) {
        var exdate = new Date();
        exdate.setDate(exdate.getDate() + exdays);
        var cookieValue = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
        document.cookie = cookieName + "=" + cookieValue;
    }

    function deleteCookie(cookieName) {
        var expireDate = new Date();
        expireDate.setDate(expireDate.getDate() - 1);
        document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
    }

    function getCookie(cookieName) {
        cookieName = cookieName + '=';
        var cookieData = document.cookie;
        var start = cookieData.indexOf(cookieName);
        var cookieValue = '';
        if (start != -1) {
            start += cookieName.length;
            var end = cookieData.indexOf(';', start);
            if (end == -1) end = cookieData.length;
           		cookieValue = cookieData.substring(start, end);
        }
        return unescape(cookieValue);
    }
*/

    $(function() {
        var userId = $('#loginUserId');
        var pwd = $('#loginPwd');
        var h6 = document.getElementsByClassName('loginH6');
        $("#loginUserId").keydown(function(key) {
            if (key.keyCode == 13) {
                loginAjax(userId, pwd);
            }
        });

        $("#loginPwd").keydown(function(key) {
            if (key.keyCode == 13) {
                loginAjax(userId, pwd);
            }
        });

        $("#loginButton").on("click", function() {
            loginAjax(userId, pwd);
        });
    })

    function loginAjax(userId, pwd) {
        $.ajax({
            url: "/user/json/login",
            method: "post",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            data: JSON.stringify({
                userId: userId.val(),
                pwd: pwd.val()
            }),
    		success : function(JSONData){
    			console.log(JSONData);
    			if(JSONData.result == 'ok'){
    				$("#loginModal").modal("hide");
    				var userId = JSONData.userId;
    				swal({
						   icon : 'success',
						  title : userId+"님 환영합니다.",
						  text:" ",
						  button : false,
						})
			    	setTimeout(function() {     
	    				location.reload();
			    	}, 700);
    				
    			}else if(JSONData.result=='unReg'){
    				swal({
    					   icon : 'info',
    					  buttons: {confirm:{value:"T",text:"네",className:"btn btn-outline-primary",},cancle:{value:"F",text:"아니오",className:"btn btn-outline-secondary",},},
    					  title : "탈퇴한 회원입니다.",
    					  text : "복구하시겠습니까?" 
    					}).then((value) =>{
    						if(value=='T'){
    							$(self.location).attr("href","/user/comeBack?userId="+JSONData.userId);
    						}
    						else if(value=='F'){
    						}
    					
    					});
    			}else if(JSONData.result =='errorId'){
    				swal({
 					   icon : 'info',
 					  title : "존재하지 않는 아이디입니다.",
 					  text:" ",
 					  button : false,
 					})
    			}else if(JSONData.result =='errorPwd'){
    				swal({
 					   icon : 'info',
 					  title : "비밀번호가 틀렸습니다.",
 					  text:" ",
 					  button : false,
 					})
    			}else{
    				swal({
  					  icon : 'warning',
  					  title : "에러",
  					  text:" ",
  					  button : false,
  					})
    			}
    		}//success
        }) //ajax
    }
</script>

	<div class="modal fade " id="loginModal">
	    <!-- <div class="modal-dialog modal-lg"> -->
	    <div class="modal-dialog" id="loginModalDialog">
	        <div class="modal-content"  style="width: 800px;height:400px; margin-left: -140px;">
	             <div class="modal-body">
			                <img alt="" src="/resources/images/userImages/login.jpg" width="500px" height="398px;" style="margin-left: -20px;margin-top: -16px;">
	                <form id="modalForm" style="margin-left: 500px;margin-top: -380px;font-family: 'NIXGONM-Vb';"> 
	                	<div style="text-align: center; height: 110px;">
	                		<img alt="" src="/resources/images/icon/euroverse_text.png" width="150px" height="auto;">
	                	</div>
	                	
	                	
	                	
	                	<div>
							<div class="input-container">
								<input type="text" name="userId" id="loginUserId" required=""/>
								<label><b>아이디</b></label>		
							</div>
							<div class="input-container">		
								<input type="password" name="pwd" id="loginPwd" required="" style="font-family: serif;"/>
								<label><b>비밀번호</b></label>
							</div>
							
							<div style="text-align:center;font-size: 12px;">
								<a href="/user/searchId"><b>아이디찾기</b></a>
								┃
								
								<a href="/user/findPwd"><b>비밀번호찾기</b></a>
							
							</div>
							
							<div style="text-align: center;margin-top: 5px;">
								<img id="kakaoLogin" src="/resources/images/userImages/kakaoImage.png" width="30" height="30" style="border-radius: 100px;cursor: pointer;"/>
	                        <img id="naverLogin" src="/resources/images/userImages/naverImage.PNG" width="30" height="30" style="border-radius: 100px; margin-left: 10px;cursor:pointer;" />
	                        <img id="googleLogin" src="/resources/images/userImages/googleImage.png" width="30" height="30" style="border-radius: 100px;margin-left:10px;cursor:pointer;"/>
							
							</div>
							
							
							<div style="text-align: center;margin-top: 10px;">
							<button type="button" id="loginButton" class="btn btn-outline-primary" style="width:200px;">로그인</button>
							</div>
	                	</div>
	                </form>
	            </div>
	            <!--modal body End  -->
	        </div>
	        <!--modal content End  -->
	    </div>
	    <!--modal dialog End  -->
	</div>
	<!--myModal End  -->
	
<!--구글 로그인을 위한 스크립트태그  -->
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
