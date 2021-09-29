<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>main</title>
<style>
* {
    margin: 0;
    color: #fff;
    font-family: 'Do Hyeon', sans-serif;
    font-size: 25px;
}

.contentA {
    height : 600px;  
    position: relative;
    margin : 0 auto;
    border: gray solid 1px;
}
.contentB {
    position: relative;
    margin : 0 auto;
    left: 50%;
}
.contentC {
    position: relative;
    margin : 0 auto;
    left: 50%;
    
}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
<%@ include file = "../include/header.jsp" %> <%-- header --%>
	<div style="clear:both; height:70px"></div>
    <div class="contentA">
        <img src='' alt="메인이미지" /> 
    </div>

    <div class="contentB">
       	<table border="">
       		<tr>
       			<td>거래소명</td>
       			<td>코인시세</td>
       		</tr>
       		<tr>
       			<td>평균거래가</td>
       			<td>10000 (0)</td>
       		</tr>
       		<tr>
       			<td>거래소1</td>
       			<td>9000 (-1000)</td>
       		</tr>
       		<tr>
       			<td>거래소2</td>
       			<td>11000 (+1000)</td>
       		</tr>
       	</table>
    </div>
    <br>
    <div class="contentC">
       	<table border="">
       		<tr>
       			<td>최근공지</td>
       		</tr>
       		<tr>
       			<td>공지1</td>
                <td>내용 ~~~~~~~~~</td>
       		</tr>
       		<tr>
       			<td>공지2</td>
                <td>내용 ~~~~~~~~~</td>
       		</tr>
       		<tr>
       			<td>공지3</td>
                <td>내용 ~~~~~~~~~</td>
       		</tr>
       	</table>
    </div>
<%@ include file = "../include/footer.jsp" %> <%-- footer --%>
</body>
</html>