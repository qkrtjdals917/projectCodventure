<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>커뮤니티</title>

  <%-- 확인용 스타일. css 먹인 후 삭제 --%>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">

</head>

<body>
  <div>
    <header>
      헤더처리
    </header>

    <div id="middle_menu">
      <h2>커뮤니티</h2> <%-- 게시판에 따라 변경시켜야함 --%>
      > <a href="infoboard">정보</a> | <a href="freeboard">자유</a>
      <select name="" id="">
        <option value="">전체</option>
        <option value="">코인정보</option>
        <option value="">뉴스</option>
        <option value="">팁과 노하우</option>
      </select>
      <select name="" id="">
        <option value="">10</option>
        <option value="">15</option>
        <option value="">30</option>
        <option value="">50</option>
        <option value="">100</option>
      </select>

      <table>
        <tr>
          <th>글번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>추천수</th>
          <th>조회수</th>
        </tr>

<<<<<<< HEAD
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
			<h2>커뮤니티</h2>
			<a href="#">정보</a> | <a href="#">자유</a> 
			<select name="" id="">
				<option value="">전체</option>
				<option value="">코인정보</option>
				<option value="">뉴스</option>
				<option value="">팁과 노하우</option>
			</select> 
			<select name="" id="">
				<option value="">10</option>
				<option value="">15</option>
				<option value="">30</option>
				<option value="">50</option>
				<option value="">100</option>
			</select>

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
								<td>
									<!-- uid -->
								</td>
								<td>
									<!-- subject -->
								</td>
								<td>
									<!-- member -->
								</td>
								<td>
									<!-- regDate -->
								</td>
								<td>
									<!-- count? -->
								</td>
								<td>
									<!-- viewCnt? -->
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<br>
			<!-- <button onclick= "location.href = 'write.jsp'" >새글작성</button> -->
		</div>






	</div>
=======
        <c:choose>
          <c:when test="${empty list || fn:length(list) == 0 }">
          </c:when>
          <c:otherwise>
            <c:forEach var="dto" items="${list }">
              <tr>
                <td>${dto.board_uid }</td>
                <td><a href="board/view?uid=${dto.board_uid }">[${dto.tag }] ${dto.subject }</a></td>
                <td>${dto.nickname }</td>
                <td>${dto.regDateTime }</td>
                <td>${dto.likeCnt }</td>
                <td>${dto.count }</td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </table>
      <br>
      <button onclick= "location.href = 'board/write'" >새글작성</button>
    </div>
  </div>
>>>>>>> branch 'master' of https://github.com/qkrtjdals917/projectCodventure.git
</body>

</html>