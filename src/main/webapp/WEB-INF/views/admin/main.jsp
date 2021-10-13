<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>관리자 메인페이지</title>

<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath }/CSS/include.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
   href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
   rel="stylesheet">

<script src="https://kit.fontawesome.com/001c1f3b98.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<link rel="stylesheet" type="text/css"
   href="${pageContext.request.contextPath }/CSS/admin.css">
<script src="${pageContext.request.contextPath }/JS/admin.js"></script>

</head>

<body>
   <header>
      <div class="container">
         <div class="container-small">
            <!-- 작은 화면의 배치를 위한 컨테이너-->
            <a href="/modaconAdmin" class="headA">
                   <img class="logo" alt="로고" src="${pageContext.request.contextPath }/images/logo.png">
            </a>

            <!-- 내비게이션 메뉴 -->
            <nav class="headB">
               <ul>
                  <li><a onclick="admNotice()">공지사항</a></li>
                  <li><a onclick="admBoard()">게시판관리</a></li>
                  <li><a onclick="admReport()">신고접수</a></li>
                  <li><a onclick="admMember()">회원관리</a></li>
               </ul>
            </nav>

            <!-- 메뉴 토글 버튼 -->
            <div>
               <button type="button" class="headC">
                  <span class="fa fa-bars" title="MENU"></span>
               </button>

               <div class="headD">
                  <button type="button" onclick="logout_btn()" id="btnLogout">로그아웃</button>
               </div>
            </div>
         </div>
      </div>

	</header><%-- header 영역끝 --%>

		<div id="adm_content">
				<h2 id="admin_title"></h2>
			
				<div class="pageSet">
					<div class="pleft" id="pageinfo"></div>
					<div class="pright" id="pageRows"></div>
				</div>
			
				<div id="contentNotice">
					<form id="NoticeForm" name="NoticeForm" method="GET">
						<div id="NoticeContainer">
						<table>
							<thead>
								<th>글번호</th>
								<th>'log'제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>DELETE</th>
							</thead>
							<tbody>
							</tbody>
						</table>
						<br>
						</div>
					</form>
				
				<!-- <button onclick= "location.href = 'write.jsp'" >공지 등록</button> -->
				
				<div class="a01">
					<div class="ntcright">
						<button type="button" id="ntcWrite" class="ntc success">글작성</button>
					</div>
				</div>
				
				<!--  모달 위치 -->
				</div>
			
			<div id="contentBoard">
            <select id="board_type" name="type" onchange="type_toggle()">
               <option id="all_type" value="전체" selected>전체게시판</option>
               <option id="infoBoard_type" value="정보">정보게시판</option>
               <option id="freeBoard_type" value="자유">자유게시판</option>
            </select>
         
            <select id="board_tag" name="tag" onchange="tag_toggle()">
               <option class="tag_default_sel" value="전체" selected>전체</option>
               <option class="info_sel" value="코인">코인</option>
               <option class="info_sel" value="뉴스">뉴스</option>
               <option class="info_sel" value="팁과노하우">팁과노하우</option>
               <option class="free_sel" value="유머">유머</option>
               <option class="free_sel" value="잡담">잡담</option>
               <option class="free_sel" value="질문">질문</option>
            </select>
            <div class="clearAll"></div>
				<%-- 커뮤니티 목록 --%>
					<form id="CommunityForm" name="CommunityForm" method="GET">
						<div id="communityContainer">
						<table>
							<thead>
								<th>글번호</th>
								<th>'log'제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>DELETE</th>
							</thead>
							<tbody>
							</tbody>
						</table>
						</div>
					</form>
				</div>
			
			<%-- 신고 content --%>
			<div id="contentReport">
			
			<table>
				<thead>
					<th>글번호</th>
					<th>'log'제목</th>
					<th>작성자</th>
					<th>신고자</th>
					<th>신고취하</th>
					<th>DELETE</th>
				</tr>
				<tbody>
				</tbody>
			</table>
			
			</div>
			
				<%-- 회원권리 --%>
				<div id="contentMember">
					
					<!-- table -->
					<form id="MemberForm" name="MemberForm" method="GET">
						<div id="memberContainer">
						<table>
							<thead>
									<th>uid</th>
									<th>이메일</th>
									<th>닉네임</th>
									<th>전화번호</th>
									<th>권한</th>
									<th>상태</th>
							</thead>
							<tbody>
							</tbody>
						</table>
						</div>
					</form>
				<!--end table -->
				
					
				</div>
		
			<%-- [페이징] --%>
			<div class="center">
				<ul class="pagination" id="pagination"></ul>
			</div>
			
			
			<%-- 글 작성 / 보기 / 수정 대화상자 --%>
			<div id="noticeWrite" class="modal">
				<form class="modal-notice anitmate" id="noticeFrm" name="noticeFrm" method="post">
					<div class="container">
						<h3 class="title">공지 작성</h3>
						<span class="close" title="Close Modal">&times;</span>
						<%-- 닫기버튼 --%>
						<input type="hidden" name="uid" value="0">
						<%-- 읽기, 삭제, 수정을 위해 필요 --%>
						
						<div class="a01 ntc_group_header">
						<div class="ntcLeft">
							<p id="viewcnt"></p>
						</div>
						<div class="ntcright">
							<p id="regdate"></p>
						</div>
						<div class="clear"></div>
						</div>
						
						<label for="subject"><b>글제목</b></label>
						<input type="text" placeholder="글제목(필수)" name="subject" required>
						<label for="content"><b>내용</b></label>
						<textarea placeholder="글내용" name="content"></textarea>
						
						<%-- 하단 버튼 : 글 작성 --%>
						<div class="a01 ntc_group_write">
							<button type="submit" class="ntc write fullntc">공지 작성</button>
						</div>
						
						<%-- 하단 버튼 : 글 조회 --%>
						<div class="a01 ntc_group_view">
							<div class="left">
								<button type="button" class="ntc danger" id="viewDelete">삭제</button>
							</div>
							<div class="right">
								<button type="button" class="ntc update" id="viewUpdate">수정</button>
							</div>
							<div class="clear"></div>
						</div>
						
						<%-- 하단 버튼 : 글 수정 --%>
						<div class="a01 ntc_group_update">
						<div>
						<button type="button" class="ntc update fullbtn" id="updateOk">수정완료</button>
						</div>
						<div class="clear"></div>
						</div>
						
						
					</div>
				</form>
			</div>
		</div>
	
	<c:choose>
		<c:when test="${not empty admPrevPage}">
			<script>
				viewPage("${admPrevPage}");
			</script>
		</c:when>
	</c:choose>



   <footer>
      <div class="container">
         <!-- 푸터A : 사이트 정보 -->
         <div class="footA">
            <h2>LOGO</h2>
            <p>TEAM: Codeventure</p>
            <p>권혁찬, 박성민, 박해연,</p>
            <p>이상빈, 정은수</p>
         </div>

         <!-- 푸터B : 푸터 메뉴 -->

         <nav class="footB">
            <div>
               <ul>
                  <li><a href="/modacon">HOME</a></li>
                  <li><a href="/modacon/coin">코인시세</a></li>
                  <li><a href="/modacon/board">커뮤니티</a></li>
                  <li><a href="/modacon/notice">공지사항</a></li>
               </ul>
            </div>
         </nav>

         <!-- 푸터C : 저작권-->
         <div class="footC">© MODACON corp. All rights reserved.</div>

      </div>
   </footer>
</body>
</html>