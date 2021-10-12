<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/include.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<script src="https://kit.fontawesome.com/001c1f3b98.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script src="${pageContext.request.contextPath }/JS/include.js"></script>
</head>
<body>
	<header>
        <div class="container">
            <div class="container-small"> <!-- 작은 화면의 배치를 위한 컨테이너-->
                <a href="/modacon" class="headA">로고</a>
                
            	<!-- 작은 창 내비게이션 메뉴 -->
	            <nav class="headB">
		            <ul>
		                <li><a href="/modacon/coin">코인시세</a></li>
		                <li><a href="/modacon/board">커뮤니티</a></li>
		                <li><a href="/modacon/notice">공지사항</a></li>
		            </ul>
		        </nav> 
		        
                <!-- 메뉴 토글 버튼 -->
                <div>
                    <button type="button" class="headC">
                        <span class="fa fa-bars" title="MENU"></span>
                    </button>

                    <div class ="headD">
                    	<c:choose>
                    		<c:when test="${empty member}">
		                        <button type="button" id="btnJoin" >회원가입</button>
		                        <button type="button" id="btnLogin">로그인</button>
                    		</c:when>
                    		<c:otherwise>
                    			<button type="button" id="btnMypage" 
                    			onClick="location.href='/modacon/mypage'">마이페이지</button>
                    			<button type="button" id="btnLogout">로그아웃</button>
                    		</c:otherwise>
                    	</c:choose>
                    	<!-- 
                    	<button type="button" id="btnJoin" >회원가입</button>
                    	<button type="button" id="btnLogin">로그인</button>
                    	 -->
                    	 
                    </div>
                </div>
            </div>

			<!-- 큰 창 내비게이션 메뉴 -->
			<nav class="headE">
				<ul>
					<li><a href="/modacon/coin">코인시세</a></li>
					<li><a href="/modacon/board">커뮤니티</a></li>
					<li><a href="/modacon/notice">공지사항</a></li>
				</ul>
			</nav>
        </div>
        
        <div id="dlg_login" class="modal">
        	<div class="modal-content">
        		<div class="logincontainer">
					<h3 class="title">로그인</h3>
				
					<span class="close" title="Close Modal">&times;</span>
					
					<form id="loginform" action="/modacon/loginOk" name="loginform" method="post">
						<div class="btn_login">
							<label for="Email"><b>Email</b></label>
							<input type="text" placeholder="Email을 입력하세요" name="email" required>
				            <br>
							<label for="Pw"><b>PW</b></label>
							<input type="password" placeholder="PW를 입력하세요" name="pw" required>
							<br>
							<p>${requestScope.loginFailMsg}</p>
		                    <button type="submit" class="btn">로그인</button>
							<button type="button" id="btn_go_join" class="btn">회원가입</button>
		                </div>
	                </form>
	                
					<form id="joinform" action="/joinOk" name="joinform" method="post">
						<div class="btn_join">
							<label for="Email"><b>Email</b></label>
							<input type="text" id="email" placeholder="Email을 입력하세요" name="email" required>
							<button type="button" id="email_check" class="btn">중복체크</button>
							<input type="hidden" id="emailDuplication" name="emailDuplication" value="emailUncheck"> 
							<br><b id="emailEx"></b>
							<br>
							<label for="Pw"><b>PW</b></label>
							<input type="password" placeholder="PW를 입력하세요" name="pw" required>
							<br>
							<label for="PwC"><b>PW 확인</b></label>
							<input type="password" placeholder="PW를 다시 입력하세요" name="pwC" required>
							<br>
							<label for="Nickname"><b>닉네임</b></label>
							<input type="text" id="nickname" placeholder="닉네임를 입력하세요" name="nickname" required>
							<button type="button" id="nickname_check" class="btn">중복체크</button>
							<input type="hidden" id="nicknameDuplication" name="nicknameDuplication" value="nicknameUncheck"> 
							<br><b id="nicknameEx"></b>
							<br>
							<label for="phoneNumber"><b>전화번호</b></label>
							<input class="phoneNum" type="text" name="phonenum1" required> - 
							<input class="phoneNum" type="text" name="phonenum2" required> - 
							<input class="phoneNum" type="text" name="phonenum3" required>
							<input type="hidden" name="phoneNumber" value="">
							<br>
							<button type="button" class="btn" onclick="chkJoin()">가입</button>
							<div class="clear"></div>
						</div>
					</form>
					
				</div>
        	</div>
		</div>
		
    </header>
    
</body>
</html>