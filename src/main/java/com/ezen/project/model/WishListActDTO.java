package com.ezen.project.model;

public class WishListActDTO {
	private int w_num;
	private int u_num;
	private int a_num;
	private String w_check;
	private int review_num;
	private String a_image1;
	private String a_name;
	private String a_address;
	private String reviewAvg; // xml에서 바로 리뷰 평점 구해주려고 만듦
	private String reviewCnt; // xml에서 바로 리뷰 개수 구해주려고 만듦
	private String reviewStar; // xml에서 바로 리뷰 별 구해주려고 만듦
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public String getReviewAvg() {
		return reviewAvg;
	}
	public void setReviewAvg(String reviewAvg) {
		this.reviewAvg = reviewAvg;
	}
	public String getReviewCnt() {
		return reviewCnt;
	}
	public void setReviewCnt(String reviewCnt) {
		this.reviewCnt = reviewCnt;
	}
	public String getReviewStar() {
		return reviewStar;
	}
	public void setReviewStar(String reviewStar) {
		this.reviewStar = reviewStar;
	}
	public int getW_num() {
		return w_num;
	}
	public void setW_num(int w_num) {
		this.w_num = w_num;
	}
	public int getU_num() {
		return u_num;
	}
	public void setU_num(int u_num) {
		this.u_num = u_num;
	}
	public int getA_num() {
		return a_num;
	}
	public void setA_num(int a_num) {
		this.a_num = a_num;
	}
	public String getW_check() {
		return w_check;
	}
	public void setW_check(String w_check) {
		this.w_check = w_check;
	}
	public String getA_image1() {
		return a_image1;
	}
	public void setA_image1(String a_image1) {
		this.a_image1 = a_image1;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	public String getA_address() {
		return a_address;
	}
	public void setA_address(String a_address) {
		this.a_address = a_address;
	}
}