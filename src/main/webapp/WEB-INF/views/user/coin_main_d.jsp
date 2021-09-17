<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>코인 메인페이지</title>
<style>
table {width: 100%;}
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>

</head>
<body>
	<div>
		<header>
			<!-- 로그인  -->
			<div>
				<a href="#">회원가입</a> | 
				<a href="#">로그인</a>
			</div>
			<div>
				<div>여긴 사이트 로고자리</div>
				<div>모다콘(사이트 이름)</div>
			</div>
			<nav>
				<table>
					<tr>
						<td>코인</td>
						<td>커뮤니티</td>
						<td>공지</td>
					</tr>
				</table>
			</nav>
		</header>
		<article>
			<form>
				<input type="text" name="coin" placeholder="원하는 코인은?"/>
			</form>
			<table>
				<tr>
					<td>----</td>
					<td>거래소1</td>
					<td>거래소2</td>
					<td>거래소3</td>
					<td>거래소4</td>
					<td>거래소5</td>
				</tr>
				
				<c:choose>
					<c:when test="" />
				</c:choose>
				<c:otherwise>
					<c:forEach var="dto" item="">
						<tr>
							<td><!-- 거래값 --></td>
							<td><!-- 거래값 --></td>
							<td><!-- 거래값 --></td>
							<td><!-- 거래값 --></td>
							<td><!-- 거래값 --></td>
							<td><!-- 거래값 --></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</table>
			
			<div>그래프</div>
		</article>
	</div>
</body>
</html>