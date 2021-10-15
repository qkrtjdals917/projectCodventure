// function selectCoin(coinName) {
//     //alert(coinName.value);
//     //this.coinName = coinName.value;
//     //alert(this.coinName);
// };
// 1. 코인 이름 리스트 불러오기 (Json obj -> 배열 - > ㄱ)
// 2. 전체 코인 가져온다 
// 3. 리스트 와 같은 이름의 정보를 가져와서 뿌린다
// 4. 

//var bithumb_data = {};
//var upbit_data = [];
//var coinone_data = {};
//var korbit_data = {};

//var coinlist = {};

var bithumb_data = [];
var upbit_data = [];
var coinone_data = [];
var korbit_data = [];

var bithumb_coinlist = [];
var upbit_coinlist = [];
var coinone_coinlist = [];
var korbit_coinlist = [];
//갱신 타이머 
var timer = undefined;


var slideIndex = 1;

$(function() {
   getCoinList();
   proc(0);   // 전체 데이터를 일정 주기로 가져옴 
   // 2개 1: data 를 채우는 부분 (전체 가져와서)
   //       2: data 에서 1번 코인의 정보를 select_coin 에다가 채움 
   showSlides(slideIndex);
   $('#targetTrade').change(function() {

      var result = $('#targetTrade option:selected').val();
      //alert(result);

      if (result == 0) {
         $('#select_coin').hide();   // select시 보이는것
       $('.select_table').hide();   // select시 보이는것
         $('#select_all').show();
         $('#bar-chart').hide();
      }
      else {
         proc(Number(result) - 1);
         // 가져온 전체 데이터에서 원하는 부분만 뽑아서 보내는 함수 
         $('#select_coin').show();   // select시 보이는것
       $('.select_table').show();   // select시 보이는것
         $('#select_all').hide();
         $('#bar-chart').show();

         //alert(result);
         //var upbit_ChangePercent = $("#upbit_Change_Rate").val();
         //alert(upbit_ChangePercent);
         //$("#korbit_changePercent").css("color","blue");
         var bitdata = 0;
         var upbitdata = 0;
         var coinonedata = 0;
         var korbitdata = 0;
         var coinsum = 0;
         var coincnt = 0;
         if (!bithumb_data) {
            bitdata = 0;
         }
         else {
            bitdata = parseFloat(bithumb_data[Number(result) - 1]['closing_price']);
            coincnt++;
         }


         if (!upbit_data) {
            upbitdata = 0;
         }
         else {
            upbitdata = parseFloat(upbit_data[Number(result) - 1]['trade_price']);
            coincnt++;
         }
         if (!coinone_data) {
            coinonedata = 0;
         }
         else {
            coinonedata = parseFloat(upbit_data[Number(result) - 1]['trade_price']);
            coincnt++;
         }
         if (!korbit_data) {
            korbitdata = 0;
         }
         else {
            korbitdata = parseFloat(korbit_data[Number(result) - 1]['last']);
            coincnt++;
         }
         coinsum = bitdata + upbitdata + coinonedata + korbitdata;
         //alert(coinsum);
         //차트 중복현상 방지     
         $("#bar-chart").remove();
         var canvasHtml = '<canvas id="bar-chart" width="300" height="100"></canvas>';
         $("#bar_div").append(canvasHtml);

         var input = document.getElementById("bar-chart");
         var chart = new Chart(document.getElementById("bar-chart"), {

            type: 'bar',
            data: {
               labels: ["평균거래가", "빗썸", "업비트", "코인원", "코빗"],
               datasets: [
                  {
                     label: "거래대금",
                     backgroundColor: ["#3e95cd", "#8e5ea2", "#3cba9f", "#e8c3b9", "#c45850"],
                     data: [(coinsum / coincnt), bitdata,
                        upbitdata,
                        coinonedata,
                        korbitdata]
                  }
               ]
            },
            options: {
               legend: { display: false },
               title: {
                  display: true,
                  text: '평균거래비 시각자료'
               }
            }
         });


      }

   });
});




