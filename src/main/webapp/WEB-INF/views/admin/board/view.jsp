<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
    <meta charset="UTF-8">
    <title>게시판 관리</title>
    </head>
    
    <%-- 신고게시판의 view와 구조가 완전히 같아 이 페이지로 같이 사용 --%>
    <body>
    
      <div class="header">
        <p>헤더 들어갈 부분</p>
      </div>
      
      <hr>
      
      <div class="content_btn"> <%-- 상단 버튼 모음 --%>
        <button id="back_btn">돌아가기</button>
        <button class="del_btn">삭제</button>
      </div>
    
      <h2 id="boardname">게시판</h2> <%-- 게시판 이름 기재. 접속한 게시판 별로 이름이 변하게 처리해줘야함 --%>
      <hr>
    
      <div class="read_contents"> <%-- 본문 --%>
        <p id="content_name">글 제목</p>
        <table>  <%-- 현재 테이블로 처리를 했지만 ul-li와 css적용해서 바꿀예정 --%>
          <tr>
            <th id="nickname">닉네임</th>
            <th id="likeCnt">추천수</th>
            <th id="contentInc">조회수</th>
            <th id="regDate">등록일</th>
          </tr>
        </table>
        <textarea id="content_text"> <%-- 글내용란 textarea로 영역을 우선 표기해둠. --%>
          글 내용
        </textarea>
      </div>
      
      <div class="content_btn">
        <button class="del_btn">삭제</button>
      </div>
      <hr>
      
    </body>
    </html>