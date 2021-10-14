var board_uid;

function add_comment(uid) {
	$.ajax({
		type: 'POST',
		url: "/modacon/board/addComment/" + uid,
		data: $("#commentForm").serialize(),
		dataType: 'text',
		success: function(data) {
			if (data == "success") {
				getCommentList(uid);
				$("#commentContent").val("");
			}
			if (data == "fail") {
				alert("댓글 저장에 실패했습니다.");
			}
		},
		error: function(request, status, error) {
			alert(status);
			alert(error);
		}

	});
}

/**
 * 초기 페이지 로딩시 댓글 불러오기
 */
$(function() {
	getCommentList(board_uid);

});

/**
 * 댓글 불러오기(Ajax)
 */

function getCommentList(uid) {

	$.ajax({
		type: 'GET',
		url: "/modacon/board/getComment/" + uid,
		cache: false,
		success: function(data) {

			var html = "";
			var list = data.list;
			var count = data.count;

			if (count > 0) {
				html += "<table class='table'><tr>";
				for (i = 0; i < count; i++) {
					html += "<tr><td>" + list[i].nickname + "</td>";
					html += "<td>" + list[i].content + "</td>";
					html += "<td>" + list[i].regDateTime + "</td>";
					//html += "<td><button id='update_comment_btn" + list.comment_uid + "'>수정</button></td>";

					html += "<td><button type='button' onclick='delete_comment(" + list[i].comment_uid + "," + list[i].member_uid + ")' id='delete_comment_btn" + list[i].comment_uid + "'>삭제</button></td></tr>";

				}
				html += "</table>"
			} else {

				html += "<div><table class='table'><h6><strong>등록된 댓글이 없습니다.</strong></h6>";
				html += "</table></div>";

			}

			$("#cCnt").html(count);
			$("#commentList").html(html);

		},
		error: function(request, status, error) {

		}

	});
}

// 댓글 삭제
function delete_comment(comment_uid, member_uid) {
	Swal.fire({
		title: '댓글 삭제',
		text: "해당 댓글을 삭제하시겠습니까? 삭제 후 다시 복구 할 수 없습니다.",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '삭제',
		cancelButtonText: '취소'
	}).then((result) => {
		if (result.isConfirmed) {
			if (member_uid == commenter) {
				$.ajax({
					url: "/modacon/board/deleteComment/" + comment_uid,
					type: "GET",
					async: false,
					cache: false,
					success: function(data, status) {
						Swal.fire({
							title: '댓글 삭제',
							text: '해당 댓글이 삭제되었습니다.',
							icon: "success"
						});
						getCommentList(board_uid);

					}
				});
			} else {
				Swal.fire(
					'삭제 실패',
					'해당 댓글의 작성자가 아닙니다.',
					'error'
				)
			}
		}
	});
} // end delete_comment();