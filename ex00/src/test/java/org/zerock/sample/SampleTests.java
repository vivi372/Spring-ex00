package org.zerock.sample;

import static org.junit.Assert.assertNotNull;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//test에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class)
//설정 파일 지정 -> 서버와 상관이 없음. : root-context.xml으로 직접 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//로그 객체 생성 -> lombok : log 이름으로 처리
@Log4j
public class SampleTests {
	
	//레스토랑의 자동 생성과 DI를 확인을 위해 객체 전달 : 자동 DI
	@Setter(onMethod_ = {@Autowired,@Inject})
	private Restaurant restaurant;
	
	//테스트할 메서드 작성 -> 여러개 가능 : 한꺼번에 다 테스트 한다.
	@Test
	public void testExist() {
		
		//not null 확인
		assertNotNull(restaurant);
		//출력해서 확인해 보기
		log.warn("-----------------------------------------------");
		log.info("-----------------------------------------------");
		log.info(restaurant);
		log.info(restaurant.getChef());
		
	}
}
