<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>공지사항</title>

  <%-- 확인용 스타일. css 먹인 후 삭제 --%>
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/BoardTest.css">
</head>


<body>
  <div class="header">
    <%@ include file="../../include/header.jsp"%>
  </div>
  <div style="clear:both; height:70px"></div>

  <div id="middle_menu">
    <h2>공지사항</h2>
  <table>
  

    <tr>
      <th>글번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성일</th>
      <th>조회수</th>
    </tr>




    <c:choose>
      <c:when test="${empty list || fn:length(list) == 0 }">
      </c:when>
      <c:otherwise>
        <c:forEach var="dto" items="${list }">
          <tr>
            <td>${dto.board_uid }</td>
            <td><a href="notice/view?uid=${dto.board_uid }">${dto.subject }</a></td>
            <td>${dto.nickname }</td>
            <td>${dto.regDateTime }</td> <%-- getRegDateTime() 사용 --%>
            <td>${dto.count }</td>
          </tr>
        </c:forEach>
      </c:otherwise>
    </c:choose>

    </table>
    <br>

  </div>

  <div class="footer">
    <%@ include file="../../include/footer.jsp"%>
  </div>
</body>

</html>