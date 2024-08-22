package org.zerock.notice.service;

import java.util.List;

import org.zerock.notice.vo.NoticeVO;

import com.webjjang.util.page.PageObject;

public interface NoticeService {
	
	public List<NoticeVO> list(PageObject pageObject);
	
}
