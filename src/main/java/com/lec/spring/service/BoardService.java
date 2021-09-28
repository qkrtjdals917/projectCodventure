package com.lec.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.comment.CommentDAO;
import com.lec.spring.domain.comment.CommentDTO;

@Service
public class BoardService {
	
	
	CommentDAO Cdao;
	
	@Autowired
	public void setDao(CommentDAO Cdao) {
		this.Cdao = Cdao;
	}
	
	// 댓글을 DB에 넣는다
	public int insert (CommentDTO dto) {
		return Cdao.insert(dto);
	}
	
	// 해당 댓글의 정보를 가져온다
	public List<CommentDTO> select (int comment_uid) {
		return Cdao.select(comment_uid);
	}
	
	// 글에 달린 댓글들을 전부 가져온다
	public List<CommentDTO> selectByBoard (int board_uid) {
		return Cdao.selectByBoard(board_uid);
	}
	
	// 글에 달린 댓글의 수를 가져온다
	public int countByBoard (int board_uid) {
		return Cdao.countByBoard(board_uid);
	}
	
	// 댓글 하나를 삭제한다
	public int delete (int comment_uid) {
		return Cdao.delete(comment_uid);
	}
	

	// 글 삭제를 할 경우 그 글에 달린 댓글도 같이 다 삭제한다
	// TODO 글삭제 

	
	
}
