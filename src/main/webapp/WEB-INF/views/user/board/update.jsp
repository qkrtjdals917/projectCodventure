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

      <form>
        <select name="" id="">
          <option value="">정보게시판</option>
          <option value="">자유게시판</option>
        </select>
        <select name="" id="">
          <option value="">유머</option>
          <option value="">잡담</option>
          <option value="">
            <!-- 빈태그 처리  -->
          </option>
        </select>


        제목 <input type="text" placeholder="수정하려는 글 제목"></input>
        <textarea name="" id="" cols="100" rows="30" placeholder="수정하려는 글내용"></textarea>
        <button>수정</button>
        <button>취소</button>
      </form>

    </body>

    </html>
  </c:otherwise>
</c:choose>