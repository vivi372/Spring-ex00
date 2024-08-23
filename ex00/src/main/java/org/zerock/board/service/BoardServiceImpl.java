package org.zerock.board.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
@Qualifier("boardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	//자동 DI 적용
	@Inject
	private BoardMapper boardMapper;
	
	@Override
	public List<BoardVO> list(PageObject pageObject) {		
		pageObject.setTotalRow(boardMapper.totalRow(pageObject));		
		return boardMapper.list(pageObject);		
	}
	@Override
	public BoardVO view(long[] longs) {		
		long no = longs[0];
		if(longs[1] == 1) {
			boardMapper.inc(no);			
		}
		return boardMapper.view(no);
	}
	//@Transactional  - insert 2번 성공을 해야 commit 됨. 한개라도 오류가 나면 rollback
	//@Transactional
	@Override
	public int write(BoardVO vo) {
		int result = boardMapper.write(vo); //글번호를 시퀀스에서 새로운 번호 사용
		//boardMapper.writeTx(vo); //위에서 사용한 글번호 재사용 - PK 예외 발생
		return result;
	}
	@Override
	public int update(BoardVO vo) {		
		return boardMapper.update(vo);
	}
	@Override
	public int delete(long no,String pw) {		
		return boardMapper.delete(no,pw);
	}
	
	
	
}
