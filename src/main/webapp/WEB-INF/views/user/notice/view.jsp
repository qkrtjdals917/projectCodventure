<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
      <title>공지사항</title>

      <%-- 확인용 스타일. css 먹인 후 삭제 --%>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
    </head>

    <body>
      <div class="header">
        <p>헤더 들어갈 부분</p>
      </div>

      <hr>

      <div class="content_btn"> <%-- 상단 버튼 모음 --%>
        <button id="back_btn" onclick="history.back();">돌아가기</button>
      </div>

      <h2 id="boardname">공지사항</h2>
      <hr>

      <div class="read_contents">
        <h3 id="content_name"> 글 제목 : ${list[0].subject }</h3>
        <table>
          <tr>
            <th id="nickname">닉네임 : ${list[0].nickname }</th>
            <th id="contentInc">조회수 : ${list[0].count }</th>
            <th id="regDate">작성일 : ${list[0].regDateTime }</th>
          </tr>
        </table>
        <hr>
        <div id="content">
          ${list[0].content }
        </div>
      </div>

    </body>

    </html>

  </c:otherwise>
</c:choose>