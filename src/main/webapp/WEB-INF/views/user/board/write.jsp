<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>게시판 글 장성</title>
</head>
<body>
    <!--selecter 2 sets-->
	<select name="" id="">
    <option value="">정보게시판</option>
    <option value="">자유게시판</option>
    </select>
    <select name="" id="">
    <option value="">유머</option>
    <option value="">잡담</option>
    <option value=""><!-- 빈태그 처리  --></option>
    </select>
    <!--end selecter 2 sets-->

    
    <!--form-->
	<form action="<!--view단-->" method="<!--post-->">
제목 <input type="text" placeholder="제목 입력란"></input>
	<textarea name="" id="" cols="100" rows="30" placeholder="내용 작성란"></textarea>
	<button value= " ">등록</button>
	<button value= " ">취소</button>
	</form>
    <!--end form-->
    
        
        
        


</body>
</html>