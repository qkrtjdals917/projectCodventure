$(function () {
	
	// email 부분
	$("#email").change(function() {
		$("#emailDuplication").val("emailUncheck");
		$("#emailEx").text("중복체크를 해주세요");
	})
	
	$("#email_check").click(function(){
		frm = document.forms['joinform'];
		email = frm['email'].value;
		
		var Ereg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		
		if(email == "") {
			alert("이메일은 필수입니다.");
			frm['email'].focus();
			
			return false;
			
		} else if(Ereg.test(email) == false) {
			alert("이메일 형식이 올바르지 않습니다.");
			frm['email'].focus();
			
			return false;
		}
		checkEmailDuplication();
	});
	// nickname 부분
	$("#nickname").change(function () {
		$("#nicknameDuplication").val("emailUncheck");
		$("#nicknameEx").text("중복체크를 해주세요");
	})
		
	$("#nickname_check").click(function(){

		frm = document.forms['joinform'];
		nickname = frm['nickname'].value;
		
		var Nreg = /^[0-9a-zA-Z가-힣]+$/;
		
		if(nickname == "") {
			alert("닉네임은 필수입니다.");
			frm['nickname'].focus();
			
			return false;
			
		} else if(Nreg.test(nickname) == false) {
			alert("닉네임 형식이 올바르지 않습니다.(특수기호 불가)");
			frm['nickname'].focus();
			
			return false;
		}

		checkNicknameDuplication();
	});
	
	// 로그인 시 해당 페이지 url 저장하기위함
	$("#btnLogin").click(function(){
		
		$.ajax({
		url : "/logincheck/",
		type : "GET",
		cache : false
		});	
//<button type="button" id="email_check" class="btn">중복체크</button>
		Swal.fire({
			title: 'Login Form',
			html: `<input type="text" id="login" class="swal2-input" placeholder="Username">
			<input type="password" id="password" class="swal2-input" placeholder="Password">`,
			confirmButtonText: 'Sign in',
			showCloseButton: true,
			showCancelButton: true,
			cancelButtonText: 'join',
			focusConfirm: false,
			preConfirm: () => {
				const login = Swal.getPopup().querySelector('#login').value
				const password = Swal.getPopup().querySelector('#password').value
				if (!login || !password) {
					Swal.showValidationMessage(`Please enter login and password`)
					}
					return { login: login, password: password }
				}
			}).then((result) => {
				Swal.fire(`
				Login: ${result.value.login}
				Password: ${result.value.password}
				`.trim())
				})

		setPopup("login");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_login").show();
	});
	
	$(".headC").click(function(){
    	$(".headE").slideToggle();
	});
	
	$("#btnJoin").click(function(){
		Swal.fire({
			title: 'Join Form',
			html: `
			<form id="join_form">
			<label for="Email"><b>Email</b></label>
			<input type="text" id="email" class="swal2-input" placeholder="Email을 입력하세요" name="email" required>
			<button type="button" id="email_check" class="btn">중복체크</button>
			<input type="hidden" id="emailDuplication" name="emailDuplication" value="emailUncheck"> 
			<br><b id="emailEx"></b>
			<br>
			<label for="Pw"><b>PW</b></label>
			<input type="password" class="swal2-input" placeholder="PW를 입력하세요" name="pw" required>
			<br>
			<label for="PwC"><b>PW 확인</b></label>
			<input type="password" class="swal2-input" placeholder="PW를 다시 입력하세요" name="pwC" required>
			<br>
			<label for="Nickname"><b>닉네임</b></label>
			<input type="text" id="nickname" class="swal2-input" placeholder="닉네임를 입력하세요" name="nickname" required>
			<button type="button" id="nickname_check" class="btn">중복체크</button>
			<input type="hidden" id="nicknameDuplication" name="nicknameDuplication" value="nicknameUncheck"> 
			<br><b id="nicknameEx"></b>
			<br>
			<label for="phoneNumber"><b>전화번호</b></label>
			<input class="phoneNum swal2-input" type="text" name="phonenum1" required> - 
			<input class="phoneNum swal2-input" type="text" name="phonenum2" required> - 
			<input class="phoneNum swal2-input" type="text" name="phonenum3" required>
			<input type="hidden" name="phoneNumber" value="">
			</form>
			`,
			confirmButtonText: 'Sign in',
			showCloseButton: true,
			showCancelButton: true,
			cancelButtonText: 'join',
			focusConfirm: false,
			preConfirm: () => {
				const login = Swal.getPopup().querySelector('#login').value
				const password = Swal.getPopup().querySelector('#password').value
				if (!login || !password) {
					Swal.showValidationMessage(`Please enter login and password`)
					}
					return { login: login, password: password }
				}
			}).then((result) => {
				Swal.fire(`
				Login: ${result.value.login}
				Password: ${result.value.password}
				`.trim())
				})
				
				
		setPopup("join");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_login").show();
	});
	
	// 로그아웃 버튼
	
	$("#btnLogout").click (function(){
		alert("로그아웃되셨습니다.");

		$.ajax({
		url : "/logoutcheck",
		type : "GET",
		cache : false
		});
		
		location.href="/logout";
		
		
	});	
	
	
	
	// 모달 창 내 버튼 부분
	$("#btn_go_join").click(function(){
		setPopup("join");
	});
	
	$(".modal .close").click(function(){
		$(this).parents(".modal").hide();
	});
	
	// 모달 창 외부 클릭시 모달창 닫기
	$(".modal").click(function(e){
		var modal = $(".modal-content")
		if(modal.has(e.target).length === 0){
		   $(this).hide();
		}
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
}// end setPopup()

function chkJoin (){
	frm = document.forms['joinform'];
	// 비밀번호 확인
	pw = frm['pw'].value;
	pwC = frm['pwC'].value;
	
	if(pw != pwC) {
		alert("비밀번호가 같지 않습니다. 다시 확인해주세요");
		frm['pwC'].focus();
		
		return false;
		
	}
	
	// 전화번호 확인
	var result = "";
	result += frm['phonenum1'].value.trim() + "-";
	result += frm['phonenum2'].value.trim() + "-";
	result += frm['phonenum3'].value.trim();
	
	frm['phoneNumber'].value = result;

	var Preg =  /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	if(Preg.test(frm['phoneNumber'].value) == false) {
		alert("전화번호 형식이 올바르지 않습니다");
		frm['phoneNumber'].focus();
		
		return false;
	}
	
	alert("회원가입이 완료되었습니다.");
	return true;
 }


function checkEmailDuplication () {
	var email = $('#email').val();
	
	$.ajax({
		url : "/checkemail/" + email,
		type : "GET",
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data == 0) {
					$("#emailDuplication").val("emailCheck");
					$("#emailEx").text("사용 가능한 이메일입니다.");
				}
				else {
					$("#emailDuplication").val("emailUncheck");
					$("#emailEx").text("이미 존재하는 이메일입니다.");
				}
			}
			
		}
	});	
}

function checkNicknameDuplication () {
	var nickname = $('#nickname').val();

	$.ajax({
		url : "/checknickname/" + nickname,
		type : "GET",
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data == 0) {
					$("#nicknameDuplication").val("nicknameCheck");
					$("#nicknameEx").text("사용 가능한 닉네임입니다.");
				}
				else {
					$("#nicknameDuplication").val("nicknameUncheck");
					$("#nicknameEx").text("이미 존재하는 닉네임입니다.");
				}
			}
		}
	});	
}

function gourl(url) {
	location.href=url;
}