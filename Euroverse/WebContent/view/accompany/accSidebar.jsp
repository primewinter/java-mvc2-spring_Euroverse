<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

	
	<!-- ICON 사용을 위한 스크립트 임포트 -->
<!--	 https://feathericons.com/ -->
	<script src="https://unpkg.com/feather-icons"></script>
	
	
	<!-- Custom styles for this template -->
	<!-- 왼쪽 사이드바를 위한 CSS... 안돼서 걍 스크립트 통째로 넣어둠 -->
    <!-- <link href="/css/bootstrapDashboardCustomStyle.css" rel="stylesheet"> -->
	<style type="text/css">
		/* body {
		  font-size: .875rem;
		} */
		.feather {
		  width: 16px;
		  height: 16px;
		  vertical-align: text-bottom;
		}
		
		/* Sidebar */
		.sidebar {
		  /*position: fixed;*/
		  /*top: 300px;*/
		  /*bottom: 0;*/
		  max-height: 600px;
		  left: 0;
          width: 20%;
		  z-index: 40; /* Behind the navbar */
		  padding: 48px 0 0; /* Height of navbar */
		}
		.sidebar-sticky {
		  position: relative;
		  top: 0;
		  height: calc(100vh - 48px);
		  padding-top: .5rem;
		  overflow-x: hidden;
		  overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
		}
		@supports ((position: -webkit-sticky) or (position: sticky)) {
		  .sidebar-sticky {
		    position: -webkit-sticky;
		    position: sticky;
		  }
		}
		
		.sidebar .nav-link {
		  font-weight: 500;
		  color: #333;
		}
		.sidebar .nav-link .feather {
		  margin-right: 4px;
		  color: #999;
		}
		.sidebar .nav-link.active {
		  color: #00c2c7;
		}
		.sidebar .nav-link:hover .feather,
		.sidebar .nav-link.active .feather {
		  color: inherit;
		}
		.sidebar-heading {
		  font-size: .75rem;
		  text-transform: uppercase;
		}
		
		/* Content */
		
		[role="main"] {
		  padding-top: 133px; /* Space for fixed navbar */
		}
		@media (min-width: 768px) {
		  [role="main"] {
		    padding-top: 48px; /* Space for fixed navbar */
		  }
		}
		
		/* Navbar */
		/* .navbar-brand {
		  padding-top: .75rem;
		  padding-bottom: .75rem;
		  font-size: 1rem;
		  background-color: rgba(0, 0, 0, .25);
		  box-shadow: inset -1px 0 0 rgba(0, 0, 0, .25);
		} */
		.navbar .form-control {
		  padding: .75rem 1rem;
		  border-width: 0;
		  border-radius: 0;
		}
		.form-control-dark {
		  color: #fff;
		  background-color: rgba(255, 255, 255, .1);
		  border-color: rgba(255, 255, 255, .1);
		}
		.form-control-dark:focus {
		  border-color: transparent;
		  box-shadow: 0 0 0 3px rgba(255, 255, 255, .25);
		}
	
	
		.bd-placeholder-img {
	        font-size: 1.125rem;
	        text-anchor: middle;
	        -webkit-user-select: none;
	        -moz-user-select: none;
	        -ms-user-select: none;
	        user-select: none;
	      }
	
	      @media (min-width: 768px) {
	        .bd-placeholder-img-lg {
	          font-size: 3.5rem;
	        }
	      }
	</style>
	
	<script>

		$(function(){
		
			$("a:contains('참여')").on("click" ,function(){
				$(self.location).attr("href","/community/getMyPartyList");
			});
            $("a:contains('찾기')").on("click" ,function(){
				$(self.location).attr("href","/community/getPostList?boardName=D");
			});
            $("a:contains('신청')").on("click" ,function(){
				$(self.location).attr("href","/myPage/myOfferList?searchKeyword=party");
			});
            $("a:contains('요청한')").on("click" ,function(){
				$(self.location).attr("href","/community/getMyOfferList");
			});
			
			
		});
		
	</script>

	
	<!-- 좌측 Plan 툴바 구성 Start /////////////////////////////////////////////////////////// -->
	<nav class="col-md-2 d-none d-md-block sidebar sticky-top" style="padding-top:0px; padding-left:25px;padding-right: 20px;">
      <div class="sidebar-sticky">
       <div id="blank-top" style="height: 60px"></div>
        <ul class="nav flex-column" style="text-align: right;">
          <li class="nav-item">
            <a class="nav-link" href="#C">
              동행찾기 &nbsp; <span data-feather="users"></span>
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link scroll" href="#E">
              참여중인 동행 &nbsp; <span data-feather="message-square"></span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link scroll" href="#E">
              신청받은 동행 &nbsp; <span data-feather="file"></span>
            </a>
          </li>
               
         <li class="nav-item">
            <a class="nav-link scroll" href="#E">
              요청한 동행 &nbsp; <span data-feather="send"></span>
            </a>
          </li>
         <!-- <li class="nav-item">
            <a class="nav-link scroll" href="#F">
              여행후기 &nbsp;<span data-feather="image"></span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link scroll" href="#B">
              여행정보 &nbsp; <span data-feather="book-open"></span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link scroll" href="#G">
              QnA &nbsp; <span data-feather="help-circle"></span>
            </a>
          </li>
          
          <li class="nav-item">
            <a class="nav-link scroll" href="#A">
              자유게시판 &nbsp; <span data-feather="message-circle"></span>
            </a>
          </li>-->
        </ul>

       
        <!-- Top 버튼 -->
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-5 mb-1 text-muted">
        	<span></span>
        	<span>
        		<a href="#" title="top" class="scroll"> top <span data-feather="arrow-up"></span></a>
        	</span>
        </h6>
        
      </div>
    </nav>
	<!-- 좌측 Plan 툴바 구성 End //////////////////////////////////////////////////// -->
	
	
	<script>
		/* icon 사용을 위한 스크립트 */
		/* https://github.com/feathericons/feather#feather 참고 */
		feather.replace();
        $('#blank-top').hide();
             $(window).scroll(function() {
                if ($(document).scrollTop() > 125) {
                    $('#blank-top').show();
                } else {
                    $('#blank-top').hide();
                }
             });
	</script>
	