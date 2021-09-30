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

<style>
* {
	margin: 0;
}
.headZ {
	color: #fff;
    float: right;
}

.headZ button:hover {
	cursor: pointer;
	opacity: 0.3;
}
	
}
.headC {
	color: #fff;	
}

</style>

</head>

<body>
	<header>
        <div class="container">
            <div class="container-small"> <!-- 작은 화면의 배치를 위한 컨테이너-->
                <a href="/modacon" class="headA">로고</a>
                
            	<!-- 내비게이션 메뉴 -->
	            <nav class="headZ">
		            <button id="admNotice">공지사항</button>
		            <button id="admBoard">게시판관리</button>
		            <button id="admReport">신고접수</button>
		            <button id="admMember">회원관리</button>
		       </nav> 
		        
                <!-- 메뉴 토글 버튼 -->
                <div>
                    <button type="button" class="headC">
                        <span class="fa fa-bars" title="MENU"></span>
                    </button>

                    <div class ="headD">
                    	<button type="button" id="btnJoin" >로그아웃</button>
                    </div>
                </div>
            </div>
        </div>
		
    </header>
    
    
    
</body>
</html>