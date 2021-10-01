package com.lec.spring.domain.board;

import java.util.List;

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

	
}