<%@ page language="java"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.*" %>

<html>

<head>
    <title>구매 목록조회</title>
    <meta charset="EUC-KR">

    <!-- 참조 : http://getbootstrap.com/css/   참조 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

    <!-- jQuery UI toolTip 사용 CSS-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jQuery UI toolTip 사용 JS-->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- asome icon CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
    <!--  ///////////////////////// CSS ////////////////////////// -->
    <style>
        h3 {
            color: white;
            font-family: Consolas;
        }

        #flight,
        #room {
            width: 100%;
            margin: auto;
            font-size: 11pt;
        }

        div.getOrderListAdmin {
            width: 60%;
            margin: auto;
            font-size: 10pt;
        }

        div.h4 {
            opacity: 0.5;
        }

        div.h4:hover {
            opacity: 1;
        }

    </style>

    <!--  ///////////////////////// JavaScript ////////////////////////// -->
    <script type="text/javascript">
        $(document).ready(function() {
            Show();
            $("div.h4.flightList").on("click",function(){
                Show();
            })
            $("div.h4.roomList").on("click",function(){
                doShow();
            })
            
        })

        function fncGetUserList(currentPage) {
            $("#currentPage").val(currentPage)
            $("form").attr("method", "POST").attr("action", "/order/getOrderList").submit();
        }

        $(function() {
            $("button.btn.btn-default").on("click", function() {
                fncGetUserList(1);
            });
        });

        function doShow() {
            $('div.h4.roomList').css('opacity','1');
            $('div.h4.flightList').css('opacity','0.5');
            if ($('#flight').is(":visible")) {
                $('#flight').hide();
                $('#iconf').hide();
                $('#room').show();
            }
        }

        function Show() {
            $('div.h4.flightList').css('opacity','1');
            $('div.h4.roomList').css('opacity','0.5');
            if ($('#room').is(":visible")) {
                $('#room').hide();
                $('#iconr').hide();
                $('#flight').show();
            }
        }

        $(function() {
            $('.fas.fa-list').on("click", function() {
                //var flightId = $("#flightId").val();
                var flightId = $(this).next().val();
                var orderId = $(this).next().next().val();
                self.location = "/order/getFlightOrder?flightId=" + flightId + "&orderId=" + orderId;
            })
            $('.fas.fa-list-ul').on("click", function() {
                var roomId = $(this).next().val();
                var orderId = $(this).next().next().val();
                self.location = "/order/getRoomOrder?roomId=" + roomId + "&orderId=" + orderId;
            })
        })

        /* ------------------------- 환불 신청에서 환불 처리중  변경 modal ------------------------- */
        function order(orderId) {
            var orderState = $('#' + orderId + ' option:selected').val();
            console.log("orderId " + orderId);
            console.log("orderState " + orderState);
            if (orderState == 'R') {

                $("#refundmodal3").modal('show');
                var orderIds = $("#confirmModal3Id").val(orderId);

            }
        }

        $(function() {
            $("#refundConfirm3").click(function() {
                var orderId = $(this).next().val();
                console.log("orderID : " + orderId);
                $.ajax({
                    url: "/order/json/updateOrderStatus/" + orderId,
                    method: "GET",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function(JSONData, status) {
                        var displayValue = "<select class='custom-select' name='orderStatus' id='${flight.orderId}' onChange='order2('${flight.orderId}')' >"
                        displayValue += "<option selected value='R' >환불처리중</option>" +
                            "<option value='C'>환불완료</option>" +
                            "</select>";

                        $("td #" + JSONData.orderId + "").html(displayValue);
                    }
                })
                $("#refundmodal3").modal("hide");
            });
        });
        /* ------------------------- 여기까징 ------------------------ */



        /* ------------------------- 환불완료로 변경 modal ------------------------- */
        function order2(orderId) {

            var orderState = $('#' + orderId + ' option:selected').val();
            console.log("orderId " + orderId);
            if (orderState == 'C') {

                $("#refundmodal4").modal('show');
                var orderIds = $("#confirmModal4Id").val(orderId);

            }
        }

        $(function() {
            $("#refundConfirm4").click(function() {
                var orderId = $(this).next().val();
                console.log("orderID : " + orderId);
                $.ajax({
                    url: "/order/json/payRefund/" + orderId,
                    method: "GET",
                    dataType: "json",
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json"
                    },
                    success: function(JSONData, status) {
                        console.log("시무룩...");
                        /* var displayValue = "<select class='custom-select' name='orderStatus' id='${flight.orderId}' onChange='order2('${flight.orderId}')' >"
 	 	 							 displayValue +=   "<option selected value='4'>환불완료</option>"
 	 	 							+ "</select>";
 	 	 						var value = "<td>"+JSONData.order.refundDate+"</td>";
 	 							 */
                        var result = "<p>환불완료 <i class='far fa-clock'></i>" + JSONData.order.refundDate + "</p>";

                        $("#" + JSONData.orderId + "s").remove();
                        $("#" + JSONData.orderId + "").html(result);
                    }

                })
                $("#refundmodal4").modal("hide");
            });
        });

        /* ------------------------- 여기까징 ------------------------ */
        /* -----------------------close modal----------------------- */
        $(function() {
            $("#resetmodal4").click(function() {

                /* if(  $("#refundmodal4")[0] != "undefined" ){
                	$("#refundmodal4")[0].reset();	
                } */
                var orderId = $(this).next().next().val();
                $("#refundmodal4").modal("hide");
                $('#' + orderId + ' option[value=R]').prop('selected', 'selected').change();
            })
            $("#resetmodal3").click(function() {
                /* if( typeof $("#refundmodal3")[0] != "undefined" ){
                	$("#refundmodal3")[0].reset();	
                } */
                var orderId = $(this).next().next().val();
                //alert(orderId);
                $("#refundmodal3").modal("hide");
                $('#' + orderId + ' option[value=A]').prop('selected', 'selected').change();
            })
        })
        
        

    </script>

