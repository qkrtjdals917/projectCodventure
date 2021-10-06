package com.lec.spring.domain.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {
	//1. mapper 생성
	private MemberDAO mapper;
	
	@Autowired
	public MemberDAOImpl(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(MemberDAO.class);
	}
	
	@Override
	public List<MemberDTO> selectAll() {
		
		return mapper.selectAll();
	}
	
	@Override
	public MemberDTO selectByUid(int member_uid) {
		return mapper.selectByUid(member_uid);
	}
	
	@Override
	public int countByNickname(String nickname) {
		return mapper.countByNickname(nickname);
	}
	
	@Override
	public int countByEmail(String email) {
		return mapper.countByEmail(email);
	}

	@Override
	public MemberDTO selectByEmail(String email) {
		return mapper.selectByEmail(email);
	}

	@Override
	public int insertMember(MemberDTO dto) {
		return mapper.insertMember(dto);
	}

	@Override
	public int changeAuth(int authority, int member_uid) {
		return mapper.changeAuth(authority, member_uid);
	}
	
	@Override
	public int selectAuthoritiesById(int member_uid) {
		return mapper.selectAuthoritiesById(member_uid);
	}

	@Override
	public int deleteMember(MemberDTO dto) {
		return mapper.deleteMember(dto);
	}

	@Override
	public int changeMember(MemberDTO dto) {
		return mapper.changeMember(dto);
	}

	@Override
	public int changePassword(MemberDTO dto) {
		return mapper.changePassword(dto);
	}

	@Override
	public int memberBoardCnt(int uid) {
		return mapper.memberBoardCnt(uid);
	}
	
}