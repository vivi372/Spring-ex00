package org.zerock.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.board.service.BoardService;
import org.zerock.board.vo.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	//자동 DI
	@Setter(onMethod_ = @Autowired)
	@Qualifier("boardService")
	private BoardService service;
	
	//일반 게시판 리스트
	@GetMapping("/list.do")
	//public ModelAndView list(Model model) {
	public String list(Model model) {
		log.info("list()");
		//model에 담으면 자동으로 request에 담긴다. - 차리된 데이터를 Model에 저장
		model.addAttribute("list", service.list());		
		return "board/list";
		
		//ModelAndView
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("list", service.list());
//		mav.setViewName("board/list");
//		
//		return mav;
	}
	//일반 게시판 상세보기
	@GetMapping("/view.do")
	public String view(long no,long inc,Model model) {
		log.info("view()");		
		long[] longs = {no,inc};
		model.addAttribute("vo",service.view(longs));
		return "board/view";
	}
	//일반 게시판 글 등록 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "board/writeForm";
	}
	//일반 게시판 글 등록 처리
	@PostMapping("/write.do")
	public String write(BoardVO vo) {
		log.info("write.do - vo:"+vo);
		service.write(vo);
		return "redirect:list.do";
	}
	//일반 게시판 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(long no,Model model) {
		log.info("updateForm.do");
		model.addAttribute("vo",service.view(new long[] {no,0}));
		return "board/updateForm";
	}
	//일반 게시판 수정 처리
	@PostMapping("/update.do")
	public String update(BoardVO vo) {
		log.info("update.do - vo:"+vo);
		service.update(vo);
		return "redirect:view.do?no="+vo.getNo()+"&inc=0";
	}
	//일반 게시판 삭제 처리
	@PostMapping("/delete.do")
	public String delete(long no,String pw) {
		log.info("delete.do"+no+pw);
		service.delete(no,pw);
		return "redirect:list.do";
	}
	
}