function getCoinList() {
   $.ajax({
      type: "GET",
      url: "/modacon/coin/getlist",
      cache: false,
      async: false,
      success: function(data) {
         if (data['status'] == "success") {
            for (var i = 0; i < 100; i++) {
               bithumb_coinlist.push(data['list'][i]['bithumb_name']);
               upbit_coinlist.push(data['list'][i]['upbit_name']);
               coinone_coinlist.push(data['list'][i]['coinone_name']);
               korbit_coinlist.push(data['list'][i]['korbit_name']);
            }
         }
      },
      error: function(data) {
      }
   });

}

// 천단위 콤마 함수
function numberWithCommas(x) {

   if (typeof x == "undefined" || isNaN(x)) {
      x = ""

      return x;
   }
   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 숫자 외 문자열 제거 함수
function numberDeleteChar(x) {

   return x.toString().replace(/[^0-9]+/g, '');
}

// 현재 시간 갱신
function CurrentTime() {
   var d = new Date();
   $("#lastUpdate").html(d.toString());
}


// 갱신 함수 
function proc(coinNumber) {
   //alert(coinNumber);
   if (timer)
      clearTimeout(timer);

   try {
      bithumb_all();    // 빗썸  -->
      upbit_all();    //업비트
      coinone_all();    // 코인원 
      korbit_all();    // 코빗
      CurrentTime();       // 갱신 시간
      set_select_all();
      set_main_coin();
      set_select_coin(coinNumber);
      // 전체 데이터에서 coinNumber번째 데이터의 정보를 jsp에 추가함
   } catch (e) {

   } finally {
      timer = setTimeout(function() {
         proc(coinNumber);
      }, 10000); //10초후 재시작
   }

}

function set_main_coin() {
   set_main_sun(0);
   set_main_sun(1);
   set_main_sun(2);
   set_main_sun(3);
   set_main_sun(4);

}

function set_main_sun(coin) {
   var result = "";
   result += "<tr><td>빗썸</td>"
   result += "<td>" + numberWithCommas(parseFloat(bithumb_data[coin]['closing_price'])) + " ( ";

   var bithumb_ChangePrice = parseFloat(bithumb_data[coin]['fluctate_24H']);
   if (bithumb_ChangePrice >= 0) {
      result += "<span style='color:red'> " + bithumb_ChangePrice + " </span>"
   }
   else {
      result += "<span style='color:blue'> " + bithumb_ChangePrice + " </span>"
   }


   result += " ) </td></tr>";

   result += "<tr><td>업비트</td>"
   result += "<td>" + numberWithCommas(parseFloat(upbit_data[coin]['trade_price'])) + " ( ";

   var upbit_ChangePrice = parseFloat(upbit_data[coin]['change_price']);
   if (upbit_ChangePrice >= 0) {
      result += "<span style='color:red'> " + upbit_ChangePrice + " </span>"
   }
   else {
      result += "<span style='color:blue'> " + upbit_ChangePrice + " </span>"
   }


   result += " ) </td></tr>";


   result += "<tr><td>코인원</td>"
   result += "<td>" + numberWithCommas(parseFloat(coinone_data[coin]['last'])) + " ( ";

   var coinone_ChangePrice = parseFloat((coinone_data[coin]['last']) - coinone_data[coin]['yesterday_last']);
   if (coinone_ChangePrice >= 0) {
      result += "<span style='color:red'> " + coinone_ChangePrice + " </span>"
   }
   else {
      result += "<span style='color:blue'> " + coinone_ChangePrice + " </span>"
   }
   result += " ) </td></tr>";

   result += "<tr><td>코빗</td>"
   result += "<td>" + numberWithCommas(parseFloat(korbit_data[coin]['last'])) + " ( ";

   var korbit_ChangePrice = parseFloat(korbit_data[coin]['change']);
   if (korbit_ChangePrice >= 0) {
      result += "<span style='color:red'> " + korbit_ChangePrice + " </span>"
   }
   else {
      result += "<span style='color:blue'> " + korbit_ChangePrice + " </span>"
   }


   result += " ) </td></tr>";

   $('#main_' + coin).html(result);
}

function set_select_coin(coinNumber) {

   // 값 체크해서 스타일까지 변경 if문으로 구분
   $('#bithumb_Price').html(numberWithCommas(parseFloat(bithumb_data[coinNumber]['closing_price'])));
   var bithumb_ChangePrice = parseFloat(bithumb_data[coinNumber]['fluctate_24H']);
   if (bithumb_ChangePrice >= 0) {
      $("#bithumb_fluctate_24H").css("color", "red");
   }
   else {
      $("#bithumb_fluctate_24H").css("color", "blue");
   }
   $('#bithumb_fluctate_24H').html(numberWithCommas(bithumb_ChangePrice));
   var bithumb_ChangePercent = (parseFloat(bithumb_data[coinNumber]['fluctate_rate_24H']));
   if (bithumb_ChangePercent >= 0) {
      $("#bithumb_fluctate_rate_24H").css("color", "red");
   }
   else {
      $("#bithumb_fluctate_rate_24H").css("color", "blue");
   }
   $('#bithumb_fluctate_rate_24H').html((parseFloat(bithumb_ChangePercent)) + '%');
   $('#bithumb_units_traded_24H').html((parseFloat(bithumb_data[coinNumber]['units_traded_24H']).toFixed(0)));

   if (!upbit_data[coinNumber]) {   // 데이터 있으면 { 오브젝트}    없으면 "" empty 
      $('#upbit_Price').html("");
      $('#upbit_Change_price').html("");
      $('#upbit_Change_Rate').html("");
      $('#upbit_Acc_trade_volume').html("");
      // 비어있다면 = 값이 없다 -> 공백
   }
   else {
      $('#upbit_Price').html(numberWithCommas(parseFloat(upbit_data[coinNumber]['trade_price'])));
      var upbit_ChangePrice = (parseFloat(upbit_data[coinNumber]['change_price']));
      if (upbit_ChangePrice >= 0) {
         $("#upbit_Change_price").css("color", "red");
      }
      else {
         $("#upbit_Change_price").css("color", "blue");
      }
      $('#upbit_Change_price').html(numberWithCommas(upbit_ChangePrice));
      var upbit_ChangePercent = ((parseFloat(upbit_data[coinNumber]['change_rate'])) * 100).toFixed(2);
      if (upbit_ChangePercent >= 0) {
         $("#upbit_Change_Rate").css("color", "red");
      }
      else {
         $("#upbit_Change_Rate").css("color", "blue");
      }
      $('#upbit_Change_Rate').html(upbit_ChangePercent + '%');
      //alert(upbit_ChangePercent);
      $('#upbit_Acc_trade_volume').html(((parseFloat(upbit_data[coinNumber]['acc_trade_volume'])) * 100).toFixed(0));
      // 값이 있으니까 그대로 
   }

   if (!coinone_data[coinNumber]) {   // 데이터 있으면 { 오브젝트}    없으면 "" empty 
      $('#coinone_BTC_last').html("");
      $('#coinone_BTC_change').html("");
      $('#coinone_BTC_changePercent').html("");
      $('#coinone_BTC_volume').html("");
      // 비어있다면 = 값이 없다 -> 공백
   }
   else {
      var coinone_btc_last = parseFloat(coinone_data[coinNumber]['last']);
      var coinone_btc_change = parseFloat((coinone_data[coinNumber]['last']) - coinone_data[coinNumber]['yesterday_last']);

      $('#coinone_BTC_last').html(numberWithCommas(coinone_btc_last));
      var coinone_ChangePrice = coinone_btc_change;
      if (coinone_ChangePrice >= 0) {
         $("#coinone_BTC_change").css("color", "red");
      }
      else {
         $("#coinone_BTC_change").css("color", "blue");
      }
      $('#coinone_BTC_change').html(numberWithCommas(coinone_btc_change));
      var coinone_ChangePercent = ((coinone_btc_change / coinone_btc_last) * 100).toFixed(2);
      if (coinone_ChangePercent >= 0) {
         $("#coinone_BTC_changePercent").css("color", "red");
      }
      else {
         $("#coinone_BTC_changePercent").css("color", "blue");
      }
      $('#coinone_BTC_changePercent').html((((coinone_btc_change / coinone_btc_last) * 100).toFixed(2) + '%'));

      $('#coinone_BTC_volume').html(numberWithCommas(parseFloat(coinone_data[coinNumber]['volume']).toFixed(0)));
      // 값이 있으니까 그대로 
   }

   if (!korbit_data[coinNumber]) {   // 데이터 있으면 { 오브젝트}    없으면 "" empty 
      $('#korbit_last').html("");
      $('#korbit_change').html("");
      $('#korbit_changePercent').html("");
      $('#korbit_volume').html("");
      // 비어있다면 = 값이 없다 -> 공백
   }
   else {

      $('#korbit_last').html(numberWithCommas(parseFloat(korbit_data[coinNumber]['last'])));
      var korbit_ChangePrice = parseFloat(korbit_data[coinNumber]['change']);
      if (korbit_ChangePrice >= 0) {
         $("#korbit_change").css("color", "red");
      }
      else {
         $("#korbit_change").css("color", "blue");
      }
      $('#korbit_change').html(numberWithCommas(korbit_ChangePrice));
      var korbit_ChangePercent = parseFloat(korbit_data[coinNumber]['changePercent']);
      if (korbit_ChangePrice >= 0) {
         $("#korbit_changePercent").css("color", "red");
      }
      else {
         $("#korbit_changePercent").css("color", "blue");
      }
      $('#korbit_changePercent').html((parseFloat(korbit_ChangePercent)) + '%');
      $('#korbit_volume').html(parseFloat(korbit_data[coinNumber]['volume']).toFixed(0));
   }



}
function set_select_all() {
   var table;
   //평균거래가 
   for (var i = 0; i < 5; i++) {
      table = "";
      
      for (var j = i * 20; j < i * 20 + 20; j++) {
         // 여기다 전체 다 넣음 
         table += "<tr>";

         //bithumb_data[i]['closing_price'] +  
         //(upbit_data[i]['trade_price']) + (coinone_data[i]['last']) + ( korbit_data[i]['last']);
         //alert(avgCoin);

         // BTC 등 코인 이름
         table += "<td id>" + bithumb_coinlist[j] + "</td>";



         table += "<td>" + numberWithCommas((avgcoin(j)).toFixed(0)) + "</td>";

      //alert(j);

         // 빗썸 가격
         table += "<td id>" + numberWithCommas(parseFloat(bithumb_data[j]['closing_price'])) + "</td>";

         //alert(JSON.stringify(upbit_data[i]));

         if (!upbit_data[j]) {
            table += "<td>-</td>";
         }
         else {
            table += "<td>" + numberWithCommas(parseFloat(upbit_data[j]['trade_price'])) + "</td>";
         }

         if (!coinone_data[j]) {
            table += "<td>-</td>";
         }
         else {
            table += "<td>" + numberWithCommas(parseFloat(coinone_data[j]['last'])) + "</td>";
         }
         if (!korbit_data[j]) {
            table += "<td>-</td>";
         }
         else {
            table += "<td>" + numberWithCommas(parseFloat(korbit_data[j]['last'])) + "</td>";
         }
         table += "</tr>";
         //alert(table);
      }
      $("#coinMain_" + i).html(table);
      // table 20개 담김 -> main_i <- ㅡmain 이 아니라 딴거로  에다가 넣음 
   } // for (i)

   /*
      var table = "<tr><th>코인명</th><th>평균거래가</th><th>빗썸</th><th>업비트</th><th>코인원</th><th>코빗</th></tr>";
      for (i = 0; i < 100; i++) {
         table += "<tr>";
   
         //bithumb_data[i]['closing_price'] +  
         //(upbit_data[i]['trade_price']) + (coinone_data[i]['last']) + ( korbit_data[i]['last']);
         //alert(avgCoin);
   
         // BTC 등 코인 이름
         table += "<td id>" + bithumb_coinlist[i] + "</td>";
   
   
   
         table += "<td>" + numberWithCommas((avgcoin(i)).toFixed(0)) + "</td>";
   
   
         // 빗썸 가격
         table += "<td id>" + numberWithCommas(parseFloat(bithumb_data[i]['closing_price'])) + "</td>";
   
         //alert(JSON.stringify(upbit_data[i]));
   
         if (!upbit_data[i]) {
            table += "<td>-</td>";
         }
         else {
            table += "<td>" + numberWithCommas(parseFloat(upbit_data[i]['trade_price'])) + "</td>";
         }
   
         if (!coinone_data[i]) {
            table += "<td>-</td>";
         }
         else {
            table += "<td>" + numberWithCommas(parseFloat(coinone_data[i]['last'])) + "</td>";
         }
         if (!korbit_data[i]) {
            table += "<td>-</td>";
         }
         else {
            table += "<td>" + numberWithCommas(parseFloat(korbit_data[i]['last'])) + "</td>";
         }
         table += "</tr>";
         $("#main_" + i).html(table);
   
      }
      //alert(table); 
   
   
   */
}


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

   if (n > slides.length) { slideIndex = 1 }

   if (n < 1) { slideIndex = slides.length }

   for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";
   }
   for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
   }
   slides[slideIndex - 1].style.display = "block";
   dots[slideIndex - 1].className += " active";
}





