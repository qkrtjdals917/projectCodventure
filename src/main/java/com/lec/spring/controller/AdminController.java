package com.lec.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.spring.domain.ajax.ModaconAjaxList;
import com.lec.spring.domain.ajax.ModaconAjaxResult;
import com.lec.spring.domain.board.BoardDTO;
import com.lec.spring.domain.member.MemberVO;
import com.lec.spring.domain.report.ReportDTO;
import com.lec.spring.service.AdminService;

@Controller	
@RequestMapping("/modaconAdmin")
public class AdminController {
	
	private AdminService adminService;

	@Autowired
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}
	
	@RequestMapping({"", "/"})
	public String adminMain(HttpServletRequest request , Model model) {
		HttpSession session = request.getSession();
		if (session != null) {
            String redirectUrl = (String) session.getAttribute("admPrevPage");
            if (redirectUrl != null) {
            	model.addAttribute("admPrevPage", redirectUrl);
            } else {
            	model.addAttribute("admPrevPage", "main");
            }
        } else {
        	model.addAttribute("admPrevPage", "main");
        }
		
		return "admin/main";
	}

	@GetMapping("/saveroute/{path}")
	@ResponseBody
	public String saveRoute (HttpServletRequest request , @PathVariable String path) {
		HttpSession session = request.getSession();
		if (session != null) {
            String redirectUrl = (String) session.getAttribute("admPrevPage");
            if (redirectUrl != null) {
            	if(path.equals(redirectUrl)) {
            		
            	}
            	session.removeAttribute("admPrevPage");
            	request.getSession().setAttribute("admPrevPage", path);
            } else {
            	request.getSession().setAttribute("admPrevPage", path);
            }
        } else {
        	request.getSession().setAttribute("admPrevPage", path);
        }
		
//	    request.getSession().setAttribute("admPrevPage", path);
	    
	    return path;
		
	}
	
	// 페이징
	@GetMapping("/noticeList/{page}/{pageRows}")
	@ResponseBody
	public ModaconAjaxList<BoardDTO> admNoticeList(
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
			totalCnt = adminService.countNtc();
			
			// 총 몇페이지 분량?
			totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
			
			// from: 몇번째 row 부터?
			int from = (page - 1) * pageRows;  // MySQL 의 Limit 는 0-base 
			
			list = adminService.ntcUpdateList(from, pageRows);
			
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
		
		result.setDataType("ntc");
		result.setPage(page);
		result.setTotalPage(totalPage);
		result.setWritePages(writePages);
		result.setPageRows(pageRows);
		result.setTotalCnt(totalCnt);
		
		return result;		
		
	} // end admNoticeList
	
	// 특정 uid 글 읽기
		@GetMapping("/{uid}")   // URI:  /board/{uid}
		public ModaconAjaxList<BoardDTO> admView(@PathVariable int uid) {
			List<BoardDTO> list = null;
			
			// message 
			StringBuffer message = new StringBuffer();
			String status = "FAIL";
			
			try {			
				list = adminService.admViewOne(uid);  // 조회수 증가 + 읽기
				
				if(list == null || list.size() == 0) {
					message.append("[해당 데이터가 없습니다]");
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
			
//			if(list != null) {
//				result.setCount(list.size());
//				result.setList(list);
//			}
//			
			return result;		
		}
		
		// 글 작성
		@PostMapping("")  // URI: /board
		public ModaconAjaxResult ntcWriteOk(BoardDTO dto) {
			int count = 0;
					
			// message 
			StringBuffer message = new StringBuffer();
			String status = "FAIL";
			
			try {
				count = adminService.write(dto);
				if(count == 0) {
					message.append("[트랜잭션 실패 : 0 insert]");
				} else {
					status = "OK";
				}
			} catch(Exception e) {
				e.printStackTrace();
				message.append("[트랜잭션 에러: " + e.getMessage() + "]");
			}
			
			ModaconAjaxResult result = new ModaconAjaxResult();
			result.setStatus(status);
			result.setMessage(message.toString());
			result.setCount(count);
			return result;
		}
		
		// 글 수정
		@PutMapping("")  // URI: /board
		public ModaconAjaxResult ntcUpdateOk(BoardDTO dto) {
			int count = 0;
				
			// message 
			StringBuffer message = new StringBuffer();
			String status = "FAIL";
			
			try {
				count = adminService.update(dto);
				if(count == 0) {
					message.append("[트랜잭션 실패 : 0 update]");
				} else {
					status = "OK";
				}
			} catch(Exception e) {
				e.printStackTrace();
				message.append("[트랜잭션 에러: " + e.getMessage() + "]");
			}
			
			ModaconAjaxResult result = new ModaconAjaxResult();
			result.setStatus(status);
			result.setMessage(message.toString());
			result.setCount(count);
			return result;
		}

		// 글 삭제
		@DeleteMapping("")  // URI: /board
		public ModaconAjaxResult deleteOk(int [] uid) {
			int count = 0;
			
			// message 
			StringBuffer message = new StringBuffer();
			String status = "FAIL";
			
			try {
				
				if(uid != null) {
					count = adminService.deleteByChk(uid);
					status = "OK";
				}
				
			} catch(Exception e) {
				e.printStackTrace();
				message.append("[트랜잭션 에러: " + e.getMessage() + "]");
			}
			
			ModaconAjaxResult result = new ModaconAjaxResult();
			result.setStatus(status);
			result.setMessage(message.toString());
			result.setCount(count);
			return result;
		}
		
		
		
		
		
		
		
		// 커뮤니티 페이징
		@GetMapping("/communityList/{page}/{pageRows}")
		@ResponseBody
		public ModaconAjaxList<BoardDTO> admCommunityList(
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
				totalCnt = adminService.countCmt();
				
				// 총 몇페이지 분량?
				totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
				
				// from: 몇번째 row 부터?
				int from = (page - 1) * pageRows;  // MySQL 의 Limit 는 0-base 
				
				list = adminService.cmtUpdateList(from, pageRows);
				
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
			
			result.setDataType("cmt");
			result.setPage(page);
			result.setTotalPage(totalPage);
			result.setWritePages(writePages);
			result.setPageRows(pageRows);
			result.setTotalCnt(totalCnt);
			
			return result;		
			
		} // end admCommunityList
		
		
		
		
		// 신고리스트 페이징
		@GetMapping("/reportList/{page}/{pageRows}")
		@ResponseBody
		public ModaconAjaxList<ReportDTO> admReportList(
				@PathVariable int page,
				@PathVariable int pageRows
				) {
			
			List<ReportDTO> list = null;
			
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
				totalCnt = adminService.countRp();
				
				// 총 몇페이지 분량?
				totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
				
				// from: 몇번째 row 부터?
				int from = (page - 1) * pageRows;  // MySQL 의 Limit 는 0-base 
				
				list = adminService.rpUpdateList(from, pageRows);
				
				if(list == null) {
					message.append("[리스트할 데이터가 없습니다]");
				} else {
					status = "OK";
					for(int i = 0 ; i < list.size() ; i++) {
						list.get(i).setNickname( adminService.selectByUid( list.get(i).getMember_uid() ).getNickname());
					}
				}
			} catch(Exception e) {
				e.printStackTrace();
				message.append("[트랜잭션 에러: " + e.getMessage() + "]");
			}
			
			ModaconAjaxList<ReportDTO> result = new ModaconAjaxList<ReportDTO>();
			
			result.setStatus(status);
			result.setMessage(message.toString());
			
			if(list != null) {
				result.setCount(list.size());
				result.setList(list);
			}
			
			result.setDataType("rp");
			result.setPage(page);
			result.setTotalPage(totalPage);
			result.setWritePages(writePages);
			result.setPageRows(pageRows);
			result.setTotalCnt(totalCnt);
			
			return result;		
			
		} // end admReportList
		
		
		// 회원리스트 페이징
		@GetMapping("/memberList/{page}/{pageRows}")
		@ResponseBody
		public ModaconAjaxList<MemberVO> admMemberList(
				@PathVariable int page,
				@PathVariable int pageRows
				) {
			
			List<MemberVO> list = null;
			
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
				totalCnt = adminService.countMb();
				
				// 총 몇페이지 분량?
				totalPage = (int)Math.ceil(totalCnt / (double)pageRows);
				
				// from: 몇번째 row 부터?
				int from = (page - 1) * pageRows;  // MySQL 의 Limit 는 0-base 
				
				list = adminService.mbUpdateList(from, pageRows);
				
				if(list == null) {
					message.append("[리스트할 데이터가 없습니다]");
				} else {
					status = "OK";
				}
			} catch(Exception e) {
				e.printStackTrace();
				message.append("[트랜잭션 에러: " + e.getMessage() + "]");
			}
			
			ModaconAjaxList<MemberVO> result = new ModaconAjaxList<MemberVO>();
			
			result.setStatus(status);
			result.setMessage(message.toString());
			
			if(list != null) {
				result.setCount(list.size());
				result.setList(list);
			}
			
			result.setDataType("mb");
			result.setPage(page);
			result.setTotalPage(totalPage);
			result.setWritePages(writePages);
			result.setPageRows(pageRows);
			result.setTotalCnt(totalCnt);
			
			return result;		
			
		} // end admMemberList
		

		
	
	
	
} // end class
