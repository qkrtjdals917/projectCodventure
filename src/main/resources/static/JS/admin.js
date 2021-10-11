var page = 1;   // 현재 페이지
var pageRows = 10;   // 페이지당 글의 개수
var viewItem = undefined;   // 가장 최근에 view 한 글의 데이터

$(document).ready(function() {
	// 페이지 최초 로딩되면 1페이지 내용을 로딩
	// loadPage(page); // 특정 페이지를 로딩하는 것
	
	$("#admNotice").click(function() {
		saveRoute("notice")
		viewPage("notice")
		loadPageNtc(page);
		//noticeList(1,10);
	});
	
	$("#admBoard").click(function() {
		saveRoute("board")
		viewPage("board")
		loadPageCmt(page);
		//communityList(1,10);
	});
	
	$("#admReport").click(function() {
		saveRoute("report")
		viewPage("report")
		
	});
	
	$("#admMember").click(function() {
		saveRoute("member")
		viewPage("member")
		//memberList(1,10);
	});
	
	$("#logobtn").click(function() {
		saveRoute("main")
		viewPage("main")
	});
});


/*

$(document).ready(function() {
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
	
	// 글 삭제 버튼 누르면
	$("#ntcDle").click(function(){
		chkDelete();
	});
		
		
	// 글 읽기(view) 대화상자에서 '삭제' 버튼 누르면 해당 글 (uid) 삭제 진행
	$("#viewDelete").click(function(){
		if(deleteUid(viewItem.uid)){
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
});

*/




// 페이징
function loadPageNtc(page) {
 	$.ajax({
		url : "/modacon/admin/noticeList/" + page + "/" + pageRows,
		type : "GET",
		cache : false,
		success : function(list, status) {
			if(status == "success"){
				noticeList(list);
				
			}else{
			}
		}
		
	}); // end ajax
} // end loadPage




function noticeList (jsonObj) {
		var result = "";
			
		if(jsonObj.status == "OK") {
			
			var count = jsonObj.count;
			
			window.page = jsonObj.page;
			window.pagerows = jsonObj.pagerows;
		
			var items = jsonObj.list;
			
			for(var i = 0; i < count; i++) {
				result += "<tr>\n";

				result += "<td><input type='checkbox' name='board_uid' value='" + items[i].board_uid + "'></td>\n";
				result += "<td>" + items[i].board_uid + "</td>\n";
				result += "<td><span class='subject' data-uid='" + items[i].board_uid +"'>" + items[i].subject + "</span></td>\n";
				result += "<td>" + items[i].nickname + "</td>\n";
				result += "<td>" + items[i].regDateTime + "</td>\n";
				result += "<td><input type='button' id='community_delete' class='delete_btn' value='삭제'></td>"
				
				result += "</tr>\n";
			}
			$("#contentNotice tbody").html(result);
		
		
		// 페이지 정보 업데이트
		$("#pageinfo").text(jsonObj.page + "/" + jsonObj.totalpage + "페이지, " + jsonObj.totalcnt + "개의 글");
		
		
		// pageRows
		var txt = "<select id='rows' onchange='changePageRows()'>\n";
		txt += "<option " + ((window.pageRows == 10)?"selected":"") + " value='10'>10개씩</option>\n";
		txt += "<option " + ((window.pageRows == 20)?"selected":"") + " value='20'>20개씩</option>\n";
		txt += "<option " + ((window.pageRows == 50)?"selected":"") + " value='50'>50개씩</option>\n";
		txt += "<option " + ((window.pageRows == 100)?"selected":"") + " value='100'>100개씩</option>\n";
		txt += "</select>\n";
		$("#pageRows").html(txt);
		$("#pageRows").html(txt);
		
		// [페이징] 정보 업데이트
		var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page, jsonObj.pagerows);
		$(".pagination").html(pagination);
		
		} else{
			alert("내용이 없습니다");
			return false;
		}
	}




