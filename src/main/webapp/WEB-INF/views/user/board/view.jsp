<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:if test="${empty member }" var="member_null" scope="session" />
<c:choose>
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

    <!DOCTYPE html> <%-- html 시작 --%>
    <html lang="ko">

    <head>
      <meta charset="UTF-8">
      <title>커뮤니티</title>

      <%-- 확인용 스타일. css 먹인 후 삭제 --%>
      <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
      <%-- SweetAlert2 --%>
      <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>

    <script type="text/javascript">
      // 로그인 확인
      function not_Login_msg() {
        Swal.fire({
          icon: 'error',
          title: '로그인 오류',
          text: '로그인 하지 않았습니다. 로그인 해주세요.'
        });
      }

      // 프론트 삭제 제약사항.
      function chkDelete() {
        // 로그인 확인
        if (${member_null}) {
          not_Login_msg();
          return;
        }
        
        Swal.fire({
          title: '글 삭제',
          text: "해당 글을 삭제하시겠습니까? 삭제 후 다시 복구 할 수 없습니다.",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: '삭제',
          cancelButtonText: '취소'
        }).then((result) => {
          if (result.isConfirmed) {
            if ("${list[0].member_uid }" == "${member.member_uid}") {
              location.href = "delete?uid=" + "${list[0].board_uid}";
            } else {
              Swal.fire(
                '삭제 실패',
                '해당 글의 작성자가 아닙니다.',
                'error'
              )
            }
          }
        });
      }
   
      // 프론트 수정 제약사항
      function chkUpdate() {
        // 로그인 확인
        if (${member_null}) {
          not_Login_msg();
          return;
        }

        Swal.fire({
          title: '글 수정',
          text: "해당 글을 수정 하시겠습니까?",
          icon: 'question',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: '수정',
          cancelButtonText: '취소'
        }).then((result) => {
          if (result.isConfirmed) {
            if ("${list[0].member_uid }" == "${member.member_uid}") {
              location.href = "update?uid=" + "${list[0].board_uid}";
            } else {
              Swal.fire(
                '수정 실패',
                '해당 글의 작성자가 아닙니다.',
                'error'
              )
            }
          }
        });
      }
    </script>

    <body>
      <div class="header">
        <%@ include file="../../include/header.jsp"%>
      </div>
      <div style="clear:both; height:70px"></div>

      <hr>

      <div class="content_btn"> <%-- 상단 버튼 모음 --%>
        <button id="back_btn" onclick="history.back()">돌아가기</button>
        <button id="update_btn" onclick="chkUpdate()">수정</button>
        <button id="del_btn" onclick="chkDelete()">삭제</button>
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
        <hr>
      </div>

      <div class="content_btn"> <%-- 하단 버튼 모음 --%>
        <button id="like_btn">추천</button>
        <button id="comment_btn">댓글</button> <%-- 댓글 버튼 누르면 밑의 comment_area가 뜨도록 처리 --%>
        <button id="update_btn" onclick="chkUpdate()">수정</button>
        <button id="del_btn" onclick="chkDelete()">삭제</button>
      </div>
      <hr>

      <%@ include file="./comment.jsp" %>


  <div class="footer">
    <%@ include file="../../include/footer.jsp"%>
  </div>
    </body>

    </html>

  </c:otherwise>
</c:choose>