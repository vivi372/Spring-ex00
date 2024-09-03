package org.zerock.goods.vo;

import java.util.List;

import lombok.Data;

@Data
public class GoodsOptVO {
	
	private Long goods_option_no;
	private Long goods_no;
	private String option_name;
	
	private List<GoodsOptVO> GoodsOptVOList;
	

	
	public List<GoodsOptVO> getGoodsOptVOList() {
		return GoodsOptVOList;
	}
	public void setGoodsOptVOList(List<GoodsOptVO> GoodsOptVOList) {
		this.GoodsOptVOList = GoodsOptVOList;
	}
	
	
}