function avgcoin(coinNumber) {
   var sum = 0;
   var cntCoin = 0;
   // 먼저 빗썸 가격 더해줌 

   sum += parseFloat( bithumb_data[coinNumber]['closing_price']);
   cntCoin ++;
   if (upbit_data[coinNumber]) {
      sum += parseFloat( upbit_data[coinNumber]['trade_price'])
      cntCoin++;   
   }   
   if (coinone_data[coinNumber]) {
      sum += parseFloat( coinone_data[coinNumber]['last'])
      cntCoin++;   
   }
   if (korbit_data[coinNumber]) {
      sum += parseFloat(  korbit_data[coinNumber]['last'])
      cntCoin++;   
   }
   var avg = sum / cntCoin;
   return avg;
}


// 빗썸 함수

function bithumb_all() {
   //   alert("all");
   bithumb_data = [];
   $.ajax({
      type: 'get',
      url: 'https://api.bithumb.com/public/ticker/all',
      async: false,
      dataType: 'JSON',
      success: function(data) {
         for (var i = 0; i < 100; i++) {
            bithumb_data.push(data['data'][bithumb_coinlist[i]]);
         }
      }
   });
}
// 업비트 함수
function upbit_all() {
   var upbit_coin_name = "";

   upbit_coin_name += upbit_coinlist[0];

   for (var i = 1; i <= 99; i++) {
      if (upbit_coinlist[i] != "") {
         upbit_coin_name += ",KRW-";
         upbit_coin_name += upbit_coinlist[i];
      }
   }
   upbit_data = [];
   //alert(upbit_coin_name);
   $.ajax({
      type: 'get',
      url: 'https://api.upbit.com/v1/ticker?markets=KRW-' + upbit_coin_name,
      async: false,
      dataType: 'JSON',
      success: function(data) {
         for (var i = 0; i < 100; i++) {
            if (upbit_coinlist[i] != "") {
               upbit_data.push(data[i]);
            }
            else {
               upbit_data.push("");
            }
         }
      }
   });

}
// 코인원 함수

