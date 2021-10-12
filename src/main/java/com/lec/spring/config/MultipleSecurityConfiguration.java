package com.lec.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

@Configuration
@EnableWebSecurity
public class MultipleSecurityConfiguration {
	
	@Bean
	public BCryptPasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Configuration
	@Order(1)
	public static class MemberSecurityConfig extends WebSecurityConfigurerAdapter {
	
		@Bean
		public AuthenticationSuccessHandler successHandler() {
		    return new CustomLoginSuccessHandler("/defaultUrl");
		}
		
		@Bean
		public AuthenticationFailureHandler failureHandler() {
			return new CustomLoginFailureHandler();
		}
		
		@Bean
		public SimpleUrlLogoutSuccessHandler logoutSuccessHandler() {
		    return new CustomLogoutSuccessHandler();
		}
		
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.csrf().disable();
			http.antMatcher("/modacon/**")
				.authorizeRequests()
				// 인증에 대한 세팅
	
				// /modacon/board/** 으로 들어오는 요청 인증
				.antMatchers("/modacon/board/**").authenticated()
			
				// /modacon/login/** 으로 들어오는 요청은 인증 / mypage도 마찬가지인데 경로가 문제....
				//.antMatchers("/modacon/login/**").authenticated()
				
				// /modacon/mypage/**는 로그인 필요
				.antMatchers("/modacon/mypage/**").authenticated()
				
				// 그 밖의 요청은 모두 허용
				.anyRequest().permitAll()
				
				// 접근오류 발생시 /login으로 이동시키기
				.and()
				.formLogin()
				.loginPage("/modacon")
	//			.failureUrl("/modacon?error=true")	// 여기서 처리하고 /loginOk로 가는데 우린 모달이다...
				.successHandler(successHandler())
				.failureHandler(failureHandler())
				// 로그인 처리
				.usernameParameter("email")
				.passwordParameter("pw")
				.loginProcessingUrl("/modacon/loginOk")
	//			.defaultSuccessUrl("/modacon")		// login 성공시 "/"로 이동
				// 로그인 실패처리
				
