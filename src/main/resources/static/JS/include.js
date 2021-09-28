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