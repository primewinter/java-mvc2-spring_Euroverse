## Euroverse  
유로버스(여행 플래너 및 커뮤니티 사이트)는 국비학원에서 진행한 팀프로젝트입니다.

###### <img src = "https://ifh.cc/g/gnRlc0.jpg" width="400px">  **[사진1] 메인화면** 
 
+ 총 개발 기간 : 2개월  
+ 분석 및 설계 : 2020/01/01 ~ 2020/01/23  
+ 구현 : 2020/01/24 ~ 2020/03/07  
+ 총 개발 인원 : 6명  
+ 시스템 개요 : MVC2 모델을 기반으로 스프링 프레임워크를 이용하여 만든 유럽 여행 플래너 및 커뮤니티 사이트입니다. 크게 회원 관리, 주문 관리, 플래너, 커뮤니티, 채팅 모듈을 가집니다.  

## 의존성 및 버전 정보
  
+ 언어 : Java    
+ 백엔드 : Spring Framework 4.0.1 / MyBatis / Apache Tomcat / Selenium
+ 프론트 : HTML5 / BootStrap 4 / CSS3 / jQuery / Ajax / JSP
+ Database : Oracle 10g, MongoDB 3.6.1  
+ 형상 관리 : GitHub  
+ IDE : Eclipse  
+ 오픈소스 : Sweetalert / FullCalendar / SummerNote / Owl carousel / AOS / Swiper
+ API :  Foreign exchange rates API / 공공데이터포털API / 청기와 LAB / I'mPort API / JavaMail API / 네이버로그인 API / 카카오로그인 API / GoogleMap API

## 분석 및 설계 과정
    1. 주제 선정

    2.1. 업무 분석 : Use Case Modeling
        2.1.1 현업 요구사항 정의서 작성  
        2.1.2 요구사항 추적표 작성
        2.1.3 Use Case 유형정의 작성    
        2.1.4 Use Case Diagram 작성    
        2.1.5 Use Case 정의서 작성
    
    2.2. 업무 분석 : Application Modeling
        2.2.1 Class Diagram 작성    
        2.2.2 VOPC(View Of Participating Class) Diagram 작성

    2.3. 화면 분석
        2.3.1 화면 정의서 작성

    2.4. 데이터 분석(Logical)
        2.4.1 ERD(Logical) 작성
        
    3.1 업무 분석 : Application Modeling 
        3.1.1 설계표준 정의
        3.1.2 Class Diagram 작성
        3.1.3 VOPC(View Of Participating Class) Diagram 작성

    3.2 화면 분석
        3.2.1 화면 정의서 

    3.3 데이터 분석(Physical)
        3.3.1 ERD(Physical) 작성
        3.3.2 테이블 목록 작성
        3.3.3 테이블 정의서 작성



## 담당 파트

**1. 실시간 알림**  : 게시판에 쓴 게시글/댓글에 대한 반응 알림, 플래너 초대/동행 초대 신청 알림, 채팅 메시지 알림, 플래너에 작성한 할 일 여행 전 문자 알림
    
    ###### <img src="https://ifh.cc/g/vyrGVR.png" width=200> **[사진2] 알림 내역 조회** 

**2. 채팅**

   **2-1. 대화 내역이 저장되지 않는 채팅(플래너채팅)** : 플래너에 입장 시 현재 같은 플래너에 입장한 회원 간 채팅
     
    ###### <img src="https://ifh.cc/g/RayOle.png" width=200> **[사진3] 플래너 채팅** 
    
   **2-2. 대화 내역이 저장되는 채팅(동행채팅)** : 동행 구하기 게시판을 통해 구한 소모임(동행)에 참여한 회원 간 채팅, 퇴장 후 재입장 시 전에 나눈 대화 내역 확인 가능
    
   ###### <img src="https://ifh.cc/g/JKF59Y.png" width=200>**[사진4] 동행 채팅방 목록**  <img src="https://ifh.cc/g/WSks7r.png" width=200> **[사진5] 동행 채팅방 화면**  
    
**3. 사이트 UI**

\\<!--사진 유효기간 : 200일  (만료 : 2020-11-10)-->

