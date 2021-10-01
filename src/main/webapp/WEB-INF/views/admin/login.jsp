<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 로그인</title>
</head>
<body>
	<div>
		<h1>관리자 로그인</h1>
		<form action="/loginOk" method="POST">
			ID<br>
			<input type="text" name="userid" placeholder="아이디 입력" /><br>
			PW<br>
			<input type="password" name="password" placeholder="패스워드 입력" /><br>
			<button onclick="">로그인</button>
		</form>
	</div>
</body>
</html>