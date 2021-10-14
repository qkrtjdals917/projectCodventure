var page = 1;   // 현재 페이지
var pageRows = 10;   // 페이지당 글의 개수
var viewItem = undefined;   // 가장 최근에 view 한 글의 데이터

var board_type = '전체';
var board_tag = '전체';

var view_uid = 0;
var view_type = "";

$(document).ready(function() {

   //saveRoute("notice")
   //viewPage("notice")
      
   $("#logobtn").click(function() {
      saveRoute("notice")
      viewPage("notice")
   });

   // 글작성 버튼 누르면 팝업
   $("#ntcWrite").click(function(){
      setPopup("write");    // 글 작성 용으로 모달 팝업 셋업
      $("#noticeWrite").show();
   });
   
   // 모달 대화상자 close 버튼 누르면
   $(".modal .close").click(function(){
      $(this).parents(".modal").hide();
   });
   
   // 글 작성 폼 submit 되면
   $("#noticeFrm").submit(function(){
      $(this).parents(".modal").hide();
      
      return chkWrite();  // 새글 등록 submit
   });
     
   // 글 읽기(view) 대화상자에서 '삭제' 버튼 누르면 해당 글 (uid) 삭제 진행
   $("#viewDelete").click(function(){
      if(delete_by_uid($("#noticeWrite input[name='board_uid']").val() , "community")){
         $(this).parents(".modal").hide();   // 삭제 하면 대화상자 닫기
      }
   });      
   
   // 글 읽기(view) 대화상자에서 '수정' 버튼 누르면
   $("#viewUpdate").click(function(){
      setPopup("update");
      // 이미 view 팝업이 듸어진 상태에서 update 팝업으로만 전환.
   });
   
   // 글 수정 완료 버튼 누르면
   $("#updateOk").click(function(){
      chkUpdate();
   });

	$(".modal").click(function(e){	
		var modal = $("#noticeWrite");
		if(modal.has(e.target).length === 0){
			$(this).hide();
		}
		
	});
});

function admNotice () {
   saveRoute("notice")
   viewPage("notice")
}
function admBoard () {
   saveRoute("board")
   viewPage("board")
}
function admReport () {
   saveRoute("report")
   viewPage("report")
}
function admMember () {
   saveRoute("member")
   viewPage("member")
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
	page = 1;
	loadPage(page, "community")
}

// 4. 게시판 태그 토글
function tag_toggle() {
  board_tag = $('#board_tag option:selected').val();
	page = 1;
	loadPage(page, "community")
}

function logout_btn () {
	Swal.fire({
		icon: 'success',
		title: '로그아웃되었습니다.'
		}).then((result) => {
			location.href="/modaconAdmin/logout";
   			});
}

function loadPage(page, type){
	
	if(type == 1) {
		
	}
	$.ajax({
		type : "GET",
		url : "/modaconAdmin/" + type + "List/" + page + "/" + pageRows,
		cache : false,
		data: {
	      type: board_type,
	      tag: board_tag
	    },
		success : function(list, status){
			if(status == "success"){
	            memberList(list, type);
	            //alert("목록 가져오기 성공:  뿌~~")
         }
      }
   });    
   
   
} // end loadPage()

