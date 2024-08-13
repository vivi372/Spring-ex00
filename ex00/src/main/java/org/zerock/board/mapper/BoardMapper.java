package org.zerock.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.board.vo.BoardVO;

@Repository
public interface BoardMapper {
	
	//일반 게시판 글 리스트
	public List<BoardVO> list();
	//일반 게시판 조회수 증가
	public int inc(long no);
	//일반 게시판 글 보기
	public BoardVO view(long no);
	//일반 게시판 글 등록
	public Integer write(BoardVO vo);
	//일반 게시판 글 수정
	public Integer update(BoardVO vo);
	//일반 게시판 글 업데이트
	public Integer delete(@Param("no") long no,@Param("pw") String pw);
}
