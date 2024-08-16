package org.zerock.board.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//Mapper 메서드 동작 테스트(단위 테스트)
//test에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class)
//설정 파일 지정 -> 서버와 상관이 없음. : root-context.xml으로 직접 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//로그 객체 생성 -> lombok : log 이름으로 처리
@Log4j
public class BoardMapperTests {
	
	//lombok의 setter를 이용해서 Spring Autowired을 이용한 자동 DI
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	// list() test
	@Test
	public void testList() {
		log.info("[일반 게시판 리스트(list()) Test]------------------------------------------------------------");
		//필요한 데이터 생성(파라메터로 넘겨지는 데이터)는 하드 코딩
		//pageObject 생성
		PageObject pageObject = new PageObject();
		
		log.info(mapper.list(pageObject));
	}
	
	// totalRow() test
	@Test
	public void testTotalRow() {
		log.info("[일반 게시판 리스트(totalRow()) Test]------------------------------------------------------------");
		//필요한 데이터 생성(파라메터로 넘겨지는 데이터)는 하드 코딩
		//pageObject 생성
		PageObject pageObject = new PageObject();
		
		log.info(mapper.totalRow(pageObject));
	}
	
	// inc() test
	@Test
	public void testInc() {
		log.info("[일반 게시판 상세보기(inc()) Test]------------------------------------------------------------");
		//필요한 데이터 생성(파라메터로 넘겨지는 데이터)는 하드 코딩		
		long no = 391;
		
		log.info(mapper.inc(no));
	}
	
	// view() test
	@Test
	public void testView() {
		log.info("[일반 게시판 상세보기(view()) Test]------------------------------------------------------------");
		//필요한 데이터 생성(파라메터로 넘겨지는 데이터)는 하드 코딩		
		long no = 391;
		
		log.info(mapper.view(no));
	}
	
	//write() test
//	@Test
//	public void testInsert() {
//		log.info("[일반 게시판 등록(write()) Test]------------------------------------------------------------");	
//		BoardVO vo = new BoardVO();
//		vo.setTitle("새 글");
//		vo.setContent("새 내용");
//		vo.setWriter("새로운 사람");
//		vo.setPw("1111");
//		
//		mapper.write(vo);
//		
//		log.info(vo);
//		
//	}
	
}
