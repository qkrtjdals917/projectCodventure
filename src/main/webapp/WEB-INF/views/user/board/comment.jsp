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
		getCommentList("${data.board_uid}");
	</script>
</c:forEach>



					
					
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
			<textarea style="width: 1100px" rows="3" cols="30" id="content" name="content" placeholder="댓글을 입력하세요"></textarea>
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
