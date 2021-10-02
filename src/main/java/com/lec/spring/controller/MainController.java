package com.lec.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.spring.config.PrincipalDetails;
import com.lec.spring.domain.member.MemberDTO;
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
	public String mainPage(Model model, Authentication authentication) {
		
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
//		if (principal != null) {
//			System.out.println("ID정보 : " + principal.getName());
//			System.out.println("ID정보 : " + principal.getNickname());
//			System.out.println("ID정보 : " + principal.getName());
//		}
		
		if (authentication != null) {
			MemberDTO dto = new MemberDTO();
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();

			System.out.println("Email정보 : " + userDetails.getUsername());
			System.out.println("Nickname정보 : " + userDetails.getNickname());
			System.out.println("UID정보 : " + userDetails.getUid());
			
			dto.setEmail(userDetails.getUsername());
			dto.setNickname(userDetails.getNickname());
			dto.setMember_uid(userDetails.getUid());
			
			model.addAttribute("member" , dto);
		}

		return "user/main";
	}

	// 마이페이지
	@RequestMapping("/mypage")
	public String hy_myPage(Model model, Authentication authentication) {
		if (authentication != null) {
			MemberDTO dto = new MemberDTO();
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();

			System.out.println("Email정보 : " + userDetails.getUsername());
			System.out.println("Nickname정보 : " + userDetails.getNickname());
			System.out.println("UID정보 : " + userDetails.getUid());
			
			dto.setEmail(userDetails.getUsername());
			dto.setNickname(userDetails.getNickname());
			dto.setMember_uid(userDetails.getUid());
			
			model.addAttribute("member" , dto);
		}
		
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
		return "user/mypage";
	}
	
	// 코인페이지
	@RequestMapping("/coin")
	public String coin(Model model, Authentication authentication) {

		return "user/coin_main";
	}

	// 커뮤니티 리스트
	@RequestMapping("/board")
	public String board(Model model) { // 여기에서 작성 부분은 로그인 한 사람만 접근가능
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

	// -------------------여기 이하 admin---------------------

//	@GetMapping("/logincheck")
//	@ResponseBody
//	public String login(Authentication authentication) {
//		String str = principal.getEmail();
//		return str;
//
//	}
}
