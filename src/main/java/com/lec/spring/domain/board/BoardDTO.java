package com.lec.spring.domain.board;

import java.time.LocalDateTime;
import java.util.List;

import com.lec.spring.domain.like.LikeDTO;

import lombok.Data;


@Data
public class BoardDTO {
	private int board_uid;
	private int member_uid;
	private String type;
	private String subject;
	private String tag;
	private LocalDateTime regDate;
	private int count;
	private String content;
	
	private List<LikeDTO> like;
	// 댓글List도 가지고 있어야되나? 혹은 따로 가져와야되나?
	
}