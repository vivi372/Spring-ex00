package org.zerock.member.service;

import java.util.List;

import javax.inject.Inject;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.member.mapper.MemberMapper;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Service
@Log4j
//타입이 같으면 식별할 수 있는 문자열 지정 - id를 지정
@Qualifier("memberServiceImpl")
public class MemberServiceImpl implements MemberService {
	
	//자동 DI 적용
	@Inject
	private MemberMapper memberMapper;
	
	@Override
	public List<MemberVO> list(PageObject pageObject) {		
		pageObject.setTotalRow(memberMapper.totalRow(pageObject));		
		return memberMapper.list(pageObject);		
	}
	@Override
	public MemberVO view(long[] longs) {		
		long no = longs[0];
		if(longs[1] == 1) {
			//memberMapper.inc(no);			
		}
		return memberMapper.view(no);
	}
	//@Transactional  - insert 2번 성공을 해야 commit 됨. 한개라도 오류가 나면 rollback
	//@Transactional
	@Override
	public int write(MemberVO vo) {
		int result = memberMapper.write(vo); //글번호를 시퀀스에서 새로운 번호 사용
		//memberMapper.writeTx(vo); //위에서 사용한 글번호 재사용 - PK 예외 발생
		return result;
	}
	@Override
	public int update(MemberVO vo) {		
		return memberMapper.update(vo);
	}
	@Override
	public int delete(MemberVO vo) {		
		return memberMapper.delete(vo);
	}
	@Override
	public LoginVO login(LoginVO vo) {
		return memberMapper.login(vo);
	}
	
	
	
}
