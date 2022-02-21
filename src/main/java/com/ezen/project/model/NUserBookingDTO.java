package com.ezen.project.model;

public class NUserBookingDTO {
	private int book_num;
	private int room_num;
	private int h_num;
	private String book_indate;
	private String book_outdate;
	private String book_joindate;
	private int book_totalprice;
	private String book_status;
	private String book_name;
	private String book_tel;
	private String book_roomtype;
	private int book_extra;
	
	// DB에 없는 변수
	private String h_name;
	private String h_image1;//호텔이미지 필요해서 bookDTO로 넣어주고 jsp에서 사용할때 여기서 바로 호텔이미지 꺼내오도록 사용
	private String day;//몇박 하는지 계산할 때 사용
	private String room_image1;
	private String room_name;
	private String room_capacity;
	private int room_count;
	
	public int getBook_num() {
		return book_num;
	}
	public void setBook_num(int book_num) {
		this.book_num = book_num;
	}
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
	public String getBook_indate() {
		return book_indate;
	}
	public void setBook_indate(String book_indate) {
		this.book_indate = book_indate;
	}
	public String getBook_outdate() {
		return book_outdate;
	}
	public void setBook_outdate(String book_outdate) {
		this.book_outdate = book_outdate;
	}
	public String getBook_joindate() {
		return book_joindate;
	}
	public void setBook_joindate(String book_joindate) {
		this.book_joindate = book_joindate;
	}
	public int getBook_totalprice() {
		return book_totalprice;
	}
	public void setBook_totalprice(int book_totalprice) {
		this.book_totalprice = book_totalprice;
	}
	public String getBook_status() {
		return book_status;
	}
	public void setBook_status(String book_status) {
		this.book_status = book_status;
	}
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getBook_tel() {
		return book_tel;
	}
	public void setBook_tel(String book_tel) {
		this.book_tel = book_tel;
	}

	public String getBook_roomtype() {
		return book_roomtype;
	}
	public void setBook_roomtype(String book_roomtype) {
		this.book_roomtype = book_roomtype;
	}
	
	public int getBook_extra() {
		return book_extra;
	}
	public void setBook_extra(int book_extra) {
		this.book_extra = book_extra;
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
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getRoom_image1() {
		return room_image1;
	}
	public void setRoom_image1(String room_image1) {
		this.room_image1 = room_image1;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public String getRoom_capacity() {
		return room_capacity;
	}
	public void setRoom_capacity(String room_capacity) {
		this.room_capacity = room_capacity;
	}
	public int getRoom_count() {
		return room_count;
	}
	public void setRoom_count(int room_count) {
		this.room_count = room_count;
	}
}
