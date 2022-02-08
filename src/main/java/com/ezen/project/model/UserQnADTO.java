package com.ezen.project.model;

public class UserQnADTO {
	private int uqa_num;
	private int u_num;
	private String uqa_subject;
	private String uqa_contents;
	private int uqa_re_step;
	private int uqa_re_level;
	private String uqa_joindate;
	private int u_num_parent;
	
	// DB에는 없는 컬럼에 대한 변수
	private String u_nickname;
	
	public int getUqa_num() {
		return uqa_num;
	}
	public void setUqa_num(int uqa_num) {
		this.uqa_num = uqa_num;
	}
	public int getU_num() {
		return u_num;
	}
	public void setU_num(int u_num) {
		this.u_num = u_num;
	}
	public String getUqa_subject() {
		return uqa_subject;
	}
	public void setUqa_subject(String uqa_subject) {
		this.uqa_subject = uqa_subject;
	}
	public String getUqa_contents() {
		return uqa_contents;
	}
	public void setUqa_contents(String uqa_contents) {
		this.uqa_contents = uqa_contents;
	}
	public int getUqa_re_step() {
		return uqa_re_step;
	}
	public void setUqa_re_step(int uqa_re_step) {
		this.uqa_re_step = uqa_re_step;
	}
	public int getUqa_re_level() {
		return uqa_re_level;
	}
	public void setUqa_re_level(int uqa_re_level) {
		this.uqa_re_level = uqa_re_level;
	}
	public String getUqa_joindate() {
		return uqa_joindate;
	}
	public void setUqa_joindate(String uqa_joindate) {
		this.uqa_joindate = uqa_joindate;
	}
	public int getU_num_parent() {
		return u_num_parent;
	}
	public void setU_num_parent(int u_num_parent) {
		this.u_num_parent = u_num_parent;
	}
	
	public String getU_nickname() {
		return u_nickname;
	}
	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}
}
