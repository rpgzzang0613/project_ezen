package com.ezen.project.service;

import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.project.model.BookingDTO;
import com.ezen.project.model.HotelDTO;
import com.ezen.project.model.NUserBookingDTO;
import com.ezen.project.model.RoomDTO;

@Service
public class HotelMapper {

	@Autowired
	private SqlSession sqlSession;
	
	// 기업용 페이지에서 호텔을 등록할 때 사용하는 메소드
	public int inputHotel(HotelDTO hdto) {
		return sqlSession.insert("inputHotel", hdto);
	}
	
	// 기업용 페이지에서 호텔을 삭제할 때 사용하는 메소드
	public int deleteHotel(int h_num) {
		return sqlSession.delete("deleteHotel", h_num);
	}
	
	// 특정 호텔의 객실 그룹의 개수를 확인하는 메소드
	public int countRoomOnHotel(int h_num) {
		return sqlSession.selectOne("countRoomOnHotel", h_num);
	}
	
	// 특정 객실 그룹의 전체 객실수를 확인하는 메소드
	public int countRoomOnGroup(String room_code) {
		return sqlSession.selectOne("countRoomOnGroup", room_code);
	}
	
	// 기업용 페이지에서 호텔 삭제시 객실이 있을 경우, 그 호텔의 객실을 전부 삭제하는 메소드
	public int deleteRoomOnHotel(int h_num) {
		return sqlSession.delete("deleteRoomOnHotel", h_num);
	}
	
	// 기업용 페이지에서 호텔 삭제시 객실이 있을 경우, 그 호텔에 소속된 객실레코드의 이미지파일 이름을 전부 가져오는 메소드
	// (파일 삭제용도)
	public List<RoomDTO> getAllRoomImagesOnHotel(int h_num) {
		return sqlSession.selectList("getAllRoomImagesOnHotel", h_num);
	}
	
	// 기업용 페이지에서 호텔 정보를 수정할 때 사용하는 메소드
	public int editHotel(HotelDTO hdto) {
		return sqlSession.update("editHotel", hdto);
	}
	
	// 기업이 소유한 호텔 목록을 가져오는 메소드
	public List<HotelDTO> listHotel(int c_num) {
		return sqlSession.selectList("listHotel", c_num);
	}
	
	// 호텔 수정시 정보를 가져오는 메소드
	public HotelDTO getHotel(int h_num) {
		return sqlSession.selectOne("getHotel", h_num);
	}
	
	// 호텔 등록에서 바로 객실 그룹 등록으로 넘어올 때, 그 호텔의 h_num을 받아오기 위한 메소드
	public int getMaxHnum() {
		return sqlSession.selectOne("getMaxHnum");
	}
	
	// 기업용 페이지에서 객실을 등록할 때 사용하는 메소드
	public int inputRoom(RoomDTO rdto) {
		return sqlSession.insert("inputRoom", rdto);
	}
	
	// 
	public String checkRoomCodeExists(int h_num) {
		return sqlSession.selectOne("checkRoomCodeExists", h_num+"%");
	}
	
	// 신규 객실 그룹 등록시, room_code 뒷자리수에 +1을 하기 위해 기존 객실 그룹의 room_code중 가장 큰 값을 꺼내오는 메소드
	public int getMaxRoomCode(int h_num) {
		List<String> rcodeList = sqlSession.selectList("getMaxRoomCode", h_num+"%");
		
		String[] arr = rcodeList.toArray(new String[rcodeList.size()]);
		int[] numarr = new int[rcodeList.size()];
		
		for(int i=0; i<rcodeList.size(); ++i) {
			String[] arr2 = arr[i].split("_");
			numarr[i] = Integer.parseInt(arr2[1]);
		}
		
		Arrays.sort(numarr);
		
		return numarr[numarr.length-1];
	}
	
	// 기업용 페이지에서 객실을 그룹 단위로 삭제할 때 사용하는 메소드
	public int deleteRoomGroup(String room_code) {
		return sqlSession.delete("deleteRoomGroup", room_code+"%");
	}
	
	// 기업용 페이지에서 객실 1개를 삭제할 때 사용하는 메소드
	public int deleteRoom(int room_num) {
		return sqlSession.delete("deleteRoom", room_num);
	}
	
	// 기업용 페이지에서 객실 정보를 그룹 단위로 수정할 때 사용하는 메소드
	public int editRoomGroup(RoomDTO rdto) {
		return sqlSession.update("editRoomGroup", rdto);
	}
	
	// 호텔의 객실 그룹 목록을 가져오는 메소드
	public List<RoomDTO> listRoomGroup(int h_num) {	
		return sqlSession.selectList("listRoomGroup", h_num);
	}
	
	// 객실그룹의 실제 객실 목록을 가져오는 메소드
	public List<RoomDTO> listRoom(String room_code) {	
		return sqlSession.selectList("listRoom", room_code);
	}

	// 객실 그룹에서 room_num이 가장 낮은 객실 1개의 정보를 대표로 가져오는 메소드
	public RoomDTO getRoomByRoomNum(int room_num) {
		return sqlSession.selectOne("getRoomByRoomNum", room_num);
	}
	
	public String getRoomType(int room_num) {
		return sqlSession.selectOne("getRoomType", room_num);
	}
	
	// 객실 비활성화를 위한 메소드
	public int disableRoom(int room_num) {
		return sqlSession.update("disableRoom", room_num);
	}
	
	// 객실 활성화를 위한 메소드
	public int enableRoom(int room_num) {
		return sqlSession.update("enableRoom", room_num);
	}
	
	// 호텔의 예약 목록을 가져오는 메소드
	public List<BookingDTO> listBookingByHotel(int h_num) {
		return sqlSession.selectList("listBookingByHotel", h_num);
	}
	
	// 호텔 번호로 호텔 이름을 가져오는 메소드
	public String getHnameByHnum(int h_num) {
		return sqlSession.selectOne("getHnameByHnum", h_num);
	}
	
	// 기업이 예약 리스트 페이지에서 예약 확정시 사용하는 메소드
	public int confirmBooking(int book_num) {
		return sqlSession.update("confirmBooking", book_num);
	}
	
	// 기업이 예약 리스트 페이지에서 예약 취소시 사용하는 메소드
	public int denyBooking(int book_num) {
		return sqlSession.update("denyBooking", book_num);
	}
	
	public int checkinBooking(int book_num) {
		return sqlSession.update("checkinBooking", book_num);
	}
	
	public int checkoutBooking(int book_num) {
		return sqlSession.update("checkoutBooking", book_num);
	}
	
	
	// 테스트
	public List<HotelDTO> listHotel2() {
		return sqlSession.selectList("listHotel2");
	}

	public List<NUserBookingDTO> listNUBookingByHotel(int h_num) {
		return sqlSession.selectList("nUserBookList",h_num);
	}

	public int confirmnBooking(int book_num) {
		return sqlSession.update("confirmnBooking", book_num);
	}
	
	// 기업이 예약 리스트 페이지에서 예약 취소시 사용하는 메소드
	public int denynBooking(int book_num) {
		return sqlSession.update("denynBooking", book_num);
	}
	
	public int checkinnBooking(int book_num) {
		return sqlSession.update("checkinnBooking", book_num);
	}
	
	public int checkoutnBooking(int book_num) {
		return sqlSession.update("checkoutnBooking", book_num);
	}
}
