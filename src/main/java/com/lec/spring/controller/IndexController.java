package com.lec.spring.controller;

import javax.validation.Valid;

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
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
//	@GetMapping("/login")
//	public String login() {
//		
//		return "user/login/login";	// login 접근시 따로 만든 페이지 리턴
//	}
//	
//	@GetMapping("/join")
//	public String join() {
//		
//		return "user/login/join";	// join 접근시 따로 만든 페이지 리턴
//	}
	
	@PostMapping("/joinOk")
	public String joinOk(@Valid MemberDTO dto) {
		System.out.println(dto);	// 잘 가져왔는지 확인
		
		// pw 인코더
		String rawPassword = dto.getPw();
		String encPassword = passwordEncoder.encode(rawPassword);	// 원본을 암호화
		dto.setPw(encPassword); // 암호와된 pw세팅
		
		int cnt = MemberService.addMember(dto);
		
		return "redirect:/modacon";	// 회원가입 완료시 로그인 페이지로 이동
	}
	
}
