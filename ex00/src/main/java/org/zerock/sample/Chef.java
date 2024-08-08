package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Data;
// 자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Component
@Data
public class Chef {
	private int num;
	
	public Chef() {
		this.num=1;
	}
	
	public Chef(int num) {
		this.num=num;
	}
}
