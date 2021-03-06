package com.lec.spring.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
    public CustomLoginSuccessHandler(String defaultTargetUrl) {
        setDefaultTargetUrl(defaultTargetUrl);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, 
    	Authentication authentication) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            String redirectUrl = (String) session.getAttribute("prevPage");
            if (redirectUrl != null) {
            	session.setAttribute("loginConfirm", "success");
//                session.removeAttribute("prevPage");
                getRedirectStrategy().sendRedirect(request, response, "/loginConfirm");
            } else {
            	session.setAttribute("loginConfirm", "success");
            	getRedirectStrategy().sendRedirect(request, response, "/loginConfirm");
            }
        } else {
        	//session.setAttribute("loginConfirm", "success");
        	getRedirectStrategy().sendRedirect(request, response, "/loginConfirm");
        }
    }
}