package org.zerock.board.service;

import java.util.List;


import org.zerock.board.vo.BoardVO;

import com.webjjang.util.page.PageObject;




public interface BoardService {	
	
	
	public List<BoardVO> list(PageObject pageObject); 
	
	public BoardVO view(long[] longs); 
	
	public int write(BoardVO vo); 
	
	public int update(BoardVO vo); 
	
	public int delete(long no,String pw); 
	
	
	
}
