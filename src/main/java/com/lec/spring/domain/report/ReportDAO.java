package com.lec.spring.domain.report;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface ReportDAO {
	
		// 신고접수 리스트 가져오기
		public List<ReportDTO> selectReport();
		
		// 신고접수 카운팅
		public int countRp();
		
		// 리스트 from 부터 pageRows개를 가져온다
		public List<ReportDTO> selectFromRowRp(
				@Param("from") int from, 
				@Param("pageRows") int pageRows 
				);
		// 신고리스트를 본다
		public ReportDTO selectByReport (int uid);
		
		// 신고취하
		public int deleteReport(int uid);
		
}