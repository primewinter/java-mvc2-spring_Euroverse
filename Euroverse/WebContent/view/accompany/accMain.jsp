<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <meta charset="EUC-KR">
    <title>Euroverse</title>
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
        .post-sm {
            font-size: 9pt;
        }

        .euro-btn {
            color: white;
            background-color: #009688;
        }

        .euro-btn:hover {
            color: lightgray;
            background-color: #005582;
        }

        .category {
            font-size: 12pt;
            font-weight: 400;
            color: #999999;
        }

        .category span:hover {
            font-size: 12pt;
            font-weight: 700;
            color: #00c2c7;
        }

        .ctgr-on {
            color: #00c2c7;
            font-weight: 700;
        }

        .ctgr-off {
            color: #999999;
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

        jQuery(document).ready(function($) {

            var size = '${search.sorting}';
            if (size.length == 0) {
                console.log(size.length + " badge-info");
                $('.post-ctgr').addClass('ctgr-on');
            } else {
                console.log(size.length + " badge-secondary");
                $('.post-ctgr').addClass('ctgr-off');
            }

        });

        function getQnaList() {
            self.location = '/community/getPostList?boardName=G';
        }

    </script>

</head>

<body>

    <!-- ToolBar Start /////////////////////////////////////-->
    <jsp:include page="/toolbar/toolBar.jsp" />
    <jsp:include page="/toolbar/pushBar.jsp" />
    
    <!-- ToolBar End /////////////////////////////////////-->

    <!--  화면구성 div Start /////////////////////////////////////-->
    <div>
        <div class="row">
            <jsp:include page="/view/accompany/accSidebar.jsp"/>
            
        <div style="width:60%;margin-left:5%">

        <div class="h4" id="boardTitle" style="font-weight: bold; margin-top:40px;padding-left:10px;">
            <c:if test="${param.boardName=='D'}">
                동행찾기
            </c:if>
        </div>

        <!-- table 위쪽 검색 Start /////////////////////////////////////-->
        <div class="row" style="margin: 10px;">

            <div class="col-md-12 text-right upper-wrap">

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

        <div class="table-responsive" style="font-size:14px;">
            <!--  table Start /////////////////////////////////////-->
            <table class="table table-hover" style="text-align:center;">

                <thead>
                    <tr>
                        <th scope="col" style="width: 7%">글번호</th>
                        <th scope="col" style="width: 12%">동행날짜</th>
                        <th scope="col" style="width: 38%">제목</th>
                        <th scope="col" style="width: 7%">인원</th>
                        <th scope="col" style="width: 18%">작성자</th>
                        <th scope="col" style="width: 10%">작성일</th>
                        <th scope="col" style="width: 7%">조회수</th>
                        <!--<th scope="col" style="width: 7%">추천수</th>-->
                    </tr>
                </thead>

                <tbody>

                    <c:set var="i" value="0" />
                    <c:forEach var="post" items="${list}">
                        <tr>
                            <c:if test="${post.postGrade == 'N'}">
                                <th scope="row" style="color:#CE1717;">공지 <i class="fas fa-bullhorn"></i></th>
                                <td style="text-align:left;">
                                    <input type="hidden" id="postId" name="postId" value="${post.postId}" /><span>${post.postTitle}</span> <span style="color:red;">(${post.comments})</span></td>
                            </c:if>
                            <c:if test="${post.postGrade == 'B' || post.postGrade == null}">
                                <c:set var="i" value="${ i+1 }" />
                                <th scope="row">
                                    <font class='post-sm'>${post.postId}</font>
                                </th>
                                <c:if test="${post.accEndDate == null}">
                                    <td>
                                        <fmt:formatDate value="${post.accStartDate}" pattern="MM.dd" />
                                    </td>
                                </c:if>
                                <c:if test="${post.accEndDate != null}">
                                    <td>
                                        <fmt:formatDate value="${post.accStartDate}" pattern="MM.dd" /> ~
                                        <fmt:formatDate value="${post.accEndDate}" pattern="MM.dd" />
                                    </td>
                                </c:if>
                                <td style="text-align:left;">
                                    <input type="hidden" id="postId" name="postId" value="${post.postId}" />
                                    <span style="color:black;">
                                    </span>
                                    ${post.postTitle} <span style="color:red;">(${post.comments})</span></td>
                                    <td>${post.accCount}/${post.accPerson}</td>
                            </c:if>
                            <td><img src='/resources/images/userImages/${post.user.userImg}' style='border-radius:50%;width:25px;height:25px;border:solid 2px #009688;margin-right:0.5em;'>${post.nickName}</td>
                            <td>
                                <font class='post-sm'>
                                    <fmt:formatDate value="${post.postDate}" pattern="yyyy.MM.dd" />
                                </font>
                            </td>
                            <td>
                                <font class='post-sm'>${post.views}</font>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>

            </table>
        </div>
        <!--  table End /////////////////////////////////////-->
        <button type="button" id="addpost_view" class="btn btn-sm euro-btn">작성하기</button>
              <!-- PageNavigation Start... -->
    <jsp:include page="../../common/pageNavigator_new.jsp" />
            </div>
        </div>
    </div>
    <!--  화면구성 div End /////////////////////////////////////-->

  
    <!-- PageNavigation End... -->
    <jsp:include page="/toolbar/footer.jsp" />
</body>

</html>
