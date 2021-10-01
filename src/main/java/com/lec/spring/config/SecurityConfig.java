package com.lec.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import com.lec.spring.service.MemberService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	// 인코딩 주입 받아서 사용
	@Bean
	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
	
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		http.authorizeRequests()
			// 인증에 대한 세팅

			// /modacon/board/write/** 으로 들어오는 요청 인증
		
		
			// /modacon/login/** 으로 들어오는 요청은 인증 / mypage도 마찬가지인데 경로가 문제....
			.antMatchers("/modacon/login/**").authenticated()
			
			// /modacon/mypage/**는 로그인 필요
			.antMatchers("/modacon/mypage/**").authenticated()
			
			// 그 밖의 요청은 모두 허용
			.anyRequest().permitAll()
			
			// 접근오류 발생시 /login으로 이동시키기
			.and()
			.formLogin()
			.loginPage("/modacon")
			
			// 로그인 처리
			.usernameParameter("email")
			.passwordParameter("pw")
			.loginProcessingUrl("/loginOk")
			.defaultSuccessUrl("/modacon")		// login 성공시 "/"로 이동
			
			
//			.permitAll()
//			.and()
//			// 로그아웃 처리
//			.logout()
//            .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
//            .logoutSuccessUrl("/login")
//            .invalidateHttpSession(true)
		;
		
	}
	
//    @Override
//    public void configure(AuthenticationManagerBuilder auth) throws Exception {
//        auth.userDetailsService(memberService).passwordEncoder(encoder());
//    }
	
}
