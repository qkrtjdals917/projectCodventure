var page = 1; // 현재 페이지
var pageRows = 10; // 페이지당 글의 개수

// 1. 시작함수
$().ready(function () {
  pageload(page);
});

// 2. 페이지 로딩
function pageload(page) {
  $.ajax({
    url: '/modacon/notice/' + page + '/' + pageRows,
    type: 'GET',
    cache: false,
    success: function (data, status) {
      if (status == 'success') {
        pageset(data);
      }
    }
  });
}

function pageset(data) {
  var result = "";
  if (data.status == "OK") {
    var items = data.data;
    var count = data.count;
    window.page = data.page;
    window.pageRows = data.pagerows;

    for (var i = 0; i < count; i++) {
      viewLink = '/modacon/notice/view?uid='.concat(items[i].board_uid);
      result += "<tr>\n";
      result += "<td>" + items[i].board_uid + "</td>\n";
      result += "<td><a href='" + viewLink + "'>" + items[i].subject + "</a></td>\n";

      result += "<td>" + items[i].nickname + "</td>\n";
      result += "<td>" + items[i].regDate + "</td>\n";
      result += "<td>" + items[i].count + "</td>\n";
      result += "</tr>\n";
    }
    $("#tbody").html(result);

    // [페이징] 정보 업데이트
    var pagination = buildPagination(data.writepages, data.totalpage, data.page, data.pagerows);
    $("#pagination").html(pagination);

  }
}

// 페이징생성함수
function buildPagination(writePages, totalPage, curPage, pageRows) {
  var str = ""; // 최종페이징 생성시 나타날 HTML <li>태그로 구성함

  // 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
  var start_page = ((parseInt((curPage - 1) / writePages)) * writePages) + 1;
  var end_page = start_page + writePages - 1;

  if (end_page >= totalPage) {
    end_page = totalPage;
  }

  //■ << 표시 여부
  if (curPage > 1) {
    str += `<li><a onclick="pageload(` + 1 + `)" class="tooltip-top" title="처음"><i class="fas fa-angle-double-left"></i></a></li>\n`;
  }
  //■  < 표시 여부
  if (start_page > 1)

    str += `<li><a onclick="pageload(` + (start_page - 1) + `)" class='tooltip-top' title='이전'><i class='fas fa-angle-left'></i></a></li>\n`;

  //■  페이징 안의 '숫자' 표시   
  if (totalPage > 1) {
    for (var k = start_page; k <= end_page; k++) {
      if (curPage != k) {
        str += `<li><a onclick="pageload(` + k + `)">` + k + `</a></li>\n`;

      } else {
        str += "<li><a class='active' title='현재페이지'>" + k + "</a></li>\n";
      }
    }
  }

  //■ > 표시
  if (totalPage > end_page) {
    str += `<li><a onclick="pageload(` + (end_page + 1) + `)" class='tooltip-top' title='다음'><i class='fas fa-angle-right'></i></a></li>\n`;
  }

  //■ >> 표시
  if (curPage < totalPage) {
    str += `<li><a onclick="pageload(` + totalPage + `)" class='tooltip-top' title='맨끝'><i class='fas fa-angle-double-right'></i></a></li>\n`;
  }
  return str;

} // end buildPagination()