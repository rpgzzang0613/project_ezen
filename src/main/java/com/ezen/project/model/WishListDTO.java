package com.ezen.project.model;

public class WishListDTO {
	private int w_num;
	private int u_num;
	private int h_num;
	private String w_check;
	private int review_num;
	private String h_image1; // 호텔이미지 필요해서 wishlistDTO로 넣어주고 jsp에서 사용할때 여기서 바로 호텔이미지 꺼내오도록 사용
	private String h_name;
	private String h_grade;
	private String h_address;
	private String reviewAvg; // xml에서 바로 리뷰 평점 구해주려고 만듦
	private String reviewCnt; // xml에서 바로 리뷰 개수 구해주려고 만듦
	private String reviewStar; // xml에서 바로 리뷰 별 구해주려고 만듦
	
	public int getReview_num() {
		return review_num;
	}
	public void setReview_num(int review_num) {
		this.review_num = review_num;
	}
	public String getH_image1() {
		return h_image1;
	}
	public void setH_image1(String h_image1) {
		this.h_image1 = h_image1;
	}
	public String getH_name() {
		return h_name;
	}
	public void setH_name(String h_name) {
		this.h_name = h_name;
	}
	public String getH_grade() {
		return h_grade;
	}
	public void setH_grade(String h_grade) {
		this.h_grade = h_grade;
	}
	public String getH_address() {
		return h_address;
	}
	public void setH_address(String h_address) {
		this.h_address = h_address;
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
	public int getH_num() {
		return h_num;
	}
	public void setH_num(int h_num) {
		this.h_num = h_num;
	}
	public String getW_check() {
		return w_check;
	}
	public void setW_check(String w_check) {
		this.w_check = w_check;
	}	
}