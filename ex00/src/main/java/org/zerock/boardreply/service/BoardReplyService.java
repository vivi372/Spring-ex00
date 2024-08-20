package org.zerock.boardreply.service;

import java.util.List;


import org.zerock.boardreply.vo.BoardReplyVO;

import com.webjjang.util.page.PageObject;

public interface BoardReplyService {	
	//1.list	
	public List<BoardReplyVO> list(PageObject pageObject,long no);
	//2.write
	public int write(BoardReplyVO vo);
	//3.update
	public int update(BoardReplyVO vo);
	//4.delete
	public int delete(BoardReplyVO vo); 
}
