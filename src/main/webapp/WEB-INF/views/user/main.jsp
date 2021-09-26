<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>main</title>
<style>
* {
    margin: 0;
    color: #fff;
    font-family: 'Do Hyeon', sans-serif;
    font-size: 25px;
}

.contentA {
    height : 600px;  
    position: relative;
    margin : 0 auto;
    border: gray solid 1px;
}
.contentB {
    position: relative;
    margin : 0 auto;
    left: 50%;
}
.contentC {
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

.modal .logincontainer {
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
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
	$(document).ready(function(){
		
		$("#btnLogin").click(function(){
			setPopup("login");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_login").show();
		});
		
		$("#btnJoin").click(function(){
			setPopup("join");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_login").show();
		});
		
		$(".modal .close").click(function(){
			$(this).parents(".modal").hide();
		});
		
		
	});
	function setPopup(mode){
		
		if(mode == "login"){
			$("#dlg_login .title").text("로그인");
			$("#dlg_login .btn_login").show();
			$("#dlg_login .btn_join").hide();
		}
		
		if(mode == "join"){

			$("#dlg_login .title").text("회원가입");
			$("#dlg_login .btn_login").hide();
			$("#dlg_login .btn_join").show();
		}
	} // end setPopup()
</script>
</head>
<body>
<%@ include file = "../include/header.jsp" %> <%-- header --%>
    <div class="contentA">
        <img src='' alt="메인이미지" /> 
    </div>

    <div class="contentB">
       	<table border="">
       		<tr>
       			<td>거래소명</td>
       			<td>코인시세</td>
       		</tr>
       		<tr>
       			<td>평균거래가</td>
       			<td>10000 (0)</td>
       		</tr>
       		<tr>
       			<td>거래소1</td>
       			<td>9000 (-1000)</td>
       		</tr>
       		<tr>
       			<td>거래소2</td>
       			<td>11000 (+1000)</td>
       		</tr>
       	</table>
    </div>
    <br>
    <div class="contentC">
       	<table border="">
       		<tr>
       			<td>최근공지</td>
       		</tr>
       		<tr>
       			<td>공지1</td>
                <td>내용 ~~~~~~~~~</td>
       		</tr>
       		<tr>
       			<td>공지2</td>
                <td>내용 ~~~~~~~~~</td>
       		</tr>
       		<tr>
       			<td>공지3</td>
                <td>내용 ~~~~~~~~~</td>
       		</tr>
       	</table>
    </div>
    <div id="dlg_login" class="modal">
		<form class="modal-content animate" id="frmLogin" name="frmLogin" method="post">
			<div class="logincontainer">
				<h3 class="title">로그인</h3>
				
				<span class="close" title="Close Modal">&times;</span>
				
				<div class="btn_login">
					<label for="Email"><b>Email</b></label>
					<input type="text" placeholder="Email을 입력하세요" name="email" required>
		            <br>
					<label for="Pw"><b>PW</b></label>
					<input type="text" placeholder="PW를 입력하세요" name="pw" required>
					<br>
                    <button type="submit" class="btn">로그인</button>
					<button type="submit" class="btn">회원가입</button>
                    
                </div>

				<div class="btn_join">
					<label for="Email"><b>Email</b></label>
					<input type="text" placeholder="Email을 입력하세요" name="email" required>
					<button type="submit" class="btn">중복체크</button>
					<br>
					<label for="Pw"><b>PW</b></label>
					<input type="text" placeholder="PW를 입력하세요" name="pw" required>
					<br>
					<label for="Pw"><b>PW 확인</b></label>
					<input type="text" placeholder="PW를 다시 입력하세요" name="pw" required>
					<br>
					<label for="Pw"><b>닉네임</b></label>
					<input type="text" placeholder="닉네임를 입력하세요" name="nickname" required>
					<button type="submit" class="btn">중복체크</button>
					<br>
					<label for="Pw"><b>전화번호</b></label>
					<input class="phoneNum" type="text" name="phonenum1" required> - 
					<input class="phoneNum" type="text" name="phonenum2" required> - 
					<input class="phoneNum" type="text" name="phonenum3" required>
					<br>
					<button type="submit" class="btn">가입</button>
					<div class="clear"></div>
				</div>
			</div>
		</form>
	</div>

<%@ include file = "../include/footer.jsp" %> <%-- footer --%>
</body>
</html>