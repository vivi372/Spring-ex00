package org.zerock.member.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String id;
	private String pw;
	private String name;
	private String gender;
	private Date birth;
	private String tel;
	private String email;
	private Date regDate;
	private Date conDate;
	private String status;
	private String photo;
	private Long newMsgCnt;
	private Integer gradeNo;
	private String gradeName;
}
