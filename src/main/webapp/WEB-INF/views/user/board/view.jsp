<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:choose>
  <c:when test="${empty list || fn:length(list) == 0 }">
    <%-- 삭제여부 확인 --%>
    <script>
      alert("해당 정보가 삭제되거나 없습니다");
      history.back();
    </script>
  </c:when>

  <c:otherwise>

    <!DOCTYPE html> <%-- html 시작 --%>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <title>커뮤니티</title>

      <%-- 확인용 스타일. css 먹인 후 삭제 --%>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
    </head>

    <body>
      <div class="header">
        <header>
          헤더처리
        </header>
      </div>

      <hr>

      <div class="content_btn"> <%-- 상단 버튼 모음 --%>
        <button id="back_btn" onclick="history.back()">돌아가기</button>
        <button id="update_btn" onclick="">수정</button>
        <button id="del_btn" onclick="">삭제</button>
      </div>

      <h2 id="boardname">${list[0].type }게시판</h2> <%-- 게시판 이름 기재. 접속한 게시판 별로 이름이 변하게 처리해줘야함 --%>
      <hr>

      <div class="read_contents"> <%-- 본문 --%>
        <h3 id="content_name">글 제목 : ${list[0].subject }</h3>
        <table> <%-- 현재 테이블로 처리를 했지만 ul-li와 css적용해서 바꿀예정 --%>
          <tr>
            <th id="nickname">닉네임 : ${list[0].nickname }</th>
            <th id="likeCnt">추천수 : ${list[0].likeCnt }</th>
            <th id="contentInc">조회수 : ${list[0].count }</th>
            <th id="regDateTime">작성일 : ${list[0].regDateTime }</th>
          </tr>
        </table>
        <hr>
        <div id="content">
          ${list[0].content }
        </div>
      </div>

      <div class="content_btn"> <%-- 하단 버튼 모음 --%>
        <button id="like_btn">추천</button>
        <button id="comment_btn">댓글</button> <%-- 댓글 버튼 누르면 밑의 comment_area가 뜨도록 처리 --%>
        <button id="update_btn">수정</button>
        <button id="del_btn">삭제</button>
      </div>
      <hr>

      <div id="comment_area"> <%-- 댓글부분 --%>
        <span id="commenter">댓글작성자</span>
        <span id="comment_text">댓글내용</span>
        <button id="comment_del">삭제</button>
        <div id="pagenation_div"> <%-- 댓글란 페이징 처리 부분 --%>
          <ul class="pagenation" id="pagenation">1</ul>
        </div>
        <input id="comment_text" /><button>작성</button> <%-- 댓글 작성란 --%>
      </div>
    </body>

    </html>

  </c:otherwise>
</c:choose>