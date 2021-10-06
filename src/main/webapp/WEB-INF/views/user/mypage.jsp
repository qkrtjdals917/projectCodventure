<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/mypage.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/bb29575d31.js"></script>
<script src="${pageContext.request.contextPath }/JS/mypage.js"></script>
</head>
<body>
<%@ include file = "../include/header.jsp" %> <%-- header --%>
	<div style="clear:both; height:70px"></div>
    <div class="contentA">
        <img src='' alt="메인이미지" /> 
    </div>

    <div class="contentB">
       	<table border="">
       		<tr>
       			<td>이메일</td>
       			<td>${member.email}</td>
       		</tr>
       		<tr>
       			<td>닉네임</td>
       			<td>${member.nickname}</td>
       		</tr>
       		<tr>
       			<td>전화번호</td>
       			<td>${member.phoneNumber}</td>
       		</tr>
       		<tr>
       			<td>작성 글 갯수</td>
       			<td>${member.memberBoardCnt}</td>
       		</tr>
       	</table>
    </div>
    <div class="contentC">
    	<button type="button" id="btnUpdate" class="btn">정보수정</button>
		<button type="button" id="btnPwChange" class="btn">비밀번호 변경</button>
		<button type="button" id="btnSecession" class="btn">회원 탈퇴</button>
    </div>
    <br>
    
    <div id="dlg_account" class="modal">
		<div class="modal-content">
			<div class="accountcontainer">
				<h3 class="title">마이페이지</h3>
				
				<span class="close" title="Close Modal">&times;</span>
				
				<form id="memChangeform" action="/update" name="memChangeform" method="post">
					<div class="btn_update">
						<label for="Pw"><b>닉네임</b></label>
						<input type="text" id="nickname" placeholder="${member.nickname}" name="nickname" required>
						<button type="button" id="nickname_check" class="btn">중복체크</button>
						<input type="hidden" id="nicknameDuplication" name="nicknameDuplication" value="nicknameUncheck"> 
						<br><b id="nicknameEx"></b>
						<br>
						<label for="phoneNumber"><b>전화번호</b></label>
						<input class="phoneNum" type="text" name="phonenum1" required> -
						<input class="phoneNum" type="text" name="phonenum2" required> - 
						<input class="phoneNum" type="text" name="phonenum3" required>
						<input type="hidden" name="phoneNumber" value="">
						<br>
	                    <button type="submit" class="btn">변경</button>
	                    
	                </div>
                </form>

				<form id="pwChangeform" action="/pwChange" name="pwChangeform" method="post">
					<div class="btn_pwChange">
						<label for="Pw"><b>현재 비밀번호</b></label>
						<input type="text" placeholder="현재 PW를 입력하세요" name="nowpw" required>
						<br>
						<label for="Pw"><b>변경 비밀번호</b></label>
						<input type="text" placeholder="바꿀 PW를 입력하세요" name="changepw" required>
						<br>
						<label for="Pw"><b>비밀번호 확인</b></label>
						<input type="text" placeholder="바꿀 PW를 다시 입력하세요" name="checkpw" required>
						<br>
						<button type="submit" class="btn">변경</button>
						<div class="clear"></div>
					</div>
				</form>
				
				<form id="memDeleteform" action="/deleteOk" name="memDeleteform" method="post">
					<div class="btn_secession">
						<b>정말로 탈퇴하십니까?</b><br>
						<b>탈퇴하시려면 아래 입력란에 회원탈퇴를 입력하세요.</b>
						<input type="text" name="checksecession" required>
			            <br>
	                    <button type="submit" class="btn">회원 탈퇴</button>
						<button type="submit" class="btn">취소</button>
	                    
	                </div>
                </form>
				
			</div>
		</div>
	</div>
	
<%@ include file = "../include/footer.jsp" %> <%-- footer --%>
</body>
</html>