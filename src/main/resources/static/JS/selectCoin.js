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

var bithumb_data;
var upbit_data;
var coinone_data;
var korbit_data;

var coinlist = {};
//갱신 타이머 
var timer = undefined;

$(function () {
	coinlist = getCoinList();
	alert (coinlist);
	
	proc(1);	// 전체 데이터를 일정 주기로 가져옴 
	// 2개 1: data 를 채우는 부분 (전체 가져와서)
	// 	   2: data 에서 1번 코인의 정보를 select_coin 에다가 채움 
	
	$('#targetTraded').change(function() {
		
		var result = $('#targetTraded option:selected').val();
		
		
		if (result == 0) {
			$('#select_coin').hide();
			$('#select_all').show();
		}
		else {
			proc(result);
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
				alert("성공?");
				return data['list'];
			}
			
		},
		error : function (data) {
			return data;
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



// 빗썸 함수 
function bithumb(coinName) {

    $.get('https://api.bithumb.com/public/ticker/all', function (data) {
        
        var bithumb_price = parseFloat(data['data'][coinName]['closing_price']);
        var bithumb_fluctate_24H = parseFloat(data['data'][coinName]['fluctate_24H']);
        var bithumb_rate_24H = parseFloat(data['data'][coinName]['fluctate_rate_24H']);
        var bithumb_units_traded_24H = parseFloat(data['data'][coinName]['units_traded_24H']).toFixed(
            0);

        $('#bithumb_Price').html('\\ ' + numberWithCommas(bithumb_price)); // 거래소 시세 정보 표에 값 세팅
        $('#bithumb_fluctate_24H').html('\\ ' + numberWithCommas(bithumb_fluctate_24H));
        $('#bithumb_fluctate_rate_24H').html((bithumb_rate_24H) + '%');
        $('#bithumb_units_traded_24H').html((bithumb_units_traded_24H));

    });
}
// 업비트 함수
function upbit(coinName) {

    $.get('https://api.upbit.com/v1/ticker?markets=KRW-' + coinName, function (data) {
        var upbit_price = parseFloat(data[0]['trade_price']);
        var upbit_change_price = parseFloat(data[0]['change_price']);
        var upbit_change_rate = parseFloat(data[0]['change_rate']);
        var upbit_acc_trade_volume = parseFloat(data[0]['acc_trade_volume']);
        console.log(upbit_price);
        $('#upbit_Price').html('\\ ' + numberWithCommas(upbit_price));
        $('#upbit_Change_price').html('\\ ' + numberWithCommas(upbit_change_price));
        $('#upbit_Change_Rate').html(((upbit_change_rate) * 100).toFixed(2) + '%');
        $('#upbit_Acc_trade_volume').html(((upbit_acc_trade_volume) * 100).toFixed(0));


    });

}
// 코인원 함수
function coinone(coinName) {
    coinName = coinName.toLowerCase(); // -> 수정
    $.get('https://api.coinone.co.kr/ticker?currency=all', function (data) {
        var coinone_btc_last = parseFloat(data[coinName]['last']);
        var coinone_btc_change = parseFloat((data[coinName]['last']) - data[coinName][
            'yesterday_last'
        ]);
        var coinone_btc_changePercent = ((coinone_btc_change / coinone_btc_last) * 100).toFixed(2);
        var coinone_btc_volume = parseFloat(data[coinName]['volume']).toFixed(0);

        $('#coinone_BTC_last').html('\\ ' + numberWithCommas(coinone_btc_last)); // 거래소 시세 정보 표에 값 세팅
        $('#coinone_BTC_change').html('\\ ' + numberWithCommas(coinone_btc_change));
        $('#coinone_BTC_changePercent').html((coinone_btc_changePercent + '%'));
        $('#coinone_BTC_volume').html((coinone_btc_volume));


    });
}

// // 코빗 함수 
function korbit(coinName) {
    coinName = coinName.toLowerCase() + "_krw";
    $.get('https://api.korbit.co.kr/v1/ticker/detailed/all', function (data) {
        var korbit_last = parseFloat(data[coinName]['last']);
        var korbit_change = parseFloat(data[coinName]['change']);
        var korbit_changePercent = parseFloat(data[coinName]['changePercent']);
        var korbit_volume = parseFloat(data[coinName]['volume']).toFixed(0);

        $('#korbit_last').html('\\ ' + numberWithCommas(korbit_last));
        $('#korbit_change').html('\\ ' + numberWithCommas(korbit_change));
        $('#korbit_changePercent').html((korbit_changePercent) + '%');
        $('#korbit_volume').html((korbit_volume));
    });

}

// 현재 시간 갱신
function CurrentTime() {
    var d = new Date();
    $("#lastUpdate").html(d.toString());
}


// 갱신 함수 
function proc(coinNumber) {
	//alert(coinName);
    if (timer)
        clearTimeout(timer);

    try {
        bithumb_all(); 	// 빗썸  -->
        upbit_all(); 	//업비트
        coinone_all(); 	// 코인원 
        korbit_all(); 	// 코빗
        CurrentTime(); 		// 갱신 시간

		set_select_coin (coinNumber);
		// 전체 데이터에서 coinNumber번째 데이터의 정보를 jsp에 추가함
    } catch (e) {

    } finally {
        timer = setTimeout(function () {
            proc(coinName);
        }, 10000); //10초후 재시작
    }
	
}

//cointable 정리 V
function coinT() {
    var modaCoin = [];


    $.get('https://api.bithumb.com/public/ticker/all', function (data) {

        modaCoin = modaCoin.concat(Object.keys(data['data']));
        console.log(modaCoin);
        //console.log(Object.keys(data['data']));
        //console.log(modaCoin);
		//var korbit;
		
		//$.ajax({
			//type: 'get',
			//url: 'https://api.korbit.co.kr/v1/ticker/detailed/all',
			//async: false,
			//dataType: 'JSON',
			//success: function (data) {
				//korbit = data;
			    //korbitValue = parseFloat(data[coinName]['last']);
			//}
		//});
		
    var table = "<tr><th>--</th><th>빗썸</th><th>업비트</th><th>코인원</th><th>코빗</th></tr>";
    for (i = 0; i < 100; i++) {
        table += "<tr>";
        table += "<td>" + modaCoin[i] + "</td>";
        table += "<td>" + numberWithCommas(parseFloat(data['data'][(modaCoin[i])]['closing_price'])) + "</td>";

//        table += "<td>" + numberWithCommas(bithumb_all(modaCoin[i])) + "</td>";

        table += "<td>" + numberWithCommas(upbit_all(modaCoin[i])) + "</td>";
        table += "<td>" + numberWithCommas(coinone_all(modaCoin[i])) + "</td>";

		//alert(JSON.stringify(korbit[korbitCoinName]));
		//var korbitCoinName = modaCoin[i].toLowerCase() + "_krw"
		//alert(JSON.stringify(korbit[korbitCoinName]));
		
       // if(typeof korbit[korbitCoinName] == undefined  ) {
			//table += "<td></td>";
		//}
		//else {
			//table += "<td>" + numberWithCommas(parseFloat(korbit[korbitCoinName]['last'])) + "</td>";
		//}
        table += "<td>" + numberWithCommas(korbit_all(modaCoin[i])) + "</td>";
        table += "</tr>";

    }

    $("#coinTable").html(table);

    });
}






// 빗썸 함수

function bithumb_all() {
    $.ajax({
        type: 'get',
        url: 'https://api.bithumb.com/public/ticker/all',
        async: false,
        dataType: 'JSON',
        success: function (data) {
			bithumb_data = data['data'];
	       }
    });
    return  data['data'];

}


// 업비트 함수
function upbit_all() {
	var upbit_coin_name = "";
	
	for(var i = 1 ; i <= 100 ; i++) {
		coinlist[i]
		
	}
	
    $.ajax({
        type: 'get',
        url: 'https://api.upbit.com/v1/ticker?markets=KRW-' + coinName,
        async: false,
        dataType: 'JSON',
        success: function (data) {
            upbit_data = data;
        }
    });
    return upbitValue;
}




// 코인원 함수

function coinone_all() {

    $.ajax({
        type: 'get',
        url: 'https://api.coinone.co.kr/ticker?currency=all',
        async: false,
        dataType: 'JSON',
        success: function (data) {
            coinone_data = data;
        }
    });

    return coinoneValue;
}





// // 코빗 함수 
function korbit_all() {
    var korbitValue;
    coinName = coinName.toLowerCase() + "_krw";


    $.ajax({
        type: 'get',
        url: 'https://api.korbit.co.kr/v1/ticker/detailed/all',
        async: false,
        dataType: 'JSON',
        success: function (data) {
            korbit_data = data;
        }
    });
    return korbitValue;
}


//
