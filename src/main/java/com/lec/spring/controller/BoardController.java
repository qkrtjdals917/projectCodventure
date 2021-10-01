package com.lec.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lec.spring.service.BoardService;

@Controller
@RequestMapping("/modacon/board")
public class BoardController {
 
    @Autowired
    private BoardService boardService;
 
    /**
     * 댓글 등록(Ajax)
     * @param boardVO
     * @param request
     * @return
     * @throws Exception
     */
    
    
//    @RequestMapping(value="/board/addComment.do")
//    @ResponseBody
//    public String ajax_addComment(@ModelAttribute("boardVO") BoardVO boardVO, HttpServletRequest request) throws Exception{
//        
//        HttpSession session = request.getSession();
//        LoginVO loginVO = (LoginVO)session.getAttribute("loginVO");
//        
//        try{
//        
//            boardVO.setWriter(loginVO.getUser_id());        
//            boardService.addComment(boardVO);
//            
//        } catch (Exception e){
//            e.printStackTrace();
//        }
//        
//        return "success";
//    }
    
    /**
     * 게시물 댓글 불러오기(Ajax)
     * @param boardVO
     * @param request
     * @return
     * @throws Exception
     */
//    @RequestMapping(value="{uid}/commentList", produces="application/json; charset=utf8")
//    @ResponseBody
//    public ResponseEntity ajax_commentList(@PathVariable int board_uid) {
//        
//        HttpHeaders responseHeaders = new HttpHeaders();
//        ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
//        
//        // 해당 게시물 댓글
//        List<BoardVO> commentVO = boardService.selectBoardCommentByCode(boardVO);
//        
//        if(commentVO.size() > 0){
//            for(int i=0; i<commentVO.size(); i++){
//                HashMap hm = new HashMap();
//                hm.put("c_code", commentVO.get(i).getC_code());
//                hm.put("comment", commentVO.get(i).getComment());
//                hm.put("writer", commentVO.get(i).getWriter());
//                
//                hmlist.add(hm);
//            }
//            
//        }
//        
//        JSONArray json = new JSONArray(hmlist);        
//        return new ResponseEntity(json.toString(), responseHeaders, HttpStatus.CREATED);
//        
//    }
}
