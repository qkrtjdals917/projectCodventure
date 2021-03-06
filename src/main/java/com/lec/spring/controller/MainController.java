package com.lec.spring.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
		MemberDTO dto = new MemberDTO(); // 삭제, 업데이트 시 dto데이터 필요. 그에 따른 코드 수정
		if (authentication != null) {
//			MemberDTO dto = new MemberDTO();
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();

			dto.setEmail(userDetails.getUsername());
			dto.setNickname(userDetails.getNickname());
			dto.setMember_uid(userDetails.getUid());

			model.addAttribute("member", dto);
		}
		return dto; // dto를 반환
	}

	// Mypage
	private void memberBoardCnt(Model model, Authentication authentication) {
		if (authentication != null) {
			MemberDTO dto = new MemberDTO();
			PrincipalDetails userDetails = (PrincipalDetails) authentication.getPrincipal();

			dto.setEmail(userDetails.getUsername());
			dto.setNickname(userDetails.getNickname());
			dto.setPhoneNumber(userDetails.getPhonNum());
			dto.setMember_uid(userDetails.getUid());
			dto.setPw(userDetails.getPassword());
			dto.setMemberBoardCnt(userDetails.getBordCnt());

			model.addAttribute("member", dto);
		}
	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@RequestMapping("")
	public String mainPage(Model model, Authentication authentication) {
		loginCheck(model, authentication);

		return "user/main";
	}

	@RequestMapping("/mainNtc")
	@ResponseBody
	public List<BoardDTO> mainNotice() {
		List<BoardDTO> list = null;
		list = userService.selectNotice();
		
		if (list.size() < 5) {
			list = list.subList(0, list.size());
		}
		else {
			list = list.subList(0, 5);
		}
		return list;
	}
		// 마이페이지
	@RequestMapping("/mypage")
	public String hy_myPage(Model model, Authentication authentication) {
		// loginCheck(model, authentication);

//		model.addAttribute("key","service.__()");
		// Service 로 데이터 가져와서 model 에 담아 view에 전달
		memberBoardCnt(model, authentication);

		return "user/mypage";
	}

	// Coin List ajax 페이지
	@GetMapping("/coin/getlist")
	@ResponseBody
	public ModaconAjaxList<CoinDTO> getCoinList(Model model) {
		ModaconAjaxList<CoinDTO> result = new ModaconAjaxList<CoinDTO>();

		if (!userService.selectCoinList().isEmpty()) {

			result.setStatus("success");
			result.setList(userService.selectCoinList());
			result.setCount(100);
		} else {
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

	// 커뮤니티 리스트, 페이징
	@GetMapping("/board/{page}/{pageRows}")
	@ResponseBody
	public BoardList<BoardDTO> boardList(@PathVariable int page, @PathVariable int pageRows, String type, String tag,
			Model model, Authentication authentication) {
		loginCheck(model, authentication);
		List<BoardDTO> list = null;

		// message
		StringBuffer message = new StringBuffer();
		String status = "FAIL";

		// 페이징 관련 세팅 값들
		// page : 현재 페이지
		// pageRows : 한 '페이지'에 몇개의 글을 리스트 할것인가?
		int writePages = 10; // 한 [페이징] 에 몇개의 '페이지'를 표현할 것인가?
		int totalPage = 0; // 총 몇 '페이지' 분량인가?
		int totalCnt = 0; // 글은 총 몇개인가?

		switch (type) {
		case "전체":
			if (tag.equals("전체")) {
				try {
					// 글 전체 개수 구하기
					totalCnt = userService.countBoard();

					// 총 몇페이지 분량?
					totalPage = (int) Math.ceil(totalCnt / (double) pageRows);

					// from: 몇번째 row 부터?
					int from = (page - 1) * pageRows; // MySQL 의 Limit 는 0-base

					list = userService.communityList(from, pageRows);

					if (list == null) {
						message.append("[리스트할 데이터가 없습니다]");
					} else {
						status = "OK";
					}
				} catch (Exception e) {
					e.printStackTrace();
					message.append("[트랜잭션 에러: " + e.getMessage() + "]");
				}
			} else {
				try {
					// 글 전체 개수 구하기
					totalCnt = userService.countTag(tag);

					// 총 몇페이지 분량?
					totalPage = (int) Math.ceil(totalCnt / (double) pageRows);

					// from: 몇번째 row 부터?
					int from = (page - 1) * pageRows; // MySQL 의 Limit 는 0-base

					list = userService.tagListPage(from, pageRows, tag);

					if (list == null) {
						message.append("[리스트할 데이터가 없습니다]");
					} else {
						status = "OK";
					}
				} catch (Exception e) {
					e.printStackTrace();
					message.append("[트랜잭션 에러: " + e.getMessage() + "]");
				}
			}
			break;
		default:
			if (tag.equals("전체")) {
				try {
					// 글 전체 개수 구하기
					totalCnt = userService.countType(type);

					// 총 몇페이지 분량?
					totalPage = (int) Math.ceil(totalCnt / (double) pageRows);

					// from: 몇번째 row 부터?
					int from = (page - 1) * pageRows; // MySQL 의 Limit 는 0-base

					list = userService.typeListPage(from, pageRows, type);

					if (list == null) {
						message.append("[리스트할 데이터가 없습니다]");
					} else {
						status = "OK";
					}
				} catch (Exception e) {
					e.printStackTrace();
					message.append("[트랜잭션 에러: " + e.getMessage() + "]");
				}
			} else {
				try {
					// 글 전체 개수 구하기
					totalCnt = userService.countTag(tag);

					// 총 몇페이지 분량?
					totalPage = (int) Math.ceil(totalCnt / (double) pageRows);

					// from: 몇번째 row 부터?
					int from = (page - 1) * pageRows; // MySQL 의 Limit 는 0-base

					list = userService.tagListPage(from, pageRows, tag);

					if (list == null) {
						message.append("[리스트할 데이터가 없습니다]");
					} else {
						status = "OK";
					}
				} catch (Exception e) {
					e.printStackTrace();
					message.append("[트랜잭션 에러: " + e.getMessage() + "]");
				}
			}
		}

		BoardList<BoardDTO> result = new BoardList<BoardDTO>();

		result.setStatus(status);
		result.setMessage(message.toString());

		if (list != null) {
			result.setCount(list.size());
			result.setList(list);
		}

		result.setPage(page);
		result.setTotalPage(totalPage);
		result.setWritePages(writePages);
		result.setPageRows(pageRows);
		result.setTotalCnt(totalCnt);

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
		String status = "FAIL";
		int count = 0;

		// 태그의 문자열이 빈 문자열이면 null 값으로 처리
		if (dto.getTag().isEmpty()) {
			dto.setTag(null);
		}

		String m_dto_uid = String.valueOf(m_dto.getMember_uid()).trim();

		if (m_dto_uid.isEmpty()) {
			message.append("로그인 해주세요.");
			list.setMessage(message.toString());
			list.setStatus(status);
			return list;
		}

		if (dto.getSubject().trim().isEmpty()) {
			message.append("제목을 입력해주세요.");
			list.setMessage(message.toString());
			list.setStatus(status);
			return list;
		}

		if (dto.getContent().trim().isEmpty() || dto.getContent().trim().length() < 3) {
			message.append("최소 3글자 이상의 내용을 입력해주세요.");
			list.setMessage(message.toString());
			list.setStatus(status);
			return list;
		}

		try {
			count = userService.write(dto);
			if (count == 0) {
				message.append("트랜잭션 실패");
			} else {
				status = "OK";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message.append("트랜잭션 에러: " + e.getMessage());
		}

		list.setUid(dto.getBoard_uid());
		list.setCount(count);
		list.setMessage(message.toString());
		list.setStatus(status);
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

		return result;
	}

	// 게시글 수정 페이지
	@RequestMapping("board/update")
	public String update(int uid, Model model, Authentication authentication) {
		MemberDTO m_dto = loginCheck(model, authentication);

		// 보드 uid가 존재하지 않는다면
		if (userService.selectOne(uid).isEmpty()) {
			model.addAttribute("list", userService.selectOne(uid));
			model.addAttribute("ERR", "해당글이 존재하지 않습니다.");
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

	// 게시글 수정
	@PutMapping("board/update")
	@ResponseBody
	public BoardList updateOk(BoardDTO dto, Model model, Authentication authentication) {
		MemberDTO m_dto = loginCheck(model, authentication);
		BoardList list = new BoardList();
		StringBuffer message = new StringBuffer();
		String status = "FAIL";
		int count = 0;

		// 태그의 문자열이 빈 문자열이면 null 값으로 처리
		if (dto.getTag().isEmpty()) {
			dto.setTag(null);
		}

		String m_dto_uid = String.valueOf(m_dto.getMember_uid()).trim();

		if (m_dto_uid.isEmpty()) {
			message.append("로그인 해주세요.");
			list.setMessage(message.toString());
			list.setStatus(status);
			return list;
		}

		if (dto.getSubject().trim().isEmpty()) {
			message.append("제목을 입력해주세요.");
			list.setMessage(message.toString());
			list.setStatus(status);
			return list;
		}

		if (dto.getContent().trim().isEmpty() || dto.getContent().trim().length() < 3) {
			message.append("최소 3글자 이상의 내용을 입력해주세요.");
			list.setMessage(message.toString());
			list.setStatus(status);
			return list;
		}

		try {
			count = userService.update(dto);
			if (count == 0) {
				message.append("트랜잭션 실패");
			} else {
				status = "OK";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message.append("트랜잭션 에러: " + e.getMessage());
		}

		list.setUid(dto.getBoard_uid());
		list.setCount(count);
		list.setMessage(message.toString());
		list.setStatus(status);
		return list;
	}

	// 공지 리스트
	@RequestMapping("/notice")
	public String notice(Model model, Authentication authentication) {
		loginCheck(model, authentication);
		return "user/notice/list";
	}

	// 공지사항 리스트 페이징
	@GetMapping("/notice/{page}/{pageRows}")
	@ResponseBody
	public BoardList<BoardDTO> boardList(@PathVariable int page, @PathVariable int pageRows, Model model, Authentication authentication) {
		loginCheck(model, authentication);
		List<BoardDTO> list = null;

		// message
		StringBuffer message = new StringBuffer();
		String status = "FAIL";

		// 페이징 관련 세팅 값들
		// page : 현재 페이지
		// pageRows : 한 '페이지'에 몇개의 글을 리스트 할것인가?
		int writePages = 10; // 한 [페이징] 에 몇개의 '페이지'를 표현할 것인가?
		int totalPage = 0; // 총 몇 '페이지' 분량인가?
		int totalCnt = 0; // 글은 총 몇개인가?
		
		try {
			// 글 전체 개수 구하기
			totalCnt = userService.countNotice();

			// 총 몇페이지 분량?
			totalPage = (int) Math.ceil(totalCnt / (double) pageRows);

			// from: 몇번째 row 부터?
			int from = (page - 1) * pageRows; // MySQL 의 Limit 는 0-base

			list = userService.noticeList(from, pageRows);

			if (list == null) {
				message.append("[리스트할 데이터가 없습니다]");
			} else {
				status = "OK";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message.append("[트랜잭션 에러: " + e.getMessage() + "]");
		}
		
		BoardList<BoardDTO> result = new BoardList<BoardDTO>();

		result.setStatus(status);
		result.setMessage(message.toString());

		if (list != null) {
			result.setCount(list.size());
			result.setList(list);
		}

		result.setPage(page);
		result.setTotalPage(totalPage);
		result.setWritePages(writePages);
		result.setPageRows(pageRows);
		result.setTotalCnt(totalCnt);
		
		System.out.println(result.getList().get(1));
		
		return result;
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
	public int likeUp(Model model, BoardDTO dto, Authentication authentication) {
		loginCheck(model, authentication);
		int count = userService.likeUp(dto);
		return count;
	}

	// 추천취소
	@DeleteMapping("board/like")
	@ResponseBody
	public int likeDown(Model model, BoardDTO dto, Authentication authentication) {
		loginCheck(model, authentication);
		int count = userService.likeDown(dto);
		return count;
	}

	// 추천수 카운트
	@PostMapping("board/likeCount")
	@ResponseBody
	public int likeCount(int uid) {
		int count = 0;
		count = userService.likeCount(uid);
		System.out.println(count);
		return count;
	}

	// 추천여부 확인
	@PostMapping("board/likeChk")
	@ResponseBody
	public int likeCnt(Model model, int board_uid, Authentication authentication) {
		MemberDTO m_dto = loginCheck(model, authentication);

		int likecheck = 0;

		likecheck = userService.likeChk(board_uid, m_dto.getMember_uid());

		return likecheck;

	}

	// 신고
	@PostMapping("board/report")
	@ResponseBody
	public int report(Model model, @RequestParam Map<String, Object> param, Authentication authentication) {
		loginCheck(model, authentication);
		int count = userService.report(param);
		return count;
	}

}