function memberList (jsonObj , type) {
   
      var result = "";
      if(jsonObj.status == "OK"){
         var count = jsonObj.count;
         
         window.page = jsonObj.page;
         window.pageRows = jsonObj.pagerows;
         
         var items = jsonObj.list;
         
         if ( type == "notice") {   // 여기를 바꾸고 
            $("#admin_title").html("공지사항");
            result += "<table>";
            for(var i = 0; i < count; i++) {
               result += "<tr>\n";
   
               result += "<td>" + items[i].board_uid + "</td>\n";
               result += "<td><span class='subject' onclick='viewBoard(" + items[i].board_uid + ")' data-uid='" + items[i].board_uid +"' >" + items[i].subject + "</span></td>\n";
               result += "<td>" + items[i].nickname + "</td>\n";
               result += "<td>" + items[i].regDate + "</td>\n";
               result += `<td><button type='button' onclick="delete_by_uid(`
               result +=  items[i].board_uid + `, '${type}' )" class='btn_delete'>삭제</button></td> `;
               result += "</tr>\n";
            }
            result += "</table>";
            $("#contentNotice tbody").html(result);
            
         }
         else if (type == "community") {
            $("#admin_title").html("커뮤니티");
            result += "<table>";
            for(var i = 0; i < count; i++) {
               result += "<tr>\n";
               
               result += "<td>" + items[i].board_uid + "</td>\n";
               result += "<td><span class='subject' onclick='viewBoard(" + items[i].board_uid + ")' data-uid='" + items[i].board_uid +"' >[" + items[i].tag + "]" + items[i].subject + "</span></td>\n";
               result += "<td>" + items[i].nickname + "</td>\n";
               result += "<td>" + items[i].regDate + "</td>\n";
               result += `<td><button type='button' onclick="delete_by_uid(`
               result +=  items[i].board_uid + `, '${type}' )" class='btn_delete'>삭제</button></td> `;
               result += "</tr>\n";
            }
            result += "</table>";
            $("#contentBoard tbody").html(result);
         }
         else if (type == "report") {
            $("#admin_title").html("신고 리스트");
            for(var i = 0; i < count; i++) {
                  result += "<tr>\n";
                  
                  result += "<td>" + items[i].report_uid + "</td>\n";
                  if(items[i].reportTag == "report1") {
                     result += "<td><span class='subject' onclick='viewBoard(" + items[i].board_uid + ")' data-uid='" + items[i].board_uid +"'>[홍보 및 광고]" ;
                  }
                  else if (items[i].reportTag == "report2") {
                     result += "<td><span class='subject' onclick='viewBoard(" + items[i].board_uid + ")' data-uid='" + items[i].board_uid +"'>[청소년 유해글]" ;
                  }
                  else if (items[i].reportTag == "report3") {
                     result += "<td><span class='subject'onclick='viewBoard(" + items[i].board_uid + ")' data-uid='" + items[i].board_uid +"'>[욕설 비방 혐오]" ;
                  }
                  else if (items[i].reportTag == "report4") {
                     result += "<td><span class='subject' onclick='viewBoard(" + items[i].board_uid + ")' data-uid='" + items[i].board_uid +"'>[기타]" ;
                  }
                  result += items[i].reportContent + "</span></td>\n";
                  result += "<td>" + items[i].board_uid + "</td>\n";
                  result += "<td>" + items[i].nickname + "</td>\n";
                  result += `<td><button type='button' onclick="delete_report(`
                  result +=  items[i].report_uid + `,` + items[i].board_uid + `)" class='btn_delete'>신고취하</button></td> `;
                  
                  result += `<td><button type='button' onclick="delete_by_uid(`
                  result +=  items[i].report_uid + `, '${type}' )" class='btn_delete'>삭제</button></td> `;
                  result += "</tr>\n";
               }
               $("#contentReport tbody").html(result);
         }
         else if (type == "member") {
            $("#admin_title").html("회원정보");
            for(var i = 0 ; i < count ; i++) {
               result += "<tr>\n";
               
               result += "<td>" + items[i].member_uid + "</td>\n";
               result += "<td>" + items[i].email + "</td>\n";
               result += "<td>" + items[i].nickname + "</td>\n";
               result += "<td>" + items[i].phoneNumber + "</td>\n";
               result += "<td><span class='subject' onclick='changeAuth(" + items[i].member_uid + ")' >" + items[i].authority + "</span></td>\n";
               result += `<td><button type='button' onclick="delete_by_uid(`
               result +=  items[i].member_uid + `, '${type}' )" class='btn_delete'>삭제</button></td> `;
               result += "</tr>\n";
            }
            $("#contentMember tbody").html(result);
         
         }
         
         
         
      // 페이지 정보 업데이트
      $("#pageinfo").text(jsonObj.page + "/" + jsonObj.totalpage + "페이지, " + jsonObj.totalcnt + "개의 정보");
      
      
      // pageRows
      var txt = `<select id='rows' onchange="changePageRows('${type}')">`;
      txt += "<option " + ((window.pageRows == 10) ? "selected" : "") + " value='10'>10개씩</option>\n";
      txt += "<option " + ((window.pageRows == 20)?"selected":"") + " value='20'>20개씩</option>\n";
      txt += "<option " + ((window.pageRows == 50)?"selected":"") + " value='50'>50개씩</option>\n";
      txt += "<option " + ((window.pageRows == 100)?"selected":"") + " value='100'>100개씩</option>\n";
      txt += "</select>\n";
      $("#pageRows").html(txt);
      // [페이징] 정보 업데이트
      
      var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page, jsonObj.pagerows, type);
      $("#pagination").html(pagination);
      
      }
      return true;
}

