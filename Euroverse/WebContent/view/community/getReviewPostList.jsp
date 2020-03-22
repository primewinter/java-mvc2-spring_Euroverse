<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">
    <title>Euroverse</title>
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--MATERIAL DESIGN CDN-->
    <link href="https://unpkg.com/material-components-web@v4.0.0/dist/material-components-web.min.css" rel="stylesheet">
    <script src="https://unpkg.com/material-components-web@v4.0.0/dist/material-components-web.min.js"></script>

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
        .post-date {
            font-size: 8pt;
        }
        .euro-btn {
            color: white;
            background-color: #009688;
        }

        .euro-btn:hover {
            color: lightgray;
            background-color: #005582;
        }

        figure.preview-img {
            position: relative;
            overflow: hidden;
            margin: 10px;
            min-width: 230px;
            max-width: 315px;
            width: 100%;
            height: 160px;
        }

        figure.preview-img img {
            max-width: 100%;
            //backface-visibility: hidden;
            //vertical-align: top;
            object-fit: cover;
            transform: scale(1.0);
            transition: transform .5s;
        }

        figure.preview-img img:hover {
            transform: scale(1.3);
            transition: .5s;
        }

        .upper-wrap {}

        .category {
            float: left;
            vertical-align: middle;
        }

        .search-section {
            float: right;
            vertical-align: middle;
        }



        div.review-row {
            padding: 1em;
        }

        div.review-row:hover {
            box-shadow: 0 0 11px rgba(33, 33, 33, .2);
        }

        .card-icons {
            font-size: 10pt;
            color: #999999;
            //letter-spacing:1em;
            word-spacing: 0.7em;
        }

        .card-title {
            font-size: 15pt;
        }

        .card-content {
            color: #999999;
            font-size: 0.875em;
            line-height: 140%;
            margin-top: 1em;
            margin-bottom: 1em;
        }

        .card-profile {
            color: #777777;
            font-size: 0.875em;
            margin-top: 1em;
        }

        #boardTitle {
            font-family: 'NIXGONM-Vb';
            /*            font-family: 'GmarketSansBold';*/
            /*        font-style: italic;*/
            display: inline-block;
            /*background-color: #ffcf00;*/
            background-color: #ffde3e;
            /*#8ad0d6;*/
            text-align: left;
            /*            transform: skew(-15deg);*/
        }

    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            $(".review-row").on("click", function() {
                var postId = $(this).find('input[name="postId"]').val();
                location.href = '/community/getPost?postId=' + postId + '&boardName=F';
            });

        });

        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form[name='detailForm']").attr("method", "POST").attr("action", "/community/getPostList").submit();
        }

        $(function() {
            $(".fas.fa-search").on("click", function() {
                fncGetUserList(1);
            });
        });

        $(function() {

            var boardName = $("#boardName").val();

            if (boardName == 'D') {
                $("td:nth-child(3)").on("click", function() {
                    var postId = $(this).find($("input[name='postId']")).val();
                    self.location = "/community/getPost?postId=" + postId + "&boardName=" + boardName;
                });
            } else {
                $("td:nth-child(2)").on("click", function() {
                    var postId = $(this).find($("input[name='postId']")).val();
                    self.location = "/community/getPost?postId=" + postId + "&boardName=" + boardName;
                });
            }
        });

        $(function() {

            var boardName = $("#boardName").val();

            $("#addpost_view").on("click", function() {
                self.location = "/community/addPost?boardName=" + boardName;
            });

            $("#boardTitle").on("click", function() {
                self.location = "/community/getPostList?boardName=" + boardName;
            });
        });

        function qnaKategotie(sorting) {

            if (sorting == 0) {
                $("select[name='sorting']").val("0").prop("selected", true);
            } else if (sorting == 1) {
                $("select[name='sorting']").val("1").prop("selected", true);
            } else if (sorting == 2) {
                $("select[name='sorting']").val("2").prop("selected", true);
            } else if (sorting == 3) {
                $("select[name='sorting']").val("3").prop("selected", true);
            } else if (sorting == 4) {
                $("select[name='sorting']").val("4").prop("selected", true);
            } else {
                $("select[name='sorting']").val("5").prop("selected", true);
            }
            fncGetUserList(1);
        }

        function onKeyDown() {
            if (event.keyCode == 13) {
                fncGetUserList(1);
            }
        }

    </script>

