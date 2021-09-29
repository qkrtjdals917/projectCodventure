/**
 * 
 */

$(function(){
    $(".headC").click(function(){
        $(".headB").slideToggle();
    });
});

$(function(){
    $("#btnLogin").click(function(){
        window.location.href = "/login";
    });
});

$(function(){
    $("#btnJoin").click(function(){
        window.location.href = "/join";
    });
});

function chkJoin (){
	frm = document.forms['joinform'];
	
	var result = "";
	result += frm['phonenum1'].value.trim() + "-";
	result += frm['phonenum2'].value.trim() + "-";
	result += frm['phonenum3'].value.trim();
	
	frm['phoneNumber'].value = result;

	return true;
 }
