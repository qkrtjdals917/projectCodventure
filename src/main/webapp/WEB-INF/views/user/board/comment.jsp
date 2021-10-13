<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/JS/comment.js"></script>
</head>
<body>
<!--  댓글 갱신 -->
<c:forEach items="${list}" var="data">
	<script>
		board_uid = ${data.board_uid};
		//getCommentList("${data.board_uid}");
		
		
	</script>
</c:forEach>
<script>
	function delete_comment (comment_uid , member_uid) {
		
		if (${member_null}) {
			not_Login_msg();
		}
		
		Swal.fire({
			title: '댓글 삭제',
			text: "해당 댓글을 삭제하시겠습니까? 삭제 후 다시 복구 할 수 없습니다.",
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '삭제',
			cancelButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) {
					alert(comment_uid);
					alert(member_uid)
					alert("${member.member_uid}");
					
					if (member_uid == "${member.member_uid}") {
						$.ajax({
							url : "/modacon/board/deleteComment/" + comment_uid,
		            		type : "GET",
		            		async : false,
		            		cache : false,
		            		success : function(data, status){
		            			Swal.fire({
		            				title : '댓글 삭제',
		            				text : '해당 댓글이 삭제되었습니다.',
		            				icon : "success"
		            			}).then((result) => {
		         					location.reload();
		         					})
							}
						});
					} else {
						Swal.fire(
								'삭제 실패',
								'해당 댓글의 작성자가 아닙니다.',
								'error'
						)
					}
				}
			});
		}	// end delete_comment();


	
</script>


					
					
<div class="container">
    <form id="commentListForm" name="commentListForm" method="post">
    	<div>
    		<span><strong>Comments</strong></span> <span id="cCnt"></span>
		</div>
        <div id="commentList">

        </div>
        
    </form>
</div>

<div class="container">
    <form id="commentForm" name="commentForm" method="post">
        <div>
			<textarea style="width: 90%" padding="10px" rows="3" cols="30" id="content" name="content" placeholder="댓글을 입력하세요"></textarea>
			<br>
			<a href='' onClick="add_comment(${list[0].board_uid})" id="comment_btn">등록</a>
        </div>
        <!--  <input type="hidden" id="b_code" name="b_code" value="${result.code }" />    -->     
    </form>

        <c:choose>
			<c:when test="${list[0].member_uid == member.member_uid}">
				
				<button onclick='' id='delete_comment_btn" + list[i].comment_uid + "'>삭제</button>
			</c:when>
</c:choose>

</div>
 
</body>
</html>
