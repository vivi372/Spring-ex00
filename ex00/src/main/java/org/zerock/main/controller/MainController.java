package org.zerock.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {

	@GetMapping({"/","/main.do"})
	public String goMain() {
		log.info("redirect main");		
		return "redirect:/main/main.do";
	}
	
	@GetMapping("/main/main.do")
	public String main(Model model) {
		log.info("/main/main.do ............");		
		return "main/main";
	}
	
}
