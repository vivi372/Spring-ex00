package org.zerock.goods.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.goods.mapper.GoodsMapper;
import org.zerock.goods.vo.BasicColorVO;
import org.zerock.goods.vo.BasicSizeVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsSizeColorVO;
import org.zerock.goods.vo.GoodsVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
//타입이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService {
	
	//자동 DI 적용
	@Inject
	private GoodsMapper goodsMapper;
	
	@Override
	public List<GoodsVO> list(PageObject pageObject) {		
		pageObject.setTotalRow(goodsMapper.totalRow(pageObject));		
		return goodsMapper.list(pageObject);		
	}
	@Override
	@Transactional
	public GoodsVO view(long[] longs) {		
		long no = longs[0];
		if(longs[1] == 1) {
			goodsMapper.inc(no);			
		}
		return goodsMapper.view(no);
	}
	
	//@Transactional  - insert 2번 성공을 해야 commit 됨. 한개라도 오류가 나면 rollback
	//상품,가격,이미지,사이즈컬러 -> 등록하다가 하나라도 오류나면 롤백한다.
	@Override
	@Transactional
	public int write(GoodsVO vo,List<String> option_name,List<GoodsImageVO> imageList,List<GoodsSizeColorVO> sizeColorList) {
		//상품 상세 정보 입력
		int result = goodsMapper.goodsWrite(vo); //글번호를 시퀀스에서 새로운 번호 사용
		//상품 가격 정보 입력
		goodsMapper.priceWrite(vo);
		//상품 옵션 정보 입력
		if(sizeColorList != null) {
			goodsMapper.sizeColorWrite(sizeColorList);
		} else {
			goodsMapper.optionWrite(option_name);			
		}
		//상품 이미지 정보 입력
		if(imageList != null) {
			goodsMapper.imageWrite(imageList);			
		}
		//goodsMapper.writeTx(vo); //위에서 사용한 글번호 재사용 - PK 예외 발생
		return result;
	}
	@Override
	public int update(GoodsVO vo) {		
		return goodsMapper.update(vo);
	}
	@Override
	public int delete(long no,String pw) {		
		return goodsMapper.delete(no,pw);
	}
	@Override
	public List<BasicSizeVO> getSizeList(Integer cate_code1) {
		
		return goodsMapper.getSizeList(cate_code1);
	}
	@Override
	public List<BasicColorVO> getColorList(Integer cate_code1) {
		
		return goodsMapper.getColorList(cate_code1);
	}
	
	//삭제할 제품에 대한 이미지를 전부 가져오기 : 상품 이미지 가져오기 -> 상품 삭제	
	
	
}
