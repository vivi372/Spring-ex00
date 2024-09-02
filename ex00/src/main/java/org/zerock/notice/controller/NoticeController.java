package org.zerock.notice.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.member.vo.LoginVO;
import org.zerock.notice.service.NoticeService;
import org.zerock.notice.vo.NoticeVO;

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
	public String list(Model model,HttpServletRequest request,HttpSession session) throws Exception {
		log.info("공지 사항 리스트");
		
		PageObject pageObject = PageObject.getInstance(request);
		
		LoginVO login = (LoginVO) session.getAttribute("login");
		long gradeNo = 0;
		if(login != null) 
			gradeNo = login.getGradeNo();
		if(gradeNo < 9 ) pageObject.setPeriod("pre");
		else pageObject.setPeriod((request.getParameter("period")==null)?"all":request.getParameter("period"));
		
		model.addAttribute("list",service.list(pageObject));
		
		log.info(pageObject);
		model.addAttribute("pageObject",pageObject);
		
		return "notice/list";
		
	}
	
	@GetMapping("view.do")
	public String view(Model model,long no) {
		
		model.addAttribute("vo", service.view(no));
		
		return "notice/view";
	}
	

	@GetMapping("writeForm.do")
	public String writeForm() {
		
		return "notice/writeForm";
	}
	
	@PostMapping("write.do")
	public String write(NoticeVO vo) {
		
		service.write(vo);
		
		return "redirect:list.do";
	}
	
}
