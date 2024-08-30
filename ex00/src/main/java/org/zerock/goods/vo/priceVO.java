package org.zerock.goods.vo;

import java.util.Date;

import lombok.Data;

@Data
public class priceVO {
	
	private Integer price; // 현재 판매 가격
	private Integer discount; // 할인 하는 가격
	private Integer discount_rate; // 할인율
	private Integer delivery_charge; // 배송비
	private Integer saved_rate; // 구매시 적립율
	private Date sale_start_date;
	private Date sale_end_date;

}
