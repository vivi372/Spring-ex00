package org.zerock.persistence;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	//JDBCTests 호출이 될 때 한번만 실행 - static 초기화 블럭
	static {
		//1.드라이버 확인
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log.info("드라이버 확인");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		Connection con = null;
		try {
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","java","java");
			log.info(con);
			log.info("연결 성공");
		} catch (Exception e) {
			e.printStackTrace();
			log.error(e.getMessage());			
		} finally {
			try {
				if(con!=null) con.close();
			} catch (SQLException e) {				
				e.printStackTrace();
			}
		}
		
		
	}
	
}
