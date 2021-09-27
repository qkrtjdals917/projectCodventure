<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/test.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/001c1f3b98.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath }/JS/include.js"></script>
</head>
<body>
	<header>
        <div class="container">
            <div class="container-small"> <!-- 작은 화면의 배치를 위한 컨테이너-->
                <a href="index.html" class="headA">로고</a>
                
            	<!-- 내비게이션 메뉴 -->
	            <nav class="headB">
		            <ul>
		                <li><a href="index.html">코인시세</a></li>
		                <li><a href="contents.html">커뮤니티</a></li>
		                <li><a href="about.html">공지사항</a></li>
		            </ul>
		        </nav> 
		        
                <!-- 메뉴 토글 버튼 -->
                <div>
                    <button type="button" class="headC">
                        <span class="fa fa-bars" title="MENU"></span>
                    </button>

                    <div class ="headD">
                        <button type="button" id="btnJoin" class="btn danger">회원가입</button>
                        <button type="button" id="btnLogin" class="btn danger">로그인</button>
                    </div>
                </div>
            </div>



        </div>
    </header>
</body>
</html>