<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="ko">
    <head>
    <meta charset="UTF-8">
    <title>게시판</title>
    </head>
    <body>
      <div class="header">
        <p>헤더 들어갈 부분</p>
      </div>
      
      <hr>
      
      <div class="content_btn"> <%-- 상단 버튼 모음 --%>
        <button id="back_btn">돌아가기</button>
        <button id="update_btn">수정</button>
        <button id="del_btn">삭제</button>
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
      
      <div class="content_btn"> <%-- 하단 버튼 모음 --%>
        <button id="like_btn">추천</button>
        <button id="comment_btn">댓글</button>  <%-- 댓글 버튼 누르면 밑의 comment_area가 뜨도록 처리 --%>
        <button id="update_btn">수정</button>
        <button id="del_btn">삭제</button>
      </div>
      <hr>
      
      <div id="comment_area"> <%-- 댓글부분 --%>
        <span id="commenter">댓글작성자</span>
        <span id="comment_text">댓글내용</span>
        <button id="comment_del">삭제</button>
        <div id="pagenation_div"> <%-- 댓글란 페이징 처리 부분 --%>
          <ul class="pagenation" id="pagenation">1</ul>
        </div>
        <input id="comment_text"/><button>작성</button> <%-- 댓글 작성란 --%>
      </div>
    </body>
    </html>