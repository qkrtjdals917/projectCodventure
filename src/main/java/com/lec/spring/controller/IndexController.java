package com.lec.spring.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
//	@PostMapping("/checkPw/{pw}")
//	@ResponseBody
//	public int currentCheckPw(@PathVariable String nickname) {
//
	// 이렇게 되면 암호화된 비밀번호를 어떻게 복호화해서 가져오는지?
	// 방법 찾으면 sql에 추가하고 .js 함수 완성
	
//		;
//	}
	
	@RequestMapping(value = "/logincheck", method = RequestMethod.GET)
	@ResponseBody
	public String loginPage(HttpServletRequest request) {
	    String referrer = request.getHeader("Referer");
	    request.getSession().setAttribute("prevPage", referrer);
	    return referrer;
	}

	@RequestMapping(value = "/logoutcheck", method = RequestMethod.GET)
	@ResponseBody
	public String logoutPage(HttpServletRequest request) {
	    String referrer = request.getHeader("Referer");
	    request.getSession().setAttribute("prevPage", referrer);
	    return referrer;
	}
	
	@PostMapping("/joinOk")
	public String joinOk(MemberDTO dto) {
		System.out.println(dto);	// 잘 가져왔는지 확인
		
		// pw 인코더
		String rawPassword = dto.getPw();
		String encPassword = passwordEncoder.encode(rawPassword);	// 원본을 암호화
		dto.setPw(encPassword); // 암호와된 pw세팅
		
		MemberService.addMember(dto);
		
		return "redirect:/modacon";	// 회원가입 완료시 로그인 페이지로 이동
	}
	
	//(/update)
	@PostMapping("/update")
	public String update(MemberDTO dto) {
		
		System.out.println(dto);
		System.out.println(MemberService.changeMember(dto));
	
		
		return "redirect:/modacon";
	}
	
	
	//(/pwChange)
	@PostMapping("/pwChange")
	public String pwChange(MemberDTO dto) {
		
		String changePassword = dto.getChangepw();	// 바꿀 비밀번호
		String currentPw = dto.getPw();			// 현재 비밀번호
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		if(encoder.matches(changePassword, currentPw)) {
		
			String encPassword = passwordEncoder.encode(changePassword);	// 원본을 암호화
			dto.setPw(encPassword); // 암호와된 pw세팅
			
			System.out.println(MemberService.changePassword(dto));
			System.out.println("변경성공");
			
			return "redirect:/modacon";
		
		}
		System.out.println("변경실패");
		
		return "redirect:/modacon";
	}
	
	
	//(/deleteOk)
	@PostMapping("/deleteOk")
	public String deleteOk(MemberDTO dto) {		
		System.out.println(MemberService.deleteMember(dto));
			
		return "redirect:/modacon";	// 로그아웃 실행
	}
	
}
