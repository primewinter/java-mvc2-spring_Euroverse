<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">

<head>
    <title>Euroverse, 유럽 여행의 시작</title>
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


</head>
<style>
    @font-face {
        font-family: 'GmarketSansBold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansBold.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

    @font-face {
        font-family: '양진체';
        src: url('https://cdn.jsdelivr.net/gh/supernovice-lab/font@0.9/yangjin.woff') format('woff');
        font-weight: normal;
        font-style: normal;
    }

    .nanumsquare {
        font-family: 'NanumSquare', sans-serif !important;
    }


    main section {
        margin-left: 5em;
        margin-right: 5em;
    }

    section.main-infinite {
        width:80%;
        margin:auto;
    }

    section.random-text {
        display: inline-block;
        vertical-align: bottom;
        text-align: left;
        margin: 3em;
    }

    /*메인 캐러셀*/
    div.carousel-inner {
        height: auto;

    }

    .carousel-inner>.carousel-item {
        width: 100%;
        height: 400px;
        vertical-align: baseline;

    }

    .carousel-inner>.carousel-item>img {
        width: 640px;
        height: 720px;
    }

    .owl-carousel .owl-item img {
        display: inline-block;
    }

    .carousel-caption {
        text-align: left;
    }


    /*무한클릭 이미지 mouseHover CSS*/

    .effect-wrap {
        width: 600px;
        height: 500px;
        display: inline-block;
        float: left;
        justify-content: center;
        align-items: center;
    }

    .effect5 {
        position: relative;
        display: inline-block;
        vertical-align: middle;
        width: 400px;
        height: 400px;
        overflow: hidden;
        /*box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.4);*/
    }

    .effect5 img {
        display: flex;
        width: 100%;
        height: 100%;
        filter: sepia(20%) saturate(60%);
    }

    .effect5 figcaption {
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        z-index: 1;
        text-align: center;
        line-height: 1.7em;
        color: #fff;
        text-transform: uppercase;
        font-size: 20px;
        opacity: 0;
        transition: all 0.3s ease;
    }

    .effect5 figcaption h3 {
        font-size: 1.3em;
        letter-spacing: 2px;
        /*font-weight: 100;*/
    }

    .effect5 figcaption em {
        display: block;
        font-weight: bold;
        letter-spacing: 1px;
        font-weight: 700;
    }

    .effect5:before,
    .effect5:after {
        content: '';
        position: absolute;
        top: 0;
        right: 0;
        bottom: 0;
        left: 0;
        background-color: rgba(0, 0, 0, 0.3);
        border-top: 70px solid rgba(0, 0, 0, 0.4);
        border-bottom: 70px solid rgba(0, 0, 0, 0.4);
        transition: all 0.3s ease;
        z-index: 1;
        opacity: 0;
    }

    .effect5:before {
        transform: scaley(2);
    }

    .effect5:after {
        transform: scaley(2);
    }

    .effect5:hover:before,
    .effect5:hover:after {
        opacity: 1;
        transform: scale(1);
    }

    .effect5:hover>img {
        opacity: 0.7;
    }

    .effect5:hover figcaption {
        opacity: 1;
        transition-delay: 0.1s;
    }


    .story-entry__image-wrap {
        overflow: hidden;
        bottom: 0px;
        width: 100%;
        height: 300px;
        font-style: oblique;
    }

    .planner-image-wrap {
        overflow: hidden;
        bottom: 0px;
        width: 100%;
        height: 200px;
        padding: 1em;
    }

    .planner-image-wrap>img {
        width: auto;
        vertical-align: middle;
        height: 200px;
        object-fit: cover;
        overflow: hidden;
    }

    .topic {
        margin: 3em 1em 3em 1em;
    }

    .story-entry__image-wrap>img,
    .story-entry__image-wrap>figure>img {
        width: auto;
        vertical-align: middle;
        height: 300px;
        object-fit: cover;
        overflow: hidden;
    }

    .story-entry__image-wrap>img:hover,
    .story-entry__image-wrap>figure>img:hover {
        /* img 마우스 오버시*/
        cursor: pointer;
        transform: scale(1.1);
        /* 마우스 오버시 이미지 크기를 1.1 배만큼 확대시킨다. */
        -o-transform: scale(1.1);
        -moz-transform: scale(1.1);
        -webkit-transform: scale(1.1);
        transition: transform .35s;
        -o-transition: transform .35s;
        -moz-transition: transform .35s;
        -webkit-transition: transform .35s;
        /* 마우스 오버시 이미지가 즉시 커지지않고 30.5 second 의 시간에 걸쳐 커진다 애니메이션 효과*/
    }



    .story-entry__content__profile {
        text-align: right;
        font-size: 9pt;
    }


    .wrapping-crop {
        max-width: 200px;
        overflow: hidden;
    }

    .wrapping-post {
        width: 40%;
        margin: 10px auto;
        border: 1px solid #000000;
    }

    .wrapping-crop img {
        width: 100%;
        vertical-align: middle;
        max-width: initial;
        margin-left: 50%;
    }

    .wrapping-text {
        padding: 5px 10px;
        background-color: yellow;
        text-align: center;
    }



    #countryMoney {
        border-radius: 10px;
    }

    /* 금액입력창 css  */
    .countryMoney {
        background: #ddd;
        border-radius: 6px;
        padding: 10px;
    }



    @import url(https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css);

    figure.snip1384 {
        position: relative;
        overflow: hidden;
        margin: 10px;
        min-width: 210px;
        max-width: 315px;
        width: 100%;
        color: #ffffff;
        text-align: left;
        font-size: 16px;
        background-color: #000000;
    }

    figure.snip1384 * {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        -webkit-transition: all 0.35s ease;
        transition: all 0.35s ease;
    }

    figure.snip1384 img {
        max-width: 100%;
        backface-visibility: hidden;
        vertical-align: top;
    }

    figure.snip1384:after,
    figure.snip1384 figcaption {
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
    }

    figure.snip1384:after {
        content: '';
        background-color: rgba(0, 0, 0, 0.65);
        -webkit-transition: all 0.35s ease;
        transition: all 0.35s ease;
        opacity: 0;
    }

    figure.snip1384 figcaption {
        z-index: 1;
        padding: 0.7em;
    }

    figure.snip1384 h3,
    figure.snip1384 .links {
        width: 100%;
        margin: 5px 0;
        padding: 0;
    }

    figure.snip1384 h3 {
        line-height: 1.1em;
        font-weight: 700;
        font-size: 1.4em;
        text-transform: uppercase;
        opacity: 0;
    }

    figure.snip1384 p {
        font-size: 0.8em;
        font-weight: 300;
        letter-spacing: 1px;
        opacity: 0;
        top: 50%;
        -webkit-transform: translateY(40px);
        transform: translateY(40px);
    }

    figure.snip1384 i {
        position: absolute;
        bottom: 10px;
        right: 10px;
        padding: 20px 25px;
        font-size: 34px;
        opacity: 0;
        -webkit-transform: translateX(-10px);
        transform: translateX(-10px);
    }

    figure.snip1384 a {
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        z-index: 1;
    }

    figure.snip1384:hover img,
    figure.snip1384.hover img {
        zoom: 1;
        filter: alpha(opacity=50);
        -webkit-opacity: 0.5;
        opacity: 0.5;
    }

    figure.snip1384:hover:after,
    figure.snip1384.hover:after {
        opacity: 1;
        position: absolute;
        top: 0px;
    }

    figure.snip1384:hover h3,
    figure.snip1384.hover h3,
    figure.snip1384:hover p,
    figure.snip1384.hover p,
    figure.snip1384:hover i,
    figure.snip1384.hover i {
        -webkit-transform: translate(0px, 0px);
        transform: translate(0px, 0px);
        opacity: 1;
    }

    /*환율 select*/
    /*the container must be positioned relative:*/
    .cur-select {
        position: relative;
        font-size: 10pt;
        width: 100px;
    }

    .cur-selected:hover {
        background-color: rgba(0, 0, 0, 0.1);
    }

    .cur-select select {
        display: none;
        /*hide original SELECT element:*/
    }

    .select-selected {
        background-color: #8ad0d6;
    }

    /*style the arrow inside the select element:*/
    .select-selected:after {
        position: absolute;
        content: "";
        top: 14px;
        right: 10px;
        width: 0;
        height: 0;
        border: 6px solid transparent;
        border-color: #fff transparent transparent transparent;
    }

    /*point the arrow upwards when the select box is open (active):*/
    .select-selected.select-arrow-active:after {
        border-color: transparent transparent #fff transparent;
        top: 7px;
    }

    /*style the items (options), including the selected item:*/
    .select-items div,
    .select-selected {
        color: #ffffff;
        padding: 8px 16px;
        cursor: pointer;
        user-select: none;
    }

    /*style items (options):*/
    .select-items {
        position: absolute;
        background-color: #8ad0d6;
        top: 100%;
        left: 0;
        right: 0;
        z-index: 99;
    }

    /*hide the items when the select box is closed:*/
    .select-hide {
        display: none;
    }

    .select-items div:hover,
    .same-as-selected {
        background-color: rgba(0, 0, 0, 0.1);
    }



    /*환율 스와이프*/
    main-infinite.swiper-container {
        height: 120px;
    }

    .swiper-slide {
        text-align: center;
        display: flex;
        /* 내용을 중앙정렬 하기위해 flex 사용 */
        align-items: center;
        /* 위아래 기준 중앙정렬 */
        justify-content: center;
        /* 좌우 기준 중앙정렬 */
        cursor: pointer;
    }

    .swiper-slide img {
        max-width: 80%;
        /* 이미지 최대너비를 제한, 슬라이드에 이미지가 여러개가 보여질때 필요 */
        /* 이 예제에서 필요해서 설정했습니다. 상황에따라 다를 수 있습니다. */
    }

    .swiper-slide {
        opacity: 60%;
    }

    .swiper-slide:hover {
        opacity: 100%;
    }

    .swiper-slide.on {
        opacity: 100%;
    }

    .popupLayer {
        position: absolute;
        display: none;
        background-color: #ffffff;
        border: solid 2px #d0d0d0;
        width: 350px;
        height: auto;
        padding: 10px;
        font-size: 0.8em;
        left: auto;
        top: auto;
    }

    .popupLayer .popup-close {
        position: absolute;
        top: 5px;
        right: 10px
    }


    section>header {
        font-family: 'NIXGONM-Vb';
        /*        font-family: 'GmarketSansBold';*/
        /*        font-style: italic;*/
        font-weight: bold;
        display: inline-block;
        /*background-color: #ffcf00;*/
        background-color: #ffde3e;
        /*#8ad0d6; #4da185;*/
        /*#97EBDB;*/
        text-align: left;
        margin-top: 2em;
        margin-bottom: 2em;
        margin-left: 5em;
        /*        transform: skew(-15deg);*/
    }
    div.random-text>header {
        font-family: 'NIXGONM-Vb';
        font-weight: bold;
        display: inline-block;
        background-color: #ffde3e;
        text-align: left;
    }



    /*    owl : review-section*/
    section.owl-review-section {
        /*        background-color: #f33f02;*/
        position: relative;
        padding-top: 0px;

        &:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            width: 100%;
            height: 30%;
            background-color: #ddd;
        }
    }

    #review-owl>div>div.item-details {
        background-color: #333333;
        color: #fff;
        padding: 20px 10px;
        text-align: left;
        /*h5{
			margin: 0 0 15px;
			font-size: 18px;
			line-height: 18px;
			span{
				color: red;
				float:right;
				padding-right: 20px;
			}
		}
		p{
			font-size: 14px;
		}*/
    }

    div.item {
        //text-align: center;
        //padding: 20px;
        margin-bottom: 80px;
    }

    .owl-carousel .owl-nav [class*='owl-'] {
        -webkit-transition: all .3s ease;
        transition: all .3s ease;
        height;0px;
    }

    .owl-carousel .owl-nav [class*='owl-'].disabled:hover {
        background-color: #D6D6D6;
    }

    .owl-carousel {
        position: relative;
    }

    .owl-carousel .owl-next,
    .owl-carousel .owl-prev {
        width: 50px;
        height: 50px;
        line-height: 50px;
        border-radius: 50%;
        position: absolute;
        top: 30%;
        font-size: 20px;
        color: #fff;
        border: 1px solid #ddd;
        text-align: center;
    }

    .owl-carousel .owl-prev {
        left: -70px;
    }

    .owl-carousel .owl-next {
        right: -70px;
    }

    div.card {
        transition: box-shadow .3s;
    }

    div.card:hover {
        box-shadow: 0 0 11px rgba(33, 33, 33, .2);
    }

    div.item-body {
        height: 200px;
    }

    div.item-body>p {
        color: #999999;
    }
    div.owl-dots {
        height: 0px;
    }

    div.owl-stage-outer {
        padding: 0.5em;
    }

    span.section__header__content {
        font-size: 25px;
    }

    span.section__header__more {
        font-size: 15px;
    }

    div.story-entry__content>span>img {
        display: inherit;
    }
    
    div.countryMoney input {
        display: inline-block;
        width: 30%;
    }

