<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<script type="text/javascript">

	jQuery(document).ready(function($){
		getCommentList(1);
	});
	
	/* function onKeyDown(cmtId) {
		if(event.keyCode == 13) {
			updateComment(cmtId);
	    }
	} */
	
	$(function(){
		$("#addComment").on("click" , function() {
			
			var content = $("textarea[id='cmtContent']").val().replace(/(\n|\r\n)/g, '<br>');

			if( content.trim() == 0 ){
				swal({
       		  	    icon : 'warning',
       			    title : "댓글을 입력해주세요.",
       			    text : " ",
       			    button : false,
       			    timer : 700
        	  	});
				return false;
			}
			
			$.ajax({
				url : '/community/json/addComment' ,
				type : "POST" ,
				cache : false ,  
				dataType : "json" ,
				data : $('#addCmt').serialize() ,
				success : function(data) {
					getCommentList(1);
					$('#cmtContent').val('');
					
					//글 작성자에게 push 하기
					var receiverId = data.postWriterId;
					var pushType = 'C';
					sendPush(receiverId, pushType);
				}
			});
		});
	});
	
	function addRecomment(cmtId) {

			var content = $("form[id='"+cmtId+"addRcmt'] textarea").val().replace(/\n/g,"<br>");
	
			if( content.trim() == 0 ){
				swal({
       		  	    icon : 'warning',
       			    title : "대댓글을 입력해주세요.",
       			    text : " ",
       			    button : false,
       			    timer : 700
        	  	});
				return false;
			} 
		
			$.ajax({
				url : '/community/json/addComment' ,
				type : "POST" ,
				cache : false ,  
				dataType : "json" ,
				data : $('#'+cmtId+'addRcmt').serialize() ,
				success : function(data) {
					$(".emptyRcmt").empty();
					getRcmtList(1);
					$('#rcmtContent'+cmtId).val('');
					
					//글 작성자에게 push 하기
					var receiverId = data.postWriterId;
					var pushType = 'C';
					sendPush(receiverId, pushType);
					
					//부모 댓글 작성자에게 push 하기
					receiverId =  data.parentCmtWriterId;
					pushType = 'R';
					sendPush(receiverId, pushType);
					
				}
			});
		}
	
	 function getCommentList(currentPage){
		
		var postId = $("input[name='postId']").val();
		console.log(currentPage);
		$.ajax({
			url : '/community/json/getCommentList/'+postId+'/'+currentPage ,
			type : "GET" ,
			dataType : "json" ,
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},  
			success : function(JSONData , status) {
				
				 var totalCount = JSONData.resultPage.totalCount+JSONData.totalCount;
				
				 var output = "<div class='comment_wrap show'>"
				 + "<div class='comment_count'>"
				 + "<div class='fl num_box'>댓글 <span id='totalCount'>"+totalCount+"</span>개</div></div>"
				 + "<div class='comment_box'><ul class='cmt_list'>"
				 for(var i in JSONData.list){
					 
					 var timestamp = Number(JSONData.list[i].cmtDate);
					 var date = new Date(timestamp);

					 	 output += "<li id='comment_li_"+JSONData.list[i].cmtId+"' class='ub-content'>"
						 + "<img src='../../resources/images/userImages/"+JSONData.list[i].userImg+"' class='card' alt='...' style='height: 40px; width: 40px; float: left; margin-top: 10px;'>"
					if(JSONData.list[i].deleted == 'F'){	
						 output += "<div class='cmt_info clear' style='margin-left: 65px; padding-top: 20px;'><div class='cmt_nickbox'><span class='gall_writer ub-writer'>"
						 + "<span class='nickname me in' title='"+JSONData.list[i].nickName+"'>"+JSONData.list[i].nickName+"</span></span></div><span class='date_time'>&emsp;"+date.getFullYear()+".0"+parseInt(date.getMonth()+1)+"."+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+"</span>"
					if(JSONData.list[i].cmtWriterId == JSONData.userId){
						 output += "<div class='cmt_updat' style='color: dimgray;font-size: 11px; margin-top: 4px;'>&nbsp;<span class='btn_cmt_updat' onclick='showUpdate("+JSONData.list[i].cmtId+");'> 수정</span><span class='btn_cmt_delete' onclick='deleteComment("+JSONData.list[i].cmtId+");'> 삭제</span></div>"
					}
						 output += "<div class='cmt_like' style='float: right; margin-right: 15px'>"
					if(JSONData.userId != null){
					if(JSONData.list[i].cmtLikeFlag == "F"){ 
						 output += "<i onclick='like_func("+JSONData.list[i].cmtId+");' id='"+JSONData.list[i].cmtId+"zz' class='far fa-thumbs-up'> "+JSONData.list[i].cmtLikeCount+"</i>"
					}else{
					 	 output += "<i onclick='like_func("+JSONData.list[i].cmtId+");' id='"+JSONData.list[i].cmtId+"zz' class='fas fa-thumbs-up'> "+JSONData.list[i].cmtLikeCount+"</i>"	 
					} 
					}else{
						 output += "<i onclick='login_need();' id='"+JSONData.list[i].cmtId+"zz' class='far fa-thumbs-up'> "+JSONData.list[i].cmtLikeCount+"</i>"
					}
						 output += "&nbsp;<i onclick='reportshow("+JSONData.list[i].cmtId+",\"C\");' data-toggle='modal' data-target='#sendReport' class='fas fa-concierge-bell'></i></div></div>"
					if(JSONData.list[i].secret == "T"){
					if(JSONData.userId == JSONData.list[i].cmtWriterId || JSONData.userId == JSONData.list[i].postWriterId){
						 output += "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old'><p class='usertxt ub-word' style='color: gray;'><i class='fas fa-lock' style='color:black;'></i>&nbsp;"+JSONData.list[i].cmtContent+"</p></div>"
					}else{
						 output += "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old'><p class='usertxt ub-word'><i class='fas fa-lock'> 비밀댓글입니다.</i></p></div>"
					}
					}else{
						 output += "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old'><p class='usertxt ub-word'>"+JSONData.list[i].cmtContent+"</p></div>"
					}
						 output += "<form name='"+JSONData.list[i].cmtId+"f'><div class='cmt_txt_cont'><div class='cmt_new' style='display: none; width: 740px; float: left; position: relative; margin: 0 0 0 10px; margin-left: 70px;' id='"+JSONData.list[i].cmtId+"neww'><input type='text' id='"+JSONData.list[i].cmtId+"new' name='cmtContent' maxlength='150' style='display: none;float: left; width: 600px; margin-bottom: 5px' value='"+JSONData.list[i].cmtContent+"'/><div class='cmt_cont_bottm clear'><div class='fr' style='float:left;'><input type='checkbox' id='secret' name='secret' value='T' "
					if(JSONData.list[i].secret == "T"){
						 output += "checked"
					}	 
						 output += "> 비밀글 <span onclick='updateComment("+JSONData.list[i].cmtId+");' class='btn btn-dark' id='addComment' style='font-size:11px;height:20px;line-height:8px;'>등록</span>&nbsp;<span onclick='cancel("+JSONData.list[i].cmtId+");' class='btn btn-dark' style='font-size:11px;height:20px;line-height:8px;'>취소</span></div></div></div></div></form>"
						 + "<p style='margin: 0 0 10px 70px; font-size: 12px; width: 300px;' onclick='showrcmt("+JSONData.list[i].cmtId+")'><i class='fas fa-reply-all fa-rotate-180'></i> 댓글쓰기</p>"
					}else{
						 output += "<div class='cmt_info clear' style='margin-left: 65px; padding-top: 20px;'><div class='cmt_nickbox'><span class='gall_writer ub-writer'><span class='nickname me in' title='"+JSONData.list[i].nickName+"'>"+JSONData.list[i].nickName+"</span></span></div><span class='date_time'>"+JSONData.list[i].cmtDate+"</span>"
						 + "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old' style='margin-left:0;'><p class='usertxt ub-word'><i class='fas fa-eraser'> 삭제된 댓글입니다.</i></p></div></div>"
					}
						 output += "<div class='container' style='width: 810px; margin-right: 0;'>"	
					     + "<div class='view_comment'>"
						 + "<form class='form-horizontal' id='"+JSONData.list[i].cmtId+"addRcmt'>"
						 + "<div class='cmt_write_box clear' id='"+JSONData.list[i].cmtId+"rcmt' style='display: none;width: 810px;'>"
						 + "<div class='cmt_txt_cont'>"
						 + "<div class='cmt_write'>"
						 + "<input type='text' name='nickName' id='nickName' value='${user.nickname}' readonly='readonly' style='text-align: center;font-size:13px;border: 1px solid #cecdce;color:gray;'>"
						 + "&nbsp;<input type='checkbox' id='secret' name='secret' value='T' aria-label='Checkbox for following text input' style='font-size:12px;'> 비밀글 "
						 + "<textarea id='rcmtContent"+JSONData.list[i].cmtId+"' name='cmtContent' maxlength='150'></textarea>"
						 + "</div>"
						 + "<div class='input-group mb-3'>"
						 + "<div style='background-color: white;border: 0;width: 900px;'>"
						 + "<span class='btn btn-dark' id='addRecomment' onclick='addRecomment("+JSONData.list[i].cmtId+")' style='font-size:12px;float:right;'>등록</span>"
						 + "</div></div></div></div>"
						 + "<input type='hidden' id='parentCmtId' name='parentCmtId' value='"+JSONData.list[i].cmtId+"'/>"
						 + "<input type='hidden' id='postId' name='postId' value='${post.postId}'/>"
						 + "<input type='hidden' id='postWriterId' name='postWriterId' value='${post.postWriterId}'>"
						 + "</form>"
						 + "<div class='emptyRcmt' id='getRecommentList"+JSONData.list[i].cmtId+"'></div></div></div></li>"
				 	}
						 output += "</ul><br><div class='container text-center'><nav aria-label='Page navigation example'><ul class='pagination justify-content-center'>"
					 
					 if( JSONData.resultPage.currentPage <= JSONData.resultPage.pageUnit ){
						 output += "<li class='page-item'>"
					 }
					 if( JSONData.resultPage.currentPage > JSONData.resultPage.pageUnit ){
					 	 output += "<li class='page-item'>"
					 	 + "<a class='page-link' onclick='getCommentList('"+JSONData.resultPage.currentPage+"-1')' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a>"
					 }
					 	 output += "</li>"
					 for(var i=JSONData.resultPage.beginUnitPage; i<=JSONData.resultPage.endUnitPage; i++){
						 if(JSONData.resultPage.currentPage == i){
							output +="<li class='page-item'>"
							+"<a class='page-link' onclick='getCommentList("+i+");'>"+i+"<span class='sr-only'>(current)</span></a>"
							+"</li>"
						 }
						 if(JSONData.resultPage.currentPage != i){
							output +="<li class='page-item'>"
							+"<a class='page-link' onclick='getCommentList("+i+");'>"+i+"</a>"
							+"</li>"
						 }
					 }
					 	 if( JSONData.resultPage.endUnitPage >= JSONData.resultPage.maxPage ){
							output += "<li class='page-item'>"
						 }
						 if( JSONData.resultPage.endUnitPage < JSONData.resultPage.maxPage ){
						 	output += "<li class='page-item'>"
						 	+ "<a class='page-link' onclick='getCommentList('"+JSONData.resultPage.currentPage+"+1')' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a>"
						 }
						 	output += "</li>"
						 	+ "</ul></nav></div></div></div>"
				 
					$("#getCommentList").html(output);
		
				  getRcmtList();
			  	}
		   });
		}
	
		function getRcmtList(){
			
			var postId = $("input[name='postId']").val();
			
			$.ajax({
				url : '/community/json/getRcmtList/'+postId ,
				type : "GET" ,
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData , status){
					$(".recmt").html("");
					
					 for(var i in JSONData.list){
						 
						 var timestamp = Number(JSONData.list[i].cmtDate);
						 var date = new Date(timestamp);
					 
								 var output = "<li id='comment_li_"+JSONData.list[i].cmtId+"' class='ub-content' style='height:117px;'>"
								 + "<img src='../../resources/images/userImages/"+JSONData.list[i].userImg+"' class='card' alt='...' style='height: 40px; width: 40px; float: left; margin-top: 10px;'>"
								 + "<div class='cmt_info clear' style='margin-left: 65px; padding-top: 20px; border-top: 1px solid #eee;'><div class='cmt_nickbox'><span class='gall_writer ub-writer'>"
								 + "<span class='nickname me in' title='"+JSONData.list[i].nickName+"'>"+JSONData.list[i].nickName+"</span></span></div><span class='date_time'>&emsp;"+date.getFullYear()+".0"+parseInt(date.getMonth()+1)+"."+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds()+"</span>"
							if(JSONData.list[i].cmtWriterId == JSONData.userId){
								 output += "<div class='cmt_updat' style='color: dimgray;font-size: 11px; margin-top: 4px;'>&nbsp;<span class='btn_cmt_updat' onclick='showUpdate("+JSONData.list[i].cmtId+");'> 수정</span><span class='btn_cmt_delete' onclick='deleteComment("+JSONData.list[i].cmtId+");'> 삭제</span></div>"
							}
								 output += "<div class='cmt_like' style='float: right;'>"
							if(JSONData.userId != null){
							if(JSONData.list[i].cmtLikeFlag == "F"){ 
								 output += "<i onclick='like_func("+JSONData.list[i].cmtId+");' id='"+JSONData.list[i].cmtId+"zz' class='far fa-thumbs-up'> "+JSONData.list[i].cmtLikeCount+"</i>"
							}else{
							 	 output += "<i onclick='like_func("+JSONData.list[i].cmtId+");' id='"+JSONData.list[i].cmtId+"zz' class='fas fa-thumbs-up'> "+JSONData.list[i].cmtLikeCount+"</i>"	 
							} 
							}else{
								 output += "<i onclick='login_need();' id='"+JSONData.list[i].cmtId+"zz' class='far fa-thumbs-up'> "+JSONData.list[i].cmtLikeCount+"</i>"
							}
								 output += "&nbsp;<i onclick='reportshow("+JSONData.list[i].cmtId+",\"R\");' data-toggle='modal' data-target='#sendReport' class='fas fa-concierge-bell'></i></div></div>"
							
							if(JSONData.list[i].secret == "T"){
							if(JSONData.userId == JSONData.list[i].cmtWriterId || JSONData.userId == JSONData.list[i].postWriterId){
								 output += "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old'><p class='usertxt ub-word' style='color: gray; width: 600px;'><i class='fas fa-lock' style='color:black;'></i>&nbsp;"+JSONData.list[i].cmtContent+"</p></div>"
							}else{
								 output += "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old'><p class='usertxt ub-word'><i class='fas fa-lock'> 비밀댓글입니다.</i></p></div>"
							}
							}else{
								 output += "<div class='clear cmt_txtbox btn_reply_write_all' id='"+JSONData.list[i].cmtId+"old'><p class='usertxt ub-word' style='width: 600px;'>"+JSONData.list[i].cmtContent+"</p></div>"
							}
								 output += "<form name='"+JSONData.list[i].cmtId+"f'><div class='cmt_txt_cont'><div class='cmt_new' style='display: none; width: 800px; float: left; position: relative; padding-left: 180px;' id='"+JSONData.list[i].cmtId+"neww'><input type='text' id='"+JSONData.list[i].cmtId+"new' name='cmtContent' maxlength='150' style='display: none;float: left; width: 550px; margin-bottom: 5px' value='"+JSONData.list[i].cmtContent+"'/><div class='cmt_cont_bottm clear'><div class='fr' style='float:left;'><input type='checkbox' id='secret' name='secret' value='T' "
							if(JSONData.list[i].secret == "T"){
								 output += "checked"
							}	 
								 output += "> 비밀글 <span onclick='updateComment("+JSONData.list[i].cmtId+");' class='btn btn-dark' id='addRecomment' style='font-size:11px;height:20px;line-height:8px;'>등록</span>&nbsp;<span onclick='cancel("+JSONData.list[i].cmtId+");' class='btn btn-dark' style='font-size:11px;height:20px;line-height:8px;'>취소</span></div></div></div></div></form></li>"

							$("#getRecommentList"+JSONData.list[i].parentCmtId).append(output);
						 }
					}
			});
		}
	
		function cancel(cmtId){
			$(".cmt_new").hide();
			$("#"+cmtId+"old").show();
		}
	
		function showUpdate(cmtId){ //수정 클릭시 onclick function으로 댓글 수정 화면
			$(".clear.cmt_txtbox.btn_reply_write_all").show(); 
			$(".cmt_new").hide(); //다른 모든 댓글 수정칸 숨김
			$("#"+cmtId+"neww").show(); //누른 댓글의 수정칸 출력
			$("#"+cmtId+"new").show(); 
			$("#"+cmtId+"old").hide(); //누른 댓글의 원 내용 숨김
		}
		
		function updateComment(cmtId){
			
			var content = $("#"+cmtId+"new").val().replace(/\n/g,"<br>");

			if(content.trim() == 0){
				swal({
       		  	    icon : 'warning',
       			    title : "댓글을 입력해주세요.",
       			    text : " ",
       			    button : false,
       			    timer : 700
        	  	});
				return false;
			}
			
			$.ajax({
				url : '/community/json/updateComment' ,
				type : "POST" ,
				data : $("form[name='"+cmtId+"f']").serialize() + "&cmtId="+cmtId ,
				dataType : "json" ,
				success : function(JSONData , status){
					swal({
	       		  	    icon : 'success',
	       			    title : "수정 완료!",
	       			    text : " ",
	       			    button : false,
	       			    timer : 500
	        	  	});
					getCommentList(1);
				}
			}); 
		}
		
		function deleteComment(cmtId){
			
			swal({
				title:"댓글을 삭제하시겠습니까?",
				text:" ",
				icon:"warning",
				buttons: [ "아니오", "예"]
			}).then((YES) => {
				if(YES){
					swal("삭제되었습니다!"," ","success");
					
					$.ajax({
						url : '/community/json/deleteComment/'+cmtId ,
						type : "GET" ,
						dataType : "json" ,
						headers : {
			   				"Accept" : "application/json",
			   				"Content-Type" : "application/json"
		   			    },
		   			    success : function(JSONData , status){
		   			    	getCommentList(1);
		   			    }
					});
				}
			});
		}
		
		function like_func(cmtId){

			$.ajax({
				url : '/community/json/like/'+cmtId ,
				type : "GET" ,
				cache : false ,
				dataType : "json" ,
				success : function(data) {
		
					if(data.likeCheck == 'F'){
					  $("#"+cmtId+"zz").attr('class','far fa-thumbs-up');
					}else{
					  $("#"+cmtId+"zz").attr('class','fas fa-thumbs-up');
					}      
					  $("#"+cmtId+"zz").html("&nbsp;"+data.cmtLikeCount);
				},
				error: function(request, status, error){
					swal("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}
		
		function showrcmt(cmtId){
			$("#"+cmtId+"rcmt").toggle();
		}
	
	</script>
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container" style="max-width: 930px;">	
	<!-- ///////////////////////댓글 작성 view 화면/////////////////////////////// -->
	<div class="view_comment">
	
		<form class="form-horizontal" id="addCmt">
		<!-- 답글 입력 -->
		<div class="cmt_write_box clear">
			<div class="cmt_txt_cont">
				<div class="cmt_write">
				  <input type="text" name="nickName" id="nickName" value="${user.nickname}" readonly="readonly" style="text-align: center;font-size:13px;border: 1px solid #cecdce;color:gray;">
			      &nbsp;<input type="checkbox" name="secret" id="secret" value="T" style="font-size:12px;"> 비밀글
				  <textarea id="cmtContent" name="cmtContent" maxlength="150"></textarea>
				</div>
				<div class="input-group mb-3">
				    <div style="background-color: white;border: 0;width: 900px;">
				      <button type="button" class="btn btn-dark" id="addComment" style="font-size:12px;float:right;">등록</button>
				    </div>
				</div>
			</div>
		</div>
		   <input type="hidden" id="postId" name="postId" value="${post.postId}"/>
		   <input type="hidden" id="postWriterId" name="postWriterId" value="${post.postWriterId}">
		</form>
	<!-- 답글쓰기 -->
		<div id="getCommentList"></div>
		
	</div>
	
	</div>