package org.zerock.category.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.category.mapper.CategoryMapper;
import org.zerock.category.vo.CategoryVO;



import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
//타입이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("categoryServiceImpl")
public class CategoryServiceImpl implements CategoryService {
	
	//자동 DI 적용
	@Inject
	private CategoryMapper categoryMapper;
	
	@Override
	public List<CategoryVO> list(Integer cate_code1) {
		CategoryVO vo = new CategoryVO();
		vo.setCate_code1(cate_code1);
		return categoryMapper.list(cate_code1);		
	}
	
	//카테고리 등록 - cate_code이 있으면 중분류 없으면 대분류
	@Override
	public int write(CategoryVO vo) {
		if(vo.getCate_code1() == 0)
			return categoryMapper.writeBig(vo);
		return categoryMapper.writeMid(vo);
	}
	@Override
	public int update(CategoryVO vo) {		
		return categoryMapper.update(vo);
	}
	@Override
	public int delete(long no,String pw) {		
		return categoryMapper.delete(no,pw);
	}
	
	
	
}
