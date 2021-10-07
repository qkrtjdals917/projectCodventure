package com.lec.spring.domain.member;

import lombok.Data;

@Data
public class MemberDTO {
	private int member_uid;
	private String email;
	private String pw;				// DB는 password 
	private String nickname;
	private String phoneNumber;		// 폰번호 ***-****-**** 인데 나눠서 또 저장? -> 번호가 null값으로 가져와 진다 수정 필요
	private int authority;
	private String emailDuplication;
	private String nicknameDuplication;
	private int memberBoardCnt;
	private String currentpw;				// 비밀번호 변경시 현재 비밀번호 입력
	private String changepw;			// 비밀번호 변경시 사용 그리고 이게 다시 pw로 들어가야 함
	private String checkpw;				// 비밀번호가 제대로 입력됬는지 확인
	private String checksecession;
	
	// 홈페이지에서 입력받을때 자바스크립트에서 처리해주면 ㄱㅊ
	// 다시 역으로 네모 3칸 로 다시꽂아줄때 스플릿으로 처리해서보내주면 ㄱㅊ
	// 만약 폰넘버가 널이면? -> 널일떄만 예외처리 
	
	public String getPhonenum1 () {
		if(!phoneNumber.isEmpty()) {
			return phoneNumber.split("-")[0];
		}
		return null;
	}
	
	public String getPhonenum2 () {
		if(!phoneNumber.isEmpty()) {
			return phoneNumber.split("-")[1];
		}
		return null;
	}
	
	public String getPhonenum3 () {
		if(!phoneNumber.isEmpty()) {
			return phoneNumber.split("-")[2];
		}
		return null;
	}

	public String toString() {
		return String.format("%s %s %s %s", email, pw, nickname, phoneNumber);
	}
	
	
	
}
