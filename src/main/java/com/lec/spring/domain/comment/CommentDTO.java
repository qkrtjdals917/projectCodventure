package com.lec.spring.domain.comment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;

@Data
public class CommentDTO {
	private int comment_uid;
	private int member_uid;
	private int board_uid;
	private String content;
	private LocalDateTime regDate;
	private String nickname;

	public String getRegDateTime() {
		if(this.regDate == null) return "";
		return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}
	// 생성일 넣어야되나? 
}
