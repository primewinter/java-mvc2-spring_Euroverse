<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">
	<title>${post.postTitle}</title>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/4.4/examples/carousel/">
    <!-- sweetalert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!--<script src="https://code.jquery.com/jquery-1.12.4.js"></script>-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


    <link href="https://fonts.googleapis.com/css?family=Monoton" rel="stylesheet">

    <!-- Use Swiper from CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/css/swiper.min.css">
    <script src="https://unpkg.com/swiper/js/swiper.js"></script>
    <script src="https://unpkg.com/swiper/js/swiper.min.js"></script>

    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <!-- AOS CDN2 :: https://michalsnik.github.io/aos/-->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

    <!--owl carousel CDN-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        .view_comment {
            position: relative;
        }

        .comment_wrap.show,
        .gall_listwrap.album .comment_wrap.show,
        .comment_box .reply.show {
            overflow: visible;
            height: 100%;
        }

        .comment_wrap {
            overflow: hidden;
            width: 100%;
            height: 38px;
            font-family: '굴림', Gulim;
            font-size: 13px;
            color: #333;
        }

        .comment_count {
            height: 38px;
            line-height: 38px;
            font-weight: bold;
        }

        .comment_count .num_box {
            width: 50%;
        }

        .comment_box {
            position: relative;
            border-top: 1px solid silver;
        }

        ol,
        ul {
            list-style: none;
            padding: 0 0 0 10px;
        }

        .cmt_list li:first-child .cmt_info {
            border-top: none;
            margin-left: 65px;
            padding-top: 20px;
        }

        .view_comment .cmt_info {
            padding: 0;
        }

        .cmt_info {
            position: relative;
            padding: 9px 12px 7px;
            border-top: 1px solid #eee;
        }

        .cmt_nickbox {
            float: left;
            margin-top: 3px;
        }

        .gall_writer {
            position: relative;
            font-size: 13px;
            cursor: pointer;
        }

        .nickname.me {
            padding: 3px 1px 1px 2px;
        }

        .comment_box .nickname {
            font-size: 12px;
            color: #777;
            vertical-align: top;
        }

        .comment_box .nickname.in>em {
            max-width: 110px;
            padding-right: 1px;
        }

        .comment_box .nickname>em {
            display: inline-block;
            max-width: 84px;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            vertical-align: top;
        }

        .writer_nikcon img {
            vertical-align: middle;
        }

        .cmt_txtbox {
            float: left;
        }

        .comment_wrap .comment_dccon {
            float: left;
        }

        .usertxt,
        .comment_wrap .comment_dccon {
            width: 820px;
            cursor: pointer;
        }

        .comment_dccon {
            position: relative;
            margin: 3px 0 5px;
        }

        .coment_dccon_img {
            float: left;
            height: 100px;
            cursor: pointer;
        }

        .fr {
            float: right;
        }

        .date_time {
            float: left;
            font-size: 12px;
            color: #999;
            vertical-align: top;
            margin-top: 3px;
        }

        .view_comment .bottom_paging_box {
            height: 69px;
        }

        .comment_box .bottom_paging_box {
            margin-top: 0;
        }

        .comment_wrap .bottom_paging_box {
            border-top: 1px #eee solid;
        }

        .bottom_paging_box {
            position: relative;
            margin-top: 18px;
            text-align: center;
            line-height: 20px;
        }

        .cmt_paging {
            padding: 23px 0 28px;
        }

        .bottom_paging_box a:first-child,
        .bottom_paging_box em:first-child {
            margin-left: 0;
        }

        .bottom_paging_box em {
            text-decoration: underline;
            color: #d31900;
        }

        .bottom_paging_box a,
        .bottom_paging_box em,
        .bottom_paging_box span {
            display: inline-block;
            margin-left: 9px;
            font-size: 14px;
            font-weight: bold;
        }

        .view_comment .cmt_write_box {}

        .cmt_write_box {
            padding: 10px 10px 10px;
            width: 910px;
        }

        .user_info_input:first-child {
            margin-top: 0px;
        }

        .user_info_input {
            width: 140px;
            height: 30px;
            margin-top: 5px;
            border: 1px solid #cecdce;
            background: #fff;
        }

        .user_info_input input,
        .cmt_write_box .user_info_input.id>label {
            width: 126px;
            height: 25px;
            line-height: 29px;
            padding: 1px 7px 0;
            border: none;
            font-family: '굴림', Gulim;
            font-size: 12px;
            vertical-align: top;
        }

        .user_info_input {
            width: 140px;
            height: 30px;
            margin-top: 5px;
            border: 1px solid #cecdce;
            background: #fff;
        }

        .cmt_txt_cont {
            float: right;
            width: 890px;
        }

        .cmt_write {
            position: relative;
        }

        .cmt_textarea_label {
            position: absolute;
            left: 13px;
            top: 13px;
            font-size: 12px;
            color: #999;
            line-height: 18px;
        }

        .cmt_txt_cont textarea {
            float: left;
            margin: 10px 0 10px 0;
            width: 890px;
            height: 78px;
            padding: 13px;
            border: 1px solid #cecdce;
            background: #fff;
            font-family: '굴림', Gulim;
            font-size: 13px;
            color: #333;
            line-height: 18px;
        }

        .cmt_cont_bottm {
            margin-top: 8px;
        }

        .view_wrap .view_comment .btn_blue,
        .view_comment .btn_blue.small {
            width: 85px;
            margin-left: 0;
        }

        .view_comment .btn_lightblue {
            font-weight: normal;
        }

        .btn_blue {
            background: #00A8C1;
            border-color: #3c4790;
            text-shadow: 0px -1px #343d8e;
            color: #fff;
        }

        .btn_lightblue {
            background: #00A8C1;
            border-color: #525eaa;
            text-shadow: 0px -1px #4b559c;
            color: #fff;
        }
        .btn_lightgreen.small,
        .btn_yeongrey.small,
        .btn_lightpurple.small,
        .btn_blue.small,
        .btn_lightblue.small,
        .btn_grey.small,
        .btn_jeangrey.small,
        .btn_white.small,
        .btn_red.small,
        .btn_lightgrey.small,
        .btn_red.small,
        .btn_green.small {
            height: 31px;
            line-height: 30px;
            margin-left: 3px;
            border-width: 1px;
            border-style: solid;
            border-radius: 2px;
            font-size: 12px;
            font-weight: bold;
        }

        .clear:after {
            clear: both;
            display: block;
            visibility: hidden;
            content: "";
        }

        .cmt_info p {
            line-height: 20px;
        }

        .usertxt {
            float: left;
            line-height: 20px;
            cursor: pointer;
            word-break: break-all;
            overflow: hidden;
        }

        .usertxt,
        .comment_wrap .comment_dccon {
            width: 700px;
            cursor: pointer;
        }

        .cmt_like {
            float: left;
        }

        .clear.cmt_txtbox.btn_reply_write_all {
            clear: both;
            width: 700px;
            margin-left: 70px;
        }

        .reportModal {
            text-align: left;
            /* vertical-align: middle; */
        }

        .card {
            width: 70px;
            height: 70px;
            border-radius: 70%;
            overflow: hidden;
            margin-left: 10px;
        }
        .party-list{
            border-radius: 20px;
            border:solid 1px #ddd;
/*            background-color: rgba(151, 235, 219, 0.7);*/
        }
 
    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        var boardName = '${post.boardName}';
        var postId = '${post.postId}';

        //============= 회원정보수정 Event  처리 =============	
        $(function() {
            //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
            $(".fr .updatePost").on("click", function() {
                self.location = "/community/updatePost?postId=${post.postId}&boardName="+boardName;
            });
            
            $("#boardTitle").on("click", function(){
				 self.location = "/community/getPostList?boardName=${param.boardName}";
			});
        });

        $(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			 $( ".fr .deletePost" ).on("click" , function() {
	
				 swal({
						title:"게시글을 삭제하시겠습니까?",
						text:" ",
						icon:"warning",
						buttons: [ "아니오", "예"]
					}).then((YES) => {
						if(YES){
							
							swal({
								icon : 'success',
								title : "삭제되었습니다!",
								text:" ",
								button : false,
							})
					    	setTimeout(function() {     
					    		self.location = "/community/deletePost?postId=${post.postId}&boardName="+boardName;
					    	}, 700);
						}
				    });
			 });
		});

        //좋아요 구현
        function like() {
            console.log($('#likeform').serialize());
            $.ajax({
                url: '/community/json/likeUpdate',
                type: "POST",
                cache: false,
                dataType: "json",
                data: $('#likeform').serialize(), //아이디가 like_form인 곳의 모든 정보를 가져와 파라미터 전송 형태(표준 쿼리형태)로 만들어줌
                success: function(data) { //ajax통신 성공시 넘어오는 데이터 통째 이름 =data

                    if (data.like != null) {
                    	swal({
               				icon : 'success',
               			    title : "좋아요 완료!",
               			    text : " ",
               			    button : false,
               			    timer : 700
               			});
                    	
                        $(".up_num_box span").html(data.like); //id값이 like_result인 html을 찾아서 data.like값으로 바꿔준다.
                    }
                },
                error: function(request, status, error) {
                	swal({
           				icon : 'error',
           			    title : "게시글 좋아요는 한번만 가능합니다.",
           			    text : " ",
           			    button : false,
           			    timer : 700
           			});
                }
            });
        }

        function reportshow(refId, repTar) {
            $("#refId").attr('value', '' + refId + '');
            $("#reportTarget").attr('value', '' + repTar + '');
            $('#sendReport').on('shown.bs.modal');
        };

        $(function() {
            $("#addReport").on("click", function() {
            	
            	if( !$("input:radio[name='reportReason']:checked").val() ){
            		swal({
           				icon : 'warning',
           			    title : '신고사유는 반드시 선택해주세요.',
           			    text : " ",
           			    button : false,
           			    timer : 700
           			});
	    			return;
	    		}

                if ($("input:radio[id='customRadio4']").is(":checked") == true) {

                    var reportContent = $("input[name='reportContent']").val();

                    if (reportContent == null || reportContent.length < 1) {
                    	swal({
               				icon : 'warning',
               			    title : '내용은 반드시 입력하세요.',
               			    text : " ",
               			    button : false,
               			    timer : 700
               			});
                        return;
                    }
                } else if ($("input:radio[id='customRadio4']").is(":checked") == false) {

                    if ($("input[name='reportContent']").val() != "") {
                    	swal({
               				icon : 'warning',
               			    title : '기타선택시 내용 작성이 가능합니다.',
               			    text : " ",
               			    button : false,
               			    timer : 700
               			});
                        return;
                    }
                }

                $.ajax({
                    url: '/community/json/addReport',
                    type: "POST",
                    data: $("#reportform").serialize(),
                    dataType: "json",
                    success: function(JSONData, status) {
                        closeModal('sendReport');
                        swal({
               				icon : 'success',
               			    title : JSONData.msg,
               			    text : " ",
               			    button : false,
               			    timer : 700
               			});
                    }
                });
            });
        });

        function addBookMark(postId) {

            $.ajax({
                url: '/community/json/addBookMark/' + postId,
                type: "GET",
                cache: false,
                dataType: "json",
                success: function(data) {
                   
                	if(data.likeCheck == 'F'){
						
  					 swal({
                 		  	  icon : 'success',
                 			  title : "북마크 취소",
                 			  text : " ",
                 			  button : false,
                 			  timer : 700
                 	  });
  					  
  					  $(".fas.fa-bookmark").attr('class','far fa-bookmark fa-2x');
  					}else{
  						
  					  swal({
  	               		  icon : 'success',
  	               		  title : "북마크 목록에 추가되었습니다!",
  	               		  text : " ",
  	               		  button : false,
  	               		  timer : 700
  	               	  });
  						
  					  $(".far.fa-bookmark").attr('class','fas fa-bookmark fa-2x');
  					}      
                },
                error: function(request, status, error) {
                    swal("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            });
        }

        function getPost(postId) {
            self.location = "/community/getPost?postId=" + postId + "&boardName=" + boardName;
        }

        function inviteUser() {
            $('#accOffer').modal({
                backdrop: 'static'
            });
            $("#accOffer").show()
        }

        $(function() {
            $('#addOffer').on('click', function() {
                addOffer();
            });
        });

        function addOffer() {

            var offerMsg = $("input[name='offerMsg']").val();
            var postWriterId = $("input[name='postWriterId']").val();

            if (offerMsg == '') {
            	swal({
       				icon : 'warning',
       			    title : "동행신청 메세지를 입력해주세요.",
       			    text : " ",
       			    button : false,
       			    timer : 700
       			});
                return false;
            }
            console.log("toUserId=" + postWriterId + ", offerMsg=" + offerMsg);

            $.ajax({
                url: "/community/json/addOffer",
                method: "POST",
                dataType: "json",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                data: JSON.stringify({
                    refId: postId,
                    toUserId: postWriterId,
                    offerMsg: offerMsg
                }),
                success: function(data) {
                    closeModal('accOffer');
                    swal({
           				icon : 'success',
           			    title : '${post.nickName}'+ " 님에게 메시지를 보냈습니다.",
           			    text : " ",
           			    button : false,
           			    timer : 700
           			});

                    //글 작성자에게 push 하기
                    var receiverId = data.toUserId;
                    var pushType = 'A';
                    sendPush(receiverId, pushType);
                }
            });
        }

        function closeModal(modalName) {

            if (typeof $("." + modalName)[0] != "undefined") {
                $("." + modalName)[0].reset();
            }
            $("#" + modalName).modal("hide");
        }

        $('#createChat').on('show.bs.modal', function(event) {
            var button = $(event.relatedTarget)
            var modal = $(this)
            modal.find('.modal-title').text('New message to ' + recipient)
            modal.find('.modal-body input').val(recipient)
        })

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function(e) {
                    $('#blah').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        };

        function createRoom() {
            var memCount = '${userList.size()}';
            var joinMems = new Array(memCount);
            for (var i = 0; i < memCount; i++) {
                joinMems[i] = $("input[name='joinMems']")[i].value;
            }

            var formData = new FormData();
            if ( $('input[name="chatRoomFile"]')[0].files[0] != undefined) {
            	console.log("파일 넣음");
            	console.log($('input[name="chatRoomFile"]')[0].files[0]);
	            formData.append("chatRoomFile", $('input[name="chatRoomFile"]')[0].files[0]);
            } 
            formData.append("joinMems", joinMems);
            formData.append("creator", $('input[name="creator"]').val());
            formData.append("chatRoomName", encodeURIComponent($('input[name="chatRoomName"]').val()));
            formData.append("postId", '${post.postId}');

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/chat/json/createRoom",
                data: formData,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function() {
                    console.log("채팅방 개설 성공");
                    closeModal('createChat');
                },
                error: function(request, status, error) {
                    console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
            })
        };

        jQuery(document).ready(function($) {
            checkRoom();

            $('.join-btn').hide();
            if ('${user.userId}' == '${post.postWriterId}') {
                
            	var array = new Array('${party}');
                console.log("member.party : "+array);
                for(var i in array) {
                    console.log(i+"번째 :: " +array[i]);
                }
            }
        });


        function checkRoom() {
            $.ajax({
                type: "GET",
                url: "/chat/json/checkRoom?postId=" + '${post.postId}',
                dataType: "json",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(json) {
                    console.log(json);
                    if (json == true) {
                        $('#create-room-btn').hide();
                    } else {
                        console.log('${user.userId == post.postWriterId && post.accCount >= 2}');
                        if ('${user.userId == post.postWriterId && post.accCount >= 2}' == 'true') {
                            $('#create-room-btn').show(); //채팅방 개설 버튼
                        } else {
                            $('#create-room-btn').hide();
                        }
                    }
                },
                error: function(request, status, error) {
                    console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
            });
        }

        function checkMem(memberId) {
            $.ajax({
                type: "GET",
                url: "/chat/json/checkRoomMem?postId=" + '${post.postId}&userId=' + memberId,
                dataType: "json",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(json) {
                    console.log(memberId + "가 채팅방 멤버인지 ? " + json);
                    var id = '#join-' + memberId;
                    console.log("checkRoomMem :: " + id + " || " + json)
                    if (json == true) {
                        $(id).hide();
                    } else {
                        $(id).hide();
                    }
                },
                error: function(request, status, error) {
                    console.log("code = " + request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
                }
            });
        }
        
        function tagSearch(tagSorting){
			fncGetUserList(1, tagSorting);
		}
		
		function fncGetUserList(currentPage, tagSorting) {
			$("#currentPage").val(currentPage)
			$("form[id='tagForm"+tagSorting+"']").attr("method" , "POST").attr("action" , "/community/getPostList").submit();
		}
		
		$(function(){
			$("#goodbye").on("click", function(){
				
				var partyId = $(this).next().val();
				
				 swal({
						title:"동행을 탈퇴하시겠습니까?",
						text:" ",
						icon:"info",
						buttons: [ "아니오", "예"]
				}).then((YES) => {
					if(YES){
						swal({
							icon : 'success',
							title : "동행 탈퇴 완료!",
							text:" ",
							button : false,
						})
				    	setTimeout(function() {     
				    		self.location = "/community/deletePartyUser?postId="+postId+"&partyId="+partyId;
				    	}, 700);
					}
			    });
			});
		});

    </script>

</head>

<body>

    <!-- ToolBar Start /////////////////////////////////////-->
    <jsp:include page="/toolbar/toolBar.jsp" />
    <jsp:include page="/toolbar/pushBar.jsp" />
    <!-- ToolBar End /////////////////////////////////////-->

    <div class="modal" tabindex="-1" role="dialog" id="sendReport">
        <div class="modal-dialog modal-dialog-centered reportModal" role="document" style="width:300px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">신고 작성</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeModal('sendReport');">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>신고사유 선택</p>
                    <form id="reportform" class="sendReport">
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio1" name="reportReason" class="custom-control-input" value="F">
                            <label class="custom-control-label" for="customRadio1" style="font-size:13px; padding-bottom:6px;">욕설</label>
                        </div>
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio2" name="reportReason" class="custom-control-input" value="A">
                            <label class="custom-control-label" for="customRadio2" style="font-size:13px; padding-bottom:6px;">음란물</label>
                        </div>
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio3" name="reportReason" class="custom-control-input" value="R">
                            <label class="custom-control-label" for="customRadio3" style="font-size:13px; padding-bottom:6px;">허위사실</label>
                        </div>
                        <div class="custom-control custom-radio">
                            <input type="radio" id="customRadio4" name="reportReason" class="custom-control-input" value="E">
                            <label class="custom-control-label" for="customRadio4" style="font-size:13px;">기타</label>
                            <input type="text" class="form-control" maxlength="30" id="reportContent" name="reportContent" placeholder="기타 내용을 입력하세요." style="font-size:13px;" />
                        </div>
                        <input type="hidden" id="refId" name="refId" value="">
                        <input type="hidden" id="reportTarget" name="reportTarget" value="">
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closeModal('sendReport');">닫기</button>
                    <button type="button" class="btn btn-primary" id="addReport">신고하기</button>
                </div>
            </div>
        </div>
    </div>

    <!--  화면구성 div Start /////////////////////////////////////-->
    <div>
        <div class="row">
            <jsp:include page="/view/accompany/accSidebar.jsp"/>
            
        <div style="width:60%;margin-left:5%">

        <br>

        <div class="page_head clear">
            <div class="h4" id="boardTitle" style="text-align: center;font-weight: bold;">
                동행찾기
            </div>
        </div>

        <hr>

        <div class="recom_bottom_box clear" style="width: 965px;">
            <c:if test="${post.postLikeFlag == 'F' || post.postLikeFlag == null}">
                <i onclick="addBookMark(${post.postId})" class="far fa-bookmark fa-2x" style="float: right;"></i>
            </c:if>
            <c:if test="${post.postLikeFlag == 'T' }">
                <i onclick="addBookMark(${post.postId})" class="fas fa-bookmark fa-2x" style="float: right;"></i>
            </c:if>
              <i class="far fa-angry" data-toggle="modal" data-target="#sendReport" onclick="reportshow('${post.postId}','P');" style="float: right; padding: 15px 30px 10px 10px; font-size: 11px;"> 신고하기</i>
            <h3 class="title ub-word" style="margin-bottom: 40px;">
                <span class="title_subject" style="font-weight:bold;">
                <c:if test="${post.postGrade == 'N'}">
		      	[공지]
		      	</c:if>
                ${post.postTitle} </span> <span style="font-size:18px;"> [ ${post.accCount} / ${post.accPerson} ]</span>
                <br><span style="font-size: 15px;">
                    <i class="fas fa-walking"></i>
                  <c:if test="${post.accEndDateStr != null}">
                    ${post.accStartDateStr} ~ ${post.accEndDateStr}
                  </c:if>
                  <c:if test="${post.accEndDateStr == null}">
                    ${post.accStartDateStr}
                  </c:if>
                </span>
            </h3>
        </div>

        <div class="view_content_wrap">
            <div class="gallview_head clear ub-content">
                <div class="gall_writer ub-writer">
                    <div class="fl">
                        <span class="nickname in" style="font-size: 14px; color: gray;">
                            ${post.nickName}
                        </span>
                        <span class="gall_date" style="font-size: 14px; color: gray;">
                            &emsp;${post.postDate}
                        </span>
                        <div class="post_history" style="float: right;">
                            <i class="far fa-eye" style="font-size: 13px;"> ${post.views}</i>
                            &nbsp;<i class="far fa-thumbs-up" style="font-size: 13px;"> ${post.postLikeCount}</i>
                            &nbsp;<i class="far fa-comments" style="font-size: 13px;"> ${post.comments}</i>
                        </div>
                    </div>
                </div>
            </div>

            <hr>

            <div class="gallview_contents">
                <div class="inner clear">
                    <div class="writing_view_box">
                        <pre></pre>
                        <div style="overflow:hidden;">
                            ${post.postContent}
                        </div>
                    </div>
                </div>

                <div class="btn_recommend_box clear">
                    <form id="likeform">
                        <input type="hidden" id="postId" name="postId" value="${post.postId}" />
                        <div class="inner fl" style="text-align: center;">
                            <div class="up_num_box" style="margin: 50px 0 50px 0">
                                <span class="up_num font_red" style="color: tomato; font-size: 20px; margin-right: 10px">${post.postLikeCount} </span>
                                <i onclick="like()" class="fas fa-heart fa-2x" style="color: tomato;"></i>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div class="tag_content_box">
                <div class="tagbox" style="font-size: 12px;">
                    <i class="fas fa-tags"> 태그 </i>
                    <span>
                        <c:set var="i" value="0" />
                        <c:forEach var="tag" items="${tag}" varStatus="last">
                            <c:set var="i" value="${ i+1 }" />
                             <form id="tagForm${i}" style="display:inline-block;">
							   <input type="hidden" name="boardName" value="${post.boardName}"/>	
							   <input type="hidden" name="searchCondition" value="2"/>
							   <input type="hidden" name="searchKeyword" value="${tag.tagContent}"/>
					           <a style="color: gray;" type="button" onclick="tagSearch('${i}');">#${tag.tagContent}</a>
					         </form>
                            <c:if test="${!last.last}">
                                <i> </i>
                            </c:if>
                        </c:forEach>
                    </span>
                    <c:if test="${user.userId == post.postWriterId}">
                        <div class="fr" style="float: right;">
                            <span class="updatePost">수정</span>
                            <span class="deletePost">삭제</span>
                        </div>
                    </c:if>
                </div>
            </div>

            <hr>

            <div class="row" style="font-family: 'Gothic A1', sans-serif;">
                <div class="col-xs-8 col-md-4"><i class="fas fa-user-times">${post.accCount}</i>
                    <button type="button" id="create-room-btn" class="btn btn-outline-dark" data-toggle="modal" data-target="#createChat" style="width: 110px; font-size: 15px; height: 30px; line-height: 15px; margin: 0 0 3px 10px">채팅방 개설</button>
                    <c:set var="loop_flag" value="false" />
                    <c:forEach var="party" items="${party}">
                           <c:if test="${party.partyUserId==user.userId}">
                               <c:set var="loop_flag" value="true" />
                           </c:if>
                    </c:forEach>
                    <c:if test="${post.accCount==post.accPerson}">
                         <c:set var="loop_flag" value="true" />
                    </c:if>
                      <c:if test="${loop_flag==false}">
                               <button type="button" id='offer-party-btn' class="btn btn-outline-info" style="width: 100px; font-size: 15px; height: 30px; line-height: 15px; margin: 0 0 3px 10px" onclick="inviteUser()">동행신청</button>
                      </c:if>
                </div>
                <div class="col-md-12 party-list" style="margin-top: 10px;height: 190px;">
                    <c:set var="i" value="0" />
                    <c:forEach var="userList" items="${userList}">
                        <c:forEach var="party" items="${party}">
                            <c:if test="${userList.userId == party.partyUserId}">
                                <c:set var="i" value="${ i+1 }" />
                                <c:if test="${party.partyRole == 'K'}">
                                    <div class="partyKing" style="max-width: 18rem;float: left;border-radius: 10px;width: 165px;height: 174px; margin-left:10px;">
                                        <img src="/resources/images/userImages/${userList.userImg}" class="card" style="margin-left: 46px;margin-top: 23px;border: 2px solid #0086ad;">
                                        <div class="card-body text-dark" style="padding:0;">
                                            <h5 class="card-title" style="font-size: 13px; text-align: center;margin-top: 7px;font-weight: bold;"><i class="fas fa-crown"></i> ${userList.nickname}</h5>
                                            <p class="card-text" style="text-align:center;"><i class="fas fa-bus">
                                                    <c:forEach var="tripStyle" items="${userList.tripStyle}">
                                                        <span style="font-family: 'Gothic A1', sans-serif; font-size: 13px;">${tripStyle}</span>
                                                    </c:forEach>
                                                </i></p>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${party.partyRole == 'M'}">
                                    <div class="partyMember" style="max-width: 18rem;float: left;border-radius: 10px;width: 165px;height: 174px; margin-left:30px;">
                                        <img src="/resources/images/userImages/${userList.userImg}" class="card" style="margin-left: 46px;margin-top: 23px;border: 2px solid silver;">
                                        <div class="card-body text-dark" style="padding:0;">
                                            <h5 class="card-title" style="font-size: 13px; text-align: center;margin-top: 7px;font-weight: bold;">${userList.nickname}</h5>
                                            <p class="card-text" style="text-align:center;"><i class="fas fa-bus">
                                                    <c:forEach var="tripStyle" items="${userList.tripStyle}">
                                                        <span style="font-family: 'Gothic A1', sans-serif; font-size: 13px;">${tripStyle}</span>
                                                        <button type="button" id="${party.partyUserId}" class="btn btn-outline-dark join-btn" style="width: 110px; font-size: 15px; height: 30px; line-height: 15px; margin: 0 0 3px 10px">채팅방 초대</button>
                                                    </c:forEach>
                                                    <c:if test="${user.userId == party.partyUserId}">
                                                    	<br><span style="font-size:13px;margin-top:5px;" class="badge badge-info" id="goodbye">탈퇴하기</span>
                                                    	 <input type="hidden" name="partyId" value="${party.partyId}"/>
                                                    </c:if>
                                                </i></p>
                                        </div>
                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </div>
            </div>

            <ul class="list-group list-group-flush" style="font-size: 13px;">
		    <c:if test="${post.prevTitle == '이전글이 없습니다'}">
			  <li class="list-group-item">이전글 <i class="fas fa-angle-double-right"> ${post.prevTitle}</i></li>
		    </c:if>
		    <c:if test="${post.prevTitle != '이전글이 없습니다'}">
			  <li class="list-group-item">이전글 <i class="fas fa-angle-double-right" onclick="getPost('${post.prevId}')"> ${post.prevTitle}</i></li>
			</c:if>
			<c:if test="${post.nextTitle == '다음글이 없습니다'}">
			  <li class="list-group-item">다음글 <i class="fas fa-angle-double-right"> ${post.nextTitle}</i></li>
		    </c:if>
		    <c:if test="${post.nextTitle != '다음글이 없습니다'}">
			  <li class="list-group-item">다음글 <i class="fas fa-angle-double-right" onclick="getPost('${post.nextId}')"> ${post.nextTitle}</i></li>
			</c:if>
		   </ul>

        </div>
            </div>
    </div>

    <!-- 댓글 jsp include -->
    <jsp:include page="/view/community/comment.jsp" />
    <jsp:include page="/toolbar/footer.jsp" />

    <!-- 동행신청 모달 -->
    <div class="modal" id="accOffer">
        <div class="modal-dialog modal-lg" style="width:600px;">
            <h4 style="color: #FFFFFF; margin-top: 100px;"> <i class="far fa-grin-alt"></i> <i class="far fa-handshake"></i> <i class="far fa-grin-wink"></i></h4>

            <div class="modal-content">

                <div class="modal-header">
                    <div class="modal-title">
                        <h6 style="margin-left:15px; align-self: center; font-weight: bolder;"><br />${post.nickName} 님에게 동행을 신청하세요!</h6>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="closeModal('accOffer')">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <form class="accOffer" style="margin: 10px;">
                        <div class="form-group" id="offerMsgForm" style="margin: 30px 10px 10px 10px; width:auto;">
                            <label for="offerMsg" class="control-label" style="font-weight: bold; margin-bottom: 7px;">${post.nickName} 님에게 보낼 메세지</label><br />
                            <input type="text" maxlength="50" class="form-control" id="offerMsg" name="offerMsg" placeholder="동행신청 메세지를 입력하세요." style="width:100%; height: 100px;">
                            <input type="hidden" id="postWriterId" name="postWriterId" value="${post.postWriterId}" />
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" onClick="closeModal('accOffer')">Close</button>
                    <button type="button" class="btn btn-success" id="addOffer">신청하기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 동행 채팅방 개설 모달 -->
    <form class="createChat" enctype="multipart/form-data" accept-charset="euc-kr">
        <div class="modal fade" id="createChat" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">동행채팅방 개설</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" style="text-align:center">
                        <div style="margin-top:20px;margin-bottom:30px">
                            <img id="blah" src="/resources/images/icon/imageIcon.png" width="50px" height="50px" onclick='document.all.chatRoomFile.click(); document.all.file.value=document.all.chatRoomFile.value' />
                        </div>
                        <div class="form-group row">
                            <label for="colFormLabelSm" class="col-sm-3 col-form-label col-form-label-sm">채팅방 이름</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control form-control-sm" name="chatRoomName" placeholder="${post.postTitle}">
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="file" id="file" name="chatRoomFile" onchange="readURL(this)" style="display:none;" />
                        </div>
                        <div class="form-group row">
                            <c:forEach var="userList" items="${userList}">
                                <c:forEach var="party" items="${party}">
                                    <c:if test="${userList.userId == party.partyUserId}">
                                        <c:set var="i" value="${ i+1 }" />
                                        <div class="col-auto d-none d-lg-block">
                                            <img class="imgFile" src="/resources/images/userImages/${userList.userImg}" style="width:50px;height:50px;border-radius:50%;">
                                            <br>${userList.nickname}<input type="hidden" name="joinMems" value="${userList.userId}">
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </div>
                        <input type="hidden" name="creator" value="${post.postWriterId}">
                        <input type="hidden" name="postId" value="${post.postId}">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary create" onclick='createRoom()'>개설</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

</body>

</html>
