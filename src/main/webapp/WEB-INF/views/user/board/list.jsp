<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
	<meta charset="UTF-8">
	<title>커뮤니티</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<%-- 확인용 스타일. css 먹인 후 삭제 --%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
	<script src="${pageContext.request.contextPath }/JS/BoardScript/list.js"></script>
</head>

<body>
	<div>
		<div class="header">
		    <%@ include file="../../include/header.jsp"%>
		</div>
		<div style="clear:both; height:70px"></div>
	
		<div id="middle_menu">
		  <h2>커뮤니티</h2> <%-- 게시판에 따라 변경시켜야함 --%>
		<div class="selectMenu">
		<select id="board_type" name="type" onchange="type_toggle()">
			<option id="all_type" value="전체" selected>전체게시판</option>
			<option id="infoBoard_type" value="정보">정보게시판</option>
			<option id="freeBoard_type" value="자유">자유게시판</option>
		</select>
	
		<select id="board_tag" name="tag">
			<option class="tag_default_sel" value="" selected>전체</option>
			<option class="info_sel" value="코인">코인</option>
			<option class="info_sel" value="뉴스">뉴스</option>
			<option class="info_sel" value="팁과노하우">팁과노하우</option>
			<option class="free_sel" value="유머">유머</option>
			<option class="free_sel" value="잡담">잡담</option>
			<option class="free_sel" value="질문">질문</option>
		</select>
		</div>
		<div class="clearAll"></div>
		<table>
			<thead>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>추천수</th>
				<th>조회수</th>
			</thead>
		
			<tbody id="tbody">
			</tbody>
		
		</table>
		<br>
		<button onclick="location.href = 'board/write'">새글작성</button>
		</div>
		<div class="footer">
			<%@ include file="../../include/footer.jsp"%>
		</div>
	</div>
</body>

</html>