// [페이징] 생성
// 한 [페이징]에 표시될 페이지수 --> writePages
// 총 페이지수 --> totalPage
// 현재 페이지 --> curPage
function buildPagination(writePages, totalPage, curPage, pageRows){
	// alert(page + "몇개");
	alert(writePages + "개" + totalPage + "개" + curPage + "개" + pageRows);
	
	var str = "";   // 최종적으로 페이징에 나타날 HTML 문자열 <li> 태그로 구성
	
	// 페이징에 보여질 숫자들 (시작숫자 start_page ~ 끝숫자 end_page)
    var start_page = ( (parseInt( (curPage - 1 ) / writePages ) ) * writePages ) + 1;
    var end_page = start_page + writePages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }

  //■ << 표시 여부
	if(curPage > 1){
		str += "<li><a onclick='loadPage(" + 1 + ")' class='tooltip-top' title='처음'><i class='fas fa-angle-double-left'></i></a></li>\n";
	}
  	//■  < 표시 여부
    if (start_page > 1) 
    	str += "<li><a onclick='loadPage(" + (start_page - 1) + ")' class='tooltip-top' title='이전'><i class='fas fa-angle-left'></i></a></li>\n";
    
    //■  페이징 안의 '숫자' 표시	
	if (totalPage > 1) {
	    for (var k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li><a onclick='loadPage(" + k + ")'>" + k + "</a></li>\n";
	        else
	            str += "<li><a class='active tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	
	//■ > 표시
    if (totalPage > end_page){
    	str += "<li><a onclick='loadPage(" + (end_page + 1) + ")' class='tooltip-top' title='다음'><i class='fas fa-angle-right'></i></a></li>\n";
    }

	//■ >> 표시
    if (curPage < totalPage) {
        str += "<li><a onclick='loadPage(" + totalPage + ")' class='tooltip-top' title='맨끝'><i class='fas fa-angle-double-right'></i></a></li>\n";
    }
	alert(str);
    return str;
	
} // end buildPagination()




// <select> 에서 pageRows 값 변경될때마다
function changePageRows(){
	window.pagerows = $("#rows").val();
	loadPageNtc(window.page);
}



// 커뮤니티 페이징
function loadPageCmt(page) {
 	$.ajax({
		url : "/modacon/admin/communityList/" + page + "/" + pageRows,
		type : "GET",
		cache : false,
		success : function(list, status) {
			if(status == "success"){
				communityList(list);
				
			} else {
			}
		}
		
	}); // end ajax
} // end loadPage


function communityList (jsonObj) {	
			var result = "";
			
		if(jsonObj.status == "OK") {
			
			var count = jsonObj.count;
			
			window.page = jsonObj.page;
			window.pagerows = jsonObj.pagerows;
			
			var items = jsonObj.list;
			
			for(var i = 0; i < count; i++) {
				result += "<tr>\n";

				result += "<td><input type='checkbox' name='board_uid' value='" + items[i].board_uid + "'></td>\n";
				result += "<td>" + items[i].board_uid + "</td>\n";
				result += "<td><span class='subject' data-uid='" + items[i].board_uid +"'>[" + items[i].tag + "]" + items[i].subject + "</span></td>\n";
				result += "<td>" + items[i].nickname + "</td>\n";
				result += "<td>" + items[i].regDateTime + "</td>\n";
				result += "<td><input type='button' id='community_delete' class='delete_btn' value='삭제'></td>"
				result += "</tr>\n";
			}
			$("#contentBoard tbody").html(result);
		// 페이지 정보 업데이트
		$("#pageinfo").text(jsonObj.page + "/" + jsonObj.totalpage + "페이지, " + jsonObj.totalcnt + "개의 글");
		
		
		// pageRows
		var txt = "<select id='rows' onchange='changePageRows()'>\n";
		txt += "<option " + ((window.pageRows == 10)?"selected":"") + " value='10'>10개씩</option>\n";
		txt += "<option " + ((window.pageRows == 20)?"selected":"") + " value='20'>20개씩</option>\n";
		txt += "<option " + ((window.pageRows == 50)?"selected":"") + " value='50'>50개씩</option>\n";
		txt += "<option " + ((window.pageRows == 100)?"selected":"") + " value='100'>100개씩</option>\n";
		txt += "</select>\n";
		$("#pageRows").html(txt);
		$("#pageRows").html(txt);
		
		// [페이징] 정보 업데이트
		var pagination = buildPagination(jsonObj.writepages, jsonObj.totalpage, jsonObj.page, jsonObj.pagerows);
		$(".pagination").html(pagination);
		
		}

}



function memberList (page, pageRows) {
	//alert("가져오고 있니?")
	$.ajax( {
		type: 'GET',
		url : "/modacon/admin/memberList/" + page + "/" + pageRows,
		cache : false,
		success : function(data, status) {
			var result = "";

			var count = data.count;
			
			var items = data.list;
			
			for(var i = 0 ; i < count ; i++) {
				result += "<tr>\n";

				result += "<td><input type='checkbox' name='member_uid' value='" + items[i].member_uid + "'></td>\n";
				result += "<td>" + items[i].member_uid + "</td>\n";
				result += "<td>" + items[i].email + "</td>\n";
				result += "<td>" + items[i].nickname + "</td>\n";
				result += "<td>" + items[i].phoneNumber + "</td>\n";
				result += "<td>" + items[i].authority + "</td>\n";
				result += "<td><input type='button' id='member_delete' class='delete_btn' value='삭제'></td>"
				result += "</tr>\n";
			}
			$("#contentMember tbody").html(result);
		
		}
		
	
	} );

}

function saveRoute (route) {
		
		$.ajax( {
		type: 'GET',
		url : "/modacon/admin/saveroute/" + route,
		cache : false
	} );
}

function viewPage (route) {
	if(route=="main") {
		$("#contentMain").show();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").hide();
	}
	
	if(route=="notice")  {
		// noticeList(1,10);
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").show();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").hide();
	}
	
	if(route=="board")  {
		communityList(1,10);
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").show();
		$("#contentReport").hide();
		$("#contentMember").hide();
	}
	
	if(route=="report")  {
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").hide();
		$("#contentReport").show();
		$("#contentMember").hide();
	}
	
	if(route=="member")  {
		memberList(1,10);
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").show();
	}
	
	
}

