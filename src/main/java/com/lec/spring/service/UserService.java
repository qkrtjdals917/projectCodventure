package com.lec.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.board.BoardDAO;
import com.lec.spring.domain.board.BoardDTO;

@Service
public class UserService {
	// DAO 객체 생성
	// 자동 넣기 Autowired 

	BoardDAO dao;
	
	@Autowired
	public void setDao(BoardDAO dao) {
		this.dao = dao;
	}
	
	// 게시판들
	public List<BoardDTO> communityList(){
		return dao.selectCommunity();
	}
	
	public List<BoardDTO> noticeList(){
		return dao.selectNotice();
	}
	
	public List<BoardDTO> freeList(){
		return dao.selectFree();
	}
	
	public List<BoardDTO> infoList(){
		return dao.selectInfo();
	}
	
	// 글 하나 선택. delete, update 시 uid 비교
	public List<BoardDTO> selectOne(int uid){
		return dao.selectOne(uid);
	}
	
	// 글 보기. view페이지에서 활용.
	public List<BoardDTO> viewContent(int uid){
		dao.viewCnt(uid);
		return dao.selectOne(uid);
	}
	
	// 글 작성
	public int write(BoardDTO dto) {
		return dao.insert(dto);
	}
	
	// 글 삭제
	public int delete(int uid) {
		return dao.deleteUid(uid);
	}
	
	// 글 수정
	public int update(BoardDTO dto) {
		return dao.update(dto);
	}
	
}
