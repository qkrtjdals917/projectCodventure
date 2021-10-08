package com.lec.spring.domain.member;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class MemberVO {
	private int member_uid;
	private String email;
	private String pw;				// DB는 password 
	private String nickname;
	private String phoneNumber;		// 폰번호 ***-****-**** 인데 나눠서 또 저장? -> 번호가 null값으로 가져와 진다 수정 필요
	private int authority;
	@JsonIgnore
	public String getPhonenum1 () {
		if(!phoneNumber.isEmpty()) {
			return phoneNumber.split("-")[0];
		}
		return "";
	}
	@JsonIgnore
	public String getPhonenum2 () {
		if(!phoneNumber.isEmpty()) {
			return phoneNumber.split("-")[1];
		}
		return "";
	}
	@JsonIgnore
	public String getPhonenum3 () {
		if(!phoneNumber.isEmpty()) {
			return phoneNumber.split("-")[2];
		}
		return "";
	}

	public String toString() {
		return String.format("%s %s %s %s", email, pw, nickname, phoneNumber);
	}
	
}
