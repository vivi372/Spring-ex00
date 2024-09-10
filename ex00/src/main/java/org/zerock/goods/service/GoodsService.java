package org.zerock.goods.service;

import java.util.List;
import java.util.Map;

import org.zerock.goods.vo.BasicColorVO;
import org.zerock.goods.vo.BasicSizeVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsSizeColorVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.goods.vo.goodsSearchVO;

import com.webjjang.util.page.PageObject;




public interface GoodsService {	
	
	//상품 리스트
	public List<GoodsVO> list(PageObject pageObject,goodsSearchVO searchVO); 
	//상품 상세보기
	public Map<String, Object> view(long goods_no,long inc); 
	
	//상품 등록
	public int write(GoodsVO vo,List<String> option_name,List<GoodsImageVO> imageList,List<GoodsSizeColorVO> sizeColorList); 
	//상품 수정 - 텍스트 정보 + 대표 이미지 + 상세 설명 이미지
	public int update(GoodsVO vo); 
	//상품 삭제
	public int delete(long no,String pw); 
	//상품 이미지 추가
	//상품 이미지 변경
	//상품 이미지 제거
	
	//상품 사이즈컬러 추가
	//상품 사이즈컬러 변경
	//상품 사이즈컬러 컬러 제거
	
	//상품 가격 추가
	//상품 가격 변경
	//상품 가격 컬러 제거
	
	//기본 사이즈 가져오기
	public List<BasicSizeVO> getSizeList(Integer cate_code1);
	//기본 컬러 가져오기
	public List<BasicColorVO> getColorList(Integer cate_code1);

	
}
