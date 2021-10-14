<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>글 작성</title>

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <%-- SweetAlert2 --%>
  <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="${pageContext.request.contextPath }/JS/BoardScript/write.js"></script>
</head>

<body onload="type_toggle()">
  <div class="header">
    <%@ include file="../../include/header.jsp"%>
  </div>
  
  <div class="board_write">
	  <form id="frm" method="post">
	
	    <input type="hidden" id="member_uid" name="member_uid" value="${member.member_uid }">
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
	
	    제목 <input id="subject" name="subject" type="text" placeholder="제목 입력란" />
	    <hr>
	    <textarea name="content" id="content" cols="100" rows="30" placeholder="내용 작성란"></textarea>
	    <br><br>
	    <button type="button" onclick="write_chk()">등록</button>
	    <button type="button" onclick="history.back()">취소</button>
	  </form>
  </div>

  <div class="footer">
    <%@ include file="../../include/footer.jsp"%>
  </div>
</body>

</html>