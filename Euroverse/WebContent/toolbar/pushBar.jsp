<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<style>
    /*동행 채팅 div 슬라이드*/
    #acc-slide * {
        margin: 0;
        padding: 0;
    }

    ul,
    li {
        list-style: none;
    }

    #acc-slide {
        font-family: 'NanumBarunGothic';
        font-weight: 400;
        background-color: white;
        display: none;
        height: 500px;
        width: 300px;
        /*position: relative;*/
        border: solid 1px #D2D2D2;
        position: fixed;
        right: 10px;
        bottom: 30px;
        overflow: hidden;
        z-index: 300;
    }

    #acc-slide ul {
        width: 200%;
        height: 100%;
        transition: 0.5s;
    }

    #acc-slide ul:after {
        content: "";
        display: block;
        clear: both;
    }

    #acc-slide li {
        float: left;
        width: 50%;
        height: 100%;
    }

    #acc-slide input[type=radio] {
        display: none;
    }

    #acc-slide label {
        display: inline-block;
        vertical-align: middle;
        width: 10px;
        height: 10px;
        border: 2px solid #666;
        background: #fff;
        transition: 0.3s;
        border-radius: 50%;
        cursor: pointer;
    }

    #acc-slide .pos {
        display: none;
        text-align: center;
        position: absolute;
        bottom: 10px;
        left: 0;
        width: 100%;
        text-align: center;
    }

    #pos1:checked~ul {
        margin-left: 0%;
    }

    #pos2:checked~ul {
        margin-left: -100%;
    }


    #pos1:checked~.pos>label:nth-child(1) {
        background: #666;
    }

    #pos2:checked~.pos>label:nth-child(2) {
        background: #666;
    }

    /*동행 채팅방 style*/
    #accChat {
        height: 100%;
        width: 100%;
        color: #333;
        font-size: 10px;
        background-color: #C5ECE9;
        z-index: 190;
    }

    .accChat.info {
        position: static;
        height: 7%;
        background-color: #C5ECE9;
    }

    .accChat.output {
        font-family: 'Nanum Gothic', sans-serif;
        font-weight: 700;
        position: static;
        height: 85%;
        width: 100%;
        background-color: white;
        overflow-y: auto;
        overflow-x: hidden;
    }

    .accLobby.content::-webkit-scrollbar, .output::-webkit-scrollbar {
        width: 10px;
    }

    .accLobby.content::-webkit-scrollbar-thumb, .output::-webkit-scrollbar-thumb {
        background-color: #858585;
        border-radius: 10px;
        background-clip: padding-box;
        border: 2px solid transparent;
    }

    .accLobby.content::-webkit-scrollbar-track, .output::-webkit-scrollbar-track {
        background-color: transparent;
        border-radius: 10px;
        box-shadow: inset 0px 0px 5px white;
    }

    .accChat.input {
        position: static;
        height: 40px;
        background-color: #C5ECE9;
    }


    /*아이콘들*/
    div.push-bar-menu {
        position: fixed;
        display: table;
        top: 3px;
        right: 10px;
        z-index: 9999;
    }
    
    div.push-bar-menu.shrink {
        position: fixed;
        display: table;
        top: 18px;
        right: 10px;
        z-index: 9999;
    }
    
    
    div.icon {
        display: table-cell;
        vertical-align: middle;
        /*border: solid 2px #858585;
        border-radius: 5px;*/
        width: 40px;
        height: 40px;
        color: #858585;
        font-size: 17pt;
        /*text-align: center;*/
    }



    /*푸시리스트*/
    #push-layer {
        background-color: white;
        font-weight: 300;
        border: solid 1px #D2D2D2;
        display: none;
        height: 500px;
        width: 300px;
        position: fixed;
        right: 10px;
        bottom: 30px;
        z-index: 300;
    }

    /*플래너채팅창*/
    #plan-chat-layer {
        display: none;
        border: solid 1px #D2D2D2;
        height: 500px;
        width: 300px;
        position: fixed;
        right: 10px;
        bottom: 30px;
        background-color: white;
        z-index: 300;
    }

    .planChat.output {
        font-family: 'Nanum Gothic', sans-serif;
        font-weight: 700;
        height: 92%;
        position: static;
        background-color: white;
        overflow: auto;
    }

    .planChat.input {
        height: 40px;
        position: static;
        background-color: #C5ECE9;
    }

    .push-bar-menu>div>div:hover {
        color: #339999;
    }
    

</style>


