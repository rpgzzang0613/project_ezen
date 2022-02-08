package com.ezen.project.model;

public class ReviewActDTO {
	
	private int review_num;
	private int a_num;
	private int u_num;
	private String review_contents;
	private String review_joindate;
	private String review_image;
	private int review_star;
	private String review_nickname;
	private String review_programtype;
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public int getU_num() {
		return u_num;
	}
	public void setU_num(int u_num) {
		this.u_num = u_num;
	}
	public String getReview_contents() {
		return review_contents;
	}
	public void setReview_contents(String review_contents) {
		this.review_contents = review_contents;
	}
	public String getReview_joindate() {
		return review_joindate;
	}
	public void setReview_joindate(String review_joindate) {
		this.review_joindate = review_joindate;
	}
	public String getReview_image() {
		return review_image;
	}
	public void setReview_image(String review_image) {
		this.review_image = review_image;
	}
	public int getReview_star() {
		return review_star;
	}
	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}

	public String getReview_nickname() {
		return review_nickname;
	}
	public void setReview_nickname(String review_nickname) {
		this.review_nickname = review_nickname;
	}
	public int getA_num() {
		return a_num;
	}
	public void setA_num(int a_num) {
		this.a_num = a_num;
	}
	public String getReview_programtype() {
		return review_programtype;
	}
	public void setReview_programtype(String review_programtype) {
		this.review_programtype = review_programtype;
	}
}
