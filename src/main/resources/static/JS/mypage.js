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
			alert("닉네임은 필수입니다.");
			frm['nickname'].focus();
			
			return false;
			
		} else if(Nreg.test(nickname) == false) {
			alert("닉네임 형식이 올바르지 않습니다.(특수기호 불가)");
			frm['nickname'].focus();
			
			return false;
		}

		mpCheckNicknameDuplication();
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
		alert("전화번호 형식이 올바르지 않습니다");
		frm['phoneNumber'].focus();
		
		return false;
	}
	
	alert("정보변경이 완료되었습니다.");
	return true;
 }


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

