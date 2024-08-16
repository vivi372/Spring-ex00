package org.zerock.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

//@Controller, @RestController - uri와 관련, @RestController에는 기본이 @responsebody이므로 생략
//전달되는 데이터가 순수한 데이터이다
@RestController
@RequestMapping("/sampleRest")
@Log4j
public class SampleRestController {
	//-------------------------------------------------- response 처리
	
	@GetMapping(value="/getText",produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE: "+MediaType.TEXT_PLAIN_VALUE);
		
		return "<h1>안녕하세요</h1>";
	}
	
	@GetMapping(value="/getSample",
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		
		return new SampleVO(112,"스타","로드");
	}
	
	@GetMapping(value="/getList")
	public List<SampleVO> getList() {	
		List<SampleVO> list =  new ArrayList<SampleVO>();
		for(int i=1;i<=10;i++) {
			SampleVO vo = new SampleVO(i, i+" First", i+" Last");
			list.add(vo);
		}
		return list;
	}
	//Map 객체를 제공
	@GetMapping(value="/getMap")
	public Map<String,Object> getMap() {	
		Map<String,Object> map = new HashMap<>();		
		List<SampleVO> list =  new ArrayList<SampleVO>();
		for(int i=1;i<=10;i++) {
			SampleVO vo = new SampleVO(i, i+" First", i+" Last");
			list.add(vo);
		}
		//특성이 서로 틀린 여러개를 담아서 넘길때
		map.put("vo", new SampleVO(111,"그루트","주니어"));
		map.put("pageObject", new PageObject());
		map.put("list", list);
		return map;
	}
	

	//--------------------------------------------- request 처리
	
	//uri안에 데이터 포함하여 전달
	@GetMapping(value="/getPath/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat,@PathVariable("pid") Integer pid) {	
		
		return new String[] {"category: "+cat,"productid: "+pid};
	}
}
