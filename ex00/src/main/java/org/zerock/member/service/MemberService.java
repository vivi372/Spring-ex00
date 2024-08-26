package org.zerock.member.service;

import java.util.List;

import org.zerock.member.vo.LoginVO;
import org.zerock.member.vo.MemberVO;

import com.webjjang.util.page.PageObject;




public interface MemberService {	
	
	
	public List<MemberVO> list(PageObject pageObject); 
	
	public MemberVO view(long[] longs); 
	
	public int write(MemberVO vo); 
	
	public int update(MemberVO vo); 
	
	public int delete(MemberVO vo); 
	
	public LoginVO login(LoginVO vo);
	
	
	
}
