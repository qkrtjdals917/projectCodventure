package com.lec.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.board.BoardDAO;
import com.lec.spring.domain.board.BoardDTO;

@Service
public class AdminService {
	// DAO 객체 생성
	BoardDAO Adao;
	
	
	// 자동 넣기 Autowired 
	@Autowired
	public void setAdao(BoardDAO Adao) {
		this.Adao = Adao;
	}
	
	
	// dao 를 활용한 트랜잭션들 담을 예정(admin)
	
	// 게시판 정보를 가져온다
	public List<BoardDTO> communityList(){
		return Adao.selectCommunity();
	}
	
	// 게시글을 삭제한다
	public int deleteByBoard (int board_uid) {
		return Adao.deleteUid(board_uid);
	}
	
	// 공지사항 정보를 가져온다
	public List<BoardDTO> noticeList(){
		return Adao.selectNotice();
	}
	
	public int count() {
		// 공지사항 게시판 글의 개수를 카운트해서 가져온다.
		return 0;
	}
	// 공지사항 정보를 from 부터 pageRows 개를 가져온다.
	public List<BoardDTO> list(int from , int pageRows) {
		return null;
	}
	
	// 공지사항 정보를 삭제한다
	public int deleteByNotice (int notice_uid) {
		return Adao.deleteUid(notice_uid);
	}
	

	public List<BoardDTO> viewByUid(int uid) {
		return Adao.selectOne(uid);
	}

	
	// TODO
	// 공지사항을 DB에 저장한다
	// 멤버 정보를 가져온다
	// 신고 정보를 가져온다
	
	
}
