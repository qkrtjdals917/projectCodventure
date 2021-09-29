package com.lec.spring.domain.like;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LikeDAOImpl implements LikeDAO {

	// 1. mapper 생성
	private LikeDAO mapper;
	
	@Autowired
	public LikeDAOImpl(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(LikeDAO.class);
	}
	
	@Override
	public int insertLike(LikeDTO dto) {
		return mapper.insertLike(dto);
	}

	@Override
	public List<LikeDTO> selectByLikeMember() {
		return mapper.selectByLikeMember();
	}

	@Override
	public int deleteLike(int member_uid) {
		return mapper.deleteLike(member_uid);
	}

	@Override
	public int deleteAll(int board_uid) {
		return mapper.deleteAll(board_uid);
	}

	@Override
	public int incLikeCnt(int board_uid) {
		return mapper.incLikeCnt(board_uid);
	}
	
}