<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



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
				<a id="logobtn" class="headA" style="cursor: pointer">로고</a>

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
	
		<h2 id="admin_title"></h2>



		<div class="pageSet">
			<div class="pleft" id="pageinfo"></div>
			<div class="pright" id="pageRows"></div>
		</div>


		<div id="contentNotice">

			<form id="NoticeForm" name="NoticeForm" method="GET">
				<div id="NoticeContainer">
					<table>
						<thead>
							<th>글번호</th>
							<th>'log'제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>DELETE</th>
						</thead>
						<tbody>
						</tbody>
					</table>
					<br>

				</div>
			</form>

			<!-- <button onclick= "location.href = 'write.jsp'" >공지 등록</button> -->

			<div class="a01">
				<div class="ntcright">
					<button type="button" id="ntcWrite" class="ntc success">글작성</button>
				</div>
			</div>

			<!--  모달 위치 -->
		</div>

	<div id="contentBoard">
		
		<a href="#">정보</a> | <a href="#">자유</a> <select name="" id="">
			<option value="">전체</option>
			<option value="">코인정보</option>
			<option value="">뉴스</option>
			<option value="">팁과 노하우</option>
		</select> 
		<%-- 커뮤니티 목록 --%>
		<form id="CommunityForm" name="CommunityForm" method="GET">
			<div id="communityContainer">
				<table>
					<thead>
						<th>글번호</th>
						<th>'log'제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>DELETE</th>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</form>
	</div>






	<div id="contentReport">

	<form id="ReportForm" name="ReportForm" method="GET">
		<table>
			<thead>
				<th>글번호</th>
				<th>'log'제목</th>
				<th>작성글 uid</th>
				<th>신고자 uid</th>
				<th>신고취하</th>
				<th>DELETE</th>
			</thead>
			<tbody>
			</tbody>
		</table>
	</form>

	</div>



	<div id="contentMember">
	
		<!-- form -->
		<form id="searchMember" action=" " method=" ">
			<input tpye="text" placeholder="회원검색"></input>

		</form>
		<!-- end form -->
		
		<!-- table -->
		<form id="MemberForm" name="MemberForm" method="GET">
			<div id="memberContainer">
				<table>
					<thead>
						<tr>
							<th>uid</th>
							<th>이메일</th>
							<th>닉네임</th>
							<th>전화번호</th>
							<th>권한</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</form>
		<!--end table -->

		
	</div>
	
	<%-- [페이징] --%>
	<div class="center">
		<ul class="pagination" id="pagination"></ul>
	</div>
		
		
	<%-- 글 작성 / 보기 / 수정 대화상자 --%>
	<div id="noticeWrite" class="modal">
		<form class="modal-notice anitmate" id="noticeFrm" name="noticeFrm"
			method="post">
			<div class="container">
					<h3 class="title">공지 작성</h3>
					<span class="close" title="Close Modal">&times;</span>
					<%-- 닫기버튼 --%>
					<input type="hidden" name="uid" value="0">
					<%-- 읽기, 삭제, 수정을 위해 필요 --%>

				<div class="ntc_group_header">
					<div class="ntcLeft">
						<p id="viewcnt"></p>
					</div>
					<div class="ntcright">
						<p id="regdate"></p>
					</div>
					<div class="clear"></div>
				</div>

					<!-- type -->
					<!-- tag -->
					<label for="subject"><b>글제목</b></label> 
					<input type="text" placeholder="글제목(필수)" name="subject" required> 
					<label for="ntc_uid"><b>작성자</b></label> 
					<input type="text" placeholder="UID" name="member_uid" required> 
					<label for="content"><b>내용</b></label>
					<textarea placeholder="글내용" name="content"></textarea>

				<%-- 하단 버튼 : 글 작성 --%>
				<div class="ntc_group_write">
					<button type="submit" class="ntc write fullntc">공지 작성</button>
				</div>

				<%-- 하단 버튼 : 글 조회 --%>
				<div class="ntc_group_view">
					<div class="left">
						<button type="button" class="ntc danger" id="viewDelete">삭제</button>
					</div>
					<div class="right">
						<button type="button" class="ntc update" id="viewUpdate">수정</button>
					</div>
					<div class="clear"></div>
				</div>

				<%-- 하단 버튼 : 글 수정 --%>
				<div class="ntc_group_update">
					<div>
						<button type="button" class="ntc update fullbtn" id="updateOk">수정완료</button>
					</div>
					<div class="clear"></div>
				</div>


			</div>
		</form>
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