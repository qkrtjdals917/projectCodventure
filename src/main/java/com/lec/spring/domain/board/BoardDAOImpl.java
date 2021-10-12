package com.lec.spring.domain.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lec.spring.domain.coin.CoinDTO;

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

	// 글 작성
	@Override
	public int insert(BoardDTO dto) {
		return mapper.insert(dto);
	}

	// 추천
	@Override
	public int likeUp(BoardDTO dto) {
		return mapper.likeUp(dto);
	}

	@Override
	public int likeDown(BoardDTO dto) {
		return mapper.likeDown(dto);
	}
	
	@Override
	public int likeCount(int uid) {
		return mapper.likeCount(uid);
	}

	// 신고
	@Override
	public int report(Map<String, Object> param) {
		return mapper.report(param);
	}

	// ↓ 해연추가 


	// 공지사항 정보 가져오기
	// 공지사항 카운트
	@Override
	public int countNtc() {
		return mapper.countNtc();
	}

	// 공지사항 페이징
	@Override
	public List<BoardDTO> selectFromRowNtc(int from, int pageRows) {
		return mapper.selectFromRowNtc(from, pageRows);
	}
	
	// 공지사항 정보 삭제 체크된 것
	public int deleteByChk (int [] uids) {
		return mapper.deleteByChk(uids);
	}
	
	// 공지사항 작성하기
	public int insertNtc(BoardDTO dto) {
		return mapper.insertNtc(dto);
	}
	
	// (커뮤티니 정보 가져오기)
	// (커뮤니티 카운팅)
	public int countAll() {
		return mapper.countAll();
	}
		
	// (커뮤니티 페이징)
	public List<BoardDTO> selectFromRowCmt(int from, int pageRows) {
				return mapper.selectFromRowCmt(from, pageRows);
			}
		
	// (정보게시판 정보 가져오기)
	// (정보게시판 페이징)
	// (자유게시판 정보 가져오기)
	// (자유게시판 페이징)
	
	
	// (커뮤니티 삭제)

	@Override
	public List<CoinDTO> selectCoinList () {
		return mapper.selectCoinList();
	}
}
