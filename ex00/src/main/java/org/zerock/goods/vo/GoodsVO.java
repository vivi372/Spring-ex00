package org.zerock.goods.vo;


import java.util.Date;

import lombok.Data;

@Data
public class GoodsVO {
	private Long goods_no;
	private Integer cate_code1;
	private Integer cate_code2;
	private String cate_name;
	private String goods_name;
	private String company;
	private Date product_date;
	private String image_name; // 리스트에 나타날 대표 이미지
	private String detail_image_name; // 보기에 나타날 상세 설명 이미지
	private String content; // 보기에 나타날 상세 설명 텍스트
	private Long hit;
	
	private Integer price; // 현재 판매 가격
	private Integer discount; // 할인 하는 가격
	private Integer discount_rate; // 할인율
	private Integer delivery_charge; // 배송비
	private Integer saved_rate; // 구매시 적립율
	private Date sale_start_date;
	private Date sale_end_date;
	
	//판매가 getter 만들기
	public Integer getSale_price() {
		//할인가가 있는 경우
		if(discount != 0) return price-discount;
		//할인율이 있는 경우 10원 미만 단위 절삭
		else return (price - (price*(discount_rate/100)))/10 * 10;
	}
}
