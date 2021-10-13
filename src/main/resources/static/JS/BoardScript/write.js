// 1. 게시판 토글
function type_toggle() {
  var board_type = $('#board_type option:selected').val();
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

// 2. 글쓰기
function write_chk() {
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
    type: "POST",
    cache: false,
    data : data,
    success : function (data, status) {
      if(status == "success"){
        if(data.status == "OK"){
          Swal.fire({
              title: '글 작성 완료',
              text: '글 작성을 완료했습니다.',
              icon: 'success',
              preConfirm: () => {
                location.href = 'view?uid=' + data.uid;
              }
          });
        }
      }
    }
  });
}