package org.zerock.controller;

import java.util.ArrayList;
import java.util.Arrays;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.TodoDTO;

import lombok.extern.log4j.Log4j;


//자동 생성을 위한 어노테이션
//-@Controller - url : HTML, @Service - 처리 ,@Repository - 데이터 저장,
//@Component - 구성체 ,@RestController - url : data : ajax, @~Advice - 예외 처리
@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

	@RequestMapping("")// /sample/
	//return이 없으면 uri 정보를 jsp로 사용
	//return이 있으면 redirect 시킨다. 없으면 jsp로 forward시킨다.
	public void basic() {
		log.info("basic...................");
	}
	//uri 매핑이 get과 post 방식만 허용
	@RequestMapping(value = "/basic", method = {RequestMethod.GET,RequestMethod.POST})
	public void basicGet() {
		log.info("basic get/post...................");
	}
	//get만 사용. value속성 하나만 남으면 기본으로 데이터가 들어가는 속성이 된다. 생략가능
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get...................");
	}
	
	//property(VO=DTO)로 넘어오는 데이터 받기(setter이름과 name이 같으면 자동으로 받는다.)
	@GetMapping("/ex00")
	public String ex00(SampleDTO dto) {
		log.info(""+dto);
		// /WEB-INF/views/+ex00+.jsp
		return "sample/ex00";
	}
	
	//파라메터 변수로 받기 - 변수명과 name이 같아야 한다. age가 없으면 오류가 난다.
	//age가 안들어 오면 기본값을  0 세팅
	@GetMapping("/ex01")
	public String ex01(@RequestParam("name") String name,@RequestParam(defaultValue = "0",name = "age") int age) {
		log.info("name:"+name);
		log.info("age:"+age);
		// /WEB-INF/views/+ex00+.jsp
		return "sample/ex01";
	}
	
	//파라메터 변수로 받기 - 아이디 여러개를 받아서 처리 - List / 배열
	@GetMapping("/ex01List")
	//List로 여러개의 데이터를 받을때 @RequestParam 꼭 필요
	//배열로 여러개의 데이터를 받을때 @RequestParam 생략 가능
	public String ex01List(@RequestParam("ids") ArrayList<String> ids,String[] names) {
		log.info("ids:"+ids+", names="+Arrays.toString(names));
		
		// /WEB-INF/views/+ex00+.jsp
		return "sample/ex01List";
	}
	
	//파라메터 변수로 받기 - 날짜 데이터 받기. DTO에 @DateTimeFormat(pattern = "yyyy-MM-dd") 입력
	@GetMapping("/ex02")	
	public String ex02(TodoDTO dto) {
		log.info("dto:"+dto);
		
		// /WEB-INF/views/+ex00+.jsp
		return "sample/ex02";
	}
	
}
