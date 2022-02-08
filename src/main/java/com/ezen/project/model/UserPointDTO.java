package com.ezen.project.model;

public class UserPointDTO {
	private int p_num;
	private int book_num;
	private int u_num;
	private String p_status;
	private String p_contents;
	private int p_point;
	private int p_remaining;
	private String p_joindate;
	
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
	public int getU_num() {
		return u_num;
	}
	public void setU_num(int u_num) {
		this.u_num = u_num;
	}
	public String getP_status() {
		return p_status;
	}
	public void setP_status(String p_status) {
		this.p_status = p_status;
	}
	public String getP_contents() {
		return p_contents;
	}
	public void setP_contents(String p_contents) {
		this.p_contents = p_contents;
	}
	public int getP_remaining() {
		return p_remaining;
	}
	public void setP_remaining(int p_remaining) {
		this.p_remaining = p_remaining;
	}
	public String getP_joindate() {
		return p_joindate;
	}
	public void setP_joindate(String p_joindate) {
		this.p_joindate = p_joindate;
	}
	public int getP_point() {
		return Math.abs(p_point);
	}
	public void setP_point(int p_point) {
		this.p_point = p_point;
	}
}
