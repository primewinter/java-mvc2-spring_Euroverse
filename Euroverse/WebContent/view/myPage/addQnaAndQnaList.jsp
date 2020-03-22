<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:if test="${  empty user }">
    <jsp:forward page="/" />
</c:if>
<!DOCTYPE html>
<html>

<head>
    <meta charset="EUC-KR">
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">

    <!-- jquery Ui 링크 (datePicker)  -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

    <!--datePicker CDN  -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- sweetalert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

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

    <!-- fontawesome CDN -->
    <!-- <script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <style>
        .media {
            margin: 20px;
        }

        .media .media-body {
            margin: 20px;
        }


        div.addQnA {
            width: 100%;
            padding: 2em;
        }

        div.addQnA>div.row {
            margin-bottom: 0.5em;
            margin-top: 0.5em;
        }

        div.QnAList {
            width: 100%;
            margin: auto;
            padding: 0.5em;
        }

        font.post-sm {
            font-size: 9pt;
            color: #BBBBBB;
        }

        font.post-title {
            font-weight: 700;
        }

        .table td {
            border: 0px;
        }

        table.QnA {
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
        }

    </style>



    <script>
        var maPageCode = 'Q';
        
        
        //게시글 수정 시 사용되는 카테고리 선택
        function selectCate(obj, postId) {
            
            var state = obj.value;
            var qnaSecondCate = $("#"+postId+"_secondCate");
            $("#"+postId+"_secondCate").css('display', 'inline-block');


            if (state == 'A') {
                //$(qnaSecondCate).remove();
                qnaSecondCate.css("display", "inline-block");
                qnaSecondCate.html("<option disabled selected hidden>2차분류</option>");
                qnaSecondCate.append("<option value='D' class='secondCate'>결제</option>");
                qnaSecondCate.append("<option value='E' class='secondCate'>환불</option>");

            } else if (state == 'B') {
                //$(qnaSecondCate).remove();
                qnaSecondCate.css("display", "inline-block");
                qnaSecondCate.html("<option disabled selected hidden>2차분류</option>");
                qnaSecondCate.append("<option value='F' class='secondCate'>항공권</option>");
                qnaSecondCate.append("<option value='G' class='secondCate'>숙소</option>");
            } else if (state == 'C') {
                //$(qnaSecondCate).remove();
                qnaSecondCate.css("display", "none");
            }
            
        }
        
        function updateQnA(postId) {
            var title = $('#qnaUpdateForm'+postId+' > table > tbody > tr:nth-child(1) > td:nth-child(2) > font.post-title > input[type=text]').val();
            var content = $('#qnaUpdateForm'+postId+' > table > tbody > tr:nth-child(2) > td > textarea').html();
            var category = $('#'+postId+'_firstCate').val();
            if (title == "" || title == null) {
                 Swal.fire({
                    text: '제목을 입력해주세요.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#00c2c7',
                    confirmButtonText: '예',
                }).then((result) => {
                    return;
                });
                
            }

            if (category == "" || category == null) {
                Swal.fire({
                    text: '카테고리를 선택해주세요.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#00c2c7',
                    confirmButtonText: '예',
                }).then((result) => {
                    return;
                });
            }

            if (content == "" || content == null) {
                Swal.fire({
                    text: '내용을 입력해주세요.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#00c2c7',
                    confirmButtonText: '예',
                }).then((result) => {
                    return;
                });

            }
            //alert($('#qnaUpdateForm'+postId).serialize());
            $('#qnaUpdateForm'+postId).attr("method", "POST").attr("action", "/myPage/updateQna").submit();
        }

        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("#qnaForm").attr("method", "POST").attr("action", "/myPage/addQnaAndQnaList").submit();
        }



        $(function() {

            $(".updateQna").on("click", function() {
                var num = $(this).next().next().val();

                var qnaFirstCate = $('#qnaFirstCate' + num).val();
                var postTitle = $('#postTitle' + num).val();
                var postContent = $('#postContent' + num).val().replace(/\n/g,"<br>");;

                if (postTitle == "" || postTitle == null) {
                    Swal.fire({
                        text: '제목을 입력해주세요.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#00c2c7',
                        confirmButtonText: '예',
                    }).then((result) => {
                        return;
                    });
                }

                if (qnaFirstCate == "" || qnaFirstCate == null) {
                     Swal.fire({
                        text: '카테고리를 선택해주세요.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#00c2c7',
                        confirmButtonText: '예',
                    }).then((result) => {
                        return;
                    });
                }

                if (postContent == "" || postContent == null) {
                     Swal.fire({
                        text: '내용을 입력해주세요.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#00c2c7',
                        confirmButtonText: '예',
                    }).then((result) => {
                        return;
                    });

                }



                $("#qnaUpdateForm" + num).attr("action", "/myPage/updateQna").attr("method", "post").submit();

            })

            $(".fa-cog").on("click", function() {
                var postId = $(this).next().val();
                var num = $(this).next().next().val();

                $("#mediaBody" + num).css("display", "none");
                $("#updateDiv" + num).css("display", "block");

                //$("#qnaUpdateForm"+num).attr("action","/myPage/updateQna").attr("method","post").submit();

            })

            $(".fa-times-circle").on("click", function() {
                var postId = $(this).next().val();
                var num = $(this).next().next().val();
                $(self.location).attr("href", "/myPage/deleteQna?postId=" + postId);
            })


            /*답글보는 로직  */
            $("b:contains('답글보기')").on("click", function() {
                console.log($(this).next().val());
                var postId = $(this).next().val();
                var num = $(this).next().next().val();

                $.ajax({
                    url: "/myPage/json/getQnaCommentList",
                    method: "post",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    data: JSON.stringify({
                        postId: postId
                    }),
                    success: function(JSONData) {
                        console.log(JSONData);
                        if (JSONData.returnMessage == 'ok') {

                            var qnaCommentList = JSONData.qnaCommentList;
                            console.log(qnaCommentList);
                            $("#appendCommentDiv" + num).html("");

                            for (var i = 0; i < qnaCommentList.length; i++) {

                                $("#appendCommentDiv" + num).append("<div class='media mt-3'>");
                                $("#appendCommentDiv" + num).append("<div class='media-body'>");
                                $("#appendCommentDiv" + num).append("<h5 class='mt-0' style='text-align: right;'>" + "답글" + "</h5>");
                                $("#appendCommentDiv" + num).append("<div align='right'><small>" + qnaCommentList[i].cmtDate + " , " + qnaCommentList[i].nickName + "</small></div>");
                                $("#appendCommentDiv" + num).append("<div id='qnaContentDiv' style='margin-top: 20px;text-align: right;'>" + qnaCommentList[i].cmtContent + "</div>");

                            }


                        } else if (JSONData.returnMessage == 'error') {
                            /* 	<div class="media mt-3">
						      	<div class="media-body">
							        <h5 class="mt-0" style="text-align: right;">답변제목</h5>
									<div align="right">
							        <small>답변 날짜 , 답변자</small>
									</div>
							        <div id="qnaContentDiv" style="margin-top: 20px;text-align: right;">
										답변내용
					 			  	</div>
						      </div>
						    </div>  */



                        }
                    }
                })

            }) /*답글보는 로직 end  */

            $("#yes").on("click", function() {
                var qnaFirstCate = $('#qnaFirstCate');
                var qnaSecondCate = $("#qnaSecondCate");
                var postContent = $("#postContent");
                var postTitle = $("#postTitle");



                if (postTitle.val() == "" || postTitle.val() == null) {
                    alert("제목을 입력해주세요");
                    return;
                }

                if (qnaFirstCate.val() == "" || qnaFirstCate.val() == null) {
                    alert("1차분류는 꼭 선택해주세요.");
                    return;
                }

                if (postContent.val() == "" || postContent.val() == null) {
                    alert("내용을 입력해주세요");
                    return;
                }


                $("#qnaForm").attr("action", "/myPage/addQna").attr("method", "post").submit();


            })

            $("#no").on("click", function() {
                var qnaFirstCate = $('#qnaFirstCate');
                var qnaSecondCate = $("#qnaSecondCate");
                var postContent = $("#postContent");
                var postTitle = $("#postTitle");

                $("#qnaFirstCate option:eq(0)").prop("selected", true);
                qnaSecondCate.css("display", "none");
                $(".secondCate").remove();
                postContent.val("");
                postTitle.val("");
            })

            $(".updateDelete").on("click", function() {
                var num = $(this).next().val();

                $("#mediaBody" + num).css("display", "block");
                $("#updateDiv" + num).css("display", "none");

            })



            $('#qnaFirstCate').change(function() {
                var state = $('#qnaFirstCate option:selected').val();

                var qnaSecondCate = $("#qnaSecondCate");


                if (state == 'A') {
                    $(".secondCate").remove();
                    qnaSecondCate.css("display", "block");
                    qnaSecondCate.append("<option disabled selected hidden>2차분류</option>");
                    qnaSecondCate.append("<option value='D' class='secondCate'>결제</option>");
                    qnaSecondCate.append("<option value='E' class='secondCate'>환불</option>");

                } else if (state == 'B') {
                    $(".secondCate").remove();
                    qnaSecondCate.css("display", "block");
                    qnaSecondCate.append("<option disabled selected hidden>2차분류</option>");
                    qnaSecondCate.append("<option value='F' class='secondCate'>항공권</option>");
                    qnaSecondCate.append("<option value='G' class='secondCate'>숙소</option>");
                } else if (state == 'C') {
                    $(".secondCate").remove();
                    qnaSecondCate.css("display", "none");
                }


            });
            
            

        });

    </script>


