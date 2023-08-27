<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en-US" dir="ltr">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>고치면 김채영 매달아놓기</title>

    <!-- ===============================================-->
    <!--    Favicons-->
    <!-- ===============================================-->
    <!-- jquery  -->
    <script type="text/javascript" src="<c:url value='/js/jquery-3.7.0.min.js'/>"></script>
    <link rel="apple-touch-icon" sizes="180x180" href="<c:url value='/assets/img/favicons/apple-touch-icon.png'/>">
    <link rel="icon" type="image/png" sizes="32x32" href="<c:url value='/assets/img/favicons/favicon-32x32.png'/>">
    <link rel="icon" type="image/png" sizes="16x16" href="<c:url value='/assets/img/favicons/favicon-16x16.png'/>">
    <link rel="shortcut icon" type="image/x-icon" href="<c:url value='/planet_icon.ico'/>">
    <link rel="manifest" href="<c:url value='/assets/img/favicons/manifest.json'/>">
 	<meta name="msapplication-TileImage" content="<c:url value='/assets/img/favicons/mstile-150x150.png'/>">
    <meta name="theme-color" content="#ffffff">
    <script src="<c:url value='/assets/js/config.js'/>"></script>
    <script src="<c:url value='/vendors/simplebar/simplebar.min.js'/>"></script>

    <!-- ===============================================-->
    <!--    Stylesheets-->
    <!-- ===============================================-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700%7cPoppins:300,400,500,600,700,800,900&amp;display=swap" rel="stylesheet">
    <link href="<c:url value='/vendors/simplebar/simplebar.min.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/theme-rtl.css'/>" rel="stylesheet" id="style-rtl">
    <link href="<c:url value='/assets/css/theme.css'/>" rel="stylesheet" id="style-default">
    <link href="<c:url value='/assets/css/user-rtl.css'/>" rel="stylesheet" id="user-style-rtl">
    <link href="<c:url value='/assets/css/user.css'/>" rel="stylesheet" id="user-style-default">
    <script>
      var isRTL = JSON.parse(localStorage.getItem('isRTL'));
      if (isRTL) {
        var linkDefault = document.getElementById('style-default');
        var userLinkDefault = document.getElementById('user-style-default');
        linkDefault.setAttribute('disabled', true);
        userLinkDefault.setAttribute('disabled', true);
        document.querySelector('html').setAttribute('dir', 'rtl');
      } else {
        var linkRTL = document.getElementById('style-rtl');
        var userLinkRTL = document.getElementById('user-style-rtl');
        linkRTL.setAttribute('disabled', true);
        userLinkRTL.setAttribute('disabled', true);
      }
      
    </script>
    <script type="text/javascript">
    	$(function() {
    		$.when(confirmRecord(), newMessage()).done(function() {
    	        bellSet();
    	    });
    		  $('.nav-link').on('click', function() {
    		    // 해당 a 태그에 active 클래스 추가
    		    $(this).addClass('active');
    		    
    		    // 클릭한 a 태그를 제외한 다른 a 태그들의 active 클래스 제거
    		    $('.nav-link').not(this).removeClass('active');
    		  });
    		
		});
    	
    	function bellSet(){
    		var newCnt=$('.list-group').find('.new').length;
    		if(newCnt>0){
    			$('#navbarDropdownNotification').addClass('notification-indicator');
    			$('#navbarDropdownNotification').addClass('notification-indicator-primary');
    		}
    	}
    	
    	function confirmRecord(){
    		return $.ajax({
    			url:"<c:url value='/approval/recordAjax'/>",
    		   	type:"post",
    		   	dataType:"json",
    		   	success:function(res){
    		   		$('#confirm').text(res[0]);
    		   		$('#turn').text(res[1]);
    		   		$('#agree').text(res[2]);
    		   		$('#approval').text(res[0]+res[1]+res[2]);
    		   		approvalInfo(res[0],res[1],res[2]);
    		    },error:function(xhr, status, error){
    		    	alert(status+" : "+error);
    		   	}
    		});
    	}
    	
    	function newMessage(){
    		return $.ajax({
    			url:"<c:url value='/message/newMessageAjax'/>",
    		   	type:"post",
    		   	dataType:"json",
    		   	success:function(res){
    		   		$('#newMessage').text(res);
    		   		$('#totalMessage').text(res);
    		   		messageInfo(res);
    		    },error:function(xhr, status, error){
    		    	alert(status+" : "+error);
    		   	}
    		});
    	}
    	
    	function approvalInfo(confirm,turn,agree){
        	var str="";
        	var topstr="<div class='list-group-title border-bottom'>NEW</div>";
        	var confirmStr="<strong>결재할 문서</strong> : "+confirm+"건이 있습니다.</p>";
        	var turnStr="<strong>반려된 문서</strong> : "+turn+"건이 있습니다.</p>";
        	var agreeStr="<strong>합의할 문서</strong> : "+agree+"건이 있습니다.</p>";
        	var turnUrl="<a class='notification notification-flush notification-unread' href='<c:url value='/approval/returnList'/>'>";
        	var agreeUrl="<a class='notification notification-flush notification-unread' href='<c:url value='/approval/deptAgreeList'/>'>";
        	var confirmUrl="<a class='notification notification-flush notification-unread' href='<c:url value='/approval/confirm/confirmList'/>'>";
        	var divstr="<div class='list-group-item new'>";	
        	var divstr2="<div class='notification-avatar'>";
        	divstr2+="<div class='avatar avatar-2xl me-3'>";
        	divstr2+="<img class='rounded-circle' src='<c:url value='/images/approval.png'/>' alt='쪽지아이콘' />";
        	divstr2+="</div>";
        	divstr2+="</div>";
        	divstr2+="<div class='notification-body'>";
        	divstr2+="<p class='mb-1'>";
        	
          	if(confirm>0 || turn>0 || agree>0){
	          	if(confirm>0){
		        	str+=divstr;
		        	str+=confirmUrl;
		        	str+=divstr2;
		        	str+=confirmStr;
		        	str+="</div></a></div>";
	          	}
	          	if(turn>0){
	          		str+=divstr;
		        	str+=turnUrl;
		        	str+=divstr2;
	          	  	str+=turnStr;
	          	  	str+="</div></a></div>";
	          	}
	          	if(agree>0){
	          		str+=divstr;
		        	str+=agreeUrl;
		        	str+=divstr2;
	          	  	str+=agreeStr;
	          	  	str+="</div></a></div>";
	          	}
          	}else{
          		return;
          	}
          	
          	if($('.list-group').find('.new').length==0){
          		$('.list-group').html(topstr);
          	} 
          	$('.list-group').append(str);
          
    	}
    	
    	function messageInfo(cnt){
        	var str="";
        	var topstr="<div class='list-group-title border-bottom'>NEW</div>";
        	
          	if(cnt>0){
        	  str+="<div class='list-group-item new'>";
        	  str+="<a class='notification notification-flush notification-unread' href='<c:url value='/message/messageList'/>'>";
        	  str+="<div class='notification-avatar'>";
        	  str+="<div class='avatar avatar-2xl me-3'>";
        	  str+="<img class='rounded-circle' src='<c:url value='/images/message.png'/>' alt='쪽지아이콘' />";
        	  str+="</div>";
        	  str+="</div>";
        	  str+="<div class='notification-body'>";
        	  str+="<p class='mb-1'>";
        	  str+="<strong>안읽은 메시지</strong> : "+cnt+"건이 있습니다.</p>";
        	  str+="</div></a></div>";
          	}else{
          		return;
          	}
          	
          	if($('.list-group').find('.new').length==0){
          		$('.list-group').html(topstr);
          	} 
          	$('.list-group').append(str);
          
    	}
    </script>
  </head>
  <body>

    <!-- ===============================================-->
    <!--    Main Content-->
    <!-- ===============================================-->
    <main class="main" id="top">
      <div class="container-lg" data-layout="container">
        <script>
          var isFluid = JSON.parse(localStorage.getItem('isFluid'));
          if (isFluid) {
            var container = document.querySelector('[data-layout]');
            container.classList.remove('container');
            container.classList.add('container-fluid');
          }
        </script>
        <nav class="navbar navbar-light navbar-vertical navbar-expand-lg">
          <script>
            var navbarStyle = localStorage.getItem("navbarStyle");
            if (navbarStyle && navbarStyle !== 'transparent') {
              document.querySelector('.navbar-vertical').classList.add(`navbar-${navbarStyle}`);
            }
          </script>
          <div class="d-flex align-items-center">
            <a class="navbar-brand" href="<c:url value='/main'/>">
              <div class="d-flex align-items-center py-3">
              	<img src="<c:url value='/title.png'/>" alt="" width="150" />
              </div>
            </a>
          </div>
          <!-- side nav -->
          <div class="collapse navbar-collapse" id="navbarVerticalCollapse">
            <div class="navbar-vertical-content scrollbar">
				<ul class="navbar-nav flex-column mb-3" id="navbarVerticalNav">
		
				<li class="nav-item">
            		<c:import url="/inc/empMain"></c:import>
				</li>
					
					<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#mypage" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-address-card"></span></span>
	                    		<span class="nav-link-text  ps-1">마이페이지</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="mypage">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/mypage/empInfoEdit'/>" role="button" data-toggle="collapse">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">내 정보 수정</span>
                        			</div> 
                      			</a>
                    		</li>
	                  			
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/mypage/myWritingList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">내가 쓴 글 관리</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/mypage/addressBook'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1" >주소록</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#a" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-user-check"></span></span>
	                    		<span class="nav-link-text ps-1">근태관리</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="a">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/commute/status'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">출/퇴근 현황</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<!-- 임원 -->
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="#">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1" >부서 근태 통계(임원)</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#b" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-file-export"></span></span>
	                    		<span class="nav-link-text ps-1">
	                    			전자결재
	                    			<span class="badge rounded-pill text-bg-primary" id="approval" ></span>
	                    		</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="b">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/approval/approvalWrite'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">결재 문서 작성</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<!-- 임원 -->
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/approval/confirmList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">나의 문서함</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/approval/returnList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">
	                        				반려함
	                        				<span class="badge rounded-pill text-bg-primary" id="turn"></span>
                        				</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<c:if test="${sessionScope.positionRank>=3 }"> <!-- 대리 이상 -->
	                    		<li class="nav-item"><!-- more inner pages-->
	                    			<a class="nav-link " href="<c:url value='/approval/confirm/confirmList'/>">
	                        			<div class="d-flex align-items-center">
	                        				<span class="nav-link-text ps-1">
	                        					결재 대기함
	                        					<span class="badge rounded-pill text-bg-primary" id="confirm" ></span>
	                        				</span>
	                        			</div> 
	                      			</a>
	                    		</li>
	                    		<li class="nav-item"><!-- more inner pages-->
	                    			<a class="nav-link " href="<c:url value='/approval/completeList'/>">
	                        			<div class="d-flex align-items-center">
	                        				<span class="nav-link-text ps-1">결재 완료함</span>
	                        			</div> 
	                      			</a>
	                    		</li>
                    		</c:if>
	                    		<li class="nav-item"><!-- more inner pages-->
	                    			<a class="nav-link " href="<c:url value='/approval/deptAgreeList'/>">
	                        			<div class="d-flex align-items-center">
	                        				<span class="nav-link-text ps-1">
		                        				합의 문서함
		                        				<span class="badge rounded-pill text-bg-primary" id="agree" ></span>
	                        				</span>
	                        			</div> 
	                      			</a>
	                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/approval/referList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">결재 문서 참조함</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#c" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-plug"></span></span>
	                    		<span class="nav-link-text ps-1">자원관리</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="c">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/reservation/addReservation'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">자원 예약</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="#">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">자원 예약 내역</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#d" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-calendar-alt"></span></span>
	                    		<span class="nav-link-text ps-1">캘린더</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="d">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/calendar/addCalendar'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">일정 등록</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/calendar/fullCalendar'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">내 일정 관리</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="#">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">부서 일정 관리(임원)</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#e" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-envelope-open"></span></span>
	                    		<span class="nav-link-text ps-1">
	                    		쪽지
	                    		<span class="badge rounded-pill text-bg-primary" id="totalMessage"></span>
	                    		</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="e">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/message/messageWrite'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">쪽지 쓰기</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/message/messageList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">
                        					쪽지함
                        					<span class="badge rounded-pill text-bg-primary" id="newMessage"></span>
                        				</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#f" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-download"></span></span>
	                    		<span class="nav-link-text ps-1">자료실</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="f">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/pds/list'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">파일 다운로드</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="#">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">다운로드 파일 관리</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<!-- label-->
                  	<div class="row navbar-vertical-label-wrapper mt-3 mb-2">
	                    <div class="col-auto navbar-vertical-label">
	                    	사내게시판
	                    </div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider" />
	                    </div>
                  	</div>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link" href="<c:url value='/board/noticeList'/>" role="button" data-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-thumbtack"></span></span>
                    			<span class="nav-link-text ps-1">공지사항</span>
	                    	</div>
	                  	</a>
						<a class="nav-link" href='<c:url value='/qna/list'/>' role="button" data-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-key"></span></span>
	                    		<span class="nav-link-text ps-1">Q&A</span>
	                    	</div>
	                  	</a>
						<a class="nav-link" href="<c:url value='/board/faqList'/>" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-question-circle"></span></span>
	                    		<span class="nav-link-text ps-1">FAQ</span>
	                    	</div>
	                  	</a>
                  	</li>
                  	<!-- label-->
                  	<div class="row navbar-vertical-label-wrapper mt-3 mb-2">
	                    <div class="col-auto navbar-vertical-label">
	                    	커뮤니티
	                    </div>
	                    <div class="col ps-0">
	                      <hr class="mb-0 navbar-vertical-divider" />
	                    </div>
                  	</div>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#g" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-parachute-box"></span></span>
	                    		<span class="nav-link-text ps-1">동호회</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="g">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/club/createClub'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">동호회 등록</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/club/clubList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">동호회 게시판</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/views/club/clubStanby.jsp'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">결재 대기 동호회(임원)</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#h" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-carrot"></span></span>
	                    		<span class="nav-link-text ps-1">중고거래</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="h">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/market/marketList'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">거래게시판</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="<c:url value='/market/addMarket'/>">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">거래 올리기</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
                  	<li class="nav-item"><!-- parent pages-->
						<a class="nav-link dropdown-indicator" href="#i" role="button" data-bs-toggle="collapse">
	                    	<div class="d-flex align-items-center">
	                    		<span class="nav-link-text"><span class="fas fa-paper-plane"></span></span>
	                    		<span class="nav-link-text ps-1">피드</span>
	                    	</div>
	                  	</a>
	                  	<ul class="nav collapse" id="i">
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="#">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">익명게시판</span>
                        			</div> 
                      			</a>
                    		</li>
                    		<li class="nav-item"><!-- more inner pages-->
                    			<a class="nav-link " href="#">
                        			<div class="d-flex align-items-center">
                        				<span class="nav-link-text ps-1">추가</span>
                        			</div> 
                      			</a>
                    		</li>
						</ul>
                  	</li>
				</ul>
			</div>
		  </div>
        </nav>
        <div class="content">
        <!-- top nav -->
          <nav class="navbar navbar-light navbar-glass navbar-top">
            <div class = "container">
            <a class="navbar-brand me-1 me-sm-3" href="<c:url value='/'/>">
              <div class="d-flex align-items-center"><img src="title.png" alt="" width="150" />
              </div>
            </a>
            <ul class="navbar-nav navbar-nav-icons ms-auto flex-row align-items-center">
              <li>
				<button class="nav-link px-0 notification-indicator-warning notification-indicator-fill fa-icon-wait" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
				<span class="fas fa-users" data-fa-transform="shrink-7" style="font-size: 33px;"></span>
				</button>
              </li>
              
              <li class="nav-item d-none d-sm-block">
                <a class="nav-link px-0 notification-indicator notification-indicator-warning notification-indicator-fill fa-icon-wait" href="app/e-commerce/shopping-cart.jsp"><span class="fas fa-shopping-cart" data-fa-transform="shrink-7" style="font-size: 33px;"></span><span class="notification-indicator-number">1</span></a>
              </li>
              <li class="nav-item dropdown">
                <a class="nav-link px-0 fa-icon-wait" id="navbarDropdownNotification" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" data-hide-on-body-scroll="data-hide-on-body-scroll">
                	<span class="fas fa-bell" data-fa-transform="shrink-6" style="font-size: 33px;"></span>
                </a>
                <div class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-menu-notification dropdown-caret-bg" aria-labelledby="navbarDropdownNotification">
                  <div class="card card-notification shadow-none">
                    <div class="card-header">
                      <div class="row justify-content-between align-items-center">
                        <div class="col-auto">
                          <h6 class="card-header-title mb-0">알림</h6>
                        </div>
                      </div>
                    </div>
                    <div class="scrollbar-overlay" style="max-height:19rem">
                      <div class="list-group list-group-flush fw-normal fs--1">
                        <div class="list-group-title border-bottom">NEW</div>
                        <div class="list-group-item">
                            <div class="notification-body p-3" align="center">
                              <p class="mb-1">
                              	<strong>새로운 알림이 없습니다.</strong> 
                              </p>
                            </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
              <li class="nav-item dropdown px-1">
                <a class="nav-link fa-icon-wait nine-dots p-1" id="navbarDropdownMenu" role="button" data-hide-on-body-scroll="data-hide-on-body-scroll" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="43" viewBox="0 0 16 16" fill="none">
                    <circle cx="2" cy="2" r="2" fill="#6C6E71"></circle>
                    <circle cx="2" cy="8" r="2" fill="#6C6E71"></circle>
                    <circle cx="2" cy="14" r="2" fill="#6C6E71"></circle>
                    <circle cx="8" cy="8" r="2" fill="#6C6E71"></circle>
                    <circle cx="8" cy="14" r="2" fill="#6C6E71"></circle>
                    <circle cx="14" cy="8" r="2" fill="#6C6E71"></circle>
                    <circle cx="14" cy="14" r="2" fill="#6C6E71"></circle>
                    <circle cx="8" cy="2" r="2" fill="#6C6E71"></circle>
                    <circle cx="14" cy="2" r="2" fill="#6C6E71"></circle>
                  </svg></a>
                <div class="dropdown-menu dropdown-caret dropdown-caret dropdown-menu-end dropdown-menu-card dropdown-caret-bg" aria-labelledby="navbarDropdownMenu">
                  <div class="card shadow-none">
                    <div class="scrollbar-overlay nine-dots-dropdown">
                      <div class="card-body px-3">
                        <div class="row text-center gx-0 gy-0">
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="https://google.com/" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/google.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Google</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/spotify.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Spotify</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/steam.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Steam</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/github-light.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Github</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/discord.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Discord</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/xbox.png" alt="" width="40" height="40" />
                             	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">xbox</p>
                            </a>
                          </div>
                          <div class="col-12">
                            <hr class="my-3 mx-n3 bg-200" />
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/twitter.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Twitter</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/facebook.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Facebook</p>
                            </a>
                          </div>
                          <div class="col-4">
                          	<a class="d-block hover-bg-200 px-2 py-3 rounded-3 text-center text-decoration-none" href="#!" target="_blank">
                          		<img class="rounded" src="assets/img/nav-icons/instagram.png" alt="" width="40" height="40" />
                              	<p class="mb-0 fw-medium text-800 text-truncate fs--2 pt-1">Instagram</p>
                            </a>
                          </div>
                          <div class="col-12"><a class="btn btn-outline-primary btn-sm mt-4" href="#!">Show more</a></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
            </div>
          </nav>
          <!-- top end -->
<c:import url="/mypage/organizationChart"></c:import>