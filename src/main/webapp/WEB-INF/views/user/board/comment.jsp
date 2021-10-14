<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
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
    var commenter = "${member.member_uid}";
  </script>



  <div class="comment">
    <div class="commentTitle">
      <form id="commentListForm" name="commentListForm" method="post">
        <div>
          <span><strong>Comments</strong></span> <span id="cCnt"></span>
        </div>
        <div id="commentList">

        </div>

      </form>
    </div>

    <div class="commentArea">
      <form id="commentForm" name="commentForm" method="post">
        <div>
          <textarea id="content" name="content" placeholder="댓글을 입력하세요"></textarea>
          <br>
          <button type="button" onClick="add_comment(${list[0].board_uid})" id="comment_btn">등록</button>
        </div>
        <!--  <input type="hidden" id="b_code" name="b_code" value="${result.code }" />    -->
        <div class="clearAll"></div>
      </form>

    </div>
  </div>

</body>

</html>