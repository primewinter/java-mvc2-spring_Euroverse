<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.*" %>

<html>

<head>
    <meta charset="EUC-KR">
    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <!-- asome icon CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        body>div.container {
            border: 3px solid white;
            margin-top: 10px;

        }

    </style>
    <script type="text/javascript">
        $(function() {
            $("#refundApp2").click(function() {

                var orderId = $("#orderId").val();
                var flightId = $("#flightIds").val();
                var roomId = $("#roomIds").val("");
                var orderStatus = $("#orderStatus").val();
                orderStatus = "A";

                $.ajax({
                    url: "/order/json/getOrderRefund/" + orderId + "/" + "A",
                    method: "GET",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function(JSONData, status) {
                        console.log("시무룩...");
                        var displayValue = "<h4 align='left' id='title'>";
                        displayValue += "환불신청" +
                            "</h4>";

                        $("#title").html("");
                        $("#title").html(displayValue);
                        console.log("시무룩2...");
                    }

                })
                console.log("시무룩3...");
                $("#refund").modal("hide");
                $("#refundApp1").css('display', 'none');
            });
        });

        /*  
=======
    
    $(function() {
			$("#refundApp2").click(function(){
				
				
				var orderId = $("#orderId").val();
				var flightId = $("#flightIds").val();
				var roomId = $("#roomIds").val("");
				var orderStatus = $("#orderStatus").val();
					orderStatus = "A";
				
	 			$.ajax (
	 					{
	 						url : "/order/json/getOrderRefund/"+orderId+"/"+"A" ,
	 						method : "GET",
	 						dataType : "json",
	 						headers : {
	 							"Accept" : "application/json",
	 							"Content-Type" : "application/json"
	 						},
	 						success : function (JSONData, status ) {
	 							console.log("시무룩...");
	 							var displayValue = "<h4 align='left' id='title'>";
	 							displayValue += "환불신청"
	 										+ "</h4>";
	 								
	 							$("#title").html("");
	 							$("#title").html(displayValue);
	 							console.log("시무룩2...");
	 						}
	 						
	 					})
	 					console.log("시무룩3...");
	 					$("#refund").modal("hide");
	 					$("#refundApp1").css( 'display' , 'none');
			});
		});
    
   /*  
>>>>>>> refs/remotes/origin/master
    $( function () {
	$("#refundApp2").on('click' , function () {
		var orderId = $("#orderId").val();
		var flightId = $("#flightIds").val();
		var roomId = $("#roomIds").val("");
		var orderStatus = $("#orderStatus").val();
			orderStatus = 2;
		$("#refundApp2").modal("hide");
		
		$("#refundApp1").css( 'outline' , '0');
		
		self.location ="/order/getOrderRefund?orderId="+orderId+"&orderStatus="+orderStatus;
		
		//$("form").attr("method" , "POST").attr("action" , "/order/getOrderRefund").submit();
	});
});  */

        $(function() {
            $(".btn.btn-warning").click(function() {
                if ($("#role").val() != 'A') {
                    self.location = "/order/getOrderList";
                } else {

                    self.location = "/order/getOrderListAdmin";
                }
            });
        });

    </script>
    <style>
        .getOrder {
            width: 60%;
            margin: auto;
            font-size: 10pt;
        }

        table {
            font-size: 10pt;
        }

        div.h4 {
            font-family: 'NIXGONM-Vb';
            font-weight: bold;
            display: inline-block;
            background-color: #ffde3e;
        }

    </style>
</head>

