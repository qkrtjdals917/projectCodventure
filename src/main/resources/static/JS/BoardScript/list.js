// list
// 전역변수
var board_type = '전체';

// 1. 시작함수
$().ready(function () {
  pageload();
});

// 2. 페이지 로딩
function pageload() {
  $.ajax({
    url: 'board',
    type: 'POST',
    cache: false,
    data: {
      type: board_type
    },
    success: function (data) {
      pageset(data);
    }
  });
}

function pageset(data) {
  var result = "";
  var items = data.data;

  for (var i = 0; i < items.length; i++) {
    viewLink = 'board/view?uid='.concat(items[i].board_uid);
    result += "<tr>\n";
    result += "<td>" + items[i].board_uid + "</td>\n";
    result += "<td><a href='" + viewLink + "'>[" + items[i].tag + "]" + items[i].subject + "</a></td>\n";
    result += "<td>" + items[i].nickname + "</td>\n";
    result += "<td>" + items[i].regDate + "</td>\n";
    result += "<td>" + items[i].likeCnt + "</td>\n";
    result += "<td>" + items[i].count + "</td>\n";
    result += "</tr>\n";
  }
  $("#tbody").html(result);
}

// 3. 메뉴 토글
function type_toggle() {
  board_type = $('#board_type option:selected').val();
  if (board_type == '정보') {
    $('#board_tag').val("").prop("selected", true);
    $('.info_sel').show();
    $('.free_sel').hide();
    pageload();
  } else if (board_type == '자유') {
    $('#board_tag').val("").prop("selected", true);
    $('.info_sel').hide();
    $('.free_sel').show();
    pageload();
  } else if (board_type == '전체') {
    $('#board_tag').val("").prop("selected", true);
    $('.info_sel').show();
    $('.free_sel').show();
    pageload();
  }
}