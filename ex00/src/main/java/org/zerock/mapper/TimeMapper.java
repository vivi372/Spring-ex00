package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
@Repository
public interface TimeMapper {

	@Select("SELECT sysdate from dual")
	public String getTime();
	//mapper.xml과 연결되어 있다.
	public String getTime2();
}
