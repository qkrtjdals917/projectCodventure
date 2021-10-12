package com.lec.spring.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.spring.config.PrincipalDetails;
import com.lec.spring.domain.ajax.ModaconAjaxList;
import com.lec.spring.domain.comment.CommentDTO;
import com.lec.spring.domain.member.MemberDTO;
import com.lec.spring.service.BoardService;

@Controller
@RequestMapping("/modacon/board")
public class BoardController {
 
    @Autowired
    private BoardService boardService;
    
	@PostMapping("/addComment/{board_uid}")
	@ResponseBody
	public String ajax_addComment(@PathVariable int board_uid, CommentDTO cdto, 
			Authentication authentication) {
		
		if (authentication != null) {
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
			
			cdto.setMember_uid(userDetails.getUid());
		}
		cdto.setBoard_uid(board_uid);
		System.out.println(cdto);
		if (boardService.insert(cdto) == 1) {
			return "success";			
		}
		else {
			return "file";
		}
	}
    
	@GetMapping(value="/getComment/{board_uid}", produces="application/json; charset=utf8")
	@ResponseBody
	public ModaconAjaxList<CommentDTO> ajax_getComment(@PathVariable int board_uid) {
	    System.out.println("ajax_getComment");
		ModaconAjaxList<CommentDTO> result = new ModaconAjaxList<CommentDTO> ();
	    
	    // 해당 게시물 댓글
	    List<CommentDTO> comment = boardService.selectByBoard(board_uid);
	    int count = boardService.countByBoard(board_uid);
	    
	    result.setList(comment);
	    result.setCount(count);
	    
	    if(count > 0){
	    	result.setStatus("OK");
	    	
	    }
	    else {
	    	result.setStatus("FAIL");
	    	result.setMessage("empty comment");
	    }    
	    return result;
	    
	}
	
	@GetMapping(value="/deleteComment/{comment_uid}")
	@ResponseBody
	public int ajax_deleteComment(@PathVariable int comment_uid) {
	    int cnt = boardService.delete(comment_uid);

	    return cnt;
	    
	}
}
