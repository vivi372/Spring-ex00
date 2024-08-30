package org.zerock.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import org.zerock.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface GoodsMapper {
	
	//상품 관리 리스트 페이지 처리를 위한 전체 데이터 개수
	public long totalRow(PageObject pageObject);
	//상품 관리 리스트
	public List<GoodsVO> list(PageObject pageObject);
	//상품 관리 조회수 증가
	public int inc(long no);
	//상품 관리 보기
	public GoodsVO view(long no);
	//상품 관리 등록
	public Integer write(GoodsVO vo);
	//상품 관리 수정
	public Integer update(GoodsVO vo);
	//상품 관리 삭제
	public Integer delete(@Param("no") long no,@Param("pw") String pw);
}
