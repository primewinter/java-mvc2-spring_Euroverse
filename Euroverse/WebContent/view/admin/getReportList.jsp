<%@ page language="java"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.*" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<html>

<head>
    <title>신고게시판</title>
    <meta charset="EUC-KR">
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
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>



    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- asome icon CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        image {
            border: 1px solid lightpink;
        }

        h3 {
            color: white;
            font-family: Consolas;
        }
        
        .getReportList {
            width: 70%;
            margin: auto;
        }
        
        div.h4.postList, div.h4.cmtList {
            opacity:0.5;
        }
        div.h4.postList:hover, div.h4.cmtList:hover {
            opacity:1;
        }
        .table {
            font-size: 10pt;
        }


    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
         $(document).ready(function() {
            
             if('${report}'=='post') {
                $("div.h4.postList").css('opacity','1');
            } else {
                $("div.h4.cmtList").css('opacity','1');
            }
             
             
             
             
             $("div.h4.postList").on("click",function(){
                postLoad();
            });
            
             $("div.h4.cmtList").on("click",function(){
                cmtLoad();
            });
        })
        
        
	     /* //=============    검색 / page 두가지 경우 모두  Event  처리 =============	 */
		 function fncGetUserList(currentPage) {
			$("#currentPage").val(currentPage)
			$("form").attr("method" , "GET").attr("action" , "/admin/getPostReportList").submit();
		};//end of getUserList(CurrentPage)
	 
	
		/*======== 검색시 페이지를 1페이지로 돌리기위해] =============  */
		$(function() {
			 $( ".fas.fa-search" ).on("click" , function() {
			 	fncGetUserList(1);
			 }); 
		});//end of function
		
		function postLoad() {
			$("#aaaa").attr("method" , "GET").attr("action" , "/admin/getPostReportList").submit();
		}
		
		function cmtLoad(){
			$("form").attr("method", "GET").attr("action", "/admin/getCmtReportList").submit();
		}
		
				
		function postdispose(refId){
			
			$.ajax({
				url: "/admin/json/updatePostReport/"+refId,
				method: "GET",
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				dataType : "json" ,
				/* success: function(data){
					alert("success??")
					$('#'+refId).html('처리완료');
					$('#'+refId).css('class','btn btn-primary');
				},
				error: fuction(error){
					alert("error??")
					console.log(error);
				}//error */
				}).always(function(data){

				swal({
					  title: "규제 하시겠습니까?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})//swal
					.then((willDelete) => {
					  if (willDelete) {
					    swal("규제되었습니다!", {
					      icon: "success",
					    });
					    $('#'+refId).html('처리완료');
						$('#'+refId).attr('class','btn btn-primary');
					  } else {
					  	
					  	}//else
					}); //then
				
			});//always
		}//dispose()
		
		function cmtdispose(refId){
			
			$.ajax({
				url: "/admin/json/updateCmtReport/"+refId,
				method: "GET",
				headers: { "Accept" : "application/json", "Content-Type" : "application/json" },
				/* success: function(){
					$('#'+refId).html('처리완료');
					$('#'+refId).css('class','btn btn-primary');
				},
				error: fuction(error){
					console.log(error);
				}//error */
			}).always(function(data){

				swal({
					  title: "규제 하시겠습니까?",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
					    swal("규제되었습니다!", {
					      icon: "success",
					    });
					    $('#'+refId).html('처리완료');
						$('#'+refId).attr('class','btn btn-primary');
					  } else {
					  }
					});
				
			})//ajax
		}//dispose()
		
	/* 	$(function(){
			$('td:nth-child(6)').on("click", function(){
				
				var refId = $(this).find("input[name='refId']").val();
				var boardName = $(this).find("input[name='boardName']").val();
				alert(boardName);
				self.location ="/admin/getPost?postId="+refId;
				});
		}); */

    </script>

</head>

<body>
        <jsp:include page="/toolbar/toolBar.jsp" />
        <jsp:include page="/toolbar/pushBar.jsp" />
        <div class="container getReportList">

            <%-- <form class="form-inline" name="detailForm">
                <input type="hidden" name="imp_uid" value="" id="imp_uid" />
                <div class="form-group">
                    <select class="form-control" name="searchCondition">
                        <option value="0" ${ !empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>구매번호</option>
                        <option value="1" ${ !empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>구매자ID</option>
                        <option value="2" ${ !empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>구매자이름</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="sr-only" for="searchKeyword">검색어</label>
                    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" placeholder="검색어" value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
                </div>
                <button type="button" class="btn btn-default">검색</button>
                <input type="hidden" id="currentPage" name="currentPage" value="" />
            </form> --%>
            
            <div class="h4 postList" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;opacity:0.5">
                  게시글 신고목록
            </div>
            <div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;font-weight: bold; margin-top: 40px;margin-bottom:20px;opacity: 1;">
                |
            </div>
            <div class="h4 cmtList" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;opacity:0.5">
                댓글 신고목록
            </div>
            
                
     <form id="aaaa">
     	<input type="hidden" name="searchKeyword" value="post">
     
     </form>


    <form>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th scope="col">번호</th>
                    <th scope="col">신고자ID</th>
                    <th scope="col">종류</th>
                    <th scope="col">신고내용</th>
                    <th scope="col">신고대상번호</th>
                    <th scope="col">제목/내용</th>
                    <th scope="col">신고날짜</th>
                    <th scope="col">신고처리</th>
                </tr>
            </thead>

            <tbody>
                <c:set var="i" value="0" />
                <c:forEach var="report" items="${list}">
                    <c:set var="i" value="${i+1}" />
                    <tr>
                        <th scope="row">
                            ${i }
                        </th>
                        <td>${report.reportUserId}</td>
                        <c:if test="${report.reportReason == 'A' }">
                        <td>음란물</td>
                        </c:if>
                        <c:if test="${report.reportReason == 'R' }">
                        <td>허위사실</td>
                        </c:if>
                        <c:if test="${report.reportReason == 'E' }">
                        <td>기타</td>
                        </c:if>
                        <c:if test="${report.reportReason == 'F' }">
                        <td>욕설</td>
                        </c:if>
                        <c:if test="${report.reportReason == NULL }">
                        <td>&nbsp;</td>
                        </c:if>
                        <c:if test="${report.reportContent != null}">
                        <td>${report.reportContent}</td>
                        </c:if>
                        <c:if test="${report.reportContent == null}">
                        <td>내용없음ㅇ${report.reportContent}</td>
                        </c:if>
                        <td>${report.refId}</td>
                        <c:if test="${report.postTitle != null }">
                        <td>${report.postTitle}&nbsp;(${report.cmtCount })
                        <input type="hidden" id="refId" name="refId" value="${report.refId}"/></td>
                        </c:if>
                        <c:if test="${report.cmtContent != null }">
                        <td>${report.cmtContent }
                        <input type="hidden" id="refId" name="refId" value="${report.refId}"/></td>
                        </c:if>
                        <td><c:set var="reportDate" value="${fn:split(report.reportDate,' ')}"></c:set>
						<c:out value="${reportDate[0]}"></c:out></td>
                        <c:if test="${report.blocked == 'F' && report.postTitle != null }">
                        <td style='padding:5px;'><button type="button" class="btn btn-info btn-sm" onclick='postdispose("${report.refId}")' id="${report.refId }">규제하기</button></td>
                        </c:if>
                        <c:if test="${report.blocked == 'F' && report.postTitle == null }">
                        <td style='padding:5px;'><button type="button" class="btn btn-info btn-sm" onclick='cmtdispose("${report.refId}")' id="${report.refId }">규제하기</button></td>
                        </c:if>
                        <c:if test="${report.blocked == 'T' }">
                        <td style='padding:5px;'><button type="button" class="btn btn-primary">처리완료</button></td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </form>
    </div>
    
    	<!-- pageNavigator include  -->
		<jsp:include page="../../common/pageNavigator_new.jsp"/>
    
    	<jsp:include page="/toolbar/footer.jsp" />
    
    
</body>

</html>
