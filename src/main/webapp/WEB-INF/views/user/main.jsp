<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/CSS/user_main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="${pageContext.request.contextPath }/JS/selectCoin.js"></script>

</head>
<body>
	<div class="wrap">
		<div class="header">
			<%@ include file = "../include/header.jsp" %> <%-- header --%>
		</div>
		
	    <div class="contentA">
	        <img src='${pageContext.request.contextPath }/images/bitcoin.jpg' alt="메인이미지" />
	    </div>
	
	    <div class="contentB">
			<div class="slideshow-container">
			
				<!-- Full-width images with number and caption text -->
				<div class="mySlides fade">
					<div class="numbertext">1 / 5</div>
					<div class="content_table">
						<table>
							<tr>
								<td>거래소명</td>
								<td>코인시세</td>
							</tr>
							<tbody id="main_0">
								
							</tbody>
						</table>
					</div>
					<div class="text">BTC</div>
				</div>
				
				<div class="mySlides fade">
					<div class="numbertext">2 / 5</div>
					<div class="content_table">
						<table>
							<tr>
								<td>거래소명</td>
								<td>코인시세</td>
							</tr>
							<tbody id="main_1"></tbody>
						</table>
					</div>
					<div class="text">ETH</div>
				</div>
				
				<div class="mySlides fade">
					<div class="numbertext">3 / 5</div>
					<div class="content_table">
						<table>
							<tr>
								<td>거래소명</td>
								<td>코인시세</td>
							</tr>
							<tbody id="main_2"></tbody>
						</table>
					</div>
					<div class="text">LTC</div>
				</div>
				
				<div class="mySlides fade">
					<div class="numbertext">4 / 5</div>
					<div class="content_table">
						<table>
							<tr>
								<td>거래소명</td>
								<td>코인시세</td>
							</tr>
							<tbody id="main_3"></tbody>
						</table>
					</div>
					<div class="text">ETC</div>
				</div>
				
				<div class="mySlides fade">
					<div class="numbertext">5 / 5</div>
					<div class="content_table">
						<table>
							<tr>
								<td>거래소명</td>
								<td>코인시세</td>
							</tr>
							<tbody id="main_4"></tbody>
						</table>
					</div>
					<div class="text">XRP</div>
				</div>
				<!-- Next and previous buttons -->
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				<a class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>
			<br>
			
			<!-- The dots/circles -->
			<div style="text-align:center">
				<span class="dot" onclick="currentSlide(1)"></span>
				<span class="dot" onclick="currentSlide(2)"></span>
				<span class="dot" onclick="currentSlide(3)"></span>
				<span class="dot" onclick="currentSlide(4)"></span>
				<span class="dot" onclick="currentSlide(5)"></span>
			</div>
	    </div>
	    <br>
	    <div class="contentC">
	    	<div class="Cheader">
		    	<h2>공지 사항 </h2>
		    	<a href="/modacon/notice">더보기</a>
	    	</div>
	       	<table border="">
	       		<thead>
	       			<th>최근공지</th>
	       			<th>작성일</th>
	       		</thead>
	       		<tbody>
	       		</tbody>
	       	</table>
	    </div>
<script>
var slideIndex = 1;
showSlides(slideIndex);
showNtc();

function plusSlides(n) {
	showSlides(slideIndex += n);	
}

function currentSlide(n) {
	showSlides(slideIndex = n);
}

function showSlides(n) {
	var i;
	var slides = document.getElementsByClassName("mySlides");
	var dots = document.getElementsByClassName("dot");
	
	if (n > slides.length) {slideIndex = 1}    
	
	if (n < 1) {slideIndex = slides.length}
	
	for (i = 0; i < slides.length; i++) {
	    slides[i].style.display = "none";  
	}
	for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" active", "");
	}
	slides[slideIndex-1].style.display = "block";  
	dots[slideIndex-1].className += " active";
}

function showNtc () {
	
	$.ajax({
	    url: '/modacon/mainNtc',
	    type: 'GET',
	    cache: false,
	    success: function (data) {
	    	
	    	var result = "";
	    	
	    	for ( var i = 0 ; i < 5 ; i++) {
	    		
	    		result += "<tr><td>" + data[i]['subject'] + "</td>";
	    		result += "<td>" + data[i]['regDate'] + "</td></tr>";
	    		
	    	}
	    	$(".contentC tbody").html(result);
	    	
	    }
	  });
	
}

</script>

	    <div class="footer">
			<%@ include file = "../include/footer.jsp" %> <%-- footer --%>
	    </div>
	</div>
</body>
</html>