				.permitAll()
				.and()
				// 로그아웃 처리
				.logout()
				.logoutUrl("/modacon/logout")
				.logoutSuccessHandler(logoutSuccessHandler())
	            .invalidateHttpSession(false)
			;
			
		}
	}	// end MemberSecurityConfig class
	

	@Configuration
	@Order(2)
	public class AdminSecurityConfig extends WebSecurityConfigurerAdapter {

	//	관리자가 메인으로 로그인 한 상태에서 admin 접속 -> 바로 가능
	//	일반회원이 메인으로 로그인 한 상태에서 admin 접속 -> 재로그인(admin login 페이지 on)
	//	그러면 그 상태에서 메인으로 그냥 돌아가면 로그인상태인가? 
	//	1. admin 으로 들어가면 로그인 초기화 \
	//	2. 권한이 없을 때 로그인페이지가 열리는데 그걸 main 이랑 admin login 두개를 어떻게 따로 쓰지?
	//	3. 
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			http.csrf().disable();
			http.antMatcher("/modaconAdmin/**")
				.authorizeRequests()
				
				.antMatchers("/modaconAdmin/login").permitAll()
				
				// /modacon/admin 으로 들어오는 요청들은 인증, 권한 필요(1, 2)
				.antMatchers("/modaconAdmin/**").hasAuthority("1")
				
				//.antMatchers("/modaconAdmin/**").access(hasRole('ROLE_2'))
				.antMatchers("/modaconAdmin/**").hasAuthority("2")
				
				// 권한이 없는 사람이 접근시 이동
				.and()
				.exceptionHandling()
				.accessDeniedPage("/modaconAdmin/login")
				// /login으로 이동시키기
				.and()
				.formLogin()
				.loginPage("/modaconAdmin/login")
				.usernameParameter("email")
				.passwordParameter("pw")
				.loginProcessingUrl("/modaconAdmin/loginOk")
				.defaultSuccessUrl("/modaconAdmin")
				.and()
								
				// 로그아웃 처리
				.logout()
				.logoutUrl("/modaconAdmin/logout")
				.logoutSuccessUrl("/modaconAdmin/login")
				.invalidateHttpSession(true)
			;
		}
	}

}
//
//@Configuration
//@Order(1)
//public static class MemberSecurityConfig extends WebSecurityConfigurerAdapter {
//
//	// 인코딩 주입 받아서 사용
//	@Bean
//	@Primary
//	public BCryptPasswordEncoder encoder1() {
//		return new BCryptPasswordEncoder();
//	}
//	
//	@Bean
//	public AuthenticationSuccessHandler successHandler() {
//	    return new CustomLoginSuccessHandler("/defaultUrl");
//	}
//	
//	@Bean
//	public AuthenticationFailureHandler failureHandler() {
//		return new CustomLoginFailureHandler();
//	}
//	
//	@Bean
//	public SimpleUrlLogoutSuccessHandler logoutSuccessHandler() {
//	    return new CustomLogoutSuccessHandler();
//	}
//	
//	@Override
//	protected void configure(HttpSecurity http) throws Exception {
//		http.csrf().disable();
//		http.antMatcher("/modacon/**")
//			.authorizeRequests()
//			// 인증에 대한 세팅
//
//			// /modacon/board/write/** 으로 들어오는 요청 인증
//			.antMatchers("/modacon/board/write").authenticated()
//			.antMatchers("/modacon/board/delete").authenticated()
//			.antMatchers("/modacon/board/update").authenticated()
//		
//			// /modacon/login/** 으로 들어오는 요청은 인증 / mypage도 마찬가지인데 경로가 문제....
//			//.antMatchers("/modacon/login/**").authenticated()
//			
//			// /modacon/mypage/**는 로그인 필요
//			.antMatchers("/modacon/mypage/**").authenticated()
//			
//			// 그 밖의 요청은 모두 허용
//			.anyRequest().permitAll()
//			
//			// 접근오류 발생시 /login으로 이동시키기
//			.and()
//			.formLogin()
//			.loginPage("/modacon")
////			.failureUrl("/modacon?error=true")	// 여기서 처리하고 /loginOk로 가는데 우린 모달이다...
//			.successHandler(successHandler())
//			.failureHandler(failureHandler())
//			// 로그인 처리
//			.usernameParameter("email")
//			.passwordParameter("pw")
//			.loginProcessingUrl("/loginOk")
////			.defaultSuccessUrl("/modacon")		// login 성공시 "/"로 이동
//			// 로그인 실패처리
//			
//			.permitAll()
//			.and()
//			// 로그아웃 처리
//			.logout()
//			.logoutSuccessHandler(logoutSuccessHandler())
//            .invalidateHttpSession(false)
//		;
//		
//	}
//	
////    @Override
////    public void configure(AuthenticationManagerBuilder auth) throws Exception {
////        auth.userDetailsService(memberService).passwordEncoder(encoder());
////    }
//	
//}

//@Configuration
//@EnableWebSecurity
//@Order(2)
//class SecurityConfig2 extends WebSecurityConfigurerAdapter {
//	
//	@Bean
//	public BCryptPasswordEncoder encoder() {
//		return new BCryptPasswordEncoder();
//	}
//	관리자가 메인으로 로그인 한 상태에서 admin 접속 -> 바로 가능
//	일반회원이 메인으로 로그인 한 상태에서 admin 접속 -> 재로그인(admin login 페이지 on)
//	그러면 그 상태에서 메인으로 그냥 돌아가면 로그인상태인가? 
//	1. admin 으로 들어가면 로그인 초기화 \
//	2. 권한이 없을 때 로그인페이지가 열리는데 그걸 main 이랑 admin login 두개를 어떻게 따로 쓰지?
//	3. 
//	@Override
//	protected void configure(HttpSecurity http) throws Exception {
//		http.csrf().disable();
//		http.authorizeRequests()
//		
//			// /modacon/admin 으로 들어오는 요청들은 인증, 권한 필요(1, 2)
//			.antMatchers("/modacon/admin/**").access("hasRole(1)")
//			
//			.antMatchers("/modacon/admin/**").access("hasRole(2)")
//			
//			// /login으로 이동시키기
//			.and()
//			.formLogin()
//			.loginPage("/login")
//			
//			// 로그인 처리
//			
//		;
//	}
//}


