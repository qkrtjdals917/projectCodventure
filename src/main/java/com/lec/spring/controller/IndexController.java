package com.lec.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.spring.domain.member.MemberDTO;
import com.lec.spring.service.MemberService;

// 관리자 페이지에서의 Security
@Controller
public class IndexController {

	@Autowired
	MemberService MemberService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@GetMapping("/checkemail/{email}")
	@ResponseBody
	public int login(@PathVariable String email) {

		return MemberService.countByEmail(email);	// login 접근시 따로 만든 페이지 리턴
	}
	
	@GetMapping("/checknickname/{nickname}")
	@ResponseBody
	public int join(@PathVariable String nickname) {

		return MemberService.countByNickname(nickname);
	}
	
	@PostMapping("/joinOk")
	public String joinOk(MemberDTO dto) {
		System.out.println(dto);	// 잘 가져왔는지 확인
		
		// pw 인코더
		String rawPassword = dto.getPw();
		String encPassword = passwordEncoder.encode(rawPassword);	// 원본을 암호화
		dto.setPw(encPassword); // 암호와된 pw세팅
		
		int cnt = MemberService.addMember(dto);
		
		return "redirect:/modacon";	// 회원가입 완료시 로그인 페이지로 이동
	}
	
	
}
