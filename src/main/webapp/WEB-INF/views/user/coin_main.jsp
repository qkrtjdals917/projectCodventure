<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>코인 메인페이지</title>
<style>
table {
	border-collapse: collapse
}

td, th {
	padding: 5px;
	width: 120px
}
</style>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/CSS/coin.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="${pageContext.request.contextPath }/JS/selectCoin.js"></script>
</head>




<body>
	<div>
		<div class="header">
			<%@ include file="../include/header.jsp"%>
		</div>
		<div class="content">
			
			<select id="targetTrade" onchange="">
				<option value="0">ALL</option>
				<option value="1">BTC</option>
				<option value="2">ETH</option>
				<option value="3">LTC</option>
				<option value="4">ETC</option>
				<option value="5">XRP</option>
				<option value="6">BCH</option>
				<option value="7">QTUM</option>
				<option value="8">BTG</option>
				<option value="9">EOS</option>
				<option value="10">ICX</option>
				<option value="11">TRX</option>
				<option value="12">ELF</option>
				<option value="13">OMG</option>
				<option value="14">KNC</option>
				<option value="15">GLM</option>
				<option value="16">ZIL</option>
				<option value="17">WAXP</option>
				<option value="18">POWR</option>
				<option value="19">LRC</option>
				<option value="20">STEEM</option>
				<option value="21">STRAX</option>
				<option value="22">ZRX</option>
				<option value="23">REP</option>
				<option value="24">XEM</option>
				<option value="25">SNT</option>
				<option value="26">ADA</option>
				<option value="27">CTXC</option>
				<option value="28">BAT</option>
				<option value="29">WTC</option>
				<option value="30">THETA</option>
				<option value="31">LOOM</option>
				<option value="32">WAVES</option>
				<option value="33">TRUE</option>
				<option value="34">LINK</option>
				<option value="35">ENJ</option>
				<option value="36">VET</option>
				<option value="37">MTL</option>
				<option value="38">IOST</option>
				<option value="39">TMTG</option>
				<option value="40">QKC</option>
				<option value="41">HDAC</option>
				<option value="42">AMO</option>
				<option value="43">BSV</option>
				<option value="44">ORBS</option>
				<option value="45">TFUEL</option>
				<option value="46">VALOR</option>
				<option value="47">CON</option>
				<option value="48">ANKR</option>
				<option value="49">MIX</option>
				<option value="50">CRO</option>
				<option value="51">FX</option>
				<option value="52">CHR</option>
				<option value="53">MBL</option>
				<option value="54">MXC</option>
				<option value="55">FCT</option>
				<option value="56">TRV</option>
				<option value="57">DAD</option>
				<option value="58">WOM</option>
				<option value="59">SOC</option>
				<option value="60">EM</option>
				<option value="61">BOA</option>
				<option value="62">FLETA</option>
				<option value="63">SXP</option>
				<option value="64">COS</option>
				<option value="65">APIX</option>
				<option value="66">EL</option>
				<option value="67">BASIC</option>
				<option value="68">HIVE</option>
				<option value="69">XPR</option>
				<option value="70">VRA</option>
				<option value="71">FIT</option>
				<option value="72">EGG</option>
				<option value="73">BORA</option>
				<option value="74">APPA</option>
				<option value="75">APM</option>
				<option value="76">CKB</option>
				<option value="77">AERGO</option>
				<option value="78">ANW</option>
				<option value="79">CENNZ</option>
				<option value="80">EVZ</option>
				<option value="81">CYCLUB</option>
				<option value="82">SRM</option>
				<option value="83">QTCON</option>
				<option value="84">UNI</option>
				<option value="85">YFI</option>
				<option value="86">UMA</option>
				<option value="87">AAVE</option>
				<option value="88">COMP</option>
				<option value="89">REN</option>
				<option value="90">BAL</option>
				<option value="91">RSR</option>
				<option value="92">NMR</option>
				<option value="93">RLC</option>
				<option value="94">UOS</option>
				<option value="95">SAND</option>
				<option value="96">GOM2</option>
				<option value="97">RINGX</option>
				<option value="98">BEL</option>
				<option value="99">OBSR</option>
				<option value="100">ORC</option>
			</select>



			<div id="select_all">
				<div class="slideshow-container">

					<!-- Full-width images with number and caption text -->
					<div class="mySlides fade">
						<div class="numbertext">1 / 5</div>
						<div class="content_table">
							<table>
								<tr>
									<th>코인명</th>
									<th>평균거래가</th>
									<th>빗썸</th>
									<th>업비트</th>
									<th>코인원</th>
									<th>코빗</th>
								</tr>
								<tbody id="coinMain_0"></tbody>
							</table>
						</div>
						
					</div>

					<div class="mySlides fade">
						<div class="numbertext">2 / 5</div>
						<div class="content_table">
							<table>
								<tr>
									<th>코인명</th>
									<th>평균거래가</th>
									<th>빗썸</th>
									<th>업비트</th>
									<th>코인원</th>
									<th>코빗</th>
								</tr>
								<tbody id="coinMain_1"></tbody>
							</table>
						</div>
						<div class="text"></div>
					</div>

					<div class="mySlides fade">
						<div class="numbertext">3 / 5</div>
						<div class="content_table">
							<table>
								<tr>
									<th>코인명</th>
									<th>평균거래가</th>
									<th>빗썸</th>
									<th>업비트</th>
									<th>코인원</th>
									<th>코빗</th>
								</tr>
								<tbody id="coinMain_2"></tbody>
							</table>
						</div>
						<div class="text"></div>
					</div>

					<div class="mySlides fade">
						<div class="numbertext">4 / 5</div>
						<div class="content_table">
							<table>
								<tr>
									<th>코인명</th>
									<th>평균거래가</th>
									<th>빗썸</th>
									<th>업비트</th>
									<th>코인원</th>
									<th>코빗</th>
								</tr>
								<tbody id="coinMain_3"></tbody>
							</table>
						</div>
						<div class="text"></div>
					</div>

					<div class="mySlides fade">
						<div class="numbertext">5 / 5</div>
						<div class="content_table">
							<table>
								<theader>
								<th>코인명</th>
								<th>평균거래가</th>
								<th>빗썸</th>
								<th>업비트</th>
								<th>코인원</th>
								<th>코빗</th>
								</theader>
								<tbody id="coinMain_4"></tbody>
							</table>
						</div>
						<div class="text"></div>
					</div>
					<!-- Next and previous buttons -->
					<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
						class="next" onclick="plusSlides(1)">&#10095;</a>
				</div>

				<!-- The dots/circles -->
				<div style="text-align: center">
					<span class="dot" onclick="currentSlide(1)"></span> <span
						class="dot" onclick="currentSlide(2)"></span> <span class="dot"
						onclick="currentSlide(3)"></span> <span class="dot"
						onclick="currentSlide(4)"></span> <span class="dot"
						onclick="currentSlide(5)"></span>
				</div>
			</div>
			<br>





			<div id="select_coin">
				<!-- 거래소 시세 정보 -->
				<table border=1>
					<tr>
						<th>거래소</th>
						<td>시세(원화)</td>
						<td>변동(24h)</td>
						<td>변동률(24h)</td>
						<td>거래량(개)</td>
					</tr>
					<tr>
						<th>빗썸</th>
						<td id="bithumb_Price"></td>
						<td id="bithumb_fluctate_24H"><span></span></td>
						<td id="bithumb_fluctate_rate_24H"></td>
						<td id="bithumb_units_traded_24H"></td>
					</tr>
					<tr>
						<th>업비트</th>
						<td id="upbit_Price"></td>
						<td id="upbit_Change_price"></td>
						<td id="upbit_Change_Rate"></td>
						<td id="upbit_Acc_trade_volume"></td>
					</tr>
					<tr>
						<th>코인원</th>
						<td id="coinone_BTC_last"></td>
						<td id="coinone_BTC_change"></td>
						<td id="coinone_BTC_changePercent"></td>
						<td id="coinone_BTC_volume"></td>
					</tr>

					<tr>
						<th>코빗</th>
						<td id="korbit_last"></td>
						<td id="korbit_change"></td>
						<td id="korbit_changePercent"></td>
						<td id="korbit_volume"></td>
					</tr>
					<tr>
						<td>최근 갱신 시간</td>
						<td colspan="4" id="lastUpdate"></td>
					</tr>
				</table>
			</div>
		</div>
		<div>
		<div id="bar_div">
		<canvas id="bar-chart" width="300" height="230"></canvas>
		</div>
		</div>

		<div class="footer">
			<%@ include file="../include/footer.jsp"%>
		</div>


	</div>
</body>


</html>