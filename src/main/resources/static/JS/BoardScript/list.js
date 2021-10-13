// list
// 전역변수
var board_type = '전체';
var board_tag = '전체';

// 1. 시작함수
$().ready(function () {
  pageload();
});

// 2. 페이지 로딩
function pageload() {
  $.ajax({
    url: '',
    type: 'POST',
    cache: false,
    data: {
      type: board_type,
      tag: board_tag
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
    if (items[i].tag == null) {
      result += "<td><a href='" + viewLink + "'>" + items[i].subject + "</a></td>\n";
    } else {
    result += "<td><a href='" + viewLink + "'>[" + items[i].tag + "]" + items[i].subject + "</a></td>\n";}
    result += "<td>" + items[i].nickname + "</td>\n";
    result += "<td>" + items[i].regDate + "</td>\n";
    result += "<td>" + items[i].likeCnt + "</td>\n";
    result += "<td>" + items[i].count + "</td>\n";
    result += "</tr>\n";
  }
  $("#tbody").html(result);
}

// 3. 게시판 타입 토글
function type_toggle() {
  board_type = $('#board_type option:selected').val();
  if (board_type == '정보') {
    $('#board_tag').val("전체").prop("selected", true);
    $('.info_sel').show();
    $('.free_sel').hide();
    board_tag = $('#board_tag option:selected').val();
  } else if (board_type == '자유') {
    $('#board_tag').val("전체").prop("selected", true);
    $('.info_sel').hide();
    $('.free_sel').show();
    board_tag = $('#board_tag option:selected').val();
  } else if (board_type == '전체') {
    $('#board_tag').val("전체").prop("selected", true);
    $('.info_sel').show();
    $('.free_sel').show();
    board_tag = $('#board_tag option:selected').val();
  }
  pageload();
}

// 4. 게시판 태그 토글
function tag_toggle() {
  board_tag = $('#board_tag option:selected').val();
  pageload();
}

// 5. 페이징
var totalData;
var dataPerPage;
var pageCount = 10;
var globalCurrentPage = 1;