<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
  <c:when test="${empty list || fn:length(list) == 0 || not empty ERR}">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <%-- SweetAlert2 --%>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="${pageContext.request.contextPath }/JS/BoardScript/update.js"></script>
    <script>
      var ERR = '${ERR}'
    </script>

    <body onload="err_alert()"></body>
  </c:when>

  <c:otherwise>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <title>게시판 글 수정</title>

      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
      <%-- SweetAlert2 --%>
      <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
      <script src="${pageContext.request.contextPath }/JS/BoardScript/update.js"></script>
    </head>

    <script>
      var board_type = '${list[0].type}';
      var board_tag = '${list[0].tag}';
    </script>

    <body onload="select_set()">
      <div class="header">
        <%@ include file="../../include/header.jsp"%>
      </div>
      <div style="clear:both; height:70px"></div>

      <form id="frm" name="frm" method="PUT">
        <input type="hidden" id="member_uid" name="member_uid" value="${member.member_uid }" />
        <input type="hidden" id="board_uid" name="board_uid" value="${list[0].board_uid }" />
        <div name="selectMenu">
          <select id="board_type" name="type" onchange="type_toggle()">
            <option id="infoBoard_type" value="정보" selected>정보게시판</option>
            <option id="freeBoard_type" value="자유">자유게시판</option>
          </select>

          <select id="board_tag" name="tag">
            <option selected value="">태그없음</option>
            <option class="info_sel" value="코인">코인</option>
            <option class="info_sel" value="뉴스">뉴스</option>
            <option class="info_sel" value="팁과노하우">팁과노하우</option>
            <option class="free_sel" value="유머">유머</option>
            <option class="free_sel" value="잡담">잡담</option>
            <option class="free_sel" value="질문">질문</option>
          </select>
        </div>

        제목 <input id="subject" name="subject" type="text" placeholder="${list[0].subject }" />
        <hr>
        <textarea id="content" name="content" id="" cols="100" rows="30" placeholder="${list[0].content }"></textarea>
        <br><br>
        <button type="button" onclick="update_chk()">수정</button>
        <button type="button" onclick="history.back()">취소</button>
      </form>
      <div class="footer">
        <%@ include file="../../include/footer.jsp"%>
      </div>
    </body>

    </html>
  </c:otherwise>
</c:choose>