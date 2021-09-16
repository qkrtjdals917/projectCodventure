<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<div>
		 <header>
            <!--마이페이지, 로그아웃-->
            <div id="login">
                <a href="#">로그아웃</a>
            </div>

            <div class="clear"></div>

            <div id="logo">
                <img src="#" width="265" height="62" alt="모다콘">
            </div>
            
        	<nav id="top_menu">
                <!-- 네비게이션 들어가는 곳-->
                <ul>
                    <li><a href="#">공지사항</a></li>
                    <li><a href="#">게시판관리</a></li>
                    <li><a href="#">신고접수</a></li>
                    <li><a href="#">회원관리</a></li>
                </ul>
            </nav>
        </header>
        
        <div id="middle_menu">
        	<h2>커뮤니티</h2>>
        	<a href="#">정보</a> | <a href="#">자유</a>
        	
        	<table>
			<tr>
				<th>글번호</th>
				<th>'log'제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>DELETE</th>
			</tr>
			
			<c:choose>
				<c:when test="#"></c:when>
			<c:otherwise>
				<c:forEach var="dto" items="#">
					<tr>
						<td><!-- uid --></td>
						<td><!-- subject --></td>
						<td><!-- member --></td>
						<td><!-- regDate --></td>
						<td><!-- button? --></td>
					</tr>
				</c:forEach>
			</c:otherwise>
			</c:choose>			
		</table>
			<br>
			<!-- <button onclick= "location.href = 'write.jsp'" >공지 등록</button> -->
        </div>
		
		
		
		
		
		
	</div>
</body>
</html>