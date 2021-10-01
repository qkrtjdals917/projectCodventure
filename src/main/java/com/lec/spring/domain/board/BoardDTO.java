package com.lec.spring.domain.board;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;


import lombok.Data;


@Data
public class BoardDTO {
	private int board_uid;
	private String subject;
	private String nickname;
	private LocalDateTime regDate;
	private int count;
	private String content;			// 글
	private String type;			// 게시판
	private String tag;				// 태그
	private String likeCnt;
	
	public String getRegDateTime() {
		if(this.regDate == null) return "";
		return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}


}