function coinone_all() {
   coinone_data = [];
   $.ajax({
      type: 'get',
      url: 'https://api.coinone.co.kr/ticker?currency=all',
      async: false,
      dataType: 'JSON',
      success: function(data) {
         for (var i = 0; i < 100; i++) {
            //alert(JSON.stringify (data[coinone_coinlist[i]]) );
            if (coinone_coinlist[i] != "") {
               coinone_data.push(data[coinone_coinlist[i]]);
            }
            else {
               coinone_data.push("");
            }
         }
      }
   });

   //for(var i = 0 ; i < 100 ; i++) {
   //alert(JSON.stringify(upbit_data[i]) );
   //}
}
// // 코빗 함수 
function korbit_all() {
   korbit_data = [];
   $.ajax({
      type: 'get',
      url: 'https://api.korbit.co.kr/v1/ticker/detailed/all',
      async: false,
      dataType: 'JSON',
      success: function(data) {
         for (var i = 0; i < 100; i++) {
            //alert(JSON.stringify (korbit_coinlist[i]) );
            //alert(JSON.stringify (data[korbit_coinlist[i]]) );

            if (korbit_coinlist[i] != "") {
               korbit_data.push(data[korbit_coinlist[i]]);
            }
            else {
               korbit_data.push("");
            }
         }
      }
   });

   //for(var i = 0 ; i < 100 ; i++) {
   //   alert(JSON.stringify(korbit_data[i]) );
   //}
}


// 차트