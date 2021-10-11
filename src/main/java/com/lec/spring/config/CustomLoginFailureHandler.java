package com.lec.spring.config;

import java.io.IOException;

import javax.security.auth.login.AccountExpiredException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class CustomLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		HttpSession session = request.getSession();
        if (session != null) {
            String redirectUrl = (String) session.getAttribute("prevPage");
            System.out.println(redirectUrl);
            if (redirectUrl != null) {
            	session.setAttribute("loginConfirm", "failure");
//            	session.removeAttribute("prevPage");
            	getRedirectStrategy().sendRedirect(request, response, "/loginConfirm");
            } else {
            	session.setAttribute("loginConfirm", "failure");
            	getRedirectStrategy().sendRedirect(request, response, "/loginConfirm");
            }
            
        } else {
        	//session.setAttribute("loginConfirm", "failure");
        	getRedirectStrategy().sendRedirect(request, response, "/loginConfirm");
        }
        
	}
	
//	private final String FAILUER_URL = "/modacon?error=true";
//	
//	@Override
//	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
//			AuthenticationException exception) throws IOException, ServletException {
//
//
//		if(exception instanceof AuthenticationServiceException) {
//			request.setAttribute("loginFailMsg", "존재하지 않는 사용자입니다.");
//			
//		} else if(exception instanceof BadCredentialsException) {
//			request.setAttribute("loginFailMsg", "아이디 또는 비밀번호가 틀립니다");
//		} 
//		
//		// 로그인 페이지로 다시 포워딩
//		// 그런데 우린 모달창으로 넘어가야해서 좀 힘들
//		request.getRequestDispatcher(FAILUER_URL).forward(request, response);
//		
//		
//	}


}
