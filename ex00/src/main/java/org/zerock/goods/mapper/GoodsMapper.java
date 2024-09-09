package org.zerock.goods.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import org.zerock.goods.vo.BasicColorVO;
import org.zerock.goods.vo.BasicSizeVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsSizeColorVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.goods.vo.goodsSearchVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface GoodsMapper {
	
	//상품 관리 리스트 페이지 처리를 위한 전체 데이터 개수
	public long totalRow(@Param("vo") goodsSearchVO searchVO);
	//상품 관리 리스트
	public List<GoodsVO> list(@Param("pageObject") PageObject pageObject,@Param("vo") goodsSearchVO searchVO);
	//상품 관리 조회수 증가
	public int inc(long no);
	//상품 관리 보기
	public GoodsVO view(long no);
	//상품 관리 상품 등록
	public Integer goodsWrite(GoodsVO vo);
	//상품 관리 상품 가격 등록
	public Integer priceWrite(GoodsVO vo);
	//상품 관리 상품 사이즈컬러 등록
	public Integer sizeColorWrite(List<GoodsSizeColorVO> list);
	//상품 관리 상품 옵션 등록
	public Integer optionWrite(List<String> list);
	//상품 관리 상품 이미지 등록
	public Integer imageWrite(List<GoodsImageVO> list);
	//상품 관리 수정
	public Integer update(GoodsVO vo);
	//상품 관리 삭제
	public Integer delete(@Param("no") long no,@Param("pw") String pw);
	//기본 사이즈 가져오기
	public List<BasicSizeVO> getSizeList(Integer cate_code1);
	//기본 컬러 가져오기
	public List<BasicColorVO> getColorList(Integer cate_code1);
}
