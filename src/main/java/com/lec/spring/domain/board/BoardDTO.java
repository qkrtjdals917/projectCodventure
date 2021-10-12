package com.lec.spring.domain.board;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;


public class BoardDTO {
	private int board_uid;
	private String subject;
	private String nickname;
	private LocalDateTime regDate;
	private int count;
	private String content;			// 글
	private String type;			// 게시판
	private String tag;				// 태그
	private String likeCnt;			// 추천수
	private String member_uid;		// 글작성, 수정 시 사용
	
	
	public int getBoard_uid() {
		return board_uid;
	}

	public void setBoard_uid(int board_uid) {
		this.board_uid = board_uid;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	@JsonIgnore
	public LocalDateTime getRegDate() {
		return regDate;
	}

	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
	}
	
	@JsonProperty("regDate")
	public String getRegDateTime() {
		if(this.regDate == null) return "";
		return this.regDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss"));
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(String likeCnt) {
		this.likeCnt = likeCnt;
	}

	public String getMember_uid() {
		return member_uid;
	}

	public void setMember_uid(String member_uid) {
		this.member_uid = member_uid;
	}


}