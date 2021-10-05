package com.lec.spring.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.spring.domain.ajax.ModaconAjaxList;
import com.lec.spring.domain.board.BoardDTO;
import com.lec.spring.service.AdminService;

@Controller	
@RequestMapping("/modacon/admin")
public class AdminController {
	
	private AdminService adminService;

	@Autowired
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@RequestMapping({"", "/"})
	public String adminMain(Model model) {
		
		return "admin/main";
	}
	
	@GetMapping("noticeList/{page}/{pageRows}")
	public ModaconAjaxList admNoticeList(
			@PathVariable int page,
			@PathVariable int pageRows
			) {
		
		List<BoardDTO> list = null;
		
		// message 
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		
		// 페이징 관련 세팅 값들
		//page : 현재 페이지
		//pageRows : 한 '페이지'에 몇개의 글을 리스트 할것인가?
		int writePages = 10;    // 한 [페이징] 에 몇개의 '페이지'를 표현할 것인가?
		int totalPage = 0; // 총 몇 '페이지' 분량인가? 
		int totalCnt = 0;  // 글은 총 몇개인가?
		
		
		try {			
			// 글 전체 개수 구하기
			totalCnt = adminService.count();
			
			// 총 몇페이지 분량?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// from: 몇번째 row 부터?
			int from = (page - 1) * pageRows;  // MySQL 의 Limit 는 0-base 
			
			list = adminService.list(from, pageRows);
			
			if(list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				status = "OK";
			}
		} catch(Exception e) {
			e.printStackTrace();
			message.append("[트랜잭션 에러: " + e.getMessage() + "]");
		}
		
		ModaconAjaxList<BoardDTO> result = new ModaconAjaxList<BoardDTO>();
		
		result.setStatus(status);
		result.setMessage(message.toString());
		
		if(list != null) {
			result.setCount(list.size());
			result.setList(list);
		}
		
		result.setPage(page);
		result.setTotalPage(totalPage);
		result.setWritePages(writePages);
		result.setPageRows(pageRows);
		result.setTotalCnt(totalCnt);
		
		return result;		
		
	} // end admNoticeList
	
	
	
	
} // end class
