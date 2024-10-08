<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 김승준 -->
<!-- 작성일 : 2017-01-12 -->
<!-- 최종수정일 : 2024-06-28 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 개발자 작성한 title을 가져 다 사용 -->
	<title>
		웹짱:<decorator:title />
	</title>
  <!-- Bootstrap 4 + jquery 라이브러리 등록 - CDN 방식 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>
  
  <!-- icon 라이브러리 등록 Awesome4 / google-->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

	<style type="text/css">
	
	pre {
		background: white;
		border: 0px;
	}
	
	/* Remove the navbar's default margin-bottom and rounded borders */
	.navbar {
		margin-bottom: 0;
		border-radius: 0;
	}
	
	/* Add a gray background color and some padding to the footer */
	footer {
		background-color: #f2f2f2;
		padding: 25px;
	}
	
	.carousel-inner img {
		width: 100%; /* Set width to 100% */
		margin: auto;
		min-height: 200px;
	}
	
	/* Hide the carousel text when the screen is less than 600 pixels wide */
	@media ( max-width : 600px) {
		.carousel-caption {
			display: none;
		}
	}
	
	article {
		min-height: 795px;
		margin-top: 60px;
	}
	
	#welcome {
		color: grey;
		margin: 0 auto;
	}
	
	</style>

	<!-- 개발자가 작성한 소스의 head 태그를 여기에 넣게 된다. title은 제외 -->
	<script type="text/javascript">
		$(function() {
			//취소 버튼 이벤트
			$(".cancelBtn").click(function() {
				history.back();
			});
			
			$(".datepicker").datepicker({		
				changeMonth: true,		
				changeYear: true,		
				dateFormat: "yy-mm-dd",		
				dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],		
				monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
				
			});
			
		});
	
	</script>
	<decorator:head/>
<%-- 	<c:if test="${!empty login }"> --%>
		<script type="text/javascript">
			$(function() {
				if(${!empty login}){
					setInterval(function() {
						//서버에서 새로운 메시지 데이터를 가져와서 새로운 메시지 란에 표시
// 						$.ajax({
// 							url: "/ajax/setCnt.do",
// 							success: function(data) {						
// 								$("#newMsgCnt").text(data);
// 							}
// 						});
					},20000);		
				}
			});	
		</script>
