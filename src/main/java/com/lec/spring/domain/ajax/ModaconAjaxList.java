package com.lec.spring.domain.ajax;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ModaconAjaxList<T>{
	
	@JsonProperty("list")
	List<T> list;
	
	int count;
	
	String status;
	String message;
		
	// 현재 가져오는 데이터의 타입
	String dataType;
	
	int page;  // 현재 페이지 #
	
	@JsonProperty("totalpage")
	int totalPage; // 총 몇 '페이지' 분량인가?
	
	@JsonProperty("totalcnt")
	int totalCnt; // 글은 총 몇개인가?
	
	@JsonProperty("writepages")
	int writePages; // 한 [페이징] 에 몇개의 '페이지'를 표현할 것인가?
	
	@JsonProperty("pagerows")
	int pageRows; // 한 '페이지'에 몇개의 글을 리스트 할것인가?
}
