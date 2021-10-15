package com.lec.spring.domain.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

import com.lec.spring.domain.coin.CoinDTO;

@MapperScan
public interface BoardDAO {
	// 전체글 list
	public abstract List<BoardDTO> selectCommunity(@Param("from") int from, @Param("pageRows") int pageRows);

	// 공지글 list
	public abstract List<BoardDTO> selectNotice();

	public abstract List<BoardDTO> selectNoticePaging(@Param("from") int from, @Param("pageRows") int pageRows);

	// Type list
	public abstract List<BoardDTO> selectType(String type);

	// Tag list
	public abstract List<BoardDTO> selectTag(String tag);

	// Type list Paging
	public abstract List<BoardDTO> selectTypePaging(@Param("from") int from, @Param("pageRows") int pageRows, String type);

	// Tag list Paging
	public abstract List<BoardDTO> selectTagPaging(@Param("from") int from, @Param("pageRows") int pageRows, String tag);

	// 특정 글 하나 선택
	public abstract List<BoardDTO> selectOne(int uid);

	// 조회수 증가
	public abstract int viewCnt(int uid);

	// 글 삭제
	public abstract int deleteUid(int uid);

	// 글 수정
	public abstract int update(BoardDTO dto);

	// 글 작성
	public abstract int insert(BoardDTO dto);

	// 추천하기
	public abstract int likeUp(BoardDTO dto);

	// 추천 취소
	public abstract int likeDown(BoardDTO dto);

	// 추천수 카운트
	public abstract int likeCount(int uid);

	// 추천여부 확인
	public abstract int likeChk(int board_uid, int member_uid);

	// 신고
	public abstract int report(Map<String, Object> param);

	// 페이징 관련
	public abstract int countBoard();

	public abstract int countType(String type);

	public abstract int countTag(String tag);
	
	// ↓해연추가

	// (공지사항 정보 가져오기)
	// (공지글 카운트)
	public abstract int countNtc();

	// (공지글 목록 페이징)
	public abstract List<BoardDTO> selectFromRowNtc(@Param("from") int from, @Param("pageRows") int pageRows);

	// (공지사항 정보 삭제 (체크된 것)
	public int deleteByChk(int[] uids);

	// (공지사항 정보 입력)
	public int insertNtc(BoardDTO dto);

	// (커뮤티니 정보 가져오기)
	// (커뮤니티 카운팅)
	public abstract int countAll();

	// (커뮤니티 페이징)
	public abstract List<BoardDTO> selectFromRowCmt(@Param("from") int from, @Param("pageRows") int pageRows);

	// (정보게시판 정보 가져오기)
	// (정보게시판 페이징)
	// (자유게시판 정보 가져오기)
	// (자유게시판 페이징)
	// (커뮤니티 삭제)

	// 코인 리스트 ㅈ가져오기
	public abstract List<CoinDTO> selectCoinList();
}