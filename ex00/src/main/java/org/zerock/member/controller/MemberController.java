package org.zerock.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.service.MemberService;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;
import com.webjjang.util.page.PageObject;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {
	
	//자동 DI
	@Setter(onMethod_ = @Autowired)
	@Qualifier("memberServiceImpl")
	private MemberService service;
	
	//회원 관리 리스트
	@GetMapping("/list.do")
	//public ModelAndView list(Model model) {
	public String list(Model model,HttpServletRequest request) throws Exception {
		log.info("list()");				
		//페이지 처리를 위한 객체 생성
		PageObject pageObject = PageObject.getInstance(request);
		//model에 담으면 자동으로 request에 담긴다. - 차리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject));		
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);		
		
		
		return "member/list";
		
		//ModelAndView
//		ModelAndView mav = new ModelAndView();
//		mav.addObject("list", service.list());
//		mav.setViewName("member/list");
//		
//		return mav;
	}
	//회원 관리 상세보기
	@GetMapping("/view.do")
	public String view(long no,long inc,Model model) {
		log.info("view()");		
		long[] longs = {no,inc};
		model.addAttribute("vo",service.view(longs));
		return "member/view";
	}
	//회원 관리 글 등록 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "member/writeForm";
	}
	//회원 관리 글 등록 처리
	@PostMapping("/write.do")
	public String write(MemberVO vo,int perPageNum,RedirectAttributes rttr) {
		log.info("write.do - vo:"+vo);
		service.write(vo);
		//처리 결과 출력
		rttr.addFlashAttribute("msg", "회원 가입이 성공적으로 처리되었습니다.");
		return "redirect:list.do?perPageNum="+perPageNum;
	}
	//회원 관리 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(long no,Model model) {
		log.info("updateForm.do");
		model.addAttribute("vo",service.view(new long[] {no,0}));
		
		return "member/updateForm";
	}
	//회원 관리 수정 처리
	@PostMapping("/update.do")
	public String update(MemberVO vo,HttpServletRequest request,RedirectAttributes rttr) throws Exception {
		log.info("update.do - vo:"+vo);
		int result = service.update(vo);
		PageObject pageObject = PageObject.getInstance(request);
		
		if(result > 0) {
			rttr.addFlashAttribute("msg", "회원 수정이 성공적으로 처리되었습니다.");
			return "redirect:view.do?id="+vo.getId()+"&inc=0&"+pageObject.getPageQuery();			
		} else {
			rttr.addFlashAttribute("msg", "비밀번호 달라 수정이 실패했습니다. 다시 입력해주세요");
			return "redirect:updateForm.do?id="+vo.getId()+"&"+pageObject.getPageQuery();	
		}		
	}
	//회원 관리 삭제 처리
	@PostMapping("/delete.do")
	public String delete(MemberVO vo,RedirectAttributes rttr,HttpServletRequest request) throws Exception {
		log.info("delete.do"+vo);
		int result = service.delete(vo);
		PageObject pageObject = PageObject.getInstance(request);
		if(result > 0) {
			rttr.addFlashAttribute("msg", vo.getId()+"인 회원 삭제가 성공적으로 처리되었습니다.");
			return "redirect:list.do?perPageNum="+pageObject.getPerPageNum();
		} else {
			//rttr.addFlashAttribute("msg", "비밀번호 달라 수정이 실패했습니다. 다시 입력해주세요");
			rttr.addFlashAttribute("reDelete", true);
			return "redirect:view.do?id="+vo.getId()+"&inc=0&"+pageObject.getPageQuery();
		}
	}
	
	//------------------------로그인,로그아웃 처리-------------------------
	
	//회원 관리 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {	
		return "member/loginForm";
	}
	
	//회원 관리 로그인
	@PostMapping("/login.do")
	public String view(LoginVO vo,HttpSession session,RedirectAttributes rttr) {		
		LoginVO login = service.login(vo);
		if(login == null) {
			rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀렸습니다. 다시 입력해주세요.");
			return "redirect:/member/loginForm.do";
		}
		session.setAttribute("login", login);
		rttr.addFlashAttribute("msg", "어서오세요 "+login.getName()+"님");
		return "redirect:/main/main.do";
	}
	
	//회원 관리 글
	@GetMapping("/logout.do")
	public String logout(HttpSession session,RedirectAttributes rttr) {	
		session.removeAttribute("login");
		rttr.addFlashAttribute("msg", "로그아웃이 성공적으로 처리되었습니다.");
		return "redirect:/main/main.do";
	}
}
