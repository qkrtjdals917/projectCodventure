<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>관리자페이지(신고접수 리스트)</title>
<style>
    table {width: 100%;}
    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
</style>
</head>
<body> 
	<h2>신고접수 리스트</h2>
	
	<!--selecter -->
	<select name=" ">
	<option value = " ">10</option>
	<option value = " ">15</option>
	<option value = " ">30</option>
	<option value = " ">50</option>
	<option value = " ">100</option>
	</select> 
	<!-- end selecter -->
	
	
	
	<!-- table -->
	<table>
	<tr>
		<th>글번호</th>
		<th>'tag'제목</th>
		<th>작성자</th>
		<th>신고자</th>
		<th>신고취하</th>
		<th>글삭제</th>
  	</tr>
    <tr>    
        <td><!--글번호 report_uid  --></td>
        <td><!--정보or자유 __ 링크걸어서 해당페이지 넘어가게 설계  --> </td>
        <td><!--(작성자)닉네임 --></td>
        <td><!--(신고자)   member_uid 외부키  --></td>
        <td><button value=" ">신고취하<!-- --></button></td>
        <td><button value=" ">삭제<!-- --></button></td>
    </tr>	
	</table> 
	<!--end table -->
	



	<!--페이징 ()-->






</body>
</html>