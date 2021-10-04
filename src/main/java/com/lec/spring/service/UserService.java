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
	
	public List<BoardDTO> viewContent(int uid){
		dao.viewCnt(uid);
		return dao.selectOne(uid);
	}
	
	public int write(BoardDTO dto) {
		return dao.insert(dto);
	}

	public int delete(int uid) {
		return dao.deleteUid(uid);
	}
	
}