</head>

<body>
    <jsp:include page="/toolbar/toolBar.jsp"></jsp:include>
    <jsp:include page="/toolbar/pushBar.jsp"></jsp:include>

	<div class="row">
            <jsp:include page="/view/user/userSideBar.jsp"/>
            
        <div style="width:60%;margin-left:5%;">
            

    <form id="qnaForm">
        <input type="hidden" id="currentPage" name="currentPage" value=0 />

        <div class="container addQnA" style="background-color:#ccf2f3;border-radius:20px;">
            <div class="row">
                <div class="col-12">
                   <div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold;">1:1문의 등록</div>
                </div>
            </div>
            <div class="row">
                <div class="col-3">
                    <select id="qnaFirstCate" name="qnaFirstCate" class="form-control custom-select-sm" style="width: 150px;">
                        <option disabled selected hidden>1차분류</option>
                        <option value="A">주문관련</option>
                        <option value="B">상품관련</option>
                        <option value="C">기타</option>
                    </select>
                </div>
                <div class="col-3">
                    <select id="qnaSecondCate" name="qnaSecondCate" class="form-control custom-select-sm" style="width: 150px; display: none;"></select>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <input type="text" id="postTitle" name="postTitle" placeholder="제목을 입력해주세요." class="form-control">
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <textarea id="postContent" name="postContent" placeholder="문의사항을 작성해주세요." class="md-textarea form-control" rows="3"></textarea>
                </div>
            </div>
            <div class="row">
                <div class="col-12" style='text-align: right;'>
                    <button id="yes" type="button" class="btn btn-info btn-sm">등록</button>
                </div>
            </div>
        </div>
    </form>

    <div class="table-responsive QnAList">
        <c:forEach var="qna" items="${qnaList}" varStatus="status">
            <!-- 나의 1:1 문의 태그 시작 부분  -->
            <form id="qnaUpdateForm${qna.postId}">
                <table class="table QnA">
                    <tbody>
                        <tr>
                            <td rowspan="3" style='width:10%;text-align:right;'>
                                <img id="qimg" style="width: 40px;" alt="" src="/resources/images/admin/Qicon.png">
                            </td>
                            <td colspan="4" style='width:90%;'>
                                <c:if test="${qna.postGrade != 'Q' }">
                                    <span class="badge badge-pill badge-secondary">답변없음</span>
                                </c:if>
                                <c:if test="${qna.postGrade == 'Q' }">
                                    <span class="badge badge-pill badge-success">답변완료</span>
                                </c:if>
                                <font class="post-title">${qna.postTitle}</font>
                                <c:if test="${qna.postGrade != 'Q' }">
                                    <span style='display:inline-block;float:right'>
                                        <input type="hidden" value="${qna.postId}" name="postId">
                                        <i class="fas fa-cog"></i> &nbsp; &nbsp; <i class="far fa-trash-alt"></i>
                                    </span>
                                </c:if>
                                <br />
                                <font class="post-sm">
                                    <c:if test="${qna.qnaFirstCate == 'A' }">
                                        주문관련 >
                                    </c:if>
                                    <c:if test="${qna.qnaFirstCate == 'B' }">
                                        상품관련 >
                                    </c:if>
                                    <c:if test="${qna.qnaFirstCate == 'C' }">
                                        기타
                                    </c:if>
                                    <c:if test="${qna.qnaSecondCate=='D'}">
                                        결제
                                    </c:if>
                                    <c:if test="${qna.qnaSecondCate=='E'}">
                                        환불
                                    </c:if>
                                    <c:if test="${qna.qnaSecondCate=='F'}">
                                        항공권
                                    </c:if>
                                    <c:if test="${qna.qnaSecondCate=='G'}">
                                        숙소
                                    </c:if>
                                </font>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="4">${qna.postContent}</td>
                        </tr>
                        <tr>
                            <td colspan="4" style="font-size:10pt;color:#ffbd3e;">
                                <i class="fas fa-clock"></i>
                                <c:set var="qnaDate" value="${fn:split(qna.postDate,' ')}"></c:set>
                                <c:out value="${qnaDate[0]}"></c:out>에 질문하셨습니다.
                            </td>
                        </tr>
                        <c:forEach var="cmt" items="${qna.cmtList}">
                            <tr>
                                <td rowspan="2"></td>
                                <td rowspan="2" style="width:5%;text-align:right;"><img style="width:40px;" src="/resources/images/admin/Aicon.png"></td>
                                <td colspan="3" style='width:90%;'>${cmt.cmtContent}</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="width:90%;font-size:10pt;color:#ffbd3e;">
                                    <i class="fas fa-clock"></i>
                                    <c:set var="cmtDate" value="${fn:split(cmt.cmtDate,' ')}"></c:set>
                                    <c:out value="${cmtDate[0]}"></c:out>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </form>
            <!-- 나의 1:1 문의 태그 시작 부분  -->
        </c:forEach>
    </div>
        </div>
    </div>
    <jsp:include page="../../common/pageNavigator_new.jsp" />

    <script>
        $(document).ready(function() {
            
            function selectCate(obj) {
                alert(obj.val());
            }
            
            
            $('i.far.fa-trash-alt').on('click', function() {

                Swal.fire({
                    text: '정말 삭제하시겠습니까?',
                    //                text: "한 번 퇴장시키시면 채팅방뿐만 아니라 동행에서도 빠지게 됩니다.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '예',
                    cancelButtonText: '아니오',
                }).then((result) => {
                    if (result.value) {
                        var postId = $(this).parent().find('input[name="postId"]').val();
                        $(self.location).attr("href", "/myPage/deleteQna?postId=" + postId);
                    }
                });
            });
            
            
            $('i.fa-cog').on('click', function(){
                $(this).unbind();
                var postId = $(this).parent().find('input[name="postId"]').val();
                var title = $('#qnaUpdateForm'+postId+' table > tbody > tr:nth-child(1) > td:nth-child(2) > font.post-title').html();
                var content = $('#qnaUpdateForm'+postId+' > table > tbody > tr:nth-child(2) > td').html();


                $(this).parent().siblings('font.post-title').html('<input type="text" name="postTitle" value="'+title+'" style="width:80%;">');
                $('#qnaUpdateForm'+postId+' > table > tbody > tr:nth-child(2) > td').html('<textarea name="postContent" class="md-textarea form-control" rows="3">'+content+'</textarea>');
                var selectTag = "<br/><select id=\""+postId+"_firstCate\" name=\"qnaFirstCate\" class=\"form-control form-control-sm\" style=\"display:inline-block;width: 150px;\" onchange='selectCate(this, "+postId+")'>"
                selectTag += "<option disabled selected hidden>1차분류</option>"
                selectTag += "<option value=\"A\">주문관련</option>"
                selectTag += "<option value=\"B\">상품관련</option>"
                selectTag += "<option value=\"C\">기타</option>"
                selectTag += "</select>"
                selectTag += "<select id=\""+postId+"_secondCate\" name=\"qnaSecondCate\" class=\"form-control custom-select-sm\" style=\"width: 150px; display:none;\"></select>";
                $('#qnaUpdateForm'+postId+' > table > tbody > tr:nth-child(1) > td:nth-child(2) > font.post-sm').html(selectTag);
                
                var submitBtn = "<button type=\"button\" class=\"btn btn-info btn-sm\" style='float:right;' onclick='updateQnA("+postId+")'>등록</button>"
                $('#qnaUpdateForm'+postId+' > table > tbody > tr:nth-child(3) > td').append(submitBtn);


            })

        });

    </script>


</body>
<jsp:include page="/toolbar/footer.jsp"></jsp:include>

</html>
