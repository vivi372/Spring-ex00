package org.zerock.notice.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.notice.service.NoticeService;


import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice")
@Log4j
public class NoticeController {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeService service;
	
	@GetMapping("list.do")
	public String list(Model model,PageObject pageObject) {
		log.info("공지 사항 리스트");
		
		model.addAttribute("list",service.list(pageObject));
		model.addAttribute("pageObject",pageObject);
		
		return "notice/list";
		
	}
	
}
