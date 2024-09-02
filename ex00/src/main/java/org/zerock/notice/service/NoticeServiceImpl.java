package org.zerock.notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.notice.mapper.NoticeMapper;
import org.zerock.notice.vo.NoticeVO;

import com.webjjang.util.page.PageObject;

import lombok.Setter;

@Service
public class NoticeServiceImpl implements NoticeService {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeMapper mapper;
	
	@Override
	public List<NoticeVO> list(PageObject pageObject) {
		pageObject.setTotalRow(mapper.totalRow(pageObject));
		return mapper.list(pageObject);
	}

	@Override
	public NoticeVO view(long no) {
		return mapper.view(no);
	}

	@Override
	public int write(NoticeVO vo) {
		
		return mapper.write(vo);
	}

}
