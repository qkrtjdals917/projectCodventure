<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang ="ko">
<head>
<meta charset="UTF-8">
<title>회원권한 수정</title>
</head>

<body>
	<h2>회원권한수정</h2>
	<!-- table -->
	<table>
	<tr>
		<th>이메일</th>
		<td>User@email.com<!--email (mc_member)--></td>
	</tr>
	<tr>
		<th>닉네임</th>
		<td>User<!-- nickname (mc_member) --></td>
	</tr>
        <th>전화번호</th>
        <td>010-1234-1234<!-- phoneNumber (mc_member)--></td>
    </tr>
    	<th>권한</th>
    	<td>
    	<select name=" ">
		<option value = " ">회원</option>
		<option value = " ">관리자</option>
		</select> 	
		</td>	
	</table> 
	<!--end table -->
	<button value=" ">변경</button>

</body>
</html>