package org.zerock.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.board.service.BoardService;

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
	
	@GetMapping("/list.do")
	public String list() {
		log.info("list()");
		service.list();
		return "board/list";
	}
	@GetMapping("/view.do")
	public String view() {
		System.out.println("BoardController.view()");
		return "board/view";
	}
	@GetMapping("/writeForm.do")
	public String writeForm() {
		System.out.println("BoardController.writeForm()");
		return "board/writeForm";
	}
	@PostMapping("/write.do")
	public String write() {
		System.out.println("BoardController.write()");
		return "redirect:list.do";
	}
	@GetMapping("/updateForm.do")
	public String updateForm() {
		System.out.println("BoardController.updateForm()");
		return "board/updateForm";
	}
	@PostMapping("/update.do")
	public String update() {
		System.out.println("BoardController.update()");
		return "redirect:view.do";
	}
	@PostMapping("/delete.do")
	public String delete() {
		System.out.println("BoardController.delete()");
		return "redirect:list.do";
	}
	
}
