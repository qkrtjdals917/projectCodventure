<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8">
  <title>게시판 글 장성</title>
</head>

<body>
  <form action="<!--view단-->" method="<!--post-->"></form>
  <div name="selecter">
    <select name="boardSelect">
      <option value="정보">정보게시판</option>
      <option value="자유">자유게시판</option>
    </select>

    <select name="infoSelectTag">
      <option value=""></option>
      <option value="">코인</option>
      <option value="">뉴스</option>
      <option value="">팁과노하우</option>
    </select>

    <select name="freeSelectTag">
      <option value=""></option>
      <option value="">유머</option>
      <option value="">잡담</option>
      <option value="">질문</option>
    </select>

  </div>

  제목 <input type="text" placeholder="제목 입력란" />
  <hr>
  <textarea name="" id="" cols="100" rows="30" placeholder="내용 작성란"></textarea>
  <br><br>
  <button value="">등록</button>
  <button value="">취소</button>
  </form>

</body>

</html>