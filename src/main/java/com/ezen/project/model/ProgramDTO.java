package com.ezen.project.model;

public class ProgramDTO {
	private int p_num;
	private int c_num;
	private int a_num;
	private String p_name;
	private int p_price;
	private int p_extraprice;
	private int p_maxbooker;
	private String p_joindate;
	
	//DB에 없는 변수
	private int p_currentbooker;
	
	public int getP_num() {
		return p_num;
	}
	public void setP_num(int p_num) {
		this.p_num = p_num;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public int getA_num() {
		return a_num;
	}
	public void setA_num(int a_num) {
		this.a_num = a_num;
	}
	public String getP_name() {
		return p_name;
	}
	public void setP_name(String p_name) {
		this.p_name = p_name;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public int getP_extraprice() {
		return p_extraprice;
	}
	public void setP_extraprice(int p_extraprice) {
		this.p_extraprice = p_extraprice;
	}
	public int getP_maxbooker() {
		return p_maxbooker;
	}
	public void setP_maxbooker(int p_maxbooker) {
		this.p_maxbooker = p_maxbooker;
	}
	public String getP_joindate() {
		return p_joindate;
	}
	public void setP_joindate(String p_joindate) {
		this.p_joindate = p_joindate;
	}
	
	public int getP_currentbooker() {
		return p_currentbooker;
	}
	public void setP_currentbooker(int p_currentbooker) {
		this.p_currentbooker = p_currentbooker;
	}

}
