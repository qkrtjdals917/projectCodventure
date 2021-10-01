<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 메인페이지 23, 28, 24, 26, 32</title>
<style>
* {
	margin: 0;
	color: black;
	font-family: 'Do Hyeon', sans-serif;
	font-size: 25px;
}

.contentMain {
	
}

.contentNotice {
	height: 600px;
	position: relative;
	margin: 0 auto;
	boarder: gray solid 1px;
}

.contentBoard {
	height: 600px;
	position: relative;
	margin: 0 auto;
	boarder: gray solid 1px;
}

.contentReport {
	height: 600px;
	position: relative;
	margin: 0 auto;
	boarder: gray solid 1px;
}

.contentMember {
	height: 600px;
	position: relative;
	margin: 0 auto;
	boarder: gray solid 1px;
}

table {
	width: 100%;
}

table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>
</head>
<body>

	<%@ include file="../admin/admin_header.jsp"%>
	<%-- header --%>
	<div style="clear: both; height: 70px"></div>
	<div class="contentA">
		<img src='' alt="메인이미지" />
	</div>

	<div class="contentMain">
		<article>
			<div>
				<!-- 내용1 -->
			</div>
			<div>
				<!-- 내용2 -->
			</div>
			<div>
				<!-- 내용3 -->
			</div>
		</article>
	</div>

	<div id="adm_content" class="content">
		<div class="content_sample">

			<div class="contentNotice">
				<div id="middle_menu">
					<h2>커뮤니티</h2>
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
										<td>${dto.board_uid }</td>
										<td><a href="board/view?board_uid=${dto.board_uid}">${dto.subject}</td>
										<td>${dto.nickname }</td>
										<td>${dto.regDateTime }</td>
										<td><input type="button" id="delete_button" value="삭제"></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>
					<br>
					<!-- <button onclick= "location.href = 'write.jsp'" >공지 등록</button> -->

					<%-- [페이징] --%>
					<div class="center">
						<ul class="pagination" id="pagination"></ul>
					</div>
				</div>

			</div>

			<div class="contentBoard">
				<select name="" id="">
					<option value="">전체</option>
					<option value="">코인정보</option>
					<option value="">뉴스</option>
					<option value="">팁과 노하우</option>
				</select> <select name="" id="">
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

					<c:choose>
						<c:when test="#"></c:when>
						<c:otherwise>
							<c:forEach var="dto" items="#">
								<tr>
									<td>${dto.board_uid }</td>
									<td><a href="board/view?board_uid=${dto.board_uid}">${dto.subject}</td>
									<td>${dto.nickname }</td>
									<td>${dto.regDateTime }</td>
									<td><input type="button" id="delete_button" value="삭제"></td>
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

			<div class="contentReport">
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
									<td>${dto.board_uid }</td>
										<td><a href="board/view?board_uid=${dto.board_uid}">${dto.subject}</td>
										<td>${dto.nickname }</td>
										<td>${dto.nickname }</td>
										<td><input type="button" id="reportBack_button" value="신고취하"></td>
										<td><input type="button" id="delete_button" value="삭제"></td>
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

			<div class="contentMember">

				<h2>회원관리</h2>
				<!-- form -->
				<form action=" " method=" ">
					<input tpye="text" placeholder="회원검색"></input>

				</form>
				<!-- end form -->

				<!--selecter -->
				<select name=" ">
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
					<tr>
						<td>${dto.email }</td>
						<td>${dto.nickname }</td>
						<td>${dto.phoneNumber }</td>
						<td>${dto.authority }</td>
						<td><input type="button" id="exit" value="강퇴"></td></td>

					</tr>
				</table>
				<!--end table -->

				<%-- [페이징] --%>
				<div class="center">
					<ul class="pagination" id="pagination"></ul>
				</div>
			</div>
		</div>
	</div>

</body>
</html>