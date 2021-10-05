package com.lec.spring.domain.ajax;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ModaconAjaxResult{
	
	int count;
	String status;
	String message;
}
