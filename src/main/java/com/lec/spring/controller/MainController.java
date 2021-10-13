package com.lec.spring.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lec.spring.config.PrincipalDetails;
import com.lec.spring.domain.ajax.ModaconAjaxList;
import com.lec.spring.domain.board.BoardDTO;
import com.lec.spring.domain.board.BoardList;
import com.lec.spring.domain.board.BoardResult;
import com.lec.spring.domain.coin.CoinDTO;
import com.lec.spring.domain.member.MemberDTO;
import com.lec.spring.service.UserService;

@Controller
@RequestMapping("/modacon")
public class MainController {
	private UserService userService;
	
	// 로그인 체크 함수
	private MemberDTO loginCheck(Model model, Authentication authentication) {
		MemberDTO dto = new MemberDTO();	// 삭제, 업데이트 시 dto데이터 필요. 그에 따른 코드 수정
		if (authentication != null) {
//			MemberDTO dto = new MemberDTO();
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
			
			// 확인용 코드
//			System.out.println("Email정보 : " + userDetails.getUsername());
//			System.out.println("Nickname정보 : " + userDetails.getNickname());
//			System.out.println("UID정보 : " + userDetails.getUid());
			
			dto.setEmail(userDetails.getUsername());
			dto.setNickname(userDetails.getNickname());
			dto.setMember_uid(userDetails.getUid());
			
			model.addAttribute("member" , dto);
		}
		return dto;	// dto를 반환
	}
	
	// Mypage
	private void memberBoardCnt(Model model, Authentication authentication) {
		if (authentication != null) {
			MemberDTO dto = new MemberDTO();
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();
			
			// 확인용 코드
			System.out.println("Email정보 : " + userDetails.getUsername());
			System.out.println("Nickname정보 : " + userDetails.getNickname());
			System.out.println("Phonenum정보 : " + userDetails.getPhonNum());
			System.out.println("cnt정보 : " + userDetails.getBordCnt());
			
			dto.setEmail(userDetails.getUsername());
			dto.setNickname(userDetails.getNickname());
			dto.setPhoneNumber(userDetails.getPhonNum());
			dto.setMember_uid(userDetails.getUid());
			dto.setPw(userDetails.getPassword());			
			dto.setMemberBoardCnt(userDetails.getBordCnt());
			
			model.addAttribute("member" , dto);
		}
	}
	
	
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping("")
	public String mainPage(Model model, Authentication authentication) {
		
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
//		if (principal != null) {
//			System.out.println("ID정보 : " + principal.getName());
//			System.out.println("ID정보 : " + principal.getNickname());
//			System.out.println("ID정보 : " + principal.getName());
//		}
				
		loginCheck(model, authentication);

		return "user/main";
	}


	// 마이페이지
	@RequestMapping("/mypage")
	public String hy_myPage(Model model, Authentication authentication) {
		//loginCheck(model, authentication);
		
//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
		memberBoardCnt(model, authentication);
		
		return "user/mypage";
	}
	
	// Coin List ajax 페이지
	@GetMapping("/coin/getlist")
	@ResponseBody
	public ModaconAjaxList<CoinDTO> getCoinList (Model model ) {
		ModaconAjaxList<CoinDTO> result = new ModaconAjaxList<CoinDTO> ();
		
		
		if( !userService.selectCoinList().isEmpty()) {
			
			result.setStatus("success");
			result.setList(userService.selectCoinList());
			result.setCount(100);
		}
		else  {
			result.setStatus("fail");
		}
		
		
		return result;
	}
	
	// 코인페이지
	@RequestMapping("/coin")
	public String coin(Model model, Authentication authentication) {
		loginCheck(model, authentication);
		
		return "user/coin_main";
	}

	// 커뮤니티 리스트
	@RequestMapping("/board")
	public String board(Model model, Authentication authentication) {
		loginCheck(model, authentication);
		return "user/board/list";
	}

	// 게시판 변경
	@PostMapping("/board")
	@ResponseBody
	public BoardList infoBoard(String type, String tag, Model model, Authentication authentication) {
		loginCheck(model, authentication);
		
		List<BoardDTO> list = null;
		
		switch(type) {
		case "전체":
			if(tag.equals("전체")) {
				list = userService.communityList();
			} else {
				list = userService.tagList(tag);
			}
			break;
		default:
			if(tag.equals("전체")) {
				list = userService.typeList(type);
			} else {
				list = userService.tagList(tag);
			}
		}
		
		BoardList result = new BoardList();
		result.setList(list);
		return result;
	}

	// 커뮤니티 뷰
	@RequestMapping("/board/view")
	public String communityView(int uid, Model model, Authentication authentication) {
		loginCheck(model, authentication);
		model.addAttribute("list", userService.viewContent(uid));
		return "user/board/view";
	}

