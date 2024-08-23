package org.zerock.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.board.vo.BoardVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface BoardMapper {
	
	//일반 게시판 리스트 페이지 처리를 위한 전체 데이터 개수
	public long totalRow(PageObject pageObject);
	//일반 게시판 글 리스트
	public List<BoardVO> list(PageObject pageObject);
	//일반 게시판 조회수 증가
	public int inc(long no);
	//일반 게시판 글 보기
	public BoardVO view(long no);
	//일반 게시판 글 등록
	public Integer write(BoardVO vo);
	//글 등록 트랜젝션 처리 테스트
	//public Integer writeTx(BoardVO vo);
	//일반 게시판 글 수정
	public Integer update(BoardVO vo);
	//일반 게시판 글 업데이트
	public Integer delete(@Param("no") long no,@Param("pw") String pw);
}
