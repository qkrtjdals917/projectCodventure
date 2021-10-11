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

$(function () {
	getCoinList();
	$('#select_all').show();
	proc(0);	// 전체 데이터를 일정 주기로 가져옴 
	// 2개 1: data 를 채우는 부분 (전체 가져와서)
	// 	   2: data 에서 1번 코인의 정보를 select_coin 에다가 채움 
	
	$('#targetTrade').change(function() {
		
		var result = $('#targetTrade option:selected').val();
		//alert(result);
		
		if (result == 0) {
			$('#select_coin').hide();
			$('#select_all').show();
		}
		else {
			proc(Number(result)-1);
			// 가져온 전체 데이터에서 원하는 부분만 뽑아서 보내는 함수 
		    $('#select_coin').show();
			$('#select_all').hide();
		}
  }); 	
});

function getCoinList () {
	$.ajax ({
		type : "GET",
		url : "/modacon/coin/getlist",
		cache : false,
		async : false,
		success : function (data) {
			if(data['status'] == "success") {
				for(var i = 0 ; i < 100 ; i++) {
					bithumb_coinlist.push(data['list'][i]['bithumb_name']);
					upbit_coinlist.push(data['list'][i]['upbit_name']);
					coinone_coinlist.push(data['list'][i]['coinone_name']);
					korbit_coinlist.push(data['list'][i]['korbit_name']);
				}
			}
		},
		error : function (data) {
		}
	});
	
}

// 천단위 콤마 함수
function numberWithCommas(x) {
	
	if (typeof x == "undefined" || isNaN(x) ){
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
        bithumb_all(); 	// 빗썸  -->
        upbit_all(); 	//업비트
        coinone_all(); 	// 코인원 
        korbit_all(); 	// 코빗
        CurrentTime(); 		// 갱신 시간
		set_select_all();
		
		set_select_coin (coinNumber);
		// 전체 데이터에서 coinNumber번째 데이터의 정보를 jsp에 추가함
    } catch (e) {

    } finally {
        timer = setTimeout(function () {
            proc(coinNumber);
        }, 10000); //10초후 재시작
    }
	
}
function set_select_coin (coinNumber) {

    $('#bithumb_Price').html('&#92; ' + numberWithCommas( parseFloat(bithumb_data[coinNumber]['closing_price'])  )); 
    $('#bithumb_fluctate_24H').html('\\ ' + numberWithCommas( parseFloat(bithumb_data[coinNumber]['fluctate_24H']) ));
    $('#bithumb_fluctate_rate_24H').html((parseFloat(bithumb_data[coinNumber]['fluctate_rate_24H'])) + '%');
    $('#bithumb_units_traded_24H').html((parseFloat(bithumb_data[coinNumber]['units_traded_24H']).toFixed(0)));
	
	$('#upbit_Price').html('\\ ' + numberWithCommas( parseFloat(upbit_data[coinNumber]['trade_price']) ));
	$('#upbit_Change_price').html('\\ ' + numberWithCommas( parseFloat(upbit_data[coinNumber]['change_price']) ));
	$('#upbit_Change_Rate').html((( parseFloat(upbit_data[coinNumber]['change_rate']) ) * 100).toFixed(2) + '%' );
	$('#upbit_Acc_trade_volume').html((( parseFloat(upbit_data[coinNumber]['acc_trade_volume']) ) * 100).toFixed(0) );

	var coinone_btc_last = parseFloat(coinone_data[coinNumber]['last']);
	var coinone_btc_change = parseFloat((coinone_data[coinNumber]['last']) - coinone_data[coinNumber]['yesterday_last']);

    $('#coinone_BTC_last').html('\\ ' + numberWithCommas( coinone_btc_last ));
    $('#coinone_BTC_change').html('\\ ' + numberWithCommas( coinone_btc_change ));
    $('#coinone_BTC_changePercent').html((((coinone_btc_change / coinone_btc_last) * 100).toFixed(2) + '%'));
    $('#coinone_BTC_volume').html(numberWithCommas(parseFloat(coinone_data[coinNumber]['volume']).toFixed(0)));

	$('#korbit_last').html('\\ ' + numberWithCommas( parseFloat( korbit_data[coinNumber]['last']) ));
	$('#korbit_change').html('\\ ' + numberWithCommas( parseFloat( korbit_data[coinNumber]['change']) ));
	$('#korbit_changePercent').html( (parseFloat(korbit_data[coinNumber]['changePercent'])) + '%');
	$('#korbit_volume').html(parseFloat(korbit_data[coinNumber]['volume']).toFixed(0));

}
function set_select_all() {
		
    var table = "<tr><th>--</th><th>빗썸</th><th>업비트</th><th>코인원</th><th>코빗</th></tr>";
	for (i = 0; i < 100; i++) {
        table += "<tr>";
        table += "<td>" + bithumb_coinlist[i] + "</td>";
        table += "<td>" + numberWithCommas(parseFloat( bithumb_data[i]['closing_price'])) + "</td>";
		
		//alert(JSON.stringify(upbit_data[i]));
		
		if (!upbit_data[i]) {
			table += "<td>-</td>";
		}
		else {
	        table += "<td>" + numberWithCommas(parseFloat( upbit_data[i]['trade_price'])) + "</td>";	
		}
		
		if (!coinone_data[i]) {
			table += "<td>-</td>";
		}
		else {
	        table += "<td>" + numberWithCommas(parseFloat(coinone_data[i]['last']) ) + "</td>";
		}
		if (!korbit_data[i]) {
			table += "<td>-</td>";
		}
		else {
	        table += "<td>" + numberWithCommas(parseFloat( korbit_data[i]['last']) ) + "</td>";
		}
        table += "</tr>";

    }
//alert(table); 

    $("#coinTable").html(table);

}