<%-- 	</c:if> --%>
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg bg-dark navbar-dark fixed-top">
		    <a class="nav-link" href="/"><b>웹짱닷컴</b></a>
		    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
		    <div class="collapse navbar-collapse" id="collapsibleNavbar">
			<!-- 주메뉴 부분 -->					
			<!-- 오른쪽 부분의 내용을 오른쪽 끝에 두기 위해서 mr-auto사용 -->
		  	<ul class="navbar-nav mr-auto">	  		
		    	<li ${(module == '/notice')?"class='nav-item active'":"class='nav-item'"}>
		      		<a class="nav-link" href="/notice/list.do">공지사항</a>
		    	</li>
		    	<li ${(module == '/goods')?"class='nav-item active'":"class='nav-item'"}>
		      		<a class="nav-link" href="/goods/list.do">쇼핑몰</a>
		    	</li>
		    	<li ${(module == '/image')?"class='nav-item active'":"class='nav-item'"}>
		      		<a class="nav-link" href="/image/list.do">갤러리</a>
		    	</li>
		    	<li ${(module == '/board')?"class='nav-item active'":"class='nav-item'"}>
		      		<a class="nav-link" href="/board/list.do">일반 게시판</a>
		    	</li>
		    	<li ${(module == '/qna')?"class='nav-item active'":"class='nav-item'"}>
		      		<a class="nav-link" href="/qna/list.do">질문 답변</a>
		    	</li>
		    	<c:if test="${!empty login }">
		    		<li ${(module == '/message')?"class='nav-item active'":"class='nav-item'"}>
			      		<a class="nav-link" href="/message/list.do">메시지</a>
			    	</li>					    	
		    	</c:if>
		    	<c:if test="${!empty login && login.gradeNo==9 }">
			    	<!-- 관리자 메뉴 -->
			    	<li ${(uri == '/member/list.do')?"class='nav-item active'":"class='nav-item'"}>
			      		<a class="nav-link" href="/member/list.do">회원관리</a>
			    	</li>		    	
		    	</c:if>
		  	</ul>
		  	
  			
 	 		
			<ul class="navbar-nav">
				<c:if test="${empty login }">
					<!-- 로그인을 안 했을때 -->
			  		<li ${(uri == '/member/loginForm.do')?"class='nav-item active'":"class='nav-item'"}>
			      		<a class="nav-link" href="/member/loginForm.do">
				      		<i class="fa fa-sign-in align-baseline" style="font-size:19px"></i>
				      		<b>로그인</b>
			      		</a>
			    	</li>
			    	<li ${(uri == '/member/writeForm.do')?"class='nav-item active'":"class='nav-item'"}>
			      		<a class="nav-link" href="/member/writeForm.do">
			      			<i class="fa fa-address-card"></i>
			      			<b>회원가입</b>
			      		</a>
			    	</li>
			    	<li class="nav-item">
			      		<a class="nav-link" href="/member/searchID.do">
			      			<i class="fa fa-search"></i>
			      			<b>아이디/비밀번호 찾기</b>
			      		</a>
			    	</li>			    					
				</c:if>
				<c:if test="${!empty login }">
					<!-- 로그인을 했을때 -->
					<li class="nav-item mt-2 mr-1">
						<b class="text-secondary">어서오세요 ${login.name }님</b>
						<img src="${login.photo }" class="rounded-circle mb-1" alt="회원 이미지" width="30px" height="30px">
						
					</li>		
    				<ul class="navbar-nav">
						<li class="nav-item">							
							<span class="badge badge-light" id="newMsgCnt" style="margin-top: 12px; height: 20px;">${login.newMsgCnt }</span>								      		
				    	</li>			
				  		<li class="nav-item">
				      		<a class="nav-link" href="/member/logout.do">
				      			<i class="fa fa-sign-out" style="font-size:19px"></i>
				      			<b>로그아웃</b>
				      		</a>
				    	</li>
				    	<li class="nav-item">
				      		<a class="nav-link" href="/member/view.do">
				      			<i class="fa fa-address-book"></i>
				      			<b>마이페이지</b>
				      		</a>
				    	</li>
				    	<li class="nav-item">
				      		<a class="nav-link" href="/cart/list.do">
				      			<i class="fa fa-shopping-basket"></i>
				      			<b>장바구니</b>
				      		</a>
				    	</li>	
			    	</ul>	
			    		    								
				</c:if>
		    </ul>
		    </div>			
		</nav>
	
	</header>
	<article>
		<!-- 여기에 개발자 작성한 body 태그 안에 내용이 들어온다. -->
		<decorator:body />
	</article>
	<footer class="container-fluid text-center">
		<p>이 홈페이지의 저작권은 이영환에게 있습니다.</p>
	</footer>
	
	
		<!-- msg를 표시할 모달 창 -->
		<!-- The Modal -->
	  	<div class="modal fade" id="msgModal">
	    	<div class="modal-dialog">
	      		<div class="modal-content">
	      
	        		<!-- Modal Header -->
	        		<div class="modal-header">
	          			<h4 class="modal-title">처리 결과</h4>
	          			<button type="button" class="close" data-dismiss="modal">&times;</button>
	        		</div>
	        
	        		<!-- Modal body -->
	        		<div class="modal-body">
	          			<span id="msg">${msg }</span>
	        		</div>
	        
	        		<!-- Modal footer -->
	        		<div class="modal-footer">
	          			<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	        		</div>
	        
	      		</div>
	    	</div>
	  	</div>
	  	<c:if test="${ !empty msg }">
			<!-- 모달을 보이게 하는 스크립트 -->
			<script type="text/javascript">
				$(function() {
					$("#msgModal").modal("show");
				});
			</script>
	</c:if>
</body>
</html>