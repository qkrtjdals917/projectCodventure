package com.lec.spring.domain.member;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface MemberDAO {
	
		// 모든 회원 정보 가져오기
		public List<MemberDTO> selectAll();
		
		// uid받고 계정정보 하나 가져오기
		public MemberDTO selectByUid (int member_uid);
		
		// nickname 이 일치하는 계정 수 가져오기
		public int countByNickname(String nickname);
		
		// email 이 일치하는 계정 수 가져오기
		public int countByEmail(String email);
		
		// email로 계정정보 하나 가져오기
		public MemberDTO selectByEmail(String email);
		
		// 회원가입
		public int insertMember(MemberDTO dto);
		
		// 권한 변경
		public int changeAuth(int authority , int member_uid);
		
		// 부여된 권한 가져오기
		public int selectAuthoritiesById(int member_uid);
		
		// 회원탈퇴
		public int deleteMember(MemberDTO dto);
		
		// 정보변경
		public int changeMember(MemberDTO dto);
		
		// 비번바꾸깅
		public int changePassword(MemberDTO dto);
		

		
		// 관리자 
		
		// 회원 리스트 가져오기 (페이징)
		// => selectAll
		// 회원 리스트 카운팅
		public int countMb();
		// 회원 리스트 from 부터 pageRows 개를 가져온다.
		public List<MemberVO> selectFromRowMb(
				@Param("from") int from, 
				@Param("pageRows") int pageRows 
				);
		// 회원리스트를 본다
		// => selectByUid
		// 강퇴기능
		// => deleteMember
		// 검색기능 listAll
		// TODO 

		// 작성글 개수 가져오기
		public int memberBoardCnt(MemberDTO dto);

		
}