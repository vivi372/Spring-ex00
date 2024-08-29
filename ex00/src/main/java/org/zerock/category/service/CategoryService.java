package org.zerock.category.service;

import java.util.List;


import org.zerock.category.vo.CategoryVO;






public interface CategoryService {	
	
	
	public List<CategoryVO> list(Integer cate_code1); 
	
	
	public int write(CategoryVO vo); 
	
	public int update(CategoryVO vo); 
	
	public int delete(CategoryVO vo); 
	
	
	
}
