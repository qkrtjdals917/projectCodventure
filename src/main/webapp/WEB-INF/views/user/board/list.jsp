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
                <a href="mypage.jsp">마이페이지</a> | <a href="#">로그아웃</a>
            </div>

            <div class="clear"></div>

            <div id="logo">
                <img src="#" width="265" height="62" alt="모다콘">
            </div>
            
        	<nav id="top_menu">
                <!-- 네비게이션 들어가는 곳-->
                <ul>
                    <li><a href="#">코인</a></li>
                    <li><a href="#">커뮤니티</a></li>
                    <li><a href="#">공지</a></li>
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
				<th>추천수</th>
				<th>조회수</th>
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
						<td><!-- count? --></td>
						<td><!-- viewCnt? --></td>
					</tr>
				</c:forEach>
			</c:otherwise>
			</c:choose>			
		</table>
			<br>
			<!-- <button onclick= "location.href = 'write.jsp'" >새글작성</button> -->
        </div>
		
		
		
		
		
		
	</div>
</body>
</html>