package com.lec.spring.domain.comment;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.data.repository.query.Param;

@MapperScan
public interface CommentDAO {
	
	public int insert (CommentDTO dto);
	
	public List<CommentDTO> select (@Param("uid") int comment_uid);
	
	public List<CommentDTO> selectByBoard (@Param("uid") int board_uid);
	
	// 글제목 (댓글수) 
	public int countByBoard (@Param("uid") int board_uid);
	
	public int delete (@Param("uid") int comment_uid);
	
	public int deleteByBoard (@Param("uid") int board_uid);
	
}