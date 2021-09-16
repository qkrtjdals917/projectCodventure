<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    </head>
    <body>
      <div class="header">
        <p>헤더 들어갈 부분</p>
      </div>
      
      <hr>
      
      <div class="content_btn"> <%-- 상단 버튼 모음 --%>
        <button id="back_btn">돌아가기</button>
        <button id="notice_update_btn">수정</button>
        <button id="del_btn">삭제</button>
      </div>
    
      <h2 id="boardname">게시판</h2>
      <hr>
    
      <div class="read_contents">
        <p id="content_name">글 제목</p>
        <table>
          <tr>
            <th id="nickname">닉네임</th>
            <th id="contentInc">조회수</th>
            <th id="regDate">등록일</th>
          </tr>
        </table>
        <textarea id="content_text">
          글 내용
        </textarea>
      </div>
      
      <div class="content_btn">
        <button id="notice_update_btn">수정</button>
        <button id="del_btn">삭제</button>
      </div>
      <hr>
    
    </body>
    </html>