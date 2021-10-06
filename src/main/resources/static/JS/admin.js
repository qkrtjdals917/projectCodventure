$(document).ready(function() {

	
	$("#admNotice").click(function() {
		saveRoute("notice")
		viewPage("notice")
		
		//noticeUpdateList(1,10);
		
		
	});
	
	$("#admBoard").click(function() {
		saveRoute("board")
		viewPage("board")

	});
	
	$("#admReport").click(function() {
		saveRoute("report")
		viewPage("report")
		
	});
	
	$("#admMember").click(function() {
		saveRoute("member")
		viewPage("member")
		
	});
	
	$("#logobtn").click(function() {
		saveRoute("main")
		viewPage("main")
	});
});

function noticeUpdateList (page, pageRows) {
	$.ajax( {
		type: 'GET',
		url : "modacon/admin/noticeList/" + page + "/" + pageRows,
		cache : false,
		success : function(data, status) {
			var result = "";
			if(status == "success") {
				var count = data.count;
				
				var items = data.list;
				
				for(var i = 0 ; i < count ; i++) {
					result += "<tr>\n";
	
					result += "<td><input type='checkbox' name='board_uid' value='" + items[i].board_uid + "'></td>\n";
					result += "<td>" + items[i].board_uid + "</td>\n";
					result += "<td><span class='subject' data-uid='" + items[i].board_uid +"'>[" + items[i].tag + "]" + items[i].subject + "</span></td>\n";
					result += "<td>" + items[i].nickname + "</td>\n";
					result += "<td>" + items[i].regdate + "</td>\n";
					result += "<td><input type='button' id='notice_delete' class='delete_btn' value='삭제'></td>"
					result += "</tr>\n";
				}
				$("#adm_content tbody").html(result);
			}
		}
	} );
}

function communityUpdateList (page, pageRows) {
	$.ajax( {
		type: 'GET',
		url : "modacon/admin/communityList/" + page + "/" + pageRows,
		cache : false,
		success : function(data, status) {
			var result = "";
			if(status == "success") {
				var count = data.count;
				
				var items = data.list;
				
				for(var i = 0 ; i < count ; i++) {
					result += "<tr>\n";
	
					result += "<td><input type='checkbox' name='board_uid' value='" + items[i].board_uid + "'></td>\n";
					result += "<td>" + items[i].board_uid + "</td>\n";
					result += "<td><span class='subject' data-uid='" + items[i].board_uid +"'>[" + items[i].tag + "]" + items[i].subject + "</span></td>\n";
					result += "<td>" + items[i].nickname + "</td>\n";
					result += "<td>" + items[i].regdate + "</td>\n";
					result += "<td><input type='button' id='notice_delete' class='delete_btn' value='삭제'></td>"
					result += "</tr>\n";
				}
				$("#adm_content tbody").html(result);
			}
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
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").show();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").hide();
	}
	
	if(route=="board")  {
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
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").show();
	}
	
	
}






