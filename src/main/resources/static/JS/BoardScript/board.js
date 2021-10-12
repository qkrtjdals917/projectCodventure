// view
// 1. 글 존재 확인
function view_chk() {
  Swal.fire({
    icon: 'error',
    title: '정보 오류',
    text: '해당 글이 삭제됐거나 없습니다.'
  }).then((result) => {
    history.back();
  });
};

// 2. 로그인 확인
function not_Login_msg() {
  Swal.fire({
    icon: 'error',
    title: '로그인 오류',
    text: '로그인 하지 않았습니다. 로그인 해주세요.'
  });
}

// 3. 프론트 삭제 제약사항
function chkDelete() {
  if (member_null) {
    not_Login_msg();
    return;
  }

  Swal.fire({
    title: '글 삭제',
    text: "해당 글을 삭제하시겠습니까? 삭제 후 다시 복구 할 수 없습니다.",
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: '삭제',
    cancelButtonText: '취소'
  }).then((result) => {
    if (result.isConfirmed) {
      if ("${list[0].member_uid }" == "${member.member_uid}") {
        location.href = "delete?uid=" + "${list[0].board_uid}";
      } else {
        Swal.fire(
          '삭제 실패',
          '해당 글의 작성자가 아닙니다.',
          'error'
        )
      }
    }
  });
}

// 4. 프론트 수정 제약사항
function chkUpdate() {
  if (member_null) {
    not_Login_msg();
    return;
  }

  Swal.fire({
    title: '글 수정',
    text: "해당 글을 수정 하시겠습니까?",
    icon: 'question',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: '수정',
    cancelButtonText: '취소'
  }).then((result) => {
    if (result.isConfirmed) {
      if (board_mem_uid == member_uid) {
        location.href = "update?uid=" + board_uid;
      } else {
        Swal.fire(
          '수정 실패',
          '해당 글의 작성자가 아닙니다.',
          'error'
        )
      }
    }
  });
}

// 5. 추천 버튼
function chkLike() {
  if (member_null) {
    not_Login_msg();
    return;
  }

  Swal.fire({
    title: '추천',
    text: "해당 글을 추천 하시겠습니까?",
    icon: 'question',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: '추천',
    cancelButtonText: '취소'
  }).then((result) => {
    if (result.isConfirmed) {
      $.ajax({
        url: "like",
        type: "POST",
        data: {
          board_uid: board_uid,
          member_uid: member_uid
        },
        success: function () {
          likeCount();
        },
      })
    }
  });
}
// 추천수
function likeCount() {
  $.ajax({
    url: "likeCount",
    type: "POST",
    data: {
      uid: board_uid
    },
    success: function (count) {
      $("#likeCount").html(count);
    },
  })
}

// 6. 신고
function chkReport() {
  if (member_null) {
    not_Login_msg();
    return;
  }

  Swal.fire({
    title: "신고",
    html: '<select id="report_tag" class="swal2-select">' +
      '<option value="" disabled selected hidden>신고사유를 선택해주세요.</option>' +
      '<option value="report1">홍보 및 광고</option>' +
      '<option value="report2">청소년 유해글</option>' +
      '<option value="report3">욕설 비방 혐오</option>' +
      '<option value="report4">기타</option>' +
      '</select>',
    input: 'textarea',
    inputPlaceholder: '신고내용을 입력해주세요.',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: '신고',
    cancelButtonText: '취소',
    preConfirm: () => {
      var rep_tag = document.getElementById('report_tag').value;
      var rep_content = Swal.getInput().value.trim();
      if(rep_tag == ""){
        Swal.fire({
          icon: "error",
          text: "신고사유를 선택해주세요.",
          preConfirm: () => {
            chkReport();
          }
        });
        return;
      }
      
      if(rep_content == ""){
        Swal.fire({
          icon: "error",
          text: "신고내용을 입력해주세요.",
          preConfirm: () => {
            chkReport();
          }
        });
        return;
      }

      $.ajax({
        url: "report",
        type: "POST",
        data: {
          board_uid: board_uid,
          report_tag: rep_tag,
          report_content: rep_content, 
          member_uid: member_uid
        },
        success: function () {
          Swal.fire({
            title: '신고완료',
            text: '신고가 완료됐습니다.',
            icon: 'success'
          });
        },
      })
    }
  });
}

// 7. 댓글 토글
function comment_toggle(){
  $('#comment_area').toggle();
}