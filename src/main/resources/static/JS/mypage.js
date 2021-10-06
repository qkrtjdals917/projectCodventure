/**
 * 
 */

$(function () {
	// nickname 부분
	$(".btn_update #nickname").change(function () {
		$(".btn_update #nicknameDuplication").val("emailUncheck");
		$(".btn_update #nicknameEx").text("중복체크를 해주세요");
	})
	
	$(".btn_update #nickname_check").click(function(){

		frm = document.forms['memChangeform'];
		nickname = frm['nickname'].value;
		
		var Nreg = /^[0-9a-zA-Z가-힣]+$/;
		
		if(nickname == "") {
			Swal.fire({
			  icon: 'warning',
			  title: '닉네임은 필수입니다'
			})
			frm['nickname'].focus();
			
			return false;
			
		} else if(Nreg.test(nickname) == false) {
			Swal.fire({
			  icon: 'warning',
			  title: '형식과 맞지 않습니다.',
			  text: '특수기호 사용불가'
			})
			frm['nickname'].focus();
			
			return false;
		}

		mpCheckNicknameDuplication();
	});
	
	// 정보변경후 로그아웃
	$(".chAftLogout").click (function(){

		$.ajax({
		url : "/logoutcheck",
		type : "GET",
		cache : false
		});
		
		location.href="/logout";
		
		
	});	
		
	// 모달창
	$("#btnUpdate").click(function(){
		setMyPagePopup("update");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_account").show();
	});
	
	$("#btnPwChange").click(function(){
		setMyPagePopup("change");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_account").show();
	});
	
	$("#btnSecession").click(function(){
		setMyPagePopup("secession");    // 글 작성 용으로 모달 팝업 셋업
		$("#dlg_account").show();
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

function setMyPagePopup(mode){
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

function chkUpdate (){
	frm = document.forms['memChangeform'];
	
	// 전화번호 확인
	var result = "";
	result += frm['phonenum1'].value.trim() + "-";
	result += frm['phonenum2'].value.trim() + "-";
	result += frm['phonenum3'].value.trim();
	
	frm['phoneNumber'].value = result;
	
	var Preg =  /^\d{2,3}-\d{3,4}-\d{4}$/;
	
	if(Preg.test(frm['phoneNumber'].value) == false) {
		Swal.fire({
			  icon: 'warning',
			  title: '전화번호 형식과 맞지 않습니다.'
			})
		frm['phoneNumber'].focus();
		
		return false;
	}
	
	$.ajax({
		url : "/logoutcheck",
		type : "GET",
		cache : false
		});
		
	location.href="/logout";
	
	Swal.fire({
	  icon: 'success',
	  title: '정보변경이 완료되었습니다.',
	  text: '재로그인 해주세요!',
	})
	
		
	return true;
	
 }


/* 닉네임 중복확인 */
function mpCheckNicknameDuplication () {
	var nickname = $('.btn_update #nickname').val();

	$.ajax({
		url : "/checknickname/" + nickname,
		type : "GET",
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data == 0) {
					$(".btn_update #nicknameDuplication").val("nicknameCheck");
					$(".btn_update #nicknameEx").text("사용 가능한 닉네임입니다.");
				}
				else {
					$(".btn_update #nicknameDuplication").val("nicknameUncheck");
					$(".btn_update #nicknameEx").text("이미 존재하는 닉네임입니다.");
				}
			}
		}
	});	
}

/* password 확인*/
function chkPw(){
	/*
	$.ajax({
		url : "/checkpw/" + pw,
		type : "GET",
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data == 0) {
					$("#nicknameDuplication").val("nicknameCheck");
					$("#nicknameEx").text("사용 가능한 닉네임입니다.");
				}
			}
		}
	});	
	*/
	
	frm = document.forms['pwChangeform'];
	
	changepw = frm['changepw'].value;
	checkpw = frm['checkpw'].value;
	
	if(changepw != checkpw) {
		Swal.fire({
			  icon: 'warning',
			  title: '바뀔 비밀번호의 입력이 맞지 않습니다'
			})
		frm['checkpw'].focus();
		
		return false;
	}
	
	$.ajax({
		url : "/logoutcheck",
		type : "GET",
		cache : false
		});
		
	location.href="/logout";
	
	Swal.fire({
	  icon: 'success',
	  title: '비밀번호 변경이 완료되었습니다.',
	  text: '재로그인 해주세요!'
	})
	
	return true;
}

function chkDelete(){
	
	frm = document.forms['memDeleteform'];
	checksecession = frm['checksecession'].value;
	checkStr = "회원탈퇴";
	
	if(checksecession !== checkStr) {
		
		Swal.fire({
		  icon: 'error',
		  title: '형식과 맞지 않습니다.',
		  text: '띄어쓰기는 없습니다!'
		})
		
		return false;
	}
	
	$.ajax({
		url : "/logoutcheck",
		type : "GET",
		cache : false
		});
		
	location.href="/logout";
	
	Swal.fire({
	  icon: 'success',
	  title: '회원탈퇴가 완료되었습니다.',
	  text: '안녕히가세요!'
	})
	
	
	return true;
}










