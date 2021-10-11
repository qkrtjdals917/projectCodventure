<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function login_check(){ 
	
		var prevPage = '<%=(String)session.getAttribute("prevPage")%>';
		var loginStatus = '<%=(String)session.getAttribute("loginConfirm")%>';
		
		if(loginStatus=="null"){ 
			// 비정상적인 접근 
			Swal.fire({
				icon: 'success',
				title: '회원가입이 완료되었습니다.',
				text: '환영합니다!'
			}).then(function(){
				frm.submit();
			});
			
		}
		else{
			// 성공인가
				// prevPage 가 있는가 없는가 
				// 있으면 prevPage 로 이동
				// 없으면 그냥 main 으로 이동 
			
			// 실패인가 
				// prevPage 가 있는가 없는가 
				// 있으면 prevPage 로 이동
				// 없으면 그냥 main 으로 이동 			
			
			location.replace("/user/main.jsp");
		}
	}   
</script>
</head>
<body>
	
</body>
</html>