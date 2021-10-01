package com.lec.spring.config;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.lec.spring.domain.member.MemberDTO;
import com.lec.spring.service.MemberService;

// /loginOk 주소요청이 오면 낚아채서 로그인 진행
// 로그인 진행이 완료되면 '시큐리티 session'에 넣어준다
//=> Security ContextHolder 라는 키값에다가 session 정보를 저장합니다.
// Authentication 안에 User 정보가 있어야 한다
// User 정보 객체는 ==> UserDetails 타입 객체여야 한다

// 따라서 로그인한 User 정보를 꺼내려면
// Security Session 에서
// 		-> Authentication 객체 꺼내고, 그 안에서
//				-> UserDetails 정보를 꺼내면 된다.
// 이걸 이용해서 사용자가 작성한 게시글을 가져오면 되려나?
public class PrincipalDetails implements UserDetails {	// UserDetails는 Spring Security에서 제공

	private MemberService memberService;
	public void setMemberService(MemberService memberService) {
		this.memberService = memberService;
	}
	
	private MemberDTO dto;
	
	public PrincipalDetails(MemberDTO dto) {
		System.out.println("PrincipalDetails(dto) 생성: " + dto);
		this.dto = dto;
	}
	
	// User가 갖고 있는 권환들 가져오기/ 여기는 인증만 다른 권한 X
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		System.out.println("getAuthorities() 호출");
		
		 return null;
	}

	@Override
	public String getPassword() {
		return dto.getPw();
	}

	@Override
	public String getUsername() {
		return dto.getEmail();
	}

	// 계정이 만료된건 아닌가?
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	// 계정이 잠긴건 아닌지?
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	// 계정 credential이 만료된건 아닌지?
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	// 계정이 활성화 되었는지?
	@Override
	public boolean isEnabled() {
		return true;
		// 1년동안 로그인 안하면 휴면계정으로 변경
		// 현재시간 - 로그인시간 => 1년을 초과하면 false
	}

	
}












