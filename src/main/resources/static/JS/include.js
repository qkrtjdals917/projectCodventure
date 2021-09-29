$(document).ready(function(){
		
		$("#btnLogin").click(function(){
			setPopup("login");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_login").show();
		});
		
		$("#btnJoin").click(function(){
			setPopup("join");    // 글 작성 용으로 모달 팝업 셋업
			$("#dlg_login").show();
		});
		
		$("#btn_go_join").click(function(){
			setPopup("join");
		});
		
		$("#email_check").click(function(){
			//TODO
		});
		
		$("#nickname_check").click(function(){
			//TODO
		});
		
		$(".modal .close").click(function(){
			$(this).parents(".modal").hide();
		});
		
		$(".headC").click(function(){
        	$(".headB").slideToggle();
    	});

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
	
	var result = "";
	result += frm['phonenum1'].value.trim() + "-";
	result += frm['phonenum2'].value.trim() + "-";
	result += frm['phonenum3'].value.trim();
	
	frm['phoneNumber'].value = result;

	return true;
 }
