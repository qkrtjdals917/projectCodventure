package com.lec.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.lec.spring.domain.member.MemberDTO;
import com.lec.spring.service.MemberService;

@Service
public class PrincipalDetailsService implements UserDetailsService {

	@Autowired
	private MemberService memberService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		System.out.println("loadUserByUsername(" + username + ")");
		
		MemberDTO dto = memberService.selectByEmail(username);
		
		// 해당 Email의 user가 있다면
		if(dto != null) {
			PrincipalDetails userDetails = new PrincipalDetails(dto);
			userDetails.setMemberService(memberService);
			return userDetails;
		}
		
		// 찾지 못했으면!
		return null;
	}

}
