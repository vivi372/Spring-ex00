package org.zerock.boardreply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.boardreply.vo.BoardReplyVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface BoardReplyMapper {
	//1-1.totalRow
	public long totalRow(@Param("pageObject") PageObject pageObject,@Param("no") long no);
	//1-2.list
	//메서드의 처리되는 데이터는 기본이 1개이다. 2개 이상인 경우 @param을 사용 map으로 만들어서 1개로 넘긴다.
	public List<BoardReplyVO> list(@Param("pageObject") PageObject pageObject,@Param("no") long no);
	//2.write
	public int write(BoardReplyVO vo);
	//3.update
	public int update(BoardReplyVO vo);
	//4.delete
	public int delete(BoardReplyVO vo); 
}
