package com.lec.spring.domain.board;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface BoardDAO {
	// 전체글 list
	public abstract List<BoardDTO> selectCommunity();
	
	// 공지글 list
	public abstract List<BoardDTO> selectNotice();
	
	// 자유글 list
	public abstract List<BoardDTO> selectFree();
	
	// 정보글 list
	public abstract List<BoardDTO> selectInfo();
	
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

	
	
	//  ↓해연추가
	
	// (공지사항 정보 가져오기)
	// (공지글 카운트)
	public abstract int countNtc();

	// (공지글 목록 페이징)
	public abstract List<BoardDTO> selectFromRowNtc(
			@Param("from") int from, 
			@Param("pageRows") int pageRows 
			);

	// (공지사항 정보 삭제)
	public int deleteByNtc(int [] board_uid);
	
	// (공지사항 정보 입력)
	public int insertNtc(BoardDTO dto);
	
	// (커뮤티니 정보 가져오기)
	// (커뮤니티 카운팅)
	public abstract int countAll();
	
	// (커뮤니티 페이징)
	public abstract List<BoardDTO> selectFromRowCmt(
			@Param("from") int from, 
			@Param("pageRows") int pageRows 
			);
	
	// (정보게시판 정보 가져오기)
	// (정보게시판 페이징)
	// (자유게시판 정보 가져오기)
	// (자유게시판 페이징)
	// (커뮤니티 삭제)
	public int deleteByCmt(int [] board_uid);

	
}