// 빗썸 함수

function bithumb_all() {
    $.ajax({
        type: 'get',
        url: 'https://api.bithumb.com/public/ticker/all',
        async: false,
        dataType: 'JSON',
        success: function (data) {
			for(var i = 0 ; i < 100 ; i++) {
				bithumb_data.push(data['data'][bithumb_coinlist[i]]);
			}
		}
    });
}
// 업비트 함수
function upbit_all() {
	var upbit_coin_name = "";
	
	upbit_coin_name += upbit_coinlist[0];
	
	for(var i = 1 ; i <= 99 ; i++) {
		if(upbit_coinlist[i] != "" ) {
			upbit_coin_name += ",KRW-";
			upbit_coin_name += upbit_coinlist[i];			
		}
	}
	
	//alert(upbit_coin_name);
    $.ajax({
        type: 'get',
        url: 'https://api.upbit.com/v1/ticker?markets=KRW-' + upbit_coin_name,
        async: false,
        dataType: 'JSON',
        success: function (data) {
			for(var i = 0 ; i < 100 ; i++) {
				if(upbit_coinlist[i] != "" ) {
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

    $.ajax({
        type: 'get',
        url: 'https://api.coinone.co.kr/ticker?currency=all',
        async: false,
        dataType: 'JSON',
        success: function (data) {
			for(var i = 0 ; i < 100 ; i++) {
				//alert(JSON.stringify (data[coinone_coinlist[i]]) );
				if(coinone_coinlist[i] != "" ) {
					coinone_data.push(data[coinone_coinlist[i]] );
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
    $.ajax({
        type: 'get',
        url: 'https://api.korbit.co.kr/v1/ticker/detailed/all',
        async: false,
        dataType: 'JSON',
        success: function (data) {
			for(var i = 0 ; i < 100 ; i++) {
				//alert(JSON.stringify (korbit_coinlist[i]) );
				//alert(JSON.stringify (data[korbit_coinlist[i]]) );

				if(korbit_coinlist[i] != "" ) {
					korbit_data.push(data[korbit_coinlist[i]]);
				}
				else {
					korbit_data.push("");
				}
			}
        }
    });

	//for(var i = 0 ; i < 100 ; i++) {
	//	alert(JSON.stringify(korbit_data[i]) );
	//}
}


//
