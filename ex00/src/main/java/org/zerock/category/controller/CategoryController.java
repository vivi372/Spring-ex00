package org.zerock.category.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.service.CategoryService;
import org.zerock.category.vo.CategoryVO;
import com.webjjang.util.page.PageObject;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Controller
@RequestMapping("/category")
@Log4j
public class CategoryController {
	
	//자동 DI
	@Setter(onMethod_ = @Autowired)
	@Qualifier("categoryServiceImpl")
	private CategoryService service;
	
	//카테고리 리스트
	@GetMapping("/list.do")
	//public ModelAndView list(Model model) {
	public String list(Model model,@RequestParam(defaultValue = "0") Integer cate_code1) throws Exception {
		log.info("list()");		
		//대분류 가져오기. 
		List<CategoryVO> bigList = service.list(0);
		
		//cate_code1이 없으면 code1 중에서 제일 작은것을 가져와서 처리				
		if(cate_code1 == 0 && (bigList != null&&bigList.size() != 0))
			cate_code1 = bigList.get(0).getCate_code1();
		
		List<CategoryVO> midList = service.list(cate_code1);
		
		//model에 담으면 자동으로 request에 담긴다. - 차리된 데이터를 Model에 저장
		model.addAttribute("bigList", bigList);	
		model.addAttribute("midList", midList);	
		
		
		return "category/list";
	}
	//카테고리 등록 폼은 입력 항목이 얼마 없어 리스트에 포함
	
	//카테고리 등록 처리
	@PostMapping("/write.do")
	public String write(CategoryVO vo,RedirectAttributes rttr) {
		log.info("write.do - vo:"+vo);
		service.write(vo);
		//처리 결과 출력
		rttr.addFlashAttribute("msg", "카테고리 등록이 성공적으로 처리되었습니다.");
		return "redirect:list.do?cate_code1="+(vo.getCate_code1()==0?1:vo.getCate_code1());
	}
	//카테고리 수정 폼은 입력 항목이 얼마 없어 리스트에 포함
	
	//카테고리 수정 처리
	@PostMapping("/update.do")
	public String update(CategoryVO vo,RedirectAttributes rttr) throws Exception {
		log.info("update.do - vo:"+vo);
		service.update(vo);
		//처리 결과 출력
		rttr.addFlashAttribute("msg", "글 수정이 성공적으로 처리되었습니다.");
		return "redirect:list.do?cate_code1="+vo.getCate_code1();
	}
	//카테고리 삭제 처리
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
			return "redirect:list.do?no="+no+"&inc=0&"+pageObject.getPageQuery();
		}
	}
	
}
