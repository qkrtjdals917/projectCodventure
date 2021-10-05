/**
 * 
 */

$(function () {
		
	// 모달창
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
	
	// 모달 창 외부 클릭시 모달창 닫기
	$(".modal").click(function(e){
		var modal = $(".modal-content")
		if(modal.has(e.target).length === 0){
		   $(this).hide();
		}
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