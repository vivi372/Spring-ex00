package org.zerock.goods.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import lombok.Data;

@Data
public class goodsSearchVO {
	
	private Integer cate_code1;
	private Integer cate_code2;
	private String goods_name;
	private Integer minPrice;
	private Integer maxPrice;
	private boolean detailState;
	
	public String getQuery() throws UnsupportedEncodingException {
		return "cate_code1="+toStr(cate_code1)+"&cate_code2="+toStr(cate_code2)+"&goods_name="+URLEncoder.encode(toStr(goods_name),"utf-8")  
				+"&minPrice="+toStr(minPrice)+"&maxPrice="+toStr(maxPrice);
	}
	
	private String toStr(Object obj) {
		return (obj==null)?"":obj.toString();
	}
	
	//검색 데이터가 존재하는지 확인하는 메서드
	public boolean isExist() {
		if(!(cate_code1 == null || cate_code1 == 0)) return true; 
		if(!(cate_code2 == null || cate_code2 == 0)) return true; 
		if(!(goods_name == null || goods_name.equals(""))) return true; 
		if(!(minPrice == null || minPrice == 0)) return true; 
		if(!(maxPrice == null || maxPrice == 0)) return true; 
		
		return false;
	}
}