<div class="push-bar-menu">
   <div class="icon-table" style=“display:table-row;”>
        <div class="icon push-list" title="활동알림">
            <i class="fas fa-bell" ></i>
            <span class="unreadCount" style='position: relative; right: 10px; top:-10px; '></span>
        </div>
    </div>
    <div class="icon-table" style=“display:table-row;”>
        <div class="icon acc-chat" title="동행채팅">
            <i class="fas fa-comments" ></i>
        </div>
    </div>
    <div class="icon-table" style=“display:table-row;”>
        <div class="icon plan-chat" title="플래너 채팅">
            <i class="fas fa-comment fa-flip-horizontal"></i>
        </div>
    </div>
</div>


<div id="push-layer">
    <div class="deletePush" style='padding: 5%;background-color:#8ad0d6;font-weight: 700'>
        <span>활동 알림&ensp;</span><span class="totalCount"></span>
        <span style='float:right;'><a href='javascript:deletePush()'><i class="far fa-trash-alt" style="color:white;"></i></a></span>
    </div>
    <div class="pushList" style="overflow-y:auto; width:298px; height:88%;"></div>
</div>




<div id="acc-slide">
    <input type="radio" name="pos" id="pos1" checked>
    <input type="radio" name="pos" id="pos2">
    <ul>
        <!-- 채팅목록 -->
        <li>
            <div class="accLobby title" style='padding: 5%;background-color:#8ad0d6;font-weight:700'>
                동행 채팅
            </div>
            <div class="accLobby content" style="overflow-y:auto; width:300px; height:88%;"></div>
        </li>
        <!--채팅방-->
        <li>
            <div id="accChat">
                <div id="accChat">
                    <div class="accChat info">
                        <i class="fas fa-arrow-left fa-2x" style="float:left;margin:5px;"><span style="margin:5px;"></span></i>
                        <p style="float:right;margin: 5px;"><i class="fas fa-bars fa-2x" data-toggle="modal" data-target="#accModal"></i></p>
                    </div>
                    <div class="accChat output" style="padding:5px"></div>
                    <div class="accChat input" style="padding:5px">
                        <div class="input-group">
                            <input type="text" class="form-control form-control-sm" id="input-accChat" placeholder="메시지를 입력하세요">
                            <span class="input-group-btn" onclick="sendAccMessage()">
                                <button class="btn btn-default btn-sm" type="button"><i class="fab fa-telegram-plane"></i></button>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </ul>
</div>



<div id="plan-chat-layer">
    <div class="planChat output" style="padding:5px"></div>
    <div class="planChat input" style="padding:5px">
        <div class="input-group">
            <input type="text" class="form-control form-control-sm" id="myChat" placeholder="메시지를 입력하세요">
            <span class="input-group-btn">
                <button class="btn btn-default btn-sm" type="button"><i class="fab fa-telegram-plane"></i></button>
            </span>
        </div>
    </div>
</div>

