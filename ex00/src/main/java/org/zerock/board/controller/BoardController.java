package org.zerock.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/board")
public class BoardController {
	
	@GetMapping("/list.do")
	public String list() {
		System.out.println("BoardController.list()");
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
