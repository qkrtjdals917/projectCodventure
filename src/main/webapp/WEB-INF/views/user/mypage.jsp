<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

body {
    margin: 0;
}

.contentA {
    position: relative;
    margin : 0 auto;
    left: 50%;
}
.contentA td{
	color: #100E34;
}
.contentB {
    position: relative;
    margin : 0 auto;
    left: 50%;
}


/* 모달 팝업 */
/* 참조: https://www.w3schools.com/howto/howto_css_login_form.asp */
.modal {  /* 모달 전체 적용 */
	background-color: rgba(0, 0, 0, 0.4);
	position: fixed;
	top: 0;
	left: 0;
	
	width: 100%;
	height: 100%;
	
	z-index: 1;
	padding-top: 40px;
	overflow: auto;
	
	display: none; /* 기본적으로 안보이기 */
	
}

.modal .modal-content {
	background-color: #fefefe;
	width: 80%;   
	margin: 5% auto 15% auto;
	border: 1px solid #888;
}

.modal .accountcontainer {
	padding: 16px;
	position: relative;  /* 아래 있는 요소들 absolute로 동작시키기 위해 */
}

.modal .close { /* 닫기(x) 버튼 */
	font-size: 35px;
	font-weight: bold;
	color: #000;
	position: absolute;
	right: 25px;
	top: 0px;
}

.modal .close:hover,
.modal .close:focus {
	color: red;
	cursor: pointer;
}

.modal input[type=text]{
	width: 70%;
	border: 1px solid #ccc;
	margin: 8px 0;
	padding: 12px 20px;
	display: inline-block;
	box-sizing: border-box;
}
.modal input[type=text].phoneNum {
	width: 20%;
}
.modal textarea {
	width: 100%;
	border: 1px solid #ccc;
}

.modal .fullbtn {
	width: 100%;
	cursor: pointer;
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/bb29575d31.js"></script>
<script>
	$(document).ready(function(){
		
		$("#btnUpdate").click(function(){
			setPopup("update");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_account").show();
		});
		
		$("#btnPwChange").click(function(){
			setPopup("change");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_account").show();
		});
		
		$("#btnSecession").click(function(){
			setPopup("secession");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_account").show();
		});
		
		$(".modal .close").click(function(){
			$(this).parents(".modal").hide();
		});
		
		
	});
	function setPopup(mode){
		
		if(mode == "update"){
			$("#dlg_account .title").text("회원정보수정");
			$("#dlg_account .btn_update").show();
			$("#dlg_account .btn_pwChange").hide();
			$("#dlg_account .btn_secession").hide();
		}
		
		if(mode == "change"){

			$("#dlg_account .title").text("비밀번호변경");
			$("#dlg_account .btn_update").hide();
			$("#dlg_account .btn_pwChange").show();
			$("#dlg_account .btn_secession").hide();
		}
		
		if(mode == "secession"){

			$("#dlg_account .title").text("회원탈퇴");
			$("#dlg_account .btn_update").hide();
			$("#dlg_account .btn_pwChange").hide();
			$("#dlg_account .btn_secession").show();
		}
	} // end setPopup()
</script>
</head>
<body>
<%@ include file = "../include/header.jsp" %> <%-- header --%>
	<div style="clear:both; height:70px"></div>
    <div class="contentA">
        <img src='' alt="메인이미지" /> 
    </div>

    <div class="contentA">
       	<table border="">
       		<tr>
       			<td>이메일</td>
       			<td>test@email.com</td>
       		</tr>
       		<tr>
       			<td>닉네임</td>
       			<td>TESTER (0)</td>
       		</tr>
       		<tr>
       			<td>전화번호</td>
       			<td>010-1111-1111</td>
       		</tr>
       		<tr>
       			<td>작성 글 갯수</td>
       			<td>0</td>
       		</tr>
       	</table>
    </div>
    <div class="contentB">
    	<button type="button" id="btnUpdate" class="btn">정보수정</button>
		<button type="button" id="btnPwChange" class="btn">비밀번호 변경</button>
		<button type="button" id="btnSecession" class="btn">회원 탈퇴</button>
    </div>
    <br>
    
    <div id="dlg_account" class="modal">
		<form class="modal-content animate" id="frmLogin" name="frmLogin" method="post">
			<div class="accountcontainer">
				<h3 class="title">로그인</h3>
				
				<span class="close" title="Close Modal">&times;</span>
				
				<div class="btn_update">
					<label for="Email"><b>이메일</b></label>
					<input type="text" placeholder="Test@email.com" name="email" required>
		            <br>
					<label for="Pw"><b>닉네임</b></label>
					<input type="text" placeholder="닉네임을 입력하세요" name="nickname" required>
					<button type="submit" class="btn">중복체크</button>
					<br>
					<label for="Email"><b>이메일</b></label>
					<input class="phoneNum" type="text" name="phonenum1" required> -
					<input class="phoneNum" type="text" name="phonenum2" required> - 
					<input class="phoneNum" type="text" name="phonenum3" required>
					<br>
                    <button type="submit" class="btn">변경</button>
                    
                </div>

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
				
				<div class="btn_secession">
					<b>정말로 탈퇴하십니까?</b><br>
					<b>탈퇴하시려면 아래 입력란에 회원탈퇴를 입력하세요.</b>
					<input type="text" name="checksecession" required>
		            <br>
                    <button type="submit" class="btn">회원 탈퇴</button>
					<button type="submit" class="btn">취소</button>
                    
                </div>
				
			</div>
		</form>
	</div>
	
<%@ include file = "../include/footer.jsp" %> <%-- footer --%>
</body>
</html>