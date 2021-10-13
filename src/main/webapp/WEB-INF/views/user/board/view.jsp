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
      <script src="${pageContext.request.contextPath }/JS/BoardScript/view.js"></script>
      
      <body onload="view_chk()"></body>
   </c:when>
   
   <c:otherwise>
   
   <!DOCTYPE html>
   <html lang="ko">
   
   <head>
   <meta charset="UTF-8">
   <title>커뮤니티</title>
   
   <%-- 확인용 스타일. css 먹인 후 삭제 --%>
   <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
   <%-- SweetAlert2 --%>
   <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
   <script src="${pageContext.request.contextPath }/JS/BoardScript/view.js"></script>
   </head>
   
   <script type="text/javascript">
   var member_null = ${member_null};
   var board_mem_uid = "${list[0].member_uid }";
   var member_uid = "${member.member_uid}";
   var board_uid = "${list[0].board_uid}";
   </script>
   
   <body onload="btn_toggle()">
      <div class="header">
         <%@ include file="../../include/header.jsp"%>
      </div>
      <hr>
      
      <div id="board_view">
         <div class="content_btn"> <%-- 상단 버튼 모음 --%>
            <button id="back_btn" onclick="history.back()">돌아가기</button>
            <button style="display: none;" id="report_btn" onclick="chkReport()">신고</button>
            <button style="display: none;" id="update_btn" onclick="chkUpdate()">수정</button>
            <button style="display: none;" id="del_btn" onclick="chkDelete()">삭제</button>
         </div>
         <div class="clearAll"></div>
      
         <h2 id="boardname">${list[0].type }게시판</h2> <%-- 게시판 이름 기재. 접속한 게시판 별로 이름이 변하게 처리해줘야함 --%>
         <hr>
      
         <div class="read_contents"> <%-- 본문 --%>
            <h3 id="content_name">글 제목 : ${list[0].subject }</h3>
            <table> <%-- 현재 테이블로 처리를 했지만 ul-li와 css적용해서 바꿀예정 --%>
               <tr>
                  <th id="nickname">닉네임 : ${list[0].nickname }</th>
                  <th id="likeCnt">추천수 : <span id="likeCount">${list[0].likeCnt }</span></th>
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
            <button style="display: none;" id="like_up_btn" onclick="chkLikeUp()">추천하기</button>
            <button style="display: none;" id="like_down_btn" onclick="chkLikeDown()">추천취소</button>
            <button id="comment_btn" onclick="comment_toggle()">댓글</button> <%-- 댓글 버튼 누르면 밑의 comment_area가 뜨도록 처리 --%>
            <button style="display: none;" id="update_btn" onclick="chkUpdate()">수정</button>
            <button style="display: none;" id="del_btn" onclick="chkDelete()">삭제</button>
         </div>
         
         <div id="comment_area" style="display: none;">
            <%@ include file="./comment.jsp" %>
         </div>
      </div>
      <div class="footer">
         <%@ include file="../../include/footer.jsp"%>
      </div>
   
   </body>
   
   </html>
   
   </c:otherwise>
</c:choose>