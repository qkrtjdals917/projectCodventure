function add_comment(uid){
	$.ajax({
        type:'POST',
        url : "/modacon/board/addComment/" + uid,
        data:$("#commentForm").serialize(),
        success : function(data){
            if(data=="success"){
                getCommentList(uid);
                $("#content").val("");
            }
			if(data=="fail") {
				alert("댓글 저장에 실패했습니다.");
			}
        },
        error:function(request,status,error){
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
        
    });
}
 
/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function () {


});
 
/**
 * 댓글 불러오기(Ajax)
 */

function getCommentList(uid){
    
    $.ajax({
        type:'GET',
        url : "/modacon/board/getComment/" + uid,
        cache : false,
        success : function(data){
            
            var html = "";
			var list = data.list;
            var count = data.count;

            if(count > 0){
                html += "<table class='table'><tr>";
                for(i=0; i<count; i++){
                    html += "<tr><td>" + list[i].nickname + "</td>";
                    html += "<td>" + list[i].content + "</td>";
                    html += "<td>" + list[i].regDateTime + "</td>";
                    //html += "<td><button id='update_comment_btn" + list.comment_uid + "'>수정</button></td>";

                    html += "<td><button onclick='delete_comment(" + list[i].comment_uid + ")' id='delete_comment_btn" + list[i].comment_uid + "'>삭제</button></td></tr>";

                }
                html += "</table>"
            } else {
                
                html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
                html += "</table></div>";
                
            }
            
            $("#cCnt").html(count);
            $("#commentList").html(html);
            
        },
        error:function(request,status,error){
            
       }
        
    });
}







