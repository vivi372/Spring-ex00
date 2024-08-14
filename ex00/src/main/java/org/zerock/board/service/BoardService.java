package org.zerock.board.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.board.mapper.BoardMapper;
import org.zerock.board.vo.BoardVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
//타입이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("boardService")
public class BoardService {
	
	//자동 DI 적용
	@Inject
	private BoardMapper boardMapper;
	
	public List<BoardVO> list(PageObject pageObject) {
		log.info("list() 실행");
		pageObject.setTotalRow(boardMapper.totalRow(pageObject));		
		return boardMapper.list(pageObject);		
	}
	
	public BoardVO view(long[] longs) {
		log.info("view() 실행");
		long no = longs[0];
		if(longs[1] == 1) {
			boardMapper.inc(no);			
		}
		return boardMapper.view(no);
	}
	
	public int write(BoardVO vo) {
		log.info("write() 실행");
		return boardMapper.write(vo);
	}
	
	public int update(BoardVO vo) {
		log.info("update() 실행");
		return boardMapper.update(vo);
	}
	
	public int delete(long no,String pw) {
		log.info("delete() 실행");
		return boardMapper.delete(no,pw);
	}
	
	
	
}
