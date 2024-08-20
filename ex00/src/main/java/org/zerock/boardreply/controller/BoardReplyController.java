package org.zerock.boardreply.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.boardreply.service.BoardReplyService;
import org.zerock.boardreply.vo.BoardReplyVO;

import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/boardreply")
@Log4j
public class BoardReplyController {
	
	@Setter(onMethod_ = @Autowired)
	@Qualifier("boardReplyServiceImpl")
	private BoardReplyService service;
	
	//1.list - get
	@GetMapping(value = "/list.do", produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<Map<String, Object>> list(PageObject pageObject,long no) throws Exception {
		log.info("list()");
		log.info("list - page : "+pageObject.getPage()+", no : "+ no);
		//DB에서 데이터를 가져와서 넘겨준다.
		List<BoardReplyVO> list = null;		
		list = service.list(pageObject, no);
		//PageObject도 넘겨야 한다.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageObject", pageObject);
		log.info("After - map : "+map);
		
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	//2.write - post
	@PostMapping(value = "/write.do",
			consumes = "application/json",//not content
			produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> write(BoardReplyVO vo,HttpSession session) {
		log.info("vo-"+vo);
		vo.setId(getId(session));//현재는 test만 나온다. 하드코딩 함 로그인 하지 않아도 된다.
		//로그인이 되어 있어야 사용할 수 있다.
		service.write(vo);
		return new ResponseEntity<>("댓글 등록이 되었습니다.",HttpStatus.OK);
	}
	//3.update - post
	@PostMapping("/update.do")
	public int update(BoardReplyVO vo) {
		return 0;
	}
	//4.delete - get
	@GetMapping("/delete.do")
	public int delete(BoardReplyVO vo) {
		return 0;
	}
	
	private String getId(HttpSession session) {
		//LoginVO vo = (LoginVO)session.getAttribute("login");
		//String id = vo.getId();
		return "test";
	}
	
}