	// 글작성 뷰
	@RequestMapping("/board/write")
	public String write(Model model, Authentication authentication) {
		loginCheck(model, authentication);
		return "user/board/write";
	}
	
	// 게시판 글 작성
	@PostMapping("/board/write")
	@ResponseBody
	public BoardList writeOk(BoardDTO dto, Model model, Authentication authentication) {
		MemberDTO m_dto = loginCheck(model, authentication);
		BoardList list = new BoardList();
		StringBuffer message = new StringBuffer();
		
		// 태그의 문자열이 빈 문자열이면 null 값으로 처리
		if (dto.getTag().isEmpty()) {
			dto.setTag(null);
		}
		
		model.addAttribute("result", userService.write(dto));
		model.addAttribute("dto", dto);
		return list;
	}
	
	// 게시글 삭제
	@DeleteMapping("/board/view")
	@ResponseBody
	public BoardResult delete(int uid, Model model, Authentication authentication) {
		MemberDTO m_dto = loginCheck(model, authentication);
		BoardResult result = new BoardResult();
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		int count = 0;
		
		if (userService.selectOne(uid).isEmpty()) { // 보드 uid가 존재하지 않는다면
			message.append("해당 게시글이 이미 존재하지 않습니다.");
		}

		String board_m_uid = userService.selectOne(uid).get(0).getMember_uid().trim();
		String m_dto_uid = String.valueOf(m_dto.getMember_uid()).trim();
		
		// 보드의 멤버 아이디와 로그인 된 멤버아이디가 같을 경우
		try {
			if (board_m_uid.equals(m_dto_uid)) {
				count = userService.delete(uid);
				status = "OK";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message.append("트랜잭션 에러: " + e.getMessage());
		}
		
		result.setCount(count);
		result.setStatus(status);
		result.setMessage(message.toString());
		
		System.out.println(result);
		
		return result;
	}
	
	// 게시글 수정
	@RequestMapping("board/update")
	public String update(int uid, Model model, Authentication authentication) {
		MemberDTO m_dto = loginCheck(model, authentication);
		
		// 보드 uid가 존재하지 않는다면
		if (userService.selectOne(uid).isEmpty()) {
			model.addAttribute("list", userService.selectOne(uid));
			return "user/board/update";
		}
		
		String board_m_uid = userService.selectOne(uid).get(0).getMember_uid().trim();
		String m_dto_uid = String.valueOf(m_dto.getMember_uid());
		
		// 수정화면 접속 시 멤버 검사
		if (board_m_uid.equals(m_dto_uid)) {
			model.addAttribute("list", userService.selectOne(uid));
			return "user/board/update";
		} else {
			model.addAttribute("ERR", "해당글의 작성자가 아니거나 잘못된 접근입니다.");
			return "user/board/update";
		}
	}
	
	// 게시글 수정 완료페이지
	@PostMapping("board/updateOk")
	public String updateOk(Model model, BoardDTO dto, Authentication authentication) {
		loginCheck(model, authentication);
		
		// 태그의 문자열이 빈 문자열이면 null 값으로 처리
		if (dto.getTag().isEmpty()) {
			dto.setTag(null);
		}
		
		System.out.println(dto);
		
		model.addAttribute("result", userService.update(dto));
		model.addAttribute("dto", dto);
		return "user/board/updateOk";
	}
	
	// 공지 리스트
	@RequestMapping("/notice")
	public String notice(Model model, Authentication authentication) {
		loginCheck(model, authentication);
		model.addAttribute("list", userService.noticeList());
		return "user/notice/list";
	}

	// 공지 뷰
	@RequestMapping("notice/view")
	public String noticeView(int uid, Model model, Authentication authentication) {
		loginCheck(model, authentication);
		model.addAttribute("list", userService.viewContent(uid));
		return "user/notice/view";
	}

	// 추천
	@PostMapping("board/like")
	@ResponseBody
	public void likeUp(Model model, BoardDTO dto, Authentication authentication) {
		loginCheck(model, authentication);
		userService.likeUp(dto);
	}
	
	// 추천수 카운트
	@PostMapping("board/likeCount")
	@ResponseBody
	public int likeCount(int uid) {
		int count = 0;
		System.out.println(uid);
		count = userService.likeCount(uid);
		return count;
	}
	
	// 신고
	@PostMapping("board/report")
	@ResponseBody
	public void report(Model model, @RequestParam Map<String, Object> param, Authentication authentication) {
		loginCheck(model, authentication);
		System.out.println(param);
		userService.report(param);
		
	}

}
