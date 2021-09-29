<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="/joinOk" method="POST">
		<label for="Email"><b>Email</b></label>
		<input type="text" placeholder="Email을 입력하세요" name="email" required>
		<button type="submit" class="btn">중복체크</button>
		<br>
		<label for="Pw"><b>PW</b></label>
		<input type="text" placeholder="PW를 입력하세요" name="pw" required>
		<br>
		<label for="Pw"><b>PW 확인</b></label>
		<input type="text" placeholder="PW를 다시 입력하세요" name="pwC" required>
		<br>
		<label for="Pw"><b>닉네임</b></label>
		<input type="text" placeholder="닉네임를 입력하세요" name="nickname" required>
		<button type="submit" class="btn">중복체크</button>
		<br>
		<label for="Pw"><b>전화번호</b></label>
		<input class="phoneNumer" type="text" name="phonenum1" required> - 
		<input class="phoneNumer" type="text" name="phonenum2" required> - 
		<input class="phoneNumer" type="text" name="phonenum3" required>
		<br>
		<button type="submit" class="btn">가입</button>
		<div class="clear"></div>
	</form>
</body>
</html>