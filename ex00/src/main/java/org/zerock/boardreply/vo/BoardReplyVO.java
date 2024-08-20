package org.zerock.boardreply.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;


import lombok.Data;

@Data
public class BoardReplyVO {
	private long rno;
	private long no;
	private String content;
	private String id;
	private String name;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date writeDate;
}
