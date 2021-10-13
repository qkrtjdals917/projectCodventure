package com.lec.spring.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.board.BoardDAO;
import com.lec.spring.domain.board.BoardDTO;
import com.lec.spring.domain.coin.CoinDTO;

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
	
	public List<BoardDTO> typeList(String type){
		return dao.selectType(type);
	}
	
	public List<BoardDTO> tagList(String tag){
		return dao.selectTag(tag);
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
	
	// 글 추천
	public int likeUp(BoardDTO dto) {
		return dao.likeUp(dto);
	}
	
	// 추천 취소
	public int likeDown(BoardDTO dto) {
		return dao.likeDown(dto);
	}
	
	// 추천수 카운트
	public int likeCount(int uid) {
		return dao.likeCount(uid);
	}
	
	// 신고
	public int report(Map<String, Object> param) {
		return dao.report(param);
	}
	
	public List<CoinDTO> selectCoinList () {
		return dao.selectCoinList();
	}
	
	// 공지사항 가져오기
	public List<BoardDTO> selectNotice () {
		return dao.selectNotice();
	}
	
	
}