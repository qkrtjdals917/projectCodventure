<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 메인페이지 23, 28, 24, 26, 32</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/CSS/test.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">

<script src="https://kit.fontawesome.com/001c1f3b98.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/CSS/admin.css">
<script src="${pageContext.request.contextPath }/JS/admin.js"></script>

</head>

<body>
	<header>
		<div class="container">
			<div class="container-small">
				<!-- 작은 화면의 배치를 위한 컨테이너-->
				<a id="logobtn" class="headA" style="cursor:pointer">로고</a>

				<!-- 내비게이션 메뉴 -->
				<nav class="headB">
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

					<div class="headD">
						<button type="button" id="btnJoin">로그아웃</button>
					</div>
				</div>
			</div>
		</div>

	</header>

	
	<div id="contentMain">
		<article>
			<div>
				내용1
				<!-- 내용1 -->
			</div>
			<div>
				내용2
				<!-- 내용2 -->
			</div>
			<div>
				내용3
				<!-- 내용3 -->
			</div>
		</article>
	</div>

	<div id="adm_content">

		<div id="contentNotice">
			<h2>공지사항</h2>
			<select name="" id="">
				<option value="">10</option>
				<option value="">15</option>
				<option value="">30</option>
				<option value="">50</option>
				<option value="">100</option>
			</select>
			<form id="NoticeForm" name="NoticeForm" method="GET">
				<div id="NoticeContainer">
					<table>
						<tr>
							<th>#</th>
							<th>글번호</th>
							<th>'log'제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>DELETE</th>
						</tr>
						<tbody>
						</tbody>
					</table>
					<br>
	
				</div>
			</form>
			<!-- <button onclick= "location.href = 'write.jsp'" >공지 등록</button> -->
			<%-- [페이징] --%>
			<div class="center">
				<ul class="pagination" id="pagination"></ul>
			</div>

		</div>

		<div id="contentBoard">
	
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
					<th>DELETE</th>
				</tr>
			</table>

			<%-- [페이징] --%>
			<div class="center">
				<ul class="pagination" id="pagination"></ul>
			</div>
		</div>

		<div id="contentReport">
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
					<th>신고자</th>
					<th>신고취하</th>
					<th>DELETE</th>
				</tr>

				<c:choose>
					<c:when test="#"></c:when>
					<c:otherwise>
						<c:forEach var="dto" items="#">
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td><input type="button" id="reportBack_button"
									value="신고취하"></td>
								<td><input type="button" class="delete_button" value="삭제"></td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>

			<%-- [페이징] --%>
			<div class="center">
				<ul class="pagination" id="pagination"></ul>
			</div>
		</div>

		<div id="contentMember">

			<h2>회원관리</h2>

			<!-- form -->
			<form id="searchMember" action=" " method=" ">
				<input tpye="text" placeholder="회원검색"></input>

			</form>
			<!-- end form -->

			<!--selecter -->
			<select id="selectPage">
				<option value=" ">10</option>
				<option value=" ">15</option>
				<option value=" ">30</option>
				<option value=" ">50</option>
				<option value=" ">100</option>
			</select>
			<!-- end selecter -->


			<!-- table -->
			<table>
				<tr>
					<th>이메일</th>
					<th>닉네임</th>
					<th>전화번호</th>
					<th>권한</th>
					<th>상태</th>
				</tr>

			</table>
			<!--end table -->

			<%-- [페이징] --%>
			<div class="center">
				<ul class="pagination" id="pagination"></ul>
			</div>
		</div>

	</div>
	
	<c:choose>
		<c:when test="${not empty admPrevPage}">
			<script>
				viewPage("${admPrevPage}");
				
			</script>
		</c:when>
	</c:choose>


	<footer>
		<div class="container">
			<!-- 푸터A : 사이트 정보 -->
			<div class="footA">
				<h2>LOGO</h2>
				<p>TEAM: Codeventure</p>
				<p>권혁찬, 박성민, 박해연,</p>
				<p>이상빈, 정은수</p>
			</div>

			<!-- 푸터B : 푸터 메뉴 -->
			<nav class="footB">
				<div>
					<ul>
						<li><a href="/modacon">HOME</a></li>
						<li><a href="/modacon/coin">코인시세</a></li>
						<li><a href="/modacon/board">커뮤니티</a></li>
						<li><a href="/modacon/notice">공지사항</a></li>
					</ul>
				</div>
			</nav>
			<!-- 푸터C : 저작권-->
			<div class="footC">© MODACON corp. All rights reserved.</div>
		</div>
	</footer>
</body>
</html>