/*

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
		$("#noticeWrite input[name='nickname']").attr("readonly", false);
		$("#noticeWrite input[name='nickname']").css("border", "1px solid #ccc");
		$("#noticeWrite textarea[name='content']").attr("readonly", false);
		$("#noticeWrite textarea[name='content']").css("border", "1px solid #ccc");
	}
	
	// 글 읽기
	if(mode == "view"){

		$("#noticeWrite .title").text("글 읽기");
		$("#noticeWrite .ntc_group_header").show();
		$("#noticeWrite .ntc_group_write").hide();
		$("#noticeWrite .ntc_group_view").show();
		$("#noticeWrite .ntc_group_update").hide();
		
		$("#noticeWrite #viewcnt").text("#" + viewItem.uid + " - 조회수: " + viewItem.viewcnt);
		$("#noticeWrite #regdate").text(viewItem.regdate);
		
		$("#noticeWrite input[name='uid']").val(viewItem.uid);   // 나중에 삭제나 수정을 위해 필요
		
		$("#noticeWrite input[name='subject']").val(viewItem.subject)
		$("#noticeWrite input[name='subject']").attr("readonly", true);
		$("#noticeWrite input[name='subject']").css("border", "none");
		
		$("#noticeWrite input[name='nickname']").val(viewItem.nickname);
		$("#noticeWrite input[name='nickname']").attr("readonly", true);
		$("#noticeWrite input[name='nickname']").css("border", "none");
		
		$("#noticeWrite textarea[name='content']").val(viewItem.content);
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

*/

/*
// 특정 uid 의 글 삭제하기
function deleteByChk(uid){
	
	if(!confirm(uid + "글을 삭제하시겠습니까?")) return false;
	
	// DELETE 방식
	$.ajax({
		url : ".",  // URL : /board
		type : "DELETE",
		data : "uid=" + uid,
		cache : false,
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){
					alert("DELETE성공: " + data.count + "개"); 
					loadPage(window.page);  // 현재 페이지 리로딩
				} else {
					alert("DELETE실패: " + data.message);
					return false;
				}
			}
		}
	});
	
	return true;
} // end deleteUid()

*/

/*

// 글 수정
function chkUpdate(){
	
	var data = $("#frmWrite").serialize();
	
	// PUT 방식 
	$.ajax({
		url : ".",  // URL: /board
		type : "PUT",
		cache : false,
		data : data, 
		
		success : function(data, status){
			if(status == "success"){
				if(data.status == "OK"){
					alert("UPDATE성공: " + data.count + "개");
					loadPage(window.page);   // 현재 페이지 리로딩
				} else {
					alert("UPDATE실패: " + data.staus + " : " + data.message);
				}
				
				//현재 팝업 닫기
				$("#noticeWrite").hide();
			}
		}
	});
}

*/

