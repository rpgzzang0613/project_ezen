package com.ezen.project.model;

public class ActivityDTO {
    private int a_num;
    private int c_num;
    private String a_name;
    private String a_tel;
    private String a_address;
    private String a_notice;
    private String a_info;
    private String a_image1;
    private String a_image2;
    private String a_image3;
    private String a_image4;
    private String a_image5;
    private String a_code;
    private String a_extracode;
    private String a_manager;
    private String a_joindate;
	
    private int reviewCount;
	private double avgReviewPoint;
    
    private int wishList = 0;
    
	public int getA_num() {
		return a_num;
	}
	public void setA_num(int a_num) {
		this.a_num = a_num;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public String getA_name() {
		return a_name;
	}
	public void setA_name(String a_name) {
		this.a_name = a_name;
	}
	public String getA_tel() {
		return a_tel;
	}
	public void setA_tel(String a_tel) {
		this.a_tel = a_tel;
	}
	public String getA_address() {
		return a_address;
	}
	public void setA_address(String a_address) {
		this.a_address = a_address;
	}
	public String getA_notice() {
		return a_notice;
	}
	public void setA_notice(String a_anotice) {
		this.a_notice = a_anotice;
	}
	public String getA_info() {
		return a_info;
	}
	public void setA_info(String a_info) {
		this.a_info = a_info;
	}
	public String getA_image1() {
		return a_image1;
	}
	public void setA_image1(String a_image1) {
		this.a_image1 = a_image1;
	}
	public String getA_image2() {
		return a_image2;
	}
	public void setA_image2(String a_image2) {
		this.a_image2 = a_image2;
	}
	public String getA_image3() {
		return a_image3;
	}
	public void setA_image3(String a_image3) {
		this.a_image3 = a_image3;
	}
	public String getA_image4() {
		return a_image4;
	}
	public void setA_image4(String a_image4) {
		this.a_image4 = a_image4;
	}
	public String getA_image5() {
		return a_image5;
	}
	public void setA_image5(String a_image5) {
		this.a_image5 = a_image5;
	}
	public String getA_code() {
		return a_code;
	}
	public void setA_code(String a_code) {
		this.a_code = a_code;
	}
	public String getA_extracode() {
		return a_extracode;
	}
	public void setA_extracode(String a_extracode) {
		this.a_extracode = a_extracode;
	}
	public String getA_manager() {
		return a_manager;
	}
	public void setA_manager(String a_manager) {
		this.a_manager = a_manager;
	}
	public String getA_joindate() {
		return a_joindate;
	}
	public void setA_joindate(String a_joindate) {
		this.a_joindate = a_joindate;
	}
	public void setA_images(String[] images) {
		this.a_image1 = images[0];
		this.a_image2 = images[1];
		this.a_image3 = images[2];
		this.a_image4 = images[3];
		this.a_image5 = images[4];
	}
	
	public int getWishList() {
		return wishList;
	}
	public void setWishList(int wishList) {
		this.wishList = wishList;
	}
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public double getAvgReviewPoint() {
		return avgReviewPoint;
	}
	public void setAvgReviewPoint(double avgReviewPoint) {
		this.avgReviewPoint = avgReviewPoint;
	}
}

