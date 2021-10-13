// 1. 업데이트 페이지 접속 시 오류
function err_alert() {
  Swal.fire({
    icon: 'error',
    title: '정보 오류',
    text: ERR
  }).then((result) => {
    history.back();
  });
}

// 2. 게시판 토글
function type_toggle() {
  board_type = $('#board_type option:selected').val();
  if (board_type == '정보') {
    $('#board_tag').val("").prop("selected", true);
    $('.info_sel').show();
    $('.free_sel').hide();
    board_tag = $('#board_tag option:selected').val();
  } else if (board_type == '자유') {
    $('#board_tag').val("").prop("selected", true);
    $('.info_sel').hide();
    $('.free_sel').show();
    board_tag = $('#board_tag option:selected').val();
  }
}

// 3. 페이지 실행시 셀렉터 세팅
function select_set() {
  if (board_type == '정보') {
    $('.info_sel').show();
    $('.free_sel').hide();
  } else {
    $('.info_sel').hide();
    $('.free_sel').show();
  }
  $('#board_type').val(board_type).prop("selected", true);
  $('#board_tag').val(board_tag).prop("selected", true);
}

// 4. 게시글 수정
function update_chk() {
  var content = $('#content').val().trim();
  var subject = $('#subject').val().trim();
  var member_uid = $('#member_uid').val();
  if (member_uid == null) {
    Swal.fire({
      icon: 'error',
      title: '로그인 오류',
      text: '로그인 하지 않았습니다. 로그인 해주세요.'
    });
    return;
  } else if (subject == null || subject == "") {
    Swal.fire({
      icon: 'warning',
      title: '제목 입력',
      text: '제목을 입력해주세요.'
    });
    return;
  } else if (content == null || content == "" || content.length < 3) {
    Swal.fire({
      icon: 'warning',
      title: '내용 입력',
      text: '글 내용을 최소 3글자 이상 입력해주세요.'
    });
    return;
  }

  var data = $('#frm').serialize();

  $.ajax({
    url: "",
    type: "PUT",
    cache: false,
    data: data,
    success: function (data, status) {
      if (status == "success") {
        if (data.status == "OK") {
          Swal.fire({
            title: '글 수정 완료',
            text: '글 수정을 완료했습니다.',
            icon: 'success',
            preConfirm: () => {
              location.href = 'view?uid=' + data.uid;
            }
          });
        } else {
          Swal.fire({
            title: '글 수정 오류',
            text: '글 수정 실패 : ' + data.message,
            icon: 'error'
          });
        }
      }
    }
  });

}