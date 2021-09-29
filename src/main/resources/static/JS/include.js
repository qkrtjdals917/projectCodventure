
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
		
		$(".headC").click(function(){
        	$(".headB").slideToggle();
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
	
	
	