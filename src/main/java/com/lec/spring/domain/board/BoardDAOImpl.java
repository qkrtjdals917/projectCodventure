package com.lec.spring.domain.board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {

	private BoardDAO mapper;
	
	@Autowired
	public BoardDAOImpl(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(BoardDAO.class);
	}
	
	
	// 글 하나 선택. 조회 시 사용.
	@Override
	public List<BoardDTO> selectOne(int uid) {
		return mapper.selectOne(uid);
	}
	
	// 조회수 증가
	@Override
	public int viewCnt(int uid) {
		return mapper.viewCnt(uid);
	}

	
	// 글 삭제
	@Override
	public int deleteUid(int uid) {
		return mapper.deleteUid(uid);
	}

	// 글 수정
	@Override
	public int update(BoardDTO dto) {
		return mapper.update(dto);
	}

	// 커뮤니티 글 전체 리스트. 공지글은 해당 안함
	@Override
	public List<BoardDTO> selectCommunity() {
		return mapper.selectCommunity();
	}

	// 공지사항 글 리스트
	@Override
	public List<BoardDTO> selectNotice() {
		return mapper.selectNotice();
	}

	// 자유게시판 글 리스트
	@Override
	public List<BoardDTO> selectFree() {
		return mapper.selectFree();
	}

	// 정보게시판 글 리스트
	@Override
	public List<BoardDTO> selectInfo() {
		return mapper.selectInfo();
	}


	@Override
	public int insert(BoardDTO dto) {
		return mapper.insert(dto);
	}
	
}