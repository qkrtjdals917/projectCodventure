package com.lec.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.lec.spring.domain.member.MemberDTO;
import com.lec.spring.service.MemberService;

// 관리자 페이지에서의 Security
@Controller
public class IndexController {

	@Autowired
	MemberService MemberService;
	
//	@Autowired
//	private PasswordEncoder passwordEncoder;
	
	// board/작성 부분에서 낚아채기
	
	
	@GetMapping("/login")
	public String login() {
		
		return "user/login/login";	// login 접근시 따로 만든 페이지 리턴
	}
	
	@GetMapping("/join")
	public String join() {
		
		return "user/login/join";	// join 접근시 따로 만든 페이지 리턴
	}
	
	@PostMapping("/joinOk")
	public String joinOk(MemberDTO dto) {
		System.out.println(dto);	// 잘 가져왔는지 확인
		
//		String rawPassword = user.getPw();
//		String encPassword = passwordEncoder.encode(rawPassword);
//		user.setPw(encPassword);
		
		int cnt = MemberService.addMember(dto);
		
		return "redirect:/login";	// 회원가입 완료시 로그인 페이지로 이동
	}
	
}
