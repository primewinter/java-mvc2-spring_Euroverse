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

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!-- sweetalert2 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        @import url(https://fonts.googleapis.com/css?family=Raleway:400,500,800);

        div.plan-card:hover {
            box-shadow: 0 0 11px rgba(33, 33, 33, .2);
        }

        figure.snip1200 {
            position: relative;
            overflow: hidden;
            min-width: 220px;
            max-height: 310px;
            width: 100%;
            background: white;
            color: darkgray;
            text-align: center;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.15);
            font-size: 16px;
        }

        figure.snip1200 * {
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            -webkit-transition: all 0.45s ease-in-out;
            transition: all 0.45s ease-in-out;
        }

        figure.snip1200 img {
            max-width: 100%;
            position: relative;
            opacity: 0.9;
        }

        figure.snip1200 figcaption {
            position: absolute;
            top: 45%;
            left: 7%;
            right: 7%;
            bottom: 45%;
            border: 1px solid darkgray;
            border-width: 1px 1px 0;
        }

        figure.snip1200 .heading {
            overflow: hidden;
            -webkit-transform: translateY(50%); 
            transform: translateY(50%); 
            position: absolute;
            bottom: 0;
            width: 100%;
        }

        figure.snip1200 h5 {
            display: table;
            margin: 0 auto;
            padding: 0 10px;
            position: relative;
            text-align: center;
            width: auto;
            text-transform: uppercase;
            font-weight: 600;
            font-family: 'NIXGONM-Vb';
        }

        figure.snip1200 h5 span {
            font-weight: 800;
        }

        figure.snip1200 h5:before,
        figure.snip1200 h5:after {
            position: absolute;
            display: block;
            width: 1000%;
            height: 1px;
            content: '';
            background: darkgray;
            top: 50%;
        }

        figure.snip1200 h5:before {
            left: -1000%;
        }

        figure.snip1200 h5:after {
            right: -1000%;
        }

        figure.snip1200 p {
            top: 50%;
            -webkit-transform: translateY(-50%);
            transform: translateY(-50%);
            position: absolute;
            width: 100%;
            padding: 0 20px;
            margin: 0;
            opacity: 0;
            line-height: 1.6em;
            font-size: 0.9em;
        }

        figure.snip1200 a {
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
            position: absolute;
            z-index: 1;
        }

        figure.snip1200:hover img,
        figure.snip1200.hover img {
            /* opacity: 0.25; */
            -webkit-transform: scale(1.1);
            transform: scale(1.1); 
        }

        figure.snip1200:hover figcaption,
        figure.snip1200.hover figcaption {
            top: 7%;
            bottom: 7%;
        }

        figure.snip1200:hover p,
        figure.snip1200.hover p {
            opacity: 1;
            -webkit-transition-delay: 0.35s;
            transition-delay: 0.35s;
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
         .card-icons {
            font-size: 10pt;
            color: #999999;
            //letter-spacing:1em;
            word-spacing: 0.7em;
            text-align:right;
        }
        #boardTitle {
            font-family: 'NIXGONM-Vb';
/*            font-family: 'GmarketSansBold';*/
    /*        font-style: italic;*/
            display: inline-block;
            /*background-color: #ffcf00;*/
            background-color: #ffde3e; /*#8ad0d6;*/
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

            $("figure").on("click", function() {
                var postId = $(this).next().val();
                self.location = "/community/getPost?postId=" + postId + "&boardName=" + boardName;
            });

            $("#boardTitle").on("click", function() {
                self.location = "/community/getPostList?boardName=" + boardName;
            });
        });

        $(function() {

            var boardName = $("#boardName").val();

            $("#addpost_view").on("click", function() {
                self.location = "/community/addPost?boardName=" + boardName;
            });
        });

        $(".hover").mouseleave(function() {
            $(this).removeClass("hover");
        });

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
    <%-- <jsp:include page="/toolbar/pushBar.jsp" /> --%> 
    <!-- ToolBar End /////////////////////////////////////-->

    <!--  화면구성 div Start /////////////////////////////////////-->
	<div class="row">
            <jsp:include page="/view/community/sidebar.jsp"/>
            
        <div style="width:60%;margin-left:5%;">

        <div class="h4" id="boardTitle" style="font-weight: bold; margin-top: 40px;padding-left:10px;">
            플래너공유
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

        <div class="table-responsive" style="font-size:14px;overflow-x: hidden;">
            <!--  table Start /////////////////////////////////////-->
            <table class="table table-hover">

                <tbody>

                    <div class="row" style="width:985px;">

                        <c:set var="i" value="0" />
                        <c:forEach var="post" items="${list}">
                            <c:forEach var="plan" items="${plan}">
                                <c:set var="i" value="${ i+1 }" />
                                <c:if test="${post.planId == plan.planId}">

                                    <div class="col-md-4">
                                        <div class="card mb-4 shadow-sm plan-card">

                                            <div style="position: relative;">

                                                <figure class="snip1200">
                                                    <img style="height:250px;" width="100%" src="${plan.planImg}" />
                                                    <a href="#"></a>
                                                </figure>
                                                <input type="hidden" id="postId" name="postId" value="${post.postId}" />

                                            </div>

                                            <div class="card-body" style="font-size:13px;">
                                                
                                                <div class="card-text">
                                                    <span style="font-size:14px;font-weight: bold;">${post.postTitle}</span> <span style="color:red;">(${post.comments})</span>
                                                    <span class='card-icons' style='float:right'><fmt:formatDate value="${post.postDate}" pattern="yyyy.MM.dd" /> </span>
                                                    <br><br>
                                                    <div class='card-icons' style='text-align:left;'>
                                                        <c:choose>
                                                            <c:when test="${plan.planType == 'A'}">여자혼자</c:when>
                                                            <c:when test="${plan.planType == 'B'}">남자혼자</c:when>
                                                            <c:when test="${plan.planType == 'C'}">여자끼리</c:when>
                                                            <c:when test="${plan.planType == 'D'}">남자끼리</c:when>
                                                            <c:when test="${plan.planType == 'E'}">단체</c:when>
                                                            <c:when test="${plan.planType == 'F'}">부모님과</c:when>
                                                            <c:when test="${plan.planType == 'G'}">커플</c:when>
                                                        </c:choose>
                                                        <br>${plan.startDateString}<c:if test="${plan.endDate != null}">-${plan.endDate}</c:if>
                                                    </div>
                                                    <br><br>
                                                    <img src='/resources/images/userImages/${post.user.userImg}' style='border-radius:50%;width:25px;height:25px;border:solid 2px #009688;margin-right:0.5em;'>${post.nickName}
                                                     <span class="card-icons" style='float:right;bottom:0px;'>
                                                    <i class="fas fa-comments"></i>${post.comments} <i class="fas fa-heart"></i>${post.postLikeCount} <i class="far fa-eye"></i>${post.views}
                                                </span>
                                                <br>
                                                </div>
                                               
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div class="btn-group">
                                                        <!--  <button type="button" class="btn btn-sm btn-outline-secondary">플래너가져오기</button>
		                  <button type="button" class="btn btn-sm btn-outline-secondary">Edit</button> -->
                                                    </div>
                                                    <small class="text-muted"></small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:forEach>

                    </div>

                </tbody>

            </table>
        </div>
        <!--  table End /////////////////////////////////////-->
        <button type="button" id="addpost_view" class="btn btn-info btn-sm">작성하기</button>
        </div>
    </div>
    <!--  화면구성 div End /////////////////////////////////////-->

    <!-- PageNavigation Start... -->
    <jsp:include page="../../common/pageNavigator_new.jsp" />
    <!-- PageNavigation End... -->
    <jsp:include page="/toolbar/footer.jsp" />

</body>

</html>
