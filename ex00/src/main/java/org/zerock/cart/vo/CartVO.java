package org.zerock.cart.vo;

import java.util.List;

import lombok.Data;

@Data
public class CartVO {
	private Long cart_no; //순환 처리
	private Long goods_no;
	private String goods_name;
	private Long size_no;
	private String size_name;
	private Long color_no;
	private String color_name;
	private Long goods_option_no;
	private String option_name;
	private Long amount;
	
	//여러개의 객체(vo) 데이터를 한꺼번에 받으려면 List 만들어서 넘겨준다. 그래서 필요
	private List<CartVO> list;
	
}
