$(document).ready(function() {
	
	$("#admNotice").click(function() {
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").show();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").hide();
		
		noticeUpdateList(1,10);

		
	});
	
	$("#admBoard").click(function() {
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").show();
		$("#contentReport").hide();
		$("#contentMember").hide();
	});
	
	$("#admReport").click(function() {
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").hide();
		$("#contentReport").show();
		$("#contentMember").hide();
	});
	
	$("#admMember").click(function() {
		$("#contentMain").hide();
		$("#adm_content").show();
		$("#contentNotice").hide();
		$("#contentBoard").hide();
		$("#contentReport").hide();
		$("#contentMember").show();
	});
	
	
});

function noticeUpdateList (page, pageRows) {
	$.ajax( {
		type: 'GET',
		url : "./noticeList/" + page + "/" + pageRows,
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