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
	})
	
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
	
	
	// 메뉴 버튼 부분
	$("#btnLogin").click(function(){
		setPopup("login");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_login").show();
	});
	
	$(".headC").click(function(){
    	$(".headB").slideToggle();
	});
	
	$("#btnJoin").click(function(){
		setPopup("join");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_login").show();
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