</head>

<body>
    <jsp:include page="/toolbar/toolBar.jsp" />
    <jsp:include page="/toolbar/pushBar.jsp" />
    <form>
        <div class="container getOrderListAdmin">

            <div class="h4 flightList" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;">
                항공 주문관리
            </div>
            <div class="h4" style="font-family:'NIXGONM-Vb';display:inline-block;font-weight: bold; margin-top: 40px;margin-bottom:20px;opacity: 1;">
            |
            </div>
            <div class="h4 roomList" style="font-family:'NIXGONM-Vb';display:inline-block;background-color:#ffde3e;font-weight: bold; margin-top: 40px;margin-bottom:20px; padding-left:10px;">
                숙소 주문관리
            </div>

            <!--
            <i class="fas fa-plane" id="iconf" style="Padding-left:180px;font-size:40px;"></i>
            <i class="fas fa-bed" id="iconr" style="Padding-left:180px;font-size:40px;"></i>-->
            <table class="table table-hover" id="flight">
                <thead>
                    <tr style="text-align: center;">
                        <th scope="col" style="width:3%;"></th>
                        <th scope="col" style="width:20%;">항공사</th>
                        <th scope="col" style="width:30%;">출발 - 도착</th>
                        <th scope="col" style="width:10%;">주문회원</th>
                        <th scope="col" style="width:10%;">금액</th>
                        <th scope="col" style="width:12%;">결제일시</th>
                        <th scope="col" style="width:12%;">주문상태</th>
                    </tr>
                </thead>

                <tbody style="text-align: left;">

                    <c:set var="i" value="0" />
                    <c:forEach var="flight" items="${list}">
                        <c:set var="i" value="${i+1}" />
                        <tr>
                            <th scope="row">
                                <i class="fas fa-list"></i>
                                <input type="hidden" name="${flight.flightId}" value="${flight.flightId}" />
                                <input type="hidden" name="${flight.orderId }" value="${flight.orderId}" />
                            </th>
                            <td id="refund">${flight.airline}</td>
                            <td>${flight.depCity} - ${flight.arrCity} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${flight.depTime}  
                            <c:if test="${flight.arrDate=='none'}"> </c:if>
                            <c:if test="${flight.arrDate!='none'}"> - ${flight.arrTime}</c:if>
                            <br />
	                            ${flight.depDate.substring(0,4)}/${flight.depDate.substring(4,6)}/${flight.depDate.substring(6,8)} 
	                            <c:if test="${flight.arrDate=='none'}"> </c:if>
	                            <c:if test="${flight.arrDate!='none'}"> - ${flight.arrDate.substring(0,4)}/${flight.arrDate.substring(4,6)}/${flight.arrDate.substring(6,8)}  </c:if>
                           </td>
                            <td>${flight.buyerId }</td>
                            <td id="appendStatus">
                                <fmt:formatNumber value="${flight.price}" pattern="###,###" />원</td>
                            <td>${flight.orderDate}</td>
                            <td id="${flight.orderId }">
                                <c:if test="${flight.orderStatus == 'O' }">
                                    주문완료
                                </c:if>
                                <c:if test="${flight.orderStatus == 'A' }">
                                    <select class="custom-select custom-select-sm" onChange="order('${flight.orderId}')" name="orderStatus" id="${flight.orderId }" style="">
                                        <option selected value="A">환불신청</option>
                                        <option value="R">환불처리중</option>
                                        <option value="C" disabled>환불완료</option>
                                    </select>
                                </c:if>
                                <c:if test="${flight.orderStatus == 'R' }">
                                    <select class="custom-select custom-select-sm" onChange="order2('${flight.orderId}')" name="orderStatus" id="${flight.orderId }s" style="">
                                        <option selected value="R">환불처리중</option>
                                        <option value="C" id="4">환불완료</option>
                                    </select>
                                </c:if>
                                <c:if test="${flight.orderStatus == 'C' }">
                                    <p>환불완료 <i class="far fa-clock"></i> ${flight.refundDate }</p>
                                </c:if>

                            </td>

                        </tr>
                    </c:forEach>
                </tbody>
            </table>



            <table class="table table-hover" id="room">

                <thead>
                    <tr style="text-align: center;">
                        <th scope="col" style="width:3%;"></th>
                        <th scope="col" style="width:20%;">숙소</th>
                        <th scope="col" style="width:20%;">체크인 - 체크아웃</th>
                        <th scope="col" style="width:12%;">이용자</th>
                        <th scope="col" style="width:10%;">주문회원</th>
                        <th scope="col" style="width:10%;">금액</th>
                        <th scope="col" style="width:12%;">결제일시</th>
                        <th scope="col" style="width:12%;">주문상태</th>
                    </tr>
                </thead>

                <tbody>

                    <c:set var="i" value="0" />
                    <c:forEach var="room" items="${list2}">
                        <c:set var="i" value="${i+1}" />
                        <tr>
                            <th scope="row" id="refund2">
                                <i class="fas fa-list-ul"></i>
                                <input type="hidden" name="${room.roomId}" value="${room.roomId}" />
                                <input type="hidden" name="${room.orderId }" value="${room.orderId}" />
                            </th>
                            <td>${room.roomName}<br /> : ${room.roomCity}</td>
                            <td>${fn:trim(room.checkIn).substring(2,4)}/${fn:trim(room.checkIn).substring(4,6)}/${fn:trim(room.checkIn).substring(6,8)}
			      		- ${fn:trim(room.checkOut).substring(2,4)}/${fn:trim(room.checkOut).substring(4,6)}/${fn:trim(room.checkOut).substring(6,8)}</td>
                       
                            <td>${room.roomNum}개<br /><i class="fas fa-child"></i> ${room.adultNum}명, <i class="fas fa-baby"></i> ${room.childNum}명</td>
                            <td>${room.buyerId }</td>
                            <td>
                                <fmt:formatNumber value="${room.price}" pattern="###,###" />원</td>
                            <td>${room.orderDate}</td>
                            <td id="${room.orderId }">

                                <c:if test="${room.orderStatus == 'O' }">
                                    주문완료
                                </c:if>
                                <c:if test="${room.orderStatus == 'A' }">
                                    <select class="custom-select custom-select-sm" name="orderStatus" onChange="order('${room.orderId}')" id="${room.orderId }" style="">
                                        <option selected value="A" id="2">환불신청</option>
                                        <option value="R" id="3">환불처리중</option>
                                        <option value="C" id="4">환불완료</option>
                                    </select>
                                </c:if>
                                <c:if test="${room.orderStatus == 'R' }">
                                    <select class="custom-select custom-select-sm" name="orderStatus" onChange="order2('${room.orderId}')" id="${room.orderId }" style="">
                                        <option selected value="R">환불처리중</option>
                                        <option value="4" id="4">환불완료</option>
                                    </select>
                                </c:if>
                                <c:if test="${room.orderStatus == 'C' }">
                                    <p>환불완료 <i class="far fa-clock"></i> ${room.refundDate }</p>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- <button type="button" class="btn btn-primary" id="refundApp1" data-toggle="modal" data-target="#refund">
			   환불 신청
			</button> -->

            <div class="modal fade" id="refundmodal3" value="" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">환불 처리중으로 변경</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            환불 처리중으로 변경하시겠습니까?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="resetmodal3" data-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-primary" id="refundConfirm3">확인</button>
                            <input type="hidden" name="orderId" id="confirmModal3Id" value="" />

                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="refundmodal4" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">환불 처리 완료</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            환불 처리를 완료 하시겠습니까?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="resetmodal4" data-dismiss="modal">취소</button>
                            <button type="button" class="btn btn-primary" id="refundConfirm4">확인</button>
                            <input type="hidden" name="orderId" id="confirmModal4Id" value="" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--화면구성 div end-->
    </form>
    <jsp:include page="/toolbar/footer.jsp" />
</body>

</html>
