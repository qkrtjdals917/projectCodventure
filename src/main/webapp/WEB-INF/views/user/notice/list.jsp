<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>공지사항</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <script src="https://kit.fontawesome.com/001c1f3b98.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
  <script src="${pageContext.request.contextPath }/JS/BoardScript/notice.js"></script>
</head>


<body>
  <div class="header">
    <%@ include file="../../include/header.jsp"%>
  </div>
  <div class="content">
    <div id="middle_menu">
      <table>
        <h2>공지사항</h2>
        <table>

          <thead>
            <th>글번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회수</th>
          </thead>

          <tbody id="tbody">
          </tbody>


        </table>
        <br>
    </div>
  </div>
  <%-- [페이징] --%>
  <div class="center">
    <ul class="pagination" id="pagination"></ul>
  </div>

  <div class="footer">
    <%@ include file="../../include/footer.jsp"%>
  </div>
</body>

</html>