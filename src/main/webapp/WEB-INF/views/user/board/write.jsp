<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>글 작성</title>
</head>

<body>
  <div class="header">
    <%@ include file="../../include/header.jsp"%>
  </div>
  <div style="clear:both; height:70px"></div>

  <form name="frm" action="writeOk" method="post">

    <input type="hidden" name="member_uid" value="${member.member_uid }">
    <div name="selectMenu">
      <select name="type">
        <option value="정보">정보게시판</option>
        <option value="자유">자유게시판</option>
      </select>

      <select name="tag">
        <option selected value="">TAG</option>
        <option value="코인">코인</option>
        <option value="뉴스">뉴스</option>
        <option value="팁과노하우">팁과노하우</option>
        <option value="유머">유머</option>
        <option value="잡담">잡담</option>
        <option value="질문">질문</option>
      </select>
    </div>

    제목 <input name="subject" type="text" placeholder="제목 입력란" />
    <hr>
    <textarea name="content" id="" cols="100" rows="30" placeholder="내용 작성란"></textarea>
    <br><br>
    <button type="submit">등록</button>
    <button type="button" onclick="history.back()">취소</button>
  </form>

</body>

</html>