</style>

<body>
    <jsp:include page="toolbar/toolBar.jsp" />

    <main>
        <div style="clear:both">
            <div id="main-carousel" class="carousel slide" data-ride="carousel">
                <div class="carousel-inner">
                    <!-- 슬라이드 쇼 -->
                    <div class="carousel-item active">
                        <!--가로--> <img class="d-block w-100" src="/resources/images/mainImg/rome.jpg" alt="First slide">
                        <div class="carousel-caption d-none d-md-block">
                            <h2>유럽여행의 시작</h2>
                            <p>당신을 기다리는 백만 개의 플래너와 함께하세요.</p>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="/resources/images/mainImg/paris_3840x2400%20(2).jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="/resources/images/mainImg/london%20(2).jpg" alt="Third slide">
                    </div> <!-- / 슬라이드 쇼 끝 -->
                    <!-- 왼쪽 오른쪽 화살표 버튼 -->
                    <a class="carousel-control-prev" href="#main-carousel" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <!-- <span>Previous</span> --> </a>
                    <a class="carousel-control-next" href="#main-carousel" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <!-- <span>Next</span> --> </a> <!-- / 화살표 버튼 끝 -->
                    <!-- 인디케이터 -->
                    <ul class="carousel-indicators">
                        <li data-target="#main-carousel" data-slide-to="0" class="active"></li>
                        <!--0번부터시작-->
                        <li data-target="#main-carousel" data-slide-to="1"></li>
                        <li data-target="#main-carousel" data-slide-to="2"></li>
                    </ul> <!-- 인디케이터 끝 -->
                </div>
            </div>
        </div>



        <div style="clear: both"></div>



        <section class="new-plan aos-init aos-animate" data-aos="fade-right">
            <header class="plan-section__header">
                <span class="col section__header__content">새로운 플래너</span><span class="section__header__more">>>more</span>
            </header>

            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="owl-E" class="owl-carousel">
                        </div>
                    </div>
                </div>
            </div>
        </section>



        <section class="owl-review-section aos-init aos-animate" data-aos="fade-left">
            <header class="review-section__header">
                <span class="col section__header__content">새로운 여행 후기</span><span class="section__header__more">>>more</span>
            </header>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="owl-F" class="owl-carousel">
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <section class="owl-info-section aos-init aos-animate" data-aos="fade-right">
            <header class="info-section__header">
                <span class="col section__header__content">새로운 여행 정보</span><span class="section__header__more">>>more</span>
            </header>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="owl-B" class="owl-carousel">
                        </div>
                    </div>
                </div>
            </div>
        </section>



        <section class="main-infinite">
           <div class="card" style="display: inline-block;float:left;padding:1em;width:40%;text-align: center;padding-top:3em;padding-left:2.5em;padding-right:2.5em;">
           <!-- <div style="text-align:left;font-size:20pt;padding-left:0.5em;"><i class="fab fa-instagram"></i><br></div>-->
              <figure class="effect5" style="">
                    <img id="infinityClick" src="https://tistory4.daumcdn.net/tistory/2141493/skin/images/simg06.png">
                    <figcaption>
                        <h4>클릭해보세요!</h4>
                    </figcaption>
                </figure>
              <div class="card-body">
                <p class="card-text" style="display:none;text-align: left;font-size:10pt;"><!--<i class="fas fa-heart" style="color:red;"></i>-->좋아요 11.2k &nbsp;&nbsp;<!--<i class="fas fa-comment"></i>-->댓글 8.7k <span style="float:right;font-size:10pt;">2020.03.08</span></p>
                
                <div class="card-title random-title" style="font-family:'NIXGONM-Vb';font-weight:bold;text-align: left;font-size:17pt;color:cornflowerblue;"></div>
                
              </div>
            </div>
           <!-- <div class="effect-wrap">
                <figure class="effect5">
                    <img id="infinityClick" src="https://tistory4.daumcdn.net/tistory/2141493/skin/images/simg06.png">
                    <figcaption>
                        <h4>클릭해보세요!</h4>
                    </figcaption>
                </figure>
            </div>-->
            <div style="display: inline-block;float:left;padding:1em;width:60%;">
                <div class="currency-convertor">
                   <br><br>
                    <div class="random-text" style="">
                    <header>
                        <span class="col section__header__content">환율 계산기</span><span class="section__header__more">>></span>
                    </header>
                    </div>
                    <br><br>
                    <div class="input-group cur-result">
                        <div class="countryMoney">
                            <input type="text" name='conMoney1' class="form-control" placeholder="국가를 선택하세요" aria-describedby="addon-wrapping" value="" onkeydown="exchange()" style="width:150px;"> <span class='text'>
                            </span>
                            <i class="fas fa-angle-double-right" style="margin-left:30px;margin-right:30px;"></i>
                            <input type="text" name='conMoney' id="result" class="form-control" placeholder="" readonly="readonly" value="" style="width:150px;"> 원
                        </div>
                    </div>
                </div>
                <br><br><br>
                <div class="random-text" style="">
                    <header>
                        <span class="col section__header__content">여행지 추천</span><span class="section__header__more">>>국가를 선택해보세요</span>
                    </header>
                    <br><br>
                    <!--<h5 style='font-family:"NIXGONM-Vb" '>#여행지랜덤추천 #클릭</h5>-->
                </div><!---->
                <br>
                <div class="swiper-container" style="margin: 1em;">
                <div class="swiper-wrapper">
                    <div class="swiper-slide"><a id="a" data-toggle="list" href="#list-home" hwa='유로' mon="EUR" con="GBR">
                            <img src='/resources/images/tripInfoimges/Europe.png' />
                            <p>EU</p>
                        </a></div>
                    <div class="swiper-slide"> <a id="b" data-toggle="list" href="#list-profile" hwa='포린트' mon="HUF" con="HUN">
                            <img src='/resources/images/tripInfoimges/Hungary.gif' />
                            <p>헝가리</p>
                        </a></div>
                    <div class="swiper-slide"><a id="c" data-toggle="list" href="#list-messages" hwa='코루나' mon="CZK" con="CZE">
                            <img src='/resources/images/tripInfoimges/Czech.gif' />
                            <p>체코</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='크로네' mon="DKK" con="DNK">
                            <img src='/resources/images/tripInfoimges/Denmark.gif' />
                            <p>덴마크</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='파운드' mon="GBP" con="GBR">
                            <img src='/resources/images/tripInfoimges/England.gif' />
                            <p>영국</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='레우' mon="RON" con="ROU">
                            <img src='/resources/images/tripInfoimges/Lithuania.gif' />
                            <p>루마니아</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='크로나' mon="SEK" con="SWE">
                            <img src='/resources/images/tripInfoimges/Sweden.gif' />
                            <p>스웨덴</p>
                        </a></div>
                    <div class="swiper-slide"> <a id="d" data-toggle="list" href="#list-settings" hwa='쿠나' mon="HRK" con="HRV">
                            <img src='/resources/images/tripInfoimges/Croatia.gif' />
                            <p>크로아티아</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='프랑' mon="CHF" con="CHE">
                            <img src='/resources/images/tripInfoimges/Swiss.gif' />
                            <p>스위스</p>
                        </a></div>
                    <div class="swiper-slide"> <a id="d" data-toggle="list" href="#list-settings" hwa='레바' mon="BGN" con="BGR">
                            <img src='/resources/images/tripInfoimges/Bulgaria.gif' />
                            <p>불가리아</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='리라' mon="TRY" con="TUR">
                            <img src='/resources/images/tripInfoimges/Turkey.gif' />
                            <p>터키</p>
                        </a></div>
                    <div class="swiper-slide"> <a id="d" data-toggle="list" href="#list-settings" hwa='크로네' mon="NOK" con="NOR">
                            <img src='/resources/images/tripInfoimges/norway.gif' />
                            <p>노르웨이</p>
                        </a></div>
                    <div class="swiper-slide"><a id="d" data-toggle="list" href="#list-settings" hwa='즈워티' mon="PLN" con="POL">
                            <img src='/resources/images/tripInfoimges/Poland.png' />
                            <p>폴란드</p>
                        </a></div>
                </div>

                <!-- 네비게이션 -->
                <div class="swiper-button-next" style="width: 10px;height: 5px;"></div><!-- 다음 버튼 (오른쪽에 있는 버튼) -->
                <div class="swiper-button-prev" style="width: 10px;height: 5px;"></div><!-- 이전 버튼 -->

            </div>
            </div>
        </section>
        <div style="clear: both"></div>

        <section>
            <!-- 클래스명은 변경하면 안 됨 -->
            

            <div style="clear: both"></div>

            <!-- ============국가정보출력 box ================ -->
            <div class="popupLayer">
                <div class="popup-close">
                    <span onClick="closeLayer(this)" style="cursor:pointer;font-size:1.5em" title="닫기">
                        <i class="fas fa-times"></i>
                    </span>
                </div>
                <div class="country-content">
                    <img class="conImg" alt="" src="" />
                </div>
            </div>

            <div class="country-title">
                <div class="content">
                    <img class="conImg" alt="" src="" />
                </div>

            </div>



        </section>






    </main>










    <script type="text/javascript">
        jQuery(document).ready(function($) {
            randomImage('GBR');
            $("figure.effect5").on("click", function() {
                randomImage('GBR');
            });
            //getBestList();
            //getRecentList("C");
            getRecentList("B");
            getRecentList("F");
            getMainPlanner("E");
        });

        function randomImage(con) {
            console.log("con :: " + con)
            $.ajax({
                url: "/api/json/infinityClick/" + con,
                method: "GET",
                dataType: "json",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(JSONData, status) {
                    console.log("랜덤이미지 출력")
                    console.log(JSONData);
                    $('#infinityClick').attr('src', JSONData.conUrl);
                    var html = '';
                    console.log('JSONData.conInfo1 :' + JSONData.conInfo1 + ', JSONData.conInfo2 :' + JSONData.conInfo2 + ', JSONData.conInfo3:' + JSONData.conInfo3 + ', JSONData.conInfo4:' + JSONData.conInfo4);
                    if (JSONData.conInfo1 != null) {
                        html += JSONData.conInfo1;
                    }
                    if (JSONData.conInfo2 != null) {
                        html += JSONData.conInfo2;
                    }
                    if (JSONData.conInfo3 != null) {
                        html += JSONData.conInfo3;
                    }
                    if (JSONData.conInfo4 != null) {
                        html += JSONData.conInfo4;
                    }

                    $('.random-title').html(html);
                }
            })
        }

        function getBestList() {
            $.ajax({
                url: "/main/json/getBestList?boardName=C&searchCondition=0",
                method: "GET",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(result) {
                    var list = result;
                    console.log(result);
                    $.each(list, function(index, vo) {
                        console.log(vo);
                        //appendTag(vo, 'C');
                    })
                },
                error: function(err) {
                    console.log(err);
                }
            })

        }

        function getRecentList(boardName) {
            $.ajax({
                url: "/main/json/getRecentList?boardName=" + boardName,
                method: "GET",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(result) {
                    console.log(boardName + " :: " + result);
                    $.each(result, function(index, vo) {
                        appendOwl(vo, boardName);
                    })

                    loadOwl(boardName)

                },
                error: function(err) {
                    console.log(err);
                }
            })
        }

        function getMainPlanner(boardName) {
            $.ajax({
                url: "/main/json/getMainPlanner?boardName=" + boardName,
                method: "GET",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(result) {
                    $.each(result.planList, function(i, plan) {
                        $.each(result.list, function(j, post) {
                            if (plan.planId == post.planId) {
                                appendPlanner(plan, post);
                            }
                        })
                    })
                    loadOwl(boardName)
                },
                error: function(err) {
                    console.log(err);
                }
            })
        }

        function loadOwl(boardName) {
            var itemsCnt;
            var timeOut;
            if (boardName == 'E') {
                itemsCnt = 4;
                timeOut = 6000
            } else if (boardName == 'B') {
                itemsCnt = 5;
                timeOut = 8500
            } else if (boardName == 'F') {
                itemsCnt = 5;
                timeOut = 8500
            }
            $('#owl-' + boardName).owlCarousel({
                loop: true,
                center: true,
                items: itemsCnt,
                margin: 30,
                autoplay: true,
                dots: true,
                nav: true,
                autoplayTimeout: timeOut,
                smartSpeed: 450,
                navText: ['<i class="fas fa-chevron-left"></i>', '<i class="fas fa-chevron-right"></i>'],
                responsive: {
                    0: {
                        items: 1
                    },
                    768: {
                        items: 2
                    },
                    1170: {
                        items: itemsCnt
                    }
                }
            });
        }

        function appendPlanner(plan, post) {
            var planType = "";
            if (plan.planType == 'A') {
                planType = "여자혼자"
            } else if (plan.planType == 'B') {
                planType = "남자혼자"
            } else if (plan.planType == 'C') {
                planType = "여자끼리"
            } else if (plan.planType == 'D') {
                planType = "남자끼리"
            } else if (plan.planType == 'E') {
                planType = "단체"
            } else if (plan.planType == 'F') {
                planType = "부모님과"
            } else if (plan.planType == 'G') {
                planType = "커플"
            }


            var tag = "";
            tag += "<div class=\"item\">"
            tag += "<a class=\"story-entry-link\" href=\"/community/getPost?postId=" + post.postId + "&boardName=E\">";
            tag += "<div class=\"card\" style=\"height:100%;\">"
            tag += "<div class=\"planner-image-wrap\">"
            tag += "<img  class=\"card-img-top\" src='" + plan.planImg + "'>";
            tag += "</div>"
            tag += "<div class=\"card-body item-body\">"
            tag += "<p class=\"card-title\">" + post.postTitle + "</p>"
            tag += "<p class=\"card-text\">" + planType + "<p>"
            tag += "<p><img src='/resources/images/userImages/" + post.user.userImg + "' style='border-radius:50%;width:20px;height:20px;border:solid 2px white;margin-right:0.5em;display:inherit;'>"
            tag += post.nickName + "</p>"
            tag += "</div></a></div>"

            $("#owl-E").append(tag);

        }

        function appendTag(vo, boardName) {
            var tag = "";
            //var tag = "<div class=\"swiper-slide\">";

            var content = vo.postContent;
            var imgSrc = parseContent(content);
            tag += "<li class=\"col-6 col-md-3 best-stories__content__item\">"
            tag += "<article class=\"story-entry story-story-item\">"
            tag += "<a class=\"story-entry-link\" href=\"/community/getPost?postId=" + vo.postId + "&boardName=" + boardName + "\">";
            tag += "<div class='story-entry__wrap' style='position: relative;'>"
            tag += "<div class=\"story-entry__image-wrap\">"
            if (imgSrc != '') {
                tag += imgSrc;
            } else {
                tag += "<div class='topic'>"
                tag += "<div style='text-align:left;'><i class=\"fas fa-quote-left\ fa-2x\"></i></div>"
                tag += "<div style='text-align:center;'>" + vo.postTitle + "</div>";
                tag += "<div style='text-align:right;'><i class=\"fas fa-quote-left fa-2x fa-rotate-180\"></i></div>"
                tag += "</div>"
            }
            tag += "</div>"
            tag += "<div class=\"story-entry__content\" style=\"font-family:'Noto Sans KR';text-align:left;padding: 10px; width: 100%; bottom: 0px; font-size: 1em; font-weight: bold; position: absolute;background-color:black;opacity:70%;\">"
            tag += "<img src='/resources/images/userImages/" + vo.user.userImg + "' style='border-radius:50%;width:20px;height:20px;border:solid 2px white;margin-right:0.5em;display:inherit;'>"
            tag += "<span style='font-size:0.8em;color:#CCC;font-weight:400;'>" + vo.nickName + "</span>"
            tag += "</div>"
            tag += "</div></a>"
            tag += "</article></li>"
            //tag += "</div>"


            if (boardName == 'F') {
                $('.review-stories__content').append(tag);
            } else if (boardName == 'C') {
                $('.best-stories__content').append(tag);
            } else {
                $('.recent-stories__content').append(tag);
            }

        }

        function appendOwl(vo, boardName) {
            var tag = "";
            var content = vo.postContent;
            var imgSrc = parseContent(content);

            tag += "<div class=\"item\">"
            tag += "<a class=\"story-entry-link\" href=\"/community/getPost?postId=" + vo.postId + "&boardName=" + boardName + "\">";
            tag += "<div class='story-entry__wrap' style='position: relative;'>"
            tag += "<div class=\"story-entry__image-wrap\">"
            if (imgSrc != '') {
                tag += imgSrc;
            } else {
                tag += "<div class='topic'>"
                tag += "<div style='text-align:left;'><i class=\"fas fa-quote-left\ fa-2x\"></i></div>"
                tag += "<div style='text-align:center;'>" + vo.postTitle + "</div>";
                tag += "<div style='text-align:right;'><i class=\"fas fa-quote-left fa-2x fa-rotate-180\"></i></div>"
                tag += "</div>"
            }
            tag += "</div>"
            tag += "<div class=\"story-entry__content\" style=\"font-family:'Noto Sans KR';text-align:left;padding: 10px; width: 100%; bottom: 0px; font-size: 1em; font-weight: bold; position: absolute;background-color:black;opacity:70%;\">"
            tag += "<span style='font-size:0.8em;color:#CCC;font-weight:400;'>"
            tag += "<img src='/resources/images/userImages/" + vo.user.userImg + "' style='border-radius:50%;width:20px;height:20px;border:solid 2px white;margin-right:0.5em;'>"
            tag += vo.nickName + "</span>"
            tag += "</div>"
            tag += "</div></a>"
            tag += "</div>"


            $('#owl-' + boardName).append(tag);


        }




        function parseContent(content) {
            if (content.includes('<img')) {
                var startInt = content.indexOf('img');
                var endInt = content.indexOf('>', startInt);
                var result = content.substring(startInt - 1, endInt + 1);
                return result;
            } else {
                return "";
            }

        }


        $(function() {

            $.getJSON('').done('https://earthquake.kr:23490/query/KRWEUR')

        })


        $(function() {
            $(".swiper-slide>a").click(function(e) {

                var conCode = $(this).attr('con');
                var conName = $(this).text().trim();
                var conHwa = $(this).attr('hwa');
                countryInfo(conCode);

                $('input[name="conMoney"]').attr('placeholder', conName);
                $('span.text').html(conHwa);

                randomImage(conCode);


                //popup(e);
                //resultFun();
            });
        });

        function countryInfo(conCode) {


            $.ajax({
                url: "/api/json/exchange/" + conCode,
                method: "GET",
                dataType: "json",
                data: JSON.stringify({
                    conCode: conCode
                }),
                contentType: "application/x-www-form-urlencoded; charset=EUC-KR",
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json"
                },
                success: function(JSONData, status) {

                    var conInfo = JSONData.response.body.items.item.basic;
                    var country = JSONData.response.body.items.item.countryName;
                    var conFlag = JSONData.response.body.items.item.imgUrl;
                    /* alert(conName); */
                    //$("#form-group").html(myItem);
                    //$("img[class='conImg']").attr("src", conFlag);
                    //$('.country-title').html(country);
                    $('.country-content').html(conInfo);

                }
            });
        };

        function exchange(data) {
            //if( $('.select-selected') ) {
            if ($(".swiper-slide.on")) {
                $.getJSON('https://api.exchangeratesapi.io/latest?base=KRW').done(

                    function(data) {

                        var mon = $(".swiper-slide.on>a").attr('mon');
                         $('#result').val('');
//                        $('input[name="conMoney1"]').val('');

                        if (mon == undefined) {
                            $("#result").val("국가를 선택하세요");
                            return;
                        }

                        var price = $("input[name='conMoney1']").val();
//                         var price = $("#result").val();
                        
                        
                        /* var num = price/ data.rates[cur] */

                        var num = Math.round(price.match(/\d+/) /
                            data.rates[mon]);
                        /* alert(num);
                        alert(data.rates[abc]); */
                        price = price.replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
                        num = num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')

                        $('#result').val(num);
//                        $('input[name="conMoney1"]').val(num);
                        
                    })
            }
        }

        new Swiper('.swiper-container', {

            slidesPerView: 5, // 동시에 보여줄 슬라이드 갯수
            spaceBetween: 30, // 슬라이드간 간격
            slidesPerGroup: 2, // 그룹으로 묶을 수, slidesPerView 와 같은 값을 지정하는게 좋음
            //slidesPerColumn: 2,

            // 그룹수가 맞지 않을 경우 빈칸으로 메우기
            // 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
            //loopFillGroupWithBlank: false,

            loop: true, // 무한 반복

            /*pagination: { // 페이징
                el: '.swiper-pagination',
                clickable: true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
            },*/
            navigation: { // 네비게이션
                nextEl: '.swiper-button-next', // 다음 버튼 클래스명
                prevEl: '.swiper-button-prev', // 이번 버튼 클래스명
            },
        });

        $('.swiper-slide').on('click', function() {
            $('.swiper-slide').removeClass('on');
            $(this).toggleClass('on');
        })

        function closeLayer(obj) {
            $(obj).parent().parent().hide();
        }

        /*
                // 브라우서 호환 ( 크로스브라우징 ) 체크 하여 문서 전체에 mousemove 이벤트를 걸어줍니다.
                if (document.addEventListener) {
                    document.addEventListener("mousemove", resultFun, false);
                } else if (document.attachEvent) {
                    document.attachEvent("onmousemove", resultFun);
                } else {
                    document.onmousemove = resultFun;
                }

                //  문서에서 마우스가 움직일때(mousemove) 마다 resultFun() 함수가 실행됩니다.
                //  x.clientX,Y 는 페이지에서 이벤트 발생한 X,Y 좌표를 가져옵니다.
                function resultFun(x) {
                    //var xY = x.clientX +  " * "  + x.clientY ;
                    var positionLeft = x.clientX;
                    var positionTop = x.clientY;
                    // result  div 에 innerHTML 로 xY 변수를 적용 합니다.
                    //document.getElementsByClassName('popupLayer').innerHTML = xY;
                    //  result  div 의 position 위치를  positionLeft, Top 변수 값으로 style 적용해줍니다.
                    $('.popupLayer').css({
                        "left": (positionLeft - 25) + "px",
                        "top": (positionTop + 30) + "px",
                        "position": "absolute"
                    }).show();
                }*/

        function popup(e) {

            /* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
            var sWidth = window.innerWidth;
            var sHeight = window.innerHeight;

            var oWidth = $('.popupLayer').width();
            var oHeight = $('.popupLayer').height();

            // 레이어가 나타날 위치를 셋팅한다.
            var divLeft = e.clientX + 10;
            var divTop = e.clientY + 5;

            // 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
            if (divLeft + oWidth > sWidth) divLeft -= oWidth;
            if (divTop + oHeight > sHeight) divTop -= oHeight;

            // 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
            if (divLeft < 0) divLeft = 0;
            if (divTop < 0) divTop = 0;

            $('.popupLayer').css({
                "top": divTop,
                "left": divLeft,
                "position": "absolute"
            }).show();
        }

        var myAOS = function() {
            AOS.init({
                easing: 'ease-out-back'
                //duration: 1500
            });
        }
        myAOS();



        /*------------------------------환율 select-----------------------------------------*/
        var x, i, j, selElmnt, a, b, c;
        /*look for any elements with the class "custom-select":*/
        x = document.getElementsByClassName("cur-select");
        var conCode;
        var conName;
        var conHwa;
        for (i = 0; i < x.length; i++) {
            selElmnt = x[i].getElementsByTagName("select")[0];
            /*for each element, create a new DIV that will act as the selected item:*/
            a = document.createElement("DIV");
            a.setAttribute("class", "select-selected");

            a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
            x[i].appendChild(a);
            /*for each element, create a new DIV that will contain the option list:*/
            b = document.createElement("DIV");
            b.setAttribute("class", "select-items select-hide");
            for (j = 1; j < selElmnt.length; j++) {
                /*for each option in the original select element,
                create a new DIV that will act as an option item:*/
                c = document.createElement("DIV");
                c.innerHTML = selElmnt.options[j].innerHTML;
                c.addEventListener("click", function(e) {
                    /*when an item is clicked, update the original select box,
                    and the selected item:*/
                    var y, i, k, s, h;
                    s = this.parentNode.parentNode.getElementsByTagName("select")[0];
                    h = this.parentNode.previousSibling;
                    for (i = 0; i < s.length; i++) {
                        if (s.options[i].innerHTML == this.innerHTML) {
                            s.selectedIndex = i;
                            h.innerHTML = this.innerHTML;
                            y = this.parentNode.getElementsByClassName("same-as-selected");
                            for (k = 0; k < y.length; k++) {
                                y[k].removeAttribute("class");
                            }
                            this.setAttribute("class", "same-as-selected");
                            break;
                        }
                    }
                    h.click();
                });
                b.appendChild(c);
            }
            x[i].appendChild(b);
            a.addEventListener("click", function(e) {
                /*when the select box is clicked, close any other select boxes,
                and open/close the current select box:*/
                e.stopPropagation();
                closeAllSelect(this);
                this.nextSibling.classList.toggle("select-hide");
                this.classList.toggle("select-arrow-active");
            });
        }

        /*   통화이름 보이기
           conCode = $('.select-selected').attr('con');
           conName = $('.select-selected').text();
           conHwa = $('.select-selected').attr('hwa');
           countryInfo(conCode);

           $('input[name="conMoney"]').attr('placeholder', conName.trim());
           $('.text').html(conHwa);*/

        function closeAllSelect(elmnt) {
            /*a function that will close all select boxes in the document,
            except the current select box:*/
            var x, y, i, arrNo = [];
            x = document.getElementsByClassName("select-items");
            y = document.getElementsByClassName("select-selected");
            for (i = 0; i < y.length; i++) {
                if (elmnt == y[i]) {
                    arrNo.push(i)
                } else {
                    y[i].classList.remove("select-arrow-active");
                }
            }
            for (i = 0; i < x.length; i++) {
                if (arrNo.indexOf(i)) {
                    x[i].classList.add("select-hide");
                }
            }
        }
        /*if the user clicks anywhere outside the select box,
        then close all select boxes:*/
        document.addEventListener("click", closeAllSelect);
        $('body > main > section.new-plan.aos-init.aos-animate > header > span.col.section__header__content').on('click', function() {
             self.location = '/community/getPostList?boardName=E';
        })
        $('body > main > section.new-plan.aos-init.aos-animate > header > span.section__header__more').on('click', function(){
            self.location = '/community/getPostList?boardName=E';
        });
        
        $('body > main > section.owl-review-section.aos-init.aos-animate > header > span.col.section__header__content').on('click', function(){
            self.location = '/community/getPostList?boardName=F';
        })
        $('body > main > section.owl-review-section.aos-init.aos-animate > header > span.section__header__more').on('click', function(){
           self.location = '/community/getPostList?boardName=F';
        });
        
        $('body > main > section.owl-info-section.aos-init.aos-animate > header > span.col.section__header__content').on('click', function() {
            self.location = '/community/getPostList?boardName=B';
        });
        $('body > main > section.owl-info-section.aos-init.aos-animate > header > span.section__header__more').on('click', function() {
            self.location = '/community/getPostList?boardName=B';
        });

    </script>

    <jsp:include page="toolbar/pushBar.jsp" />
    <jsp:include page="toolbar/footer.jsp" />

</body>

</html>
