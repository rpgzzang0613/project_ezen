package com.ezen.project.model;

public class CompanyQnADTO {
	private int cqa_num;
	private int c_num;
	private String cqa_subject;
	private String cqa_contents;
	private int cqa_re_step;
	private int cqa_re_level;
	private String cqa_joindate;
	private int c_num_parent;
	
	// DB에는 없는 컬럼에 대한 변수
	private String c_name;
	
	public int getCqa_num() {
		return cqa_num;
	}
	public void setCqa_num(int cqa_num) {
		this.cqa_num = cqa_num;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public String getCqa_subject() {
		return cqa_subject;
	}
	public void setCqa_subject(String cqa_subject) {
		this.cqa_subject = cqa_subject;
	}
	public String getCqa_contents() {
		return cqa_contents;
	}
	public void setCqa_contents(String cqa_contents) {
		this.cqa_contents = cqa_contents;
	}
	public int getCqa_re_step() {
		return cqa_re_step;
	}
	public void setCqa_re_step(int cqa_re_step) {
		this.cqa_re_step = cqa_re_step;
	}
	public int getCqa_re_level() {
		return cqa_re_level;
	}
	public void setCqa_re_level(int cqa_re_level) {
		this.cqa_re_level = cqa_re_level;
	}
	public String getCqa_joindate() {
		return cqa_joindate;
	}
	public void setCqa_joindate(String cqa_joindate) {
		this.cqa_joindate = cqa_joindate;
	}
	public int getC_num_parent() {
		return c_num_parent;
	}
	public void setC_num_parent(int c_num_parent) {
		this.c_num_parent = c_num_parent;
	}
	
	public String getC_name() {
		return c_name;
	}
	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

}
