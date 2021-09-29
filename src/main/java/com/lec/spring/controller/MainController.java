package com.lec.spring.controller;

import org.springframework.boot.web.servlet.server.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/modacon")
public class MainController {
	
	@RequestMapping("")
	public String mainPage(Model model , Session session) {
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
		
		model.addAttribute("session", session);
		
		return "user/main";
	}
	//코인, 
	@RequestMapping("/coin")
	public String coin() {
		
		return "user/coin_main";
	}
	//커뮤니티, 
	@RequestMapping("/board")
	public String board() {		// 여기에서 작성 부분은 로그인 한 사람만 접근가능
		
		return "user/board/list";
	}
	
	//공지
	@RequestMapping("/notice")
	public String notice() {
		
		return "user/notice/view";
	}
	
	//-------------------여기 이하 admin---------------------
	
	@GetMapping("/login")
	public String login() {
		
		return "user/login/login";	// 로그인 페이지
	}
	
}