// [커뮤니티 페이징 생성]
function buildPagination(writePages, totalPage, curPage, pageRows, type){
   var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
   
   // 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
       end_page = totalPage;
    }

  //■ << 표시 여부
   if(curPage > 1){
      str += `<li><a onclick="loadPage(` + 1 + `, '${type}' )" class="tooltip-top" title="처음"><i class="fas fa-angle-double-left"></i></a></li>\n`;
   }
     //■  < 표시 여부
    if (start_page > 1) 

       str += `<li><a onclick="loadPage(` + (start_page - 1) + `, '${type}', '${type}' )" class='tooltip-top' title='이전'><i class='fas fa-angle-left'></i></a></li>\n`;
    
    //■  페이징 안의 '숫자' 표시   
   if (totalPage > 1) {
       for (var k = start_page; k <= end_page; k++) {
           if (curPage != k) {
               str += `<li><a onclick="loadPage(` + k + `, '${type}' )">` + k + `</a></li>\n`;
      
         }
           else {
               str += "<li><a class='active' title='현재페이지'>" + k + "</a></li>\n";
         }
       }
   }
   
   //■ > 표시
    if (totalPage > end_page){
       str += `<li><a onclick="loadPage(` + (end_page + 1) + `, '${type}' )" class='tooltip-top' title='다음'><i class='fas fa-angle-right'></i></a></li>\n`;
    }

   //■ >> 표시
    if (curPage < totalPage) {
        str += `<li><a onclick="loadPage(` + totalPage + `, '${type}' )" class='tooltip-top' title='맨끝'><i class='fas fa-angle-double-right'></i></a></li>\n`;
    }
    return str;
   
} // end buildPagination()

// [커뮤니티] <select> 에서 pageRows 값 변경될때마다
function changePageRows(type ){
   window.pageRows = $("#rows").val();
	page = 1;
   loadPage(window.page, type );
}




function saveRoute (route) {
      
      $.ajax( {
      type: 'GET',
      url : "/modaconAdmin/saveroute/" + route,
      cache : false
   } );
}

function viewPage (route) {
   window.page = 1;
   window.pageRows = 10;
   
   if(route=="notice")  {
      loadPage(page, "notice");
      $("#adm_content").show();
      $("#contentNotice").show();
      $("#contentBoard").hide();
      $("#contentReport").hide();
      $("#contentMember").hide();
   }
   
   if(route=="board")  {
      loadPage(page, "community");
      $("#adm_content").show();
      $("#contentNotice").hide();
      $("#contentBoard").show();
      $("#contentReport").hide();
      $("#contentMember").hide();
   }
   
   if(route=="report")  {
      loadPage(page, "report");
      $("#adm_content").show();
      $("#contentNotice").hide();
      $("#contentBoard").hide();
      $("#contentReport").show();
      $("#contentMember").hide();
   }
   
   if(route=="member")  {
      loadPage(page, "member");
      $("#adm_content").show();
      $("#contentNotice").hide();
      $("#contentBoard").hide();
      $("#contentReport").hide();
      $("#contentMember").show();
   }
   
   
}



// 글 쓰기 / 읽기 / 수정 대화상자 세팅
function setPopup(mode) {
   
   // 글 작성
   if(mode == "write"){
      $('#noticeFrm')[0].reset();  // form 내의 기존 내용 reset
      $("#noticeWrite .title").text("새글 작성");
      $("#noticeWrite .ntc_group_header").hide();
      $("#noticeWrite .ntc_group_write").show();
      $("#noticeWrite .ntc_group_view").hide();
      $("#noticeWrite .ntc_group_update").hide();
      
      $("#noticeWrite input[name='subject']").attr("readonly", false);
      $("#noticeWrite input[name='subject']").css("border", "1px solid #ccc");

      $("#noticeWrite input[name='nickname']").attr("readonly", true);
      $("#noticeWrite input[name='nickname']").css("border", "none");

      $("#noticeWrite textarea[name='content']").attr("readonly", false);
      $("#noticeWrite textarea[name='content']").css("border", "1px solid #ccc");
   }
   
   // 글 읽기
   if(mode == "view"){

      $("#noticeWrite .title").text("글 읽기");
      $("#noticeWrite .ntc_group_header").show();
      $("#noticeWrite .ntc_group_write").hide();
      $("#noticeWrite .ntc_group_view").show();
		if(window.view_type != "공지") {
	      $("#noticeWrite #viewUpdate").hide();
		} else {
	      $("#noticeWrite #viewUpdate").show();
		}
		
      $("#noticeWrite .ntc_group_update").hide();
      
      $("#noticeWrite input[name='subject']").attr("readonly", true);
      $("#noticeWrite input[name='subject']").css("border", "none");
      
      $("#noticeWrite input[name='nickname']").attr("readonly", true);
      $("#noticeWrite input[name='nickname']").css("border", "none");
      
      $("#noticeWrite textarea[name='content']").attr("readonly", true);
      $("#noticeWrite textarea[name='content']").css("border", "none");
   }
   
   // 글 수정
   if(mode == "update"){
      
      $("#noticeWrite .title").text("글 수정");
      
      $("#noticeWrite .ntc_group_header").show();
      $("#noticeWrite .ntc_group_write").hide();
      $("#noticeWrite .ntc_group_view").hide();
      $("#noticeWrite .ntc_group_update").show();
      
      $("#noticeWrite input[name='subject']").attr("readonly", false);
      $("#noticeWrite input[name='subject']").css("border", "1px solid #ccc");
      $("#noticeWrite input[name='nickname']").attr("readonly", true);   // 작성자는 수정 불가
      $("#noticeWrite input[name='nickname']").css("border", "1px solid #ccc");
      $("#noticeWrite textarea[name='content']").attr("readonly", false);
      $("#noticeWrite textarea[name='content']").css("border", "1px solid #ccc");
   }
   
   
} // end setPopup()