<!--채팅 참여자 목록 모달-->
<div class="modal fade" id="accModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="false">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="accModalLabel">채팅방 제목</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form class="form-group accModal">
                    채팅 참여자 목록
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var userId = '${user.userId}';
    var pushAddr = "ws://localhost:8080/userSocket/";
    var userSocket;

    if (userId != null && userId != '') { // 로그인 했을 때만 웹소켓 연결
        pushAddr += userId;
        console.log("접속한 주소 "+pushAddr);
        userSocket = new WebSocket(pushAddr);
    
        //웹 소켓이 연결되었을 때 호출되는 이벤트
        userSocket.onopen = function(message) {
            console.log('[push] : 연결됐다.')
            //웹 소켓에서 메시지가 날아 왔을 때 호출되는 이벤트
            userSocket.onmessage = function(message) {
                console.log("push 왔다 ::: " + message.data)
                var obj = JSON.parse(message.data);
                var pushType = obj.pushType;
                //console.log("pushType :: " + pushType);
                if (pushType == 'P') {
                    const Toast = Swal.mixin({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 5000,
                        timerProgressBar: true,
                        onOpen: (toast) => {
                            toast.addEventListener('click', function() {
                                self.location = "/plan/getPlan?planId=" + obj.refId;
                            })
                        }
                    })

                    Toast.fire({
                        icon: 'success',
                        title: obj.pushMsg + ', 잊지 않으셨나요?'
                    });
                } else {
                    getPushList(userId);
                    getUnreadCount(userId);
                }
            };
            console.log('[push] : 여기까지오나.')
        };
        //웹 소켓이 닫혔을 때 호출되는 이벤트
        userSocket.onclose = function(message) {
            console.log("push 접속이 끊어졌습니다.\n");
        };
        //웹 소켓이 에러가 났을 때 호출되는 이벤트
        userSocket.onerror = function(message) {
            console.log("push 에러가 발생했습니다.\n");
        };
    }
    //웹소켓 종료
    function disconnect() {
        userSocket.close();
    }

    function sendPush(receiverId, pushType) {
        console.log('push 보낸다.');
        var push = new Object();
        console.log("[sendPush] receiverId : " + receiverId + " || pushType : " + pushType);
        push.receiverId = receiverId;
        push.pushType = pushType;
        userSocket.send(JSON.stringify({
            push
        }));
        //console.log("push 보냈음 ::" + JSON.stringify({push}));
    }

    function getPushList(userId) {
        $.ajax({
            url: "/push/json/getPushList/" + userId,
            type: "GET",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function(result) {
                console.log(result);
                var list = result.list;
                var resultPage = result.resultPage;
                var search = result.search;
                var totalCount = result.totalCount;
                $(".totalCount").html(totalCount);
                //console.log("totalCount : " + totalCount);
                //console.log("list.size : " + list.size);
                $(".pushList").html("");
                if ( totalCount == 0 ) {
                    $('.pushList').append("<p style='margin:1em;font-size:10pt;text-align:center;color:#999999'><i class=\"far fa-bell fa-2x\"></i><br/>활동알림이 없습니다.<br/>내 글에 달린 댓글, 동행신청, 플래너초대 등 새로운 소식을 알려드립니다.</p>");
                } else {
                    $.each(list, function(index, vo) {
                        showList(vo, 0);
                    })
                }

                //console.log("resultPage : " + resultPage);
                //console.log("search : " + search);
            },
            error: function(error, status) {
                console.log("알림 내역 출력 실패");
                console.log(error.responseText);
                console.log(status);
            }
        })
    }

    // <무한스크롤 ----------------------------------------------------------------------------
    var pushPage = 2;
    var end = false;

    // 스크롤 감지
    $(".pushList").scroll(function() {
        var scrollTop = $(this).scrollTop(); // 현재 스크롤의 위치
        var innerHeight = $(this).innerHeight(); // 패딩값을 포함한 현재 .pushList 구역의 높이
        var scrollHeight = $(this).prop('scrollHeight'); // 스크롤 시키지 않았을 때의 전체 높이
        //console.log("ScrollTop : "+scrollTop+"|| innerHeight : "+innerHeight+"|| scrollHeight : "+scrollHeight);
        if (scrollTop + innerHeight >= scrollHeight) { // scrollTop() 과 innerHeight() 값을 더한 값이 scrollHeight() 보다 같거나 크게 되면 맨 아래 감지 가능
            scrollList();
        }
    })

    // 스크롤 최하단에 위치 시 작동할 function(무한스크롤) : 리스트 호출
    function scrollList() {
        if (end == true) { //더 이상 불러올 data가 없는 경우 return
            return;
        }
        var search = new Object();
        search.currentPage = pushPage;
        $.ajax({
            url: "/push/json/getPushList/" + userId,
            type: "POST",
            data: JSON.stringify({
                search
            }),
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function(list) {
                var length = list.length;
                if (length < 5) {
                    isEnd = true;
                }
                $.each(list, function(index, vo) {
                    showList(vo);
                })

                pushPage++;
            },
            error: function(error) {
                console.log("fetchList 실패");
                console.log(error);
            }
        })
    }

    // 푸시리스트 호출 시 작동할 function : 리스트 화면에 출력
    function showList(vo, type) {
        var tag = "";
        tag += "<table style='margin:5%;width:90%;'>"
        tag += "<tbody style='width:100%;'>"
        tag += "<tr>"
        tag += "<td style='text-align:center;width:10%;'>"
        tag += "<input type='checkbox' name='chk' id='" + vo.pushId + "' value='" + vo.pushId + "'>"; // style='display:none;'
        tag += "</td>"
        tag += "<td style='text-align:left;width:90%;'>"
        tag += "<font size='2'  font color='black'>"
        if (vo.pushType.trim() == 'C' || vo.pushType.trim() == 'R') {
            tag += "<a href='/community/getPost?postId=" + vo.refId + "&boardName=" + vo.boardName + "'>";
        } else if (vo.pushType.trim() == 'I') {
            tag += "<a href='/myPage/myOfferList' >"; // 초대 목록 리스트 링크
        } else if (vo.pushType.trim() == 'A') {
            tag += "<a href='/myPage/myOfferList?searchKeyword=party' >" // 동행 신청 목록 리스트 링크
        }
        tag += vo.pushMsg + "</font></td>";
        tag += "<tr>";
        tag += "<td colspan='2' style='text-align:right;vertical-align:top;'>";
        tag += "<font size='1' font color='gray'>" + vo.pushTime + "</font></a>";
        tag += "</td>";
        tag += "</tr>";
        tag += "</tbody>"
        tag += "</table>"
        tag += "<style>"
        tag += "label { font-weight: normal; font-color: white; }"
        tag += "</style>";

        $(".pushList").append(tag);
    }

    // ----------------------------------------------------------------------------------------- 무한스크롤>

    function getUnreadCount(userId) {
        $.ajax({
            url: "/push/json/getUnreadCount/" + userId,
            type: "GET",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function(result) {
                console.log("안 읽은 알림 개수 출력 성공 : " + result + "개")
                var h = "<sup class=\"badge badge-pill badge-danger\" style='font-size: 3pt;'>" + result + "</sup>";
                $(".unreadCount").html(h);
            },
            error: function(error) {
                console.log("안 읽은 알림 개수 출력 실패");
                console.log(error);
            }
        })
    }

    function readPush(userId) {
        $.ajax({
            url: "/push/json/readPush/" + userId,
            type: "GET",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function() {
                console.log("알림 읽기 성공")
            },
            error: function(error) {
                console.log("알림 읽기 실패");
                console.log(error);
            }
        })
    }

    function deletePush() {
        console.log("삭제 시작")

        var arrayParam = new Array();
        //each로 loop를 돌면서 checkbox의 check된 값을 가져와 담아준다.
        $("input:checkbox[name='chk']:checked").each(function() {
            arrayParam.push($(this).val());
        });
        //console.log("배열!!! \n");
        //console.log(arrayParam);

        var formData = JSON.stringify(arrayParam);

        $.ajax({
            url: "/push/json/deletePush",
            type: "POST",
            data: formData,
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function() {
                console.log("알림 삭제 성공");
                getPushList(userId);
            },
            error: function(error) {
                console.log("알림 삭제 실패");
                console.log(error);
            }
        })
    }

    // 동행 채팅 관련 function ================================================
    var chatRoomId;
    var accChatSocket;
    var accChatLayer = $(".accChat.output");
    var inputAccChat = $("#input-accChat");
    var chatRoomName;

    function getChatRoomList() {
        $.ajax({
            url: "/chat/json/getChatRoomList/" + userId,
            type: "GET",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function(result) {
                console.log("채팅방 조회 성공");
                if (result.length == 0 ) {
                    $(".accLobby.content").html("<p style='margin:1em;font-size:10pt;text-align:center;color:#999999'><i class=\"far fa-question-circle fa-2x\"></i><br/>참여 중인 동행 채팅이 없습니다.<br/>휴대폰 본인인증 절차를 거친 후 동행에 참여하실 수 있습니다.</p>");
                } else {
                    showRoomList(result);
                }
            },
            error: function(error) {
                console.log("채팅방 조회 실패");
                console.log(error);
            }
        });
    }

    function showRoomList(list) {
        var html = "";
        //console.log("채팅방 목록 개수 : " + list.length);
        html += "<table class='roomTable' style='border-collapse: separate;border-spacing:0 15px;width:90%;margin:5%;' >"
        for (var i in list) {
            html += "<tr onclick='enterRoom(\"" + list[i].chatRoomId + "\")'>";
            //html += "<input type='hidden' name='chatRoomId' value='"+list[i].chatRoomId+"'>";
            html += "<td class='td1' style='text-align:left;width:40px;'>";
            //=\"/resources/images/chatImg/"+list[i].chatImg+"\" 
            if( list[i].chatImg != 'null' ) {
                html += "<img style='border: 2px solid #ccc;border-radius: 50%;width:35px;height:35px;' src=\"/resources/images/chatImg/"+list[i].chatImg+"\">"
            } else {
                html += "<img style='border: 2px solid #ccc;border-radius: 50%;width:35px;height:35px;' src=\"/resources/images/userImages/defaultUserImage.jpg\">"
            }
            html += "</td>"
            html += "<td class='td2' style='text-align:left;min-width:150px;'>";
            html += "<b><font size='3'>" + list[i].chatRoomName + "&ensp;</font></b><font color=gray>" + list[i].chatMems.length + "</font><br/>";
            html += "<font size=2 color=gray>";
            try {
                if (list[i].lastChat.chatContent.length > 12) {
                    html += list[i].lastChat.chatContent.substring(0, 12) + '..';
                } else {
                    html += list[i].lastChat.chatContent
                }
                html += "</font>";
                html += "</td>";
                html += " <td class='td3' style='padding:4;text-align:left;' valign='top'>";
                html += "<font size=1 color=gray>" + list[i].lastChat.sendTime + "</font>";
                html += "</td>";
            } catch (e) {
            }
            html += "</tr>";
        }
        html += "</table>"
        $(".accLobby.content").html(html);
    }


    function enterRoom(roomId) {
        $('#pos2').prop('checked', true);
        chatRoomId = roomId;
        console.log("입장한 채팅방 번호 : " + roomId);
        var accChatAddr = "ws://192.168.0.82:8080/accSocket/" + roomId + "/" + userId;
        accChatSocket = new WebSocket(accChatAddr);
        //웹 소켓이 연결되었을 때 호출되는 이벤트
        accChatSocket.onopen = function(message) {
            console.log('[accChat] : connection opened. || 방 번호 : ' + roomId)
            accChatLayer.html("");
            loadChat(roomId); // 웹소켓 연결 되면 이전 대화 내용 불러옴 
            loadChatRoomInfo(roomId); // 채팅방 정보 불러옴

            //웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
            accChatSocket.onmessage = function(message) {
                //console.log("메시지 날아옴 :: " + message)
                var data = JSON.parse(message.data)
                data.readers = [userId];
                receiveAccChat(data);
                //readChat(data);
                $(".accChat.output").scrollTop($(".accChat.output")[0].scrollHeight);
            };
        };
        //웹 소켓이 닫혔을 때 호출되는 이벤트
        accChatSocket.onclose = function(message) {
            accChatLayer.value += "접속이 끊어졌습니다.\n";
        };
        //웹 소켓이 에러가 났을 때 호출되는 이벤트
        accChatSocket.onerror = function(message) {
            accChatLayer.value += "accChat 에러가 발생했습니다.\n";
        };
    }

    var userNickname = '${user.nickname}';

    function receiveAccChat(chat) {
        //console.log("들어왔따~!")
        var html = "";
        if (chat.senderId == 'system') {
            html += "<div class='msgA center' style=\"text-align:center;margin: 20px;background-color:#D8D8D8;border-radius:10px;\">";
            html += "<font color='#424242' size=2>" + chat.chatContent + "</font>";
            html += "</div>"
        } else if (chat.user.nickname == userNickname) {
            html += "<div class='msgA right' style=\"text-align:right;margin:10px;\">"
            html += "<font color='#cccccc' size=1>" + chat.sendTime + "&ensp;</font>";
            html += "<div style='display: inline-block;background-color:#C5ECE9;height:auto;min-height:25px;max-width:150px;vertical-align:middle;border-radius:10px;padding:2px;text-align:justify;word-wrap:break-word;padding:5px;'>";
            html += "<font color='black' size=2>" + chat.chatContent + "</font>";
            html += "</div>"
            html += "</div>"
        } else {
            if ($("div.msgA").last().hasClass('left') == true && $($("div.msgA").last()).find('div.sender  font.senderId').html() == chat.user.nickname) {
                html += "<div class='msgA left' style=\"text-align:left;margin:10px;\">"
                html += "<div class='sender' style='text-align:center;display: inline-block;vertical-align: center;'>";
                html += "<font class='senderId' style='display:none;'>" + chat.user.nickname + "</font>";
                html += "<img  style='visibility:hidden;width:30px;height:2px;margin:5px 2px 5px 2px;' src=\"/resources/images/userImages/" + chat.user.userImg + "\">";
                html += "</div>"
            } else {
                html += "<div class='msgA left' style=\"text-align:left;margin:10px;\">"
                html += "<div class='sender' style='text-align:center;display: inline-block;vertical-align: center;'>";
                html += "<font class='senderId'>" + chat.user.nickname + "</font><br/>";
                html += "<img  style='border: 2px solid #C5ECE9;width:30px;height:30px;margin:2px;' class='rounded-circle' src=\"/resources/images/userImages/" + chat.user.userImg + "\">";
                html += "</div>"
            }
            html += "<div style='display: inline-block;background-color:#F2F2F2;height:auto;min-height:25px;max-width:150px;vertical-align:middle;text-align:justify;border-radius:10px;padding:2px;word-wrap:break-word;padding:5px;'>";
            html += "<font color='black' size=2>" + chat.chatContent + "</font>";
            html += "</div>"
            html += "<font color='#cccccc' size=1> " + chat.sendTime + "</font>";
            html += "</div>"
        }
        accChatLayer.append(html);
    }

    function sendAccMessage(quitUser) {
        if (quitUser != null) {
            var chat = new Object();
            chat.senderId = "system";
            chat.chatContent = quitUser + "님이 동행에서 탈퇴하셨습니다."
            chat.chatRoomId = chatRoomId;
            accChatSocket.send(JSON.stringify({
                chat
            }));
            console.log("탈퇴 메시지 송출 :: ");
            console.log(chat);
        }

        if (inputAccChat.val().trim() != "") {
            console.log("공백 입력 > 전송");
            var chat = new Object();
            chat.senderId = userId;
            chat.chatContent = inputAccChat.val();
            chat.chatRoomId = chatRoomId;
            accChatSocket.send(JSON.stringify({
                chat
            }));
        }
        inputAccChat.val('');
        $(".accChat.output").scrollTop($(".accChat.output")[0].scrollHeight);
    }

    function disconnectAcc() {
        accChatSocket.close();
    }

    function loadChat(roomNo) {
        console.log(roomNo + "번 방 채팅메시지 불러오기 시작")
        $.ajax({
            url: "/chat/json/getChat/" + roomNo,
            type: "GET",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function(result) {
                var list = JSON.stringify({
                    result
                });
                console.log("getChat() 성공 : " + result.length + " || " + result);
                if (result.length != 0) {
                    var html = "";
                    for (var i in result) {
                        receiveAccChat(result[i]);
                    }
                } else {
                    var chat = new Object();
                    chat.senderId = "system";
                    chat.chatContent = "동행채팅이 개설되었습니다.";
                    chat.chatRoomId = roomNo;
                    accChatSocket.send(JSON.stringify({
                        chat
                    }));
                }
                $(".accChat.output").scrollTop($(".accChat.output")[0].scrollHeight);
            },
            error: function(error) {
                console.log("getChat() 실패")
                console.log(error);
            }
        })
    }

    function loadChatRoomInfo(roomId) {
        $.ajax({
            url: "/chat/json/getChatRoom/" + roomId,
            type: "GET",
            dataType: "json",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function(result) {
                var userList = result.userList;
                chatRoomName = result.chatRoomName;
                var html = "<b><font size=3 color=black>" + chatRoomName + "</font></b>";
                html += "<font size=3 color=gold>" + userList.length + "</font>";
                $(".accChat.info span").html(html);
                $("#accModalLabel").html(chatRoomName + "(" + userList.length + ")");

                var tag = ""
                for (var i in userList) {
                    tag += "<div style='margin-bottom:20px;text-align:left;'>"
                    tag += "<img  style='border: 2px solid gold;border-radius: 7px;-moz-border-radius: 7px;-khtml-border-radius: 7px; -webkit-border-radius: 7px;width:30px;height:30px;margin-right:10px;' src=\"/resources/images/userImages/" + userList[i].userImg + "\">";
                    tag += userList[i].nickname;
                    if (userId == result.creator && userId != userList[i].userId) {
                        tag += "<button type='button' class='btn btn-outline-danger' style='float:right;' onclick='quitAcc(\"" + userList[i].userId + "\")'>강퇴</button>";
                    } else if(userId != result.creator && userId == userList[i].userId){
                         tag += "<button type='button' class='btn btn-outline-danger' style='float:right;' onclick='quitAcc(\"" + userList[i].userId + "\")'>나가기</button>";
                    }
                    tag += "</div>"
                }
                $(".form-group.accModal").html(tag);
            },
            error: function(error) {
                console.log("채팅방 정보 조회 실패 :: " + error);
            }
        })

    }

    function readChat(chat) {
        console.log("readChat 시작")
        $.ajax({
            url: "/chat/json/readChat/",
            type: "POST",
            data: JSON.stringify(chat),
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json"
            },
            success: function() {
                console.log("readChat() 성공");
            },
            error: function(error) {
                console.log("readChat() 실패")
                console.log(error);
            }
        })

    }

    function quitAcc(quitId) {
        console.log("퇴장시킬 user : " + quitId);
        if ( userId != quitId ) {
            Swal.fire({
                title: '정말 내보내시겠습니까?',
//                text: "한 번 퇴장시키시면 채팅방뿐만 아니라 동행에서도 빠지게 됩니다.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '예',
                cancelButtonText: '아니오',
            }).then((result) => {
                if (result.value) {
                    var chatRoom = new Object();
                    chatRoom.chatRoomId = chatRoomId;
                    chatRoom.chatMems = [quitId];
                    $.ajax({
                        url: "/chat/json/quitChatRoom/",
                        type: "POST",
                        data: JSON.stringify(chatRoom),
                        dataType: "text",
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        success: function(result) {
                            //console.log(result);
                            console.log("quitChatRoom() 성공 :: " + quitId + " || db에서 가져온 닉네임 : " + result);
                            sendAccMessage(result);
                            getChatRoomList();
                            loadChatRoomInfo(chatRoomId);
                            Swal.fire(
                                '완료',
                                '해당 회원이 동행에서 제외되었습니다.'
                            )
                        },
                        error: function(error) {
                            console.log("quitChatRoom() 실패")
                            console.log(error);
                        }
                    })
                }
            })
        } else {
            Swal.fire({
                title: '정말 나가시겠습니까?',
//                text: "한 번 퇴장시키시면 채팅방뿐만 아니라 동행에서도 빠지게 됩니다.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '예',
                cancelButtonText: '아니오',
            }).then((result) => {
                if (result.value) {
                    var chatRoom = new Object();
                    chatRoom.chatRoomId = chatRoomId;
                    chatRoom.chatMems = [quitId];
                    $.ajax({
                        url: "/chat/json/quitChatRoom/",
                        type: "POST",
                        data: JSON.stringify(chatRoom),
                        dataType: "text",
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json"
                        },
                        success: function(result) {
                            //console.log(result);
                            console.log("quitChatRoom() 성공 :: " + quitId + " || db에서 가져온 닉네임 : " + result);
                            sendAccMessage(result);
                            getChatRoomList();
                            $('#accModal').modal('hide');
                            $('#pos1').prop('checked', true);
                            disconnectAcc();
                            
                            Swal.fire(
                                '완료'
                            )
                        },
                        error: function(error) {
                            console.log("quitChatRoom() 실패")
                            console.log(error);
                        }
                    })
                }
            })
        }
    }


    /* -----------------------------------------  플래너 채팅 스크립트  --------------------------------------- */
    var planId = '${plan.planId}';
    var planChatSocket;
    var planChatLayer = $("div.planChat.output");
    var myChat = $("#myChat");


    function connectPlanChat() {
        var addr = "ws://192.168.0.82:8080/planSocket/" + planId + "/" + userId;
        planChatSocket = new WebSocket(addr);

        planChatSocket.onopen = function(message) {
            console.log("접속했다." + addr);

            planChatSocket.onmessage = function(message) {
                //console.log("메시지 받았다.")
                var json = JSON.parse(message.data);
                //console.log(Array.isArray(json));
                if (Array.isArray(json)) {
                    checkOnlineMembers(json);
                    //console.log("checkOnlineMembers")
                } else {
                    //console.log("receivePlanChat")
                    receivePlanChat(json);
                }
                $(".planChat.output").scrollTop($(".planChat.output")[0].scrollHeight);
            };

        };
        planChatSocket.onclose = function(message) {
            console.log("접속이 끊어졌습니다.\n");
        };
        planChatSocket.onerror = function(message) {
            console.log("에러가 발생했습니다.\n");
        };

    }

    function receivePlanChat(chat) {
        //console.log("들어왔따~!")
        var html = "";
        if (chat.senderId == 'system') {
            html += "<div class='msg center' style=\"text-align:center;margin:20px;background-color:#D8D8D8;border-radius:10px;\">";
            html += "<font color='#424242' size=2>" + chat.chatContent + "</font>";
            html += "</div>"
        } else if (chat.senderId == userId) {
            html += "<div class='msg right' style=\"text-align:right;margin:10px;\">"
            html += "<font color='#cccccc' size=1>" + chat.sendTime + "&ensp;</font>";
            html += "<div style='display: inline-block;background-color:#C5ECE9;height:auto;min-height:25px;vertical-align:middle;border-radius:10px;padding:5px'>";
            html += "<font color='black' size=2;>" + chat.chatContent + "</font>";
            html += "</div>"
            html += "</div>"
        } else {
            html += "<div class='msg left' style=\"text-align:left;margin:10px;\">"
            //console.log("T ? F ? :: " + $("div.msg").last().hasClass('left') + " || " + $($("div.msg").last()).find('div.sender  font.senderId').html());
            if ($("div.msg").last().hasClass('left') == true && $($("div.msg").last()).find('div.sender font.senderId').html() == chat.senderId) {
                html += "<div class='sender' style='text-align:center;display: inline-block;vertical-align: center;'>";
                html += "<font class='senderId' style='display:none;'>" + chat.senderId + "</font>";
                html += "<img  style='visibility:hidden;width:30px;height:2px;margin:5px 2px 5px 2px;' src=\"/resources/images/userImages/" + chat.user.userImg + "\">";
                html += "</div>"
            } else {
                html += "<div class='sender' style='text-align:center;display: inline-block;vertical-align: center;'>";
                html += "<font class='senderId' style='font-size:8pt;font-weight:400;'>" + chat.senderId + "</font><br/>";
                html += "<img  style='border: 2px solid #C5ECE9;width:30px;height:30px;margin:2px;' class='rounded-circle' src=\"/resources/images/userImages/" + chat.user.userImg + "\">";
                html += "</div>"
            }
            html += "<div style='display: inline-block;background-color:#F2F2F2;height:auto;min-height:25px;vertical-align:middle;border-radius:10px;padding:5px'>";
            html += "<font color='black' size=2>" + chat.chatContent + "</font>";
            html += "</div>"
            html += "<font color='#cccccc' size=1> " + chat.sendTime + "</font>";
            html += "</div>"
        }
        planChatLayer.append(html);
    }

    function checkOnlineMembers(data) {
        <c:forEach var="member" items="${plan.planPartyList}">
            $("#img_${member.userId}").removeClass("on");
        </c:forEach>
        for (var i in data) {
            console.log("접속한 회원 id : " + data[i].userId);
            $("#img_" + data[i].userId).addClass("on");
        }
    }

    function sendMessage() {
        if (myChat.val().trim() != "") {
            var chat = new Object();
            chat.senderId = userId;
            chat.chatContent = myChat.val();

            planChatSocket.send(JSON.stringify({
                chat
            }));
        }
        myChat.val('');
        $(".planChat.output").scrollTop($(".planChat.output")[0].scrollHeight);
    }

    /*      ---------------------------------------------------   */


    jQuery(document).ready(function($) {
        console.log("현재 로그인한 회원 : " + userId);

        $("div.icon.push-list").click(function() {
            $('#push-layer').slideToggle(300);
            $('#acc-slide').fadeOut(300);
            $('#plan-chat-layer').fadeOut(300);
            if (userId != null && userId != '') {
                setTimeout(() => readPush(userId), 20);
                setTimeout(() => getUnreadCount(userId), 50);
            }
        });

        $("div.icon.acc-chat").click(function() {
            $('#acc-slide').slideToggle(300);
            $('#push-layer').fadeOut(300);
            $('#plan-chat-layer').fadeOut(300);
        });

        $("div.icon.plan-chat").click(function() {
            $('#plan-chat-layer').slideToggle(300);
            $('#push-layer').fadeOut(300);
            $('#acc-slide').fadeOut(300);
        })

        if (planId.length == 0 || '${boardName}' == 'E') {
            $('div.icon.plan-chat').hide();
        } else if ('${boardName}' != 'E' && planId.length !=0 ){
            $('div.icon.plan-chat').hide();
            $('div.icon.plan-chat').fadeIn(200).effect( "shake", { direction: "up", times: 3, distance: 1} );
            
            connectPlanChat();
        }


        $("#myChat").keydown(function(key) {
            if (key.keyCode == 13) {
                sendMessage();
                myChat.val();
            }
        });
        $("#click").on("mouseover", function() {
            $("#click").css({
                "background-color": "#2ECCFA"
            });
        }).on("mouseout", function() {
            $("#click").css({
                "background-color": "#81e0fc"
            });
        });

        $(".fa-comment-dots").on("click", function() {
            $("#planChat").toggleClass('on');
        });
        $(".fa-telegram-plane").on("click", function() {
            sendMessage();
        })







        if (userId != null && userId != '') {
            setTimeout(() => getPushList(userId), 10);
            setTimeout(() => getUnreadCount(userId), 10);
            setTimeout(() => getChatRoomList(), 20);
        }


        $(".accChat.output").scrollTop($(".accChat.output")[0].scrollHeight);
        $("#input-accChat").keydown(function(key) {
            if (key.keyCode == 13) {
                sendAccMessage();
                inputAccChat.val();
            }
        });
        $(".fas.fa-arrow-left").on("click", function() {
            $('#pos1').prop('checked', true);
            disconnectAcc();
        });
        
        $(window).scroll(function() {
           
            if ($(document).scrollTop() > 160) {
                $('.icon-table').css('display', 'inline-block');
                $('.push-bar-menu').css('margin-top', '10px');
                $('div.icon').css('color','#323232');
                $('div.icon').hover(function() {
                    $(this).css('color','#339999');
                }, function() {
                    $(this).css('color','#323232');
                })
            } else {
                $('.icon-table').css('display','table-row');
                $('div.icon').css('color','#858585');
                $('.push-bar-menu').css('margin-top', '0px');
                
            }
        });







    });

</script>
