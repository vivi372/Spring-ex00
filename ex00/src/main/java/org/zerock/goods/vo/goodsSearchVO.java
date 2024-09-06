package org.zerock.goods.vo;

import lombok.Data;

@Data
public class goodsSearchVO {
	
	private Integer cate_code1;
	private Integer cate_code2;
	private String goods_name;
	private Integer minPrice;
	private Integer maxPrice;
	private boolean detailState;
	
	public String getQuery() {
		return "cate_code1="+toStr(cate_code1)+"&cate_code2="+toStr(cate_code2)+"&goods_name="+toStr(goods_name)
				+"&minPrice="+toStr(minPrice)+"&maxPrice="+toStr(maxPrice);
	}
	
	private String toStr(Object obj) {
		return (obj==null)?"":obj.toString();
	}
}
