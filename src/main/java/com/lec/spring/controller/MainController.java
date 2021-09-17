package com.lec.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/modacon")
public class MainController {
	
	@RequestMapping("")
	public String mainPage(Model model) {
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
		return "user/main";
	}
	//코인, 
	@RequestMapping("/coin")
	public String coin() {
		
		return "user/coin_main";
	}
	//커뮤니티, 
	@RequestMapping("/board")
	public String board() {
		
		return "user/board/list";
	}
	//공지
	@RequestMapping("/notice")
	public String notice() {
		
		return "user/notice/view";
	}
	
	
}
