package com.lec.spring.domain.report;

import lombok.Data;

@Data		// getter setter tostring 생성자 ( 매개변수 x , 모든 멤버변수를 매개변수로 갖는생성자)
public class ReportDTO {
	private int report_uid;
	private int board_uid;
	private int member_uid;
	private String reportTag;		//신고사유
	private String reportContent;	//신고 자세한 내용
	private String nickname;
	
}