</head>

<body>

    <!-- ToolBar Start /////////////////////////////////////-->
    <jsp:include page="/toolbar/toolBar.jsp" />
    <jsp:include page="/toolbar/pushBar.jsp" />
    
    <!-- ToolBar End /////////////////////////////////////-->

    <!--  화면구성 div Start /////////////////////////////////////-->
	<div class="row">
            <jsp:include page="/view/community/sidebar.jsp"/>
            
        <div style="width:60%;margin-left:5%;">

        <div class="h4" id="boardTitle" style="font-weight: bold; margin-top: 40px;padding-left:10px;">
            여행후기
        </div>

        <!-- table 위쪽 검색 Start /////////////////////////////////////-->
        <div class="row" style="margin: 10px;">

            <div class="col-md-12 text-right upper-wrap">

                <div class='category' style="display:flex;">
                </div>
                <div class="search-section">
                    <form class="form-inline mt-2 mt-md-0" name="detailForm" style="float:right;">
                        <input type="hidden" id="boardName" name="boardName" value="${param.boardName}" />

                        <div class="form-group">
                            <select class="form-control form-control-sm" name="searchCondition" style="height: 35px; width: 85px; font-size: 13px; margin-right: 2px;">
                                <option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>제목</option>
                                <option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>작성자</option>
                                <option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>태그</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="sr-only" for="searchKeyword">검색어</label>
                            <input type="text" class="form-control form-control-sm mr-sm-2" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${! empty search.searchKeyword ? search.searchKeyword : '' }" style="height: 35px; font-size: 13px;" onKeyDown="onKeyDown();">
                        </div>

                        &nbsp;<i class="fas fa-search"></i>

                        <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
                        <input type="hidden" id="currentPage" name="currentPage" value="" />

                    </form>
                </div>
            </div>
        </div>
        <!-- table 위쪽 검색 Start /////////////////////////////////////-->

        <div class="container">
            <c:set var="i" value="0" />
            <c:forEach var="post" items="${list}">
                <c:set var="i" value="${ i+1 }" />
                <div class="row review-row">
                    <input type="hidden" id="postId" name="postId" value="${post.postId}" />
                    <div class="col-md-4">
                        <div style="position: relative;">
                            <figure class="preview-img">
                                <!--<img style="height:200px;width:300px;" src="/resources/images/commImg/"/>-->
                                ${post.imgSrc}
                                <a href="#"></a>
                            </figure>

                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <div class="card-icons">
                                <fmt:formatDate value="${post.postDate}" pattern="yyyy.MM.dd" /> <i class="fas fa-comments"></i> ${post.comments} <i class="fas fa-heart"></i> ${post.postLikeCount} <i class="far fa-eye"></i> ${post.views}
                            </div>
                            <div class="card-title">${post.postTitle}</div>
                            <div class="card-content">
                                <c:set var="j" value="0" />
                                <c:forEach var="tag" items="${post.tagList}" varStatus="last">
                                    <c:set var="j" value="${ j+1 }" />
                                    <form id="tagForm" style="display:inline-block;">
                                        <input type="hidden" name="boardName" value="${post.boardName}" />
                                        <input type="hidden" name="searchCondition" value="2" />
                                        <input type="hidden" name="searchKeyword" value="${tag.tagContent}" />
                                        <a href="#" style="color: gray;" type="button">#${tag.tagContent}</a>
                                    </form>
                                    <!--<c:if test="${!last.last}">
                                        <i>,</i>
                                    </c:if>-->
                                </c:forEach>
                            </div>
                            <div class="card-profile"><img src='/resources/images/userImages/${post.user.userImg}' style='border-radius:50%;width:1.25em;height:1.25em;border:solid 2px #009688;margin-right:0.5em;'>${post.nickName}</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <!--  table End /////////////////////////////////////-->
        <button type="button" id="addpost_view" class="btn btn-sm euro-btn">작성하기</button>
        </div>
    </div>
    <!--  화면구성 div End /////////////////////////////////////-->

    <!-- PageNavigation Start... -->
    <jsp:include page="../../common/pageNavigator_new.jsp" />
    <!-- PageNavigation End... -->
    <jsp:include page="/toolbar/footer.jsp" />
</body>

</html>
