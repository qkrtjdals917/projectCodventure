package com.lec.spring.domain.comment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentDTO {
	private int comment_uid;		// X 자동생성
	private int member_uid;			// session 에서 가져옴
	private int board_uid;			// url 에서 @PathVariable 로 가져옴
	private String content;			// form 문에서
	private LocalDateTime regDate;	// X 자동생성
	private String nickname;		// session 에서 가져옴

	public String getRegDateTime() {
		if(this.regDate == null) return "";
		return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}

	@Override
	public String toString() {
		return "CommentDTO [comment_uid=" + comment_uid + ", member_uid=" + member_uid + ", board_uid=" + board_uid
				+ ", content=" + content + ", regDate=" + regDate + ", nickname=" + nickname + "]";
	}
	
	
	// 생성일 넣어야되나? 
}
