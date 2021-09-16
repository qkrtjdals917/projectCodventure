<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>관리자페이지 (회원관리))</title>
<style>
    table {width: 100%;}
    table, th, td {
        border: 1px solid black;
        border-collapse: collapse;
    }
</style>
</head>


<body>
	<h2>회원관리</h2>
	<!-- form -->
	<form action=" " method =" ">
	<input tpye ="text" placeholder="회원검색"></input>	
	
	</form>
	<!-- end form -->




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
		<th>이메일</th>
		<th>닉네임</th>
		<th>전화번호</th>
		<th>권한</th>
		<th>상태</th>
  	</tr>
    <tr>    
        <td><!--email (mc_member)--></td>
        <td><!--nickname (mc_member) --> </td>
        <td><!--phoneNumber (mc_member)--></td>
        <td><!--authority 외부키  클릭시 mrm (member right modificaton (회원권한수정 page))--></td>
       	<td><button value=" ">강퇴<!-- --></button></td>
        
    </tr>	
	</table> 
	<!--end table -->
	

</body>
</html>