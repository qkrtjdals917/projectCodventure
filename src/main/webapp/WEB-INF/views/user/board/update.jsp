<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
  <c:when test="${not empty ERR}">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <%-- SweetAlert2 --%>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
      $().ready(function () {
        Swal.fire({
          icon: 'error',
          title: '수정 오류',
          text: '${ERR }'
        }).then((result) => {
          history.back();
        });
      });
    </script>
  </c:when>

  <c:when test="${empty list || fn:length(list) == 0 }">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <%-- SweetAlert2 --%>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
      $().ready(function () {
        Swal.fire({
          icon: 'error',
          title: '정보 오류',
          text: '해당 글이 삭제됐거나 없습니다.'
        }).then((result) => {
          history.back();
        });
      });
    </script>
  </c:when>

  <c:otherwise>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <title>게시판 글 수정</title>

      <%-- SweetAlert2 --%>
      <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <body>
      <div class="header">
        <%@ include file="../../include/header.jsp"%>
      </div>
      <div style="clear:both; height:70px"></div>
      <form name="frm" action="updateOk" method="post">
        <input type="hidden" name="member_uid" value="${member.member_uid }" />
        <input type="hidden" name="board_uid" value="${list[0].board_uid }" />
        <div class="selectMenu">
          <select name="type">
            <option value="정보">정보게시판</option>
            <option value="자유">자유게시판</option>
          </select>

          <select name="tag">
            <option value="" selected>TAG선택</option>
            <option value="코인">코인</option>
            <option value="뉴스">뉴스</option>
            <option value="팁과노하우">팁과노하우</option>
            <option value="유머">유머</option>
            <option value="잡담">잡담</option>
            <option value="질문">질문</option>
          </select>
        </div>


        제목 <input name="subject" type="text" value="${list[0].subject }" />
        <hr>
        <textarea name="content" id="" cols="100" rows="30">${list[0].content }</textarea>
        <br><br>
        <button type="submit">수정</button>
        <button type="button" onclick="history.back()">취소</button>
      </form>
      <div class="footer">
        <%@ include file="../../include/footer.jsp"%>
      </div>
    </body>

    </html>
  </c:otherwise>
</c:choose>