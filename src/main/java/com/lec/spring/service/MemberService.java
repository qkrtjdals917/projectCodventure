package com.lec.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.member.MemberDAO;
import com.lec.spring.domain.member.MemberDTO;

@Service
public class MemberService {

	@Autowired
	MemberDAO dao;
	
	// 회원가입
	public int addMember(MemberDTO dto) {
		int cnt = dao.insertMember(dto);
		return cnt;
	}
	
	// 회원삭제
	public int deleteMember(int uid) {
		int cnt = dao.deleteMember(uid);
		return cnt;
	}
	
	// 특정 uid(uid)의 정보 가져오기
	public MemberDTO selectByUid(int uid) {
		return dao.selectByUid(uid);
	}
	
	// 특정 email(email)의 정보 가져오기
	public MemberDTO selectByEmail(String email) {
		return dao.selectByEmail(email);
	}
	
	// 특정 email(email)를 가진 정보의 개수 가져오기 -> 중복체크
	public int countByEmail(String email) {
		return dao.countByEmail(email);
	}
	
	// 특정 nickname(nickname)를 가진 정보의 개수 가져오기 -> 중복체크
	public int countByNickname(String nickname) {
		return dao.countByNickname(nickname);
	}
	
	// 모든 회원 정보 가져오기
	public List<MemberDTO> selectAll() {
		return dao.selectAll();
	}
	
	// 권한 변경
	public int changeAuth(int authority, int uid) {
		return dao.changeAuth(authority, uid);
	}
	
	// 부여된 권한 가져오기
	public int selectAuthoritiesById(int member_uid) {
		return dao.selectAuthoritiesById(member_uid);
	}
	
	// 회원 정보변경
	public int changeMember(MemberDTO dto) {
		return dao.changeMember(dto);
	}
	
	// 회원 비번 변경
	public int changePassword(MemberDTO dto) {
		return dao.changePassword(dto);
	}
	
}
