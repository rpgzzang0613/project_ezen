package com.ezen.project.model;

public class HotelDTO {
	private int h_num;
	private int c_num;
	private String h_name;
	private String h_tel;
	private String h_address;
	private String h_grade;
	private String h_notice;
	private String h_info;
	private String h_image1;
	private String h_image2;
	private String h_image3;
	private String h_image4;
	private String h_image5;
	private String h_park;
	private String h_meal;
	private String h_wifi;
	private String h_disabled;
	private String h_ott;
	private String h_pool;
	private String h_kids;
	private String h_bus;
	private String h_smoke;
	private String h_front24;
	private String h_manager;
	private String h_joindate;
	
	// DB에 없는 값
	private int reviewCount;
	private double reviewAvg;
	private int wishList = 0;
	
	public int getH_num() {
		return h_num;
	}
	public void setH_num(int h_num) {
		this.h_num = h_num;
	}
	public int getC_num() {
		return c_num;
	}
	public void setC_num(int c_num) {
		this.c_num = c_num;
	}
	public String getH_name() {
		return h_name;
	}
	public void setH_name(String h_name) {
		this.h_name = h_name;
	}
	public String getH_tel() {
		return h_tel;
	}
	public void setH_tel(String h_tel) {
		this.h_tel = h_tel;
	}
	public String getH_address() {
		return h_address;
	}
	public void setH_address(String h_address) {
		this.h_address = h_address;
	}
	public String getH_grade() {
		return h_grade;
	}
	public void setH_grade(String h_grade) {
		this.h_grade = h_grade;
	}
	public String getH_notice() {
		return h_notice;
	}
	public void setH_notice(String h_notice) {
		this.h_notice = h_notice;
	}
	public String getH_info() {
		return h_info;
	}
	public void setH_info(String h_info) {
		this.h_info = h_info;
	}
	public String getH_image1() {
		return h_image1;
	}
	public void setH_image1(String h_image1) {
		this.h_image1 = h_image1;
	}
	public String getH_image2() {
		return h_image2;
	}
	public void setH_image2(String h_image2) {
		this.h_image2 = h_image2;
	}
	public String getH_image3() {
		return h_image3;
	}
	public void setH_image3(String h_image3) {
		this.h_image3 = h_image3;
	}
	public String getH_image4() {
		return h_image4;
	}
	public void setH_image4(String h_image4) {
		this.h_image4 = h_image4;
	}
	public String getH_image5() {
		return h_image5;
	}
	public void setH_image5(String h_image5) {
		this.h_image5 = h_image5;
	}
	public String getH_park() {
		return h_park;
	}
	public void setH_park(String h_park) {
		this.h_park = h_park;
	}
	public String getH_meal() {
		return h_meal;
	}
	public void setH_meal(String h_meal) {
		this.h_meal = h_meal;
	}
	public String getH_wifi() {
		return h_wifi;
	}
	public void setH_wifi(String h_wifi) {
		this.h_wifi = h_wifi;
	}
	public String getH_disabled() {
		return h_disabled;
	}
	public void setH_disabled(String h_disabled) {
		this.h_disabled = h_disabled;
	}
	public String getH_ott() {
		return h_ott;
	}
	public void setH_ott(String h_ott) {
		this.h_ott = h_ott;
	}
	public String getH_pool() {
		return h_pool;
	}
	public void setH_pool(String h_pool) {
		this.h_pool = h_pool;
	}
	public String getH_kids() {
		return h_kids;
	}
	public void setH_kids(String h_kids) {
		this.h_kids = h_kids;
	}
	public String getH_bus() {
		return h_bus;
	}
	public void setH_bus(String h_bus) {
		this.h_bus = h_bus;
	}
	public String getH_smoke() {
		return h_smoke;
	}
	public void setH_smoke(String h_smoke) {
		this.h_smoke = h_smoke;
	}
	public String getH_front24() {
		return h_front24;
	}
	public void setH_front24(String h_front24) {
		this.h_front24 = h_front24;
	}
	public String getH_manager() {
		return h_manager;
	}
	public void setH_manager(String h_manager) {
		this.h_manager = h_manager;
	}
	public String getH_joindate() {
		return h_joindate;
	}
	public void setH_joindate(String h_joindate) {
		this.h_joindate = h_joindate;
	}

	public void setH_images(String[] images) {
		this.h_image1 = images[0];
		this.h_image2 = images[1];
		this.h_image3 = images[2];
		this.h_image4 = images[3];
		this.h_image5 = images[4];
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
	public double getReviewAvg() {
		return reviewAvg;
	}
	public void setReviewAvg(double reviewAvg) {
		this.reviewAvg = reviewAvg;
	}
}
