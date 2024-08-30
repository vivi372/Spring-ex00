package org.zerock.goods.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.goods.service.GoodsService;
import org.zerock.goods.vo.GoodsVO;
import com.webjjang.util.page.PageObject;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Controller
@RequestMapping("/goods")
@Log4j
public class GoodsController {
	
	//자동 DI
	@Setter(onMethod_ = @Autowired)
	@Qualifier("goodsServiceImpl")
	private GoodsService service;
	
	//상품 관리 리스트
	@GetMapping("/list.do")
	//검색을 위한 데이터를 따로 받아야 한다.
	public String list(Model model,HttpServletRequest request) throws Exception {
		log.info("list()");				
		//페이지 처리를 위한 객체 생성
		PageObject pageObject = PageObject.getInstance(request);
		//한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
		if(strPerPageNum == null || strPerPageNum.equals(""))
			pageObject.setPerPageNum(8);
		//model에 담으면 자동으로 request에 담긴다. - 차리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject));	
		//전체 페이지 세팅후 값을 보기 위해서
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);	
		//검색에 대한 정보도 넘겨야한다.
		
		
		return "goods/list";
	}
	//상품 관리 상세보기
	@GetMapping("/view.do")
	public String view(long no,long inc,Model model) {
		log.info("view()");		
		long[] longs = {no,inc};
		model.addAttribute("vo",service.view(longs));
		return "goods/view";
	}
	//상품 관리 글 등록 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("writeForm.do");
		return "goods/writeForm";
	}
	//상품 관리 글 등록 처리
	@PostMapping("/write.do")
	public String write(GoodsVO vo,int perPageNum,RedirectAttributes rttr) {
		log.info("write.do - vo:"+vo);
		service.write(vo);
		//처리 결과 출력
		rttr.addFlashAttribute("msg", "글 등록이 성공적으로 처리되었습니다.");
		return "redirect:list.do?perPageNum="+perPageNum;
	}
	//상품 관리 수정 폼
	@GetMapping("/updateForm.do")
	public String updateForm(long no,Model model) {
		log.info("updateForm.do");
		model.addAttribute("vo",service.view(new long[] {no,0}));
		
		return "goods/updateForm";
	}
	//상품 관리 수정 처리
	@PostMapping("/update.do")
	public String update(GoodsVO vo,HttpServletRequest request,RedirectAttributes rttr) throws Exception {
		log.info("update.do - vo:"+vo);
		int result = service.update(vo);
		PageObject pageObject = PageObject.getInstance(request);
		long no = vo.getGoods_no();
		if(result > 0) {
			rttr.addFlashAttribute("msg", no+"번 글 수정이 성공적으로 처리되었습니다.");
			return "redirect:view.do?no="+no+"&inc=0&"+pageObject.getPageQuery();			
		} else {
			rttr.addFlashAttribute("msg", "비밀번호 달라 수정이 실패했습니다. 다시 입력해주세요");
			return "redirect:updateForm.do?no="+no+"&"+pageObject.getPageQuery();	
		}
	}
	//상품 관리 삭제 처리
	@PostMapping("/delete.do")
	public String delete(long no,String pw,RedirectAttributes rttr,HttpServletRequest request) throws Exception {
		log.info("delete.do"+no+pw);
		int result = service.delete(no,pw);
		PageObject pageObject = PageObject.getInstance(request);
		if(result > 0) {
			rttr.addFlashAttribute("msg", no+"번 글 삭제가 성공적으로 처리되었습니다.");
			return "redirect:list.do?perPageNum="+pageObject.getPerPageNum();
		} else {
			//rttr.addFlashAttribute("msg", "비밀번호 달라 수정이 실패했습니다. 다시 입력해주세요");
			rttr.addFlashAttribute("reDelete", true);
			return "redirect:view.do?no="+no+"&inc=0&"+pageObject.getPageQuery();
		}
	}
	
}
