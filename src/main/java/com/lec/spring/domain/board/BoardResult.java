package com.lec.spring.domain.board;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardResult {
	int count;
	String status;
	String message;
}
