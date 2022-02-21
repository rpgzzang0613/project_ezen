package com.ezen.project.model;

public class RoomDTO {
	private int room_num;
	private int h_num;
	private int c_num;
	private String room_name;
	private String room_type;
	private String room_image1;
	private String room_image2;
	private String room_image3;
	private int room_price;
	private String room_capacity;
	private int room_extraprice;
	private String room_enable;
	private String room_code;
	
	// DB에 없는 컬럼
	private int max_count;
	private int booked_count;
	private int nbooked_count;
	private String room_booked;
	
	public int getRoom_num() {
		return room_num;
	}
	public void setRoom_num(int room_num) {
		this.room_num = room_num;
	}
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
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getRoom_type() {
		return room_type;
	}
	public void setRoom_type(String room_type) {
		this.room_type = room_type;
	}
	public String getRoom_image1() {
		return room_image1;
	}
	public void setRoom_image1(String room_image1) {
		this.room_image1 = room_image1;
	}
	public String getRoom_image2() {
		return room_image2;
	}
	public void setRoom_image2(String room_image2) {
		this.room_image2 = room_image2;
	}
	public String getRoom_image3() {
		return room_image3;
	}
	public void setRoom_image3(String room_image3) {
		this.room_image3 = room_image3;
	}
	public int getRoom_price() {
		return room_price;
	}
	public void setRoom_price(int room_price) {
		this.room_price = room_price;
	}
	public String getRoom_capacity() {
		return room_capacity;
	}
	public void setRoom_capacity(String room_capacity) {
		this.room_capacity = room_capacity;
	}
	public int getRoom_extraprice() {
		return room_extraprice;
	}
	public void setRoom_extraprice(int room_extraprice) {
		this.room_extraprice = room_extraprice;
	}
	public String getRoom_enable() {
		return room_enable;
	}
	public void setRoom_enable(String room_enable) {
		this.room_enable = room_enable;
	}
	public String getRoom_code() {
		return room_code;
	}
	public void setRoom_code(String room_code) {
		this.room_code = room_code;
	}

	public void setRoom_images(String[] images) {
		this.room_image1 = images[0];
		this.room_image2 = images[1];
		this.room_image3 = images[2];
	}
	
	public int getMax_count() {
		return max_count;
	}
	public void setMax_count(int max_count) {
		this.max_count = max_count;
	}
	public int getBooked_count() {
		return booked_count;
	}
	public void setBooked_count(int booked_count) {
		this.booked_count = booked_count;
	}
	public String getRoom_booked() {
		return room_booked;
	}
	public void setRoom_booked(String room_booked) {
		this.room_booked = room_booked;
	}
	public int getNbooked_count() {
		return nbooked_count;
	}
	public void setNbooked_count(int nbooked_count) {
		this.nbooked_count = nbooked_count;
	}
	
}
