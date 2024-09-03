package org.zerock.goods.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.category.service.CategoryService;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.service.GoodsService;
import org.zerock.goods.vo.BasicColorVO;
import org.zerock.goods.vo.BasicSizeVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsSizeColorVO;
import org.zerock.goods.vo.GoodsVO;

import com.webjjang.util.file.FileUtil;
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
	@Setter(onMethod_ = @Autowired)
	@Qualifier("categoryServiceImpl")
	private CategoryService cateService;
	
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
	public String writeForm(Model model) {
		log.info("writeForm.do");
		
		model.addAttribute("category", cateService.list(0));
		return "goods/writeForm";
	}
	//상품 관리 글 등록 폼 중분류 카테고리,사이즈,컬러 가져오기
	@GetMapping(value = "/getCateMidSizeColor.do", produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE })
	public @ResponseBody Map<String, Object> getCateMidSizeColor(Integer cate_code1) {
		
		List<CategoryVO> cateList = cateService.list(cate_code1);
		List<BasicSizeVO> sizeList = service.getSizeList(cate_code1);
		List<BasicColorVO> colorList = service.getColorList(cate_code1);
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("cateList", cateList);
		map.put("sizeList", sizeList);
		map.put("colorList", colorList);
		
		return map;
	}
	
	//상품 관리 글 등록 처리
	@PostMapping("/write.do")
	public String write(GoodsVO vo,@RequestParam(required = false) ArrayList<String> option_name,MultipartFile image_name_file,MultipartFile detail_image_name_file,
			@RequestParam ArrayList<MultipartFile> image_names,int perPageNum,RedirectAttributes rttr,
			@RequestParam(required = false) ArrayList<Long> size_no,@RequestParam(required = false) ArrayList<Long> color_no,HttpServletRequest request) throws Exception {
		log.info("write.do - vo:"+vo);
		log.info("write.do - option_name:"+option_name);
		log.info("write.do - iamge_name:"+image_name_file);
		log.info("write.do - detail_image_name:"+detail_image_name_file);
		log.info("write.do - image_names:"+image_names);
		log.info("write.do - size_no:"+size_no);
		log.info("write.do - color_no:"+color_no);
		
		List<GoodsSizeColorVO> sizeColorList = new ArrayList<GoodsSizeColorVO>();
		
		for(Long size:size_no) {
			for(Long color:color_no) {
				GoodsSizeColorVO sizeColorVO = new GoodsSizeColorVO();
				sizeColorVO.setSize_no(size);
				sizeColorVO.setColor_no(color);
				sizeColorList.add(sizeColorVO);
			}
		}
		log.info("write.do - sizeColorList:"+sizeColorList);
		String path = "/upload/goods";
		
		vo.setImage_name(FileUtil.upload(path, image_name_file, request));
		vo.setDetail_image_name(FileUtil.upload(path, detail_image_name_file, request));
		
		List<GoodsImageVO> imageList = new ArrayList<GoodsImageVO>();
		
		for(MultipartFile iamge_name:image_names) {
			GoodsImageVO imageVO = new GoodsImageVO();
			imageVO.setImage_name(FileUtil.upload(path, iamge_name, request));
			imageList.add(imageVO);
		}
		
		service.write(vo, option_name, imageList,sizeColorList);
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
