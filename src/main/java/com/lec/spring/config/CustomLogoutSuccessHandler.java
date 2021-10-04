package com.lec.spring.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

public class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {
	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		HttpSession session = request.getSession();
        if (session != null) {
            String redirectUrl = (String) session.getAttribute("prevPage");
            System.out.println(redirectUrl);
            if (redirectUrl != null) {
                getRedirectStrategy().sendRedirect(request, response, redirectUrl);
            } else {
                super.onLogoutSuccess(request, response, authentication);
            }
            
            session.invalidate();
        } else {
            super.onLogoutSuccess(request, response, authentication);
        }
        
		//여기에 로직 추가
//		super.onLogoutSuccess(request, response, authentication);
	}
}