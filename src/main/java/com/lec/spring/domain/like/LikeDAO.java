package com.lec.spring.domain.like;

import java.util.List;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface LikeDAO {
	
	// 추천하는 기능
	public int insertLike(LikeDTO dto);
	
	// 추천한 사람들 리스트 가져오기
	public List<LikeDTO> selectByLikeMember();
	
	// 추천삭제
	public int deleteLike(int member_uid);
	
	// 글 삭제시 해당 글 추천 모두 삭제
	public int deleteAll(int board_uid);

	// 추천수
	public int incLikeCnt(int board_uid);
	
}