function viewBoard(uid) {
	$.ajax({
		url : "/modaconAdmin/board/"+ uid,  // url : /board
		type : "GET",
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK") {
					
					var list = data.list[0];
					$("#noticeWrite #viewcnt").text("#" + list["board_uid"] + " - 조회수: " + list["count"]);
					$("#noticeWrite #regdate").text(list["regDate"]);
					
					$("#noticeWrite input[name='subject']").val(list["subject"])
					$("#noticeWrite input[name='name']").val(list["nickname"]);
					$("#noticeWrite textarea[name='content']").val(list["content"]);
					
					window.view_uid = list["board_uid"];
					window.view_type = list["type"];
					
					setPopup("view");
					$("#noticeWrite").show();
				}
				else {
					alert("해당 글이 존재하지 않습니다.");
				}
			}
		}
	});
	
	
	

}



// 해당 type 의 데이터를 uid로 골라 삭제 
function delete_by_uid (uid, type) {
	if(!confirm(uid + "글을 삭제하시겠습니까?")) return false;
   var url;
   if ( type == "notice") {
      url = "board";
   }
   else if (type == "community") {
      url = "board";      
   }
   else if (type == "report") {
      url = "report";            
   }
   else if (type == "member") {
      url = "member";                  
   }
   $.ajax({
      url : "/modaconAdmin/" + url,
      type : "DELETE",
      data : "uid=" +uid,
      cache : false,
      success : function (data) {
         alert(data + " 개의 데이터가 삭제되었습니다!");
         location.reload();
      }
   
   });
}
function delete_report (report_uid , board_uid) {
	if(!confirm(uid + "번째 신고를 삭제하시겠습니까?")) return false;
   $.ajax({
      url : "/modaconAdmin/report/" + board_uid,
      type : "DELETE",
      data : "report_uid" + report_uid,
      cache : false,
      success : function (data) {
         
         alert("신고가 취하되었습니다");
         location.reload();
      }
   
   });
}
// 새글 등록 처리
function chkWrite(){
	
	// 특정 form 의 name 달린 form element 들의 value 들을 string 으로 묶기
	// ex) name=aaa&subject=bbb&content=ccc   <-- string 타입이다
	var data = $("#noticeFrm").serialize();
	
	$.ajax({
		url : "/modaconAdmin/board",  // url : /board
		type : "POST",
		cache : false,
		data : data,  // POST 로 ajax request 할 경우 data 에 parameter 넘기기
		
		success : function(data, status){
			if(status == "success"){
				if(data) {
					alert("글 작성 완료!");
					loadPage(1, "notice");
				}
				else {
					alert("글 작성 실패");
				}
			}
		}
	});
	
	return false;
	
} // end chkWrite()


// 글 수정
function chkUpdate(){
   
   var data = $("#noticeFrm").serialize();
   data = data + "&board_uid=" + view_uid;
   // PUT 방식 
   $.ajax({
      url : "/modaconAdmin/board",  // URL: /board
      type : "PUT",
      cache : false,
      data : data, 
      success : function(data){
			if(data) {
				alert("글 수정 완료!");
				loadPage(1, "notice");
			}
			else {
				alert("글 수정 실패");
			}
            //현재 팝업 닫기
            $("#noticeWrite").hide();
      }
   });
}

