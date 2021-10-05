package com.lec.spring.domain.comment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDAOImpl implements CommentDAO {
	private CommentDAO mapper;
	
	@Autowired
	public CommentDAOImpl(SqlSession sqlSession) {
		mapper = sqlSession.getMapper(CommentDAO.class);
	}

	@Override
	public int insert(CommentDTO dto) {
		return mapper.insert(dto);
	}

	@Override
	public List<CommentDTO> select(int comment_uid) {
		return mapper.select(comment_uid);
	}

	@Override
	public List<CommentDTO> selectByBoard(int board_uid) {
		return mapper.selectByBoard(board_uid);
	}

	@Override
	public int countByBoard(int board_uid) {
		return mapper.countByBoard(board_uid);
	}

	@Override
	public int delete(int comment_uid) {
		return mapper.delete(comment_uid);
	}

	@Override
	public int deleteByBoard(int board_uid) {
		return mapper.deleteByBoard(board_uid);
	}


	
	
	
}