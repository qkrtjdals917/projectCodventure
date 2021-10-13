package com.lec.spring.domain.board;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardList extends BoardResult{
	@JsonProperty("data")
	List<BoardDTO> list;
	
	int uid;
}
