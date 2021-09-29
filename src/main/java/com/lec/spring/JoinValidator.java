package com.lec.spring;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.lec.spring.domain.member.MemberDTO;

public class JoinValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// TODO Auto-generated method stub
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberDTO dto = (MemberDTO) target;
		
		String email = dto.getEmail();
		if(email == null || email.trim().equals("")) {
			errors.rejectValue("email", "empty email");
		}

	}

}
