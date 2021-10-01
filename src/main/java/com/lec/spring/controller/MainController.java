package com.lec.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.spring.service.UserService;

@Controller
@RequestMapping("/modacon")
public class MainController {
	private UserService userService;
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	@RequestMapping("")
	public String mainPage(Model model) {
		
		return "user/main";
	}
	
	//코인, 
	@RequestMapping("/coin")
	public String coin() {
		
		return "user/coin_main";
	}
	
	// 커뮤니티 리스트
	@RequestMapping("/board")
	public String board(Model model) {
		model.addAttribute("list", userService.communityList());
		return "user/board/list";
	}
	
	// 정보게시판 리스트
	@RequestMapping("/infoboard")
	public String infoBoard(Model model) {
		model.addAttribute("list", userService.infoList());
		return "user/board/list";
	}
	
	// 자유게시판 리스트
	@RequestMapping("/freeboard")
	public String freeBoard(Model model) {
		model.addAttribute("list", userService.freeList());
		return "user/board/list";
	}
	
	// 커뮤니티 뷰
	@RequestMapping("/board/view")
	public String communityView(int uid, Model model) {
		model.addAttribute("list", userService.viewContent(uid));
		return "user/board/view";
	}
	
	// 게시판 글 작성
	@RequestMapping("/board/write")
	public String write(Model model) {
		return "user/board/write";
	}
	
	// 공지 리스트
	@RequestMapping("/notice")
	public String notice(Model model) {
		model.addAttribute("list", userService.noticeList());
		return "user/notice/list";
	}
	
	// 공지 뷰
	@RequestMapping("notice/view")
	public String noticeView(int uid, Model model) {
		model.addAttribute("list", userService.viewContent(uid));
		return "user/notice/view";
	}
	
}
