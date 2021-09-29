package com.lec.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/modacon/mypage")
public class MyPageController {
	
	@RequestMapping("")
	public String hy_myPage(Model model) {
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
		return "user/mypage";
	}
	
//	//정보수정, 
//	@RequestMapping("/mypage")
//	public String hy_updateMypage() {
//		
//		return "user/mypage";
//	}
//	//비밀번호 변경, 
//	@RequestMapping("/board")
//	public String hy_updatePw() {
//		
//		return "user/mypage";
//	}
//	//회원탈퇴
//	@RequestMapping("/notice")
//	public String hy_resign() {
//		
//		return "user/mypage";
//	}
//	
	
}
