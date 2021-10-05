<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>코인 메인페이지</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/user_main.css">
</head>
<body>
	<div>
		<div class="header">
	    	<%@ include file="../include/header.jsp"%>
	    </div>
		<div class="content">
			<form>
				<input type="text" name="coin" placeholder="원하는 코인은?"/>
			</form>
			<table>
				<tr>
					<td>----</td>
					<td>거래소1</td>
					<td>거래소2</td>
					<td>거래소3</td>
					<td>거래소4</td>
					<td>거래소5</td>
				</tr>
				<tr>
					<td><!-- 거래소 --></td>
					<td><!-- 거래소 --></td>
					<td><!-- 거래소 --></td>
					<td><!-- 거래소 --></td>
					<td><!-- 거래소 --></td>
					<td><!-- 거래소 --></td>
				</tr>
			</table>
		</div>
		<div class="footer">
	    	<%@ include file="../include/footer.jsp"%>
	    </div>
	</div>
</body>
</html>