package org.zerock.persistence;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

//test에 사용되는 클래스
@RunWith(SpringJUnit4ClassRunner.class)
//설정 파일 지정 -> 서버와 상관이 없음. : root-context.xml으로 직접 지정
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//로그 객체 생성 -> lombok : log 이름으로 처리
@Log4j
public class DataSourceTests {
	
	//자동 DI - root-context.xml에 bean 태그로 설정
	@Setter(onMethod_ = @Autowired)
	private DataSource dataSource;
	
	@Setter(onMethod_ = @Autowired)
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void testConnection() {
		//try(resource) -> try가 종료되면 resource가 자동 닫기가 된다.
		try (
				SqlSession session = sqlSessionFactory.openSession();
				Connection con = session.getConnection();				
				){
			//Connection con = dataSource.getConnection();
			log.info("-----------------------------------------------");
			log.info(session);
			log.info(con);
			
			log.info("2.연결 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
