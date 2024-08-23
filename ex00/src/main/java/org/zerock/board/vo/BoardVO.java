package org.zerock.board.vo;



import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardVO {
	private long no,hit,replyCnt;
	private String title,content,writer,pw;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private	Date writeDate; // slq - java.sql.Date : casting - spring에서는 자동 캐스팅
}
