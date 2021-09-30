<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<div>
		<h1>로그인</h1>
		<form action="/loginOk" method="POST">
			Email<br>
			<input type="text" placeholder="Email을 입력하세요" name="email" required><br>
			PW<br>
			<input type="password" placeholder="PW를 입력하세요" name="password" required><br>
			<button onclick="">로그인</button>
		</form>
	</div>
</body>
</html>