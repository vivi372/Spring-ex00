package org.zerock.category.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.category.vo.CategoryVO;


@Repository
public interface CategoryMapper {
	
	//카테고리 리스트
	public List<CategoryVO> list(Integer cate_code1);
	//카테고리 대분류 등록
	public Integer writeBig(CategoryVO vo);
	//카테고리 중분류 등록
	public Integer writeMid(CategoryVO vo);
	//카테고리 대분류 수정
	public Integer updateBig(CategoryVO vo);
	//카테고리 중분류 수정
	public Integer updateMid(CategoryVO vo);
	//카테고리 삭제
	public Integer delete(@Param("no") long no,@Param("pw") String pw);
}
