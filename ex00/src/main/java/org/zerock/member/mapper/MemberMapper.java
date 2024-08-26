package org.zerock.member.mapper;

import java.util.List;
import org.springframework.stereotype.Repository;
import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;

import com.webjjang.util.page.PageObject;

@Repository
public interface MemberMapper {
	
	//회원 관리 리스트 페이지 처리를 위한 전체 데이터 개수
	public long totalRow(PageObject pageObject);
	//회원 관리 리스트
	public List<MemberVO> list(PageObject pageObject);
	//회원 관리 조회수 증가
	//public int inc(long no);
	//회원 관리 상세 보기
	public MemberVO view(long no);
	//회원 관리 회원 가입
	public Integer write(MemberVO vo);
	//글 등록 트랜젝션 처리 테스트
	//public Integer writeTx(MemberVO vo);
	//회원 관리 수정
	public Integer update(MemberVO vo);
	//회원 관리 탈퇴
	public Integer delete(MemberVO vo);
	
	//회원 관리 글 보기
	public LoginVO login(LoginVO vo);
}
