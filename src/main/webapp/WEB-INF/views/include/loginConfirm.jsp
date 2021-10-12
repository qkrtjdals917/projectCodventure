<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
$(function () {
	
		var prevPage = '<%=(String)session.getAttribute("prevPage")%>';
		var loginStatus = '<%=(String)session.getAttribute("loginConfirm")%>';
		
		if(!loginStatus){ 
			// 비정상적인 접근 
			Swal.fire({
				icon: 'error',
				title: '비정상적인 접근입니다.',
				text: '이전 화면으로 이동합니다!'
			}).then(function(){
				history.back();
			});
			
		}
		else{
			if(loginStatus == "success") {
				if (!prevPage) {
					// 이전 주소가 없을 때 
					Swal.fire({
						icon: 'success',
						title: '로그인에 성공했습니다.',
						text: '메인 페이지로 이동합니다!'
					}).then(function(){
						location.href = "/modacon";
					});
				}
				else {
					// 이전 주소가 있을 때 
					Swal.fire({
						icon: 'success',
						title: '로그인에 성공했습니다.',
						text: '기존 페이지로 이동합니다!'
					}).then(function(){
						location.href = prevPage;
					});
					
				}
				
			}
			else if (loginStatus == "failure") {
				if (!prevPage) {
					// 이전 주소가 없을 때 
					Swal.fire({
						icon: 'error',
						title: '로그인에 실패했습니다.',
						text: '메인 페이지로 이동합니다!'
					}).then(function(){
						location.href = "/modacon";
					});
				}
				else {
					// 이전 주소가 있을 때 
					Swal.fire({
						icon: 'error',
						title: '로그인에 실패했습니다.',
						text: '기존 페이지로 이동합니다!'
					}).then(function(){
						location.href = prevPage;
					});
				}	
			}
			else {
				// 비정상적인 접근 
				Swal.fire({
					icon: 'error',
					title: '비정상적인 접근입니다.',
					text: '이전 화면으로 이동합니다!'
				}).then(function(){
					history.back();
				});
			}
			//location.replace("/user/main.jsp");
		}
	}   );
</script>
</head>
<body>
	
</body>
</html>