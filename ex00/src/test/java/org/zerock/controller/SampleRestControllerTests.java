package org.zerock.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.zerock.domain.SampleVO;

import com.google.gson.Gson;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//test에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class)
//설정 파일 지정 -> 서버와 상관이 있음. : root-context.xml,servlet-context.xml으로 직접 지정
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml","file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
//로그 객체 생성 -> lombok : log 이름으로 처리
@Log4j
public class SampleRestControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc; // Spring의 webMvc 테스팅을 위한 가짜 객체
	
	@Before
	public void setUp() { //mockMvc 세팅하는 메서드
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testConvert() throws Exception {
		//전달하는 객체 SampleVO
		SampleVO vo = new SampleVO();
		vo.setFirstName("가모라");
		vo.setMno(100);
		
		//json 데이터 String으로 만들어서 전달
		String jsonStr = new Gson().toJson(vo);
		
		log.info(jsonStr);
		
		ResultActions ra = mockMvc.perform(
				post("/sampleRest/sample")//요청 URI
				.contentType(MediaType.APPLICATION_JSON)//넘겨주는 data type : JSON
				.content(jsonStr))//넘겨주는 data
				.andExpect(status().is(200));
		
		
	}
	
	
}