<body>
    <jsp:include page="/toolbar/toolBar.jsp" />
    <jsp:include page="/toolbar/pushBar.jsp" />
    <form>
    <br/>
        <input type="hidden" name="role" id="role" value="${user.role }" />
        <input type="hidden" name="orderId" id="orderId" value="${order.orderId }" />
        <input type="hidden" name="orderStatus" id="orderStatus" value="${order.orderStatus }" />
        <input type="hidden" name="flightId" id="flightIds" value="${flight.flightId }" />
        <input type="hidden" name="roomId" id="roomIds" value="${room.roomId }" />
        <div class="container getOrder">

            <h4 align="left" id="title" style="margin-left:480px;">
                <c:if test="${order.orderStatus == 'O' }">
                    주문완료
                </c:if>
                <c:if test="${order.orderStatus == 'A' }">
                    환불신청
                </c:if>
                <c:if test="${order.orderStatus == 'R' }">
                    환불 처리중
                </c:if>
                <c:if test="${order.orderStatus == 'C' }">
                    환불완료
                </c:if>
            </h4>
            <c:if test="${room.roomName == null }">
                <div class="row">
                    <div class="h4">항공 정보</div>
                </div>
                <hr/>
                <div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">항공사</div>
                        <div class="col-md-9">${flight.airline}</div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">출발시간 - 도착시간</div>
                        <div class="col-md-9">
                          ${flight.depDate.substring(0,4)}/${flight.depDate.substring(4,6)}/${flight.depDate.substring(6,8)} &nbsp;&nbsp;${flight.depTime}
					      <c:if test="${flight.tripCourse == 'R' }" >
					      &nbsp;&nbsp;-&nbsp;&nbsp;${flight.arrDate.substring(0,4)}/${flight.arrDate.substring(4,6)}/${flight.arrDate.substring(6,8)} &nbsp;&nbsp;${flight.arrTime}
					      </c:if>
                        </div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">소요시간(경유)</div>
                        <div class="col-md-9">${flight.leadTime}(${flight.stopOver})</div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">구간</div>
                        <div class="col-md-9">
                            <c:if test="${flight.tripCourse == 'R' }">
                                <td>왕복 구간</td>
                            </c:if>
                            <c:if test="${flight.tripCourse == 'O' }">
                                <td>편도 구간</td>
                            </c:if>
                        </div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">가격</div>
                         <div class="col-md-9"><fmt:formatNumber value="${flight.price}" pattern="###,###" />원</div>
                    </div>
                </div>
                <hr />
            </c:if>
            <c:if test="${flight.depCity == null }">
               <div class="row">
                    <div class="h4">숙소 정보</div>
                </div>
                <hr/>
                <div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">숙소</div>
                        <div class="col-md-9">${room.roomName}</div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">체크인 - 체크아웃</div>
                        <div class="col-md-9">
                           ${fn:trim(room.checkIn).substring(0,4)}/${fn:trim(room.checkIn).substring(4,6)}/${fn:trim(room.checkIn).substring(6,8)} -
			      ${fn:trim(room.checkOut).substring(0,4)}/${fn:trim(room.checkOut).substring(4,6)}/${fn:trim(room.checkOut).substring(6,8)}
                        </div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">객실 수</div>
                        <div class="col-md-9">${room.roomNum}</div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">숙박인원</div>
                        <div class="col-md-9">성인 ${room.adultNum}명, 유아 ${room.childNum}명</div>
                    </div>
                    <div class="row" style="margin-bottom: 15px">
                        <div class="col-md-3">가격</div>
                         <div class="col-md-9"> <fmt:formatNumber value="${room.price}" pattern="###,###" />원</div>
                    </div>
                </div>
                <hr />
            </c:if>


            <div class="row">
                <div class="h4">결제 정보</div>
                <c:if test="${order.orderStatus == 'C' }">
                    <i class="fas fa-hand-holding-usd" style="font-size:40px;"></i>
                    <div class="h4">환불 정보</div>
                </c:if>
            </div>
            <hr />
            <div class="row">
                <div class="col-sm-2">
                    총 결제 금액
                    <div class="row">
                        <c:if test="${flight.depCity == null }">
                            <div id="totalAmount" style="Padding-left:30px;">
                                <fmt:formatNumber value="${room.price}" pattern="###,###" />원</div>
                        </c:if>
                        <c:if test="${room.roomName == null }">
                            <!-- flight.price 로 바꿔줘야함 -->
                            <div id="totalAmount" style="Padding-left:30px;">
                                <fmt:formatNumber value="${flight.price}" pattern="###,###" />원</div>
                        </c:if>
                    </div>
                </div>
                <div class="col-sm-1">
                    <i class="fas fa-minus-circle" style="margin-top:10px;"></i>
                </div>

                <c:set var="i" value="0" />
                <c:forEach var="point" items="${point}">
                    <c:set var="i" value="${i+1}" />
                    <c:if test="${point.usedType == 'U'}">
                        <div class="col-sm-2" style="Padding-left:30px;">
                            포인트 할인
                            <div class="row">
                                <!--         if (point.getUsedType() == "R") {
							order.setAddPoint(point.getUsedPoint());
						}else if(point.getUsedType() == "U") {
							order.setPayPoint(point.getUsedPoint());
						} -->
                                <div id="usedPoint" > - ${point.usedPoint} P</div>
                            </div>

                        </div>
                    </c:if>
                </c:forEach>

                <div class="col-sm-1">
                    <i class="fas fa-equals" style="margin-left:15px;margin-top:10px;"></i>
                </div>
                <div class="col-sm-2" style="Padding-left:40px;">
                    실 결제 금액
                    <div class="row">
                        <div id="actualAmount" style="Padding-left:20px;">
                            <fmt:formatNumber value="${order.actualAmount}" pattern="###,###" />원</div>
                    </div>
                </div>
                <c:if test="${order.orderStatus == 'C' }">
                    <div class="col-4">
                        <!-- style="background-color:whitesmoke;width:40%;" -->
                        <div class="" style="margin-left:50px;">환불 금액</div>
                        <div class="row">
                            <div id="actualAmount" style="margin-left:60px;">
                                <fmt:formatNumber value="${order.actualAmount}" pattern="###,###" />원</div>
                        </div>
                    </div>
                </c:if>
            </div>
            <br />
            <hr style="width:60%;float:left;margin-right:700px;" />


            <div class="row" style="Padding-left:170px;">
                <div class="col-sm-1" style="margin-top:10px;">
                    <i class="fas fa-plus"></i>
                </div>
                <c:set var="i" value="0" />
                <c:forEach var="point" items="${point}">
                    <c:set var="i" value="${i+1}" />
                    <c:if test="${point.usedType == 'R' || point.usedType == 'F' }">

                        <div class="col-sm-2" style="margin-left:30px;">
                            <p>적립 된 포인트</p>
                            <%-- <c:if test="${point.usedType eq 'F' | point.usedType eq 'R' }"> --%>
                            <div id="addPoint" style="Padding-left:20px;">${point.usedPoint} P </div>
                        </div>
                    </c:if>
                </c:forEach>
                <div class="col-sm-1" style="margin-left:20px;">
                    <i class="fas fa-equals" style="margin-left:15px;margin-top:10px;"></i>
                </div>
                <div class="col-sm-2" style="margin-left:50px;">
                    <p>총 포인트</p>
                    <div id="totalPoint" style="margin-left:10px;">${user.totalPoint} P </div>
                </div>
                <c:if test="${order.orderStatus == 'C' }">
                    <div class="col-4">
                        <p style="margin-left:50px;">환불 일시</p>
                        <div id="refundDate" style="margin-left:50px;">${order.refundDate} </div>
                    </div>
                </c:if>
            </div>
            <br />
            <div class="row">
                <div class="h4">구매자 정보</div>
            </div>
            <hr />
            <div>
                <div class="row" style="margin-bottom: 15px">
                    <div class="col-md-3">구매자</div>
                    <div class="col-md-9">${order.buyerName}</div>
                </div>
                <div class="row" style="margin-bottom: 15px">
                    <div class="col-md-3">연락처</div>
                    <div class="col-md-9">${order.buyerPhone}</div>
                </div>
                <div class="row" style="margin-bottom: 15px">
                    <div class="col-md-3">Email</div>
                    <div class="col-md-9">${order.buyerEmail}</div>
                </div>
                <div class="row" style="margin-bottom: 15px">
                    <div class="col-md-3">할부</div>
                    <div class="col-md-9">${order.payInstal} 개월</div>
                </div>
                <div class="row" style="margin-bottom: 15px">
                    <div class="col-md-3">결제방식</div>
                    <c:if test="${order.payOpt == '0' }">
                        <div class="col-md-9">휴대폰 소액 결제</div>
                    </c:if>
                    <c:if test="${order.payOpt == '1'}">
                        <div class="col-md-9">카드결제</div>
                    </c:if>
                </div>
            </div>
            <hr />

            <div class="form-group" align="center">
                <button type="button" class="btn btn-warning">확인</button>
                <c:if test="${order.orderStatus == 'O' &&  user.role != 'A'}">
                    <button type="button" class="btn btn-info" id="refundApp1" data-toggle="modal" data-target="#refund">
                        환불 신청
                    </button>
                </c:if>
                <!-- 	<button type="button" class="btn btn-primary" id="refundApp1" data-toggle="modal" data-target="#refund">
			   환불 신청
			</button> -->
            </div>

        </div>

        <div class="modal fade" id="refund" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">환불 신청</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        예약한 상품을 환불 신청 하시겠습니까?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="reset" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="refundApp2">환불신청</button>
                    </div>
                </div>
            </div>
        </div>




        <%-- 		<div class="row">
		
			<div class="col-xs-4 col-md-2"><strong>도착도시</strong></div>
			<div class="col-xs-8 col-md-4">${flight.depCity }</div>
		 <c:if test="${flight.depCity == null }">
			<div class="col-xs-4 col-md-2"><strong>도착지역</strong></div>
			<div class="col-xs-8 col-md-4">${room.roomCity }</div>
		</c:if>
		</div>
	<hr/>
	
	<div class="row">
	<c:if test="${flight.arrCity == null }">
			<div class="col-xs-4 col-md-2"><strong>숙소이름</strong></div>
			<div class="col-xs-8 col-md-4">${room.roomName }</div>
	</c:if>
	<c:if test="${room.roomName == null }">
			<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${flight.arrCity }</div>
	</c:if>
		</div>
	<hr/>
	
	<div class="row">
			<div class="col-xs-4 col-md-2"><strong>orderId</strong></div>
			<div class="col-xs-8 col-md-4">${order.orderId }</div>
		</div>
	<hr/> --%>

    </form>
    <jsp:include page="/toolbar/footer.jsp" />
</body>

</html>
