package org.zerock.boardreply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.boardreply.mapper.BoardReplyMapper;
import org.zerock.boardreply.vo.BoardReplyVO;

import com.webjjang.util.page.PageObject;

import lombok.Setter;

@Service
@Qualifier("boardReplyServiceImpl")
public class BoardReplyServiceImpl implements BoardReplyService {
	//자동 DI
	@Setter(onMethod_ = @Autowired )
	BoardReplyMapper mapper;

	@Override
	public List<BoardReplyVO> list(PageObject pageObject, long no) {
		//전체 데이터 세팅
		pageObject.setTotalRow(mapper.totalRow(pageObject, no));
		return mapper.list(pageObject, no);
	}

	@Override
	public int write(BoardReplyVO vo) {
		
		return mapper.write(vo);
	}

	@Override
	public int update(BoardReplyVO vo) {
		
		return mapper.update(vo);
	}

	@Override
	public int delete(BoardReplyVO vo) {
		
		return mapper.delete(vo);
	}

}
