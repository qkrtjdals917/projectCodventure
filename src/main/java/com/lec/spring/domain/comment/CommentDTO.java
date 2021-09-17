package com.lec.spring.domain.comment;

import lombok.Data;

@Data
public class CommentDTO {
	private int comment_uid;
	private int member_uid;
	private int board_uid;
	private String content;
	
}
