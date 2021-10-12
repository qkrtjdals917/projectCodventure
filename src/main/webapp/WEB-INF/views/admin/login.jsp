<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 로그인</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/admin_login.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<script src="https://kit.fontawesome.com/001c1f3b98.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<div id="wrap">
		<h1>MODACON</h1>
		<h2>관리자</h2>
		<form id="adlogin" action="/modaconAdmin/loginOk" name="adlogin" method="POST">
			ID<br>
			<input type="text" name="email" placeholder="아이디 입력" /><br>
			PW<br>
			<input type="password" name="pw" placeholder="패스워드 입력" /><br>
			<button>로그인</button>
		</form>
	</div>
</body>
</html>