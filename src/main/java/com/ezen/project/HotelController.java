package com.ezen.project;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.project.model.BookingDTO;
import com.ezen.project.model.HotelDTO;
import com.ezen.project.model.NUserBookingDTO;
import com.ezen.project.model.RoomDTO;
import com.ezen.project.service.HotelMapper;

@Controller
public class HotelController {
	
	@Autowired
	private HotelMapper hotelMapper;
	
	@Resource(name = "uploadPath")
	private String upPath;
	
	@RequestMapping("/hotel_main")
	public String hotelMain(HttpServletRequest req) {
		HttpSession session = req.getSession();
		LoginOkBeanCompany companyLoginOkBean = (LoginOkBeanCompany)session.getAttribute("companyLoginOkBean");
		session.setAttribute("c_num", companyLoginOkBean.getC_num());
		
		return "hotel/hotel_main";
	}
	
	@RequestMapping("/hotel_list")
	public String hotelList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		int c_num = (Integer)session.getAttribute("c_num");
		
		List<HotelDTO> hotelList = hotelMapper.listHotel(c_num);
		req.setAttribute("hotelList", hotelList);
		
		return "hotel/hotel_list";
	}
	
	@RequestMapping("/hotel_input")
	public String hotelInput() {
		return "hotel/hotel_input";
	}
	
	@RequestMapping("/hotel_input_ok")
	public String hotelInputOk(HttpServletRequest req, HotelDTO hdto, BindingResult result) 
			throws IllegalStateException, IOException {
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> mfList = mr.getFiles("h_images");
		
		// DTO에 파일이름을 한꺼번에 설정하기 위한 배열
		String[] images = new String[mfList.size()];
		
		// 업로드파일이 없는 경우와 있는 경우에 따라 파일 이름 설정
		for(int i=0; i<mfList.size(); ++i) {
			images[i] = mfList.get(i).getOriginalFilename();
			if(images[i] == null || images[i].trim().equals("")) {
				images[i] = "default.jpg";
			}else {
				images[i] = UUID.randomUUID().toString()+"_"+images[i];
			}
		}
		
		// 설정한 파일 이름을 한꺼번에 DTO에 넣음
		hdto.setH_images(images);
		
		// 서비스 체크가 안되어있으면 "n" 넣기
		if(hdto.getH_park() == null) hdto.setH_park("n");
		if(hdto.getH_meal() == null) hdto.setH_meal("n");
		if(hdto.getH_wifi() == null) hdto.setH_wifi("n");
		if(hdto.getH_disabled() == null) hdto.setH_disabled("n");
		if(hdto.getH_ott() == null) hdto.setH_ott("n");
		if(hdto.getH_pool() == null) hdto.setH_pool("n");
		if(hdto.getH_kids() == null) hdto.setH_kids("n");
		if(hdto.getH_bus() == null) hdto.setH_bus("n");
		if(hdto.getH_smoke() == null) hdto.setH_smoke("n");
		if(hdto.getH_front24() == null) hdto.setH_front24("n");
		
		// 줄개행을 @로 치환
		hdto.setH_info(hdto.getH_info().replace("\r\n", "@"));
		hdto.setH_notice(hdto.getH_notice().replace("\r\n", "@"));
		
		// DB에 등록
		int res = hotelMapper.inputHotel(hdto);
		
		// DB 등록이 성공하면
		if(res>0) {
			// 실제 파일들을 업로드
			for(int i=0; i<mfList.size(); ++i) {
				// 업로드할 파일명이 default.jpg면 업로드 안함
				if(!images[i].equals("default.jpg")) {
					File file = new File(upPath+"\\hotel", images[i]);
					mfList.get(i).transferTo(file);
				}
			}
			
            req.setAttribute("msg", "호텔등록 성공!! 객실등록 페이지로 이동합니다.");
            req.setAttribute("url", "room_group_input");
         }else {
            req.setAttribute("msg", "호텔등록 실패!! 다시 입력해 주세요.");
            req.setAttribute("url", "hotel_list");
         }
		
		return "message";
	}
	
	@RequestMapping("/hotel_edit")
	public String hotelEdit(HttpServletRequest req, int h_num) {
		HotelDTO hdto = hotelMapper.getHotel(h_num);
		
		// @를 줄개행으로 치환
		hdto.setH_info(hdto.getH_info().replace("@", "\r\n"));
		hdto.setH_notice(hdto.getH_notice().replace("@", "\r\n"));
		
		req.setAttribute("hdto", hdto);
		
		return "hotel/hotel_edit";
	}
	
	@RequestMapping("/hotel_edit_ok")
	public String hotelEditOk(HttpServletRequest req, HotelDTO hdto, BindingResult result, 
			String[] pre_images) throws IllegalStateException, IOException {
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> mfList = mr.getFiles("h_images");
		
		// DTO에 파일이름을 한꺼번에 설정하기 위한 배열 생성
		String[] images = new String[mfList.size()];
		
		// 파일 이름 설정
		for(int i=0; i<mfList.size(); ++i) {
			images[i] = mfList.get(i).getOriginalFilename();
			
			if(images[i] == null || images[i].trim().equals("")) {
				// 파일 업로드가 없으면 기존 파일의 이름을 그대로 설정
				images[i] = pre_images[i];
			}else {
				// 파일 업로드가 있으면 파일이름 새로 설정
				images[i] = UUID.randomUUID().toString()+"_"+images[i];
			}
		}
		
		// h_image1,2,3,4,5의 이름을 한꺼번에 DTO에 설정하는 메소드
		hdto.setH_images(images);
		
		// 서비스 체크가 안되어있으면 "n" 넣기
		if(hdto.getH_park() == null) hdto.setH_park("n");
		if(hdto.getH_meal() == null) hdto.setH_meal("n");
		if(hdto.getH_wifi() == null) hdto.setH_wifi("n");
		if(hdto.getH_disabled() == null) hdto.setH_disabled("n");
		if(hdto.getH_ott() == null) hdto.setH_ott("n");
		if(hdto.getH_pool() == null) hdto.setH_pool("n");
		if(hdto.getH_kids() == null) hdto.setH_kids("n");
		if(hdto.getH_bus() == null) hdto.setH_bus("n");
		if(hdto.getH_smoke() == null) hdto.setH_smoke("n");
		if(hdto.getH_front24() == null) hdto.setH_front24("n");
		
		// 줄개행을 @로 치환
		hdto.setH_info(hdto.getH_info().replace("\r\n", "@"));
		hdto.setH_notice(hdto.getH_notice().replace("\r\n", "@"));
		
		// DB 등록
		int res = hotelMapper.editHotel(hdto);
		
		if(res>0) {
			// 실제 파일을 업로드
			for(int i=0; i<mfList.size(); ++i) {
				// 새 파일명이랑 기존 파일명이 다를 경우
				if(!images[i].equals(pre_images[i])) {
					// 새 파일 업로드
					File newFile = new File(upPath+"\\hotel", images[i]);
					mfList.get(i).transferTo(newFile);
					
					// 기존 파일 삭제 (default.jpg 예외)
					File preFile = new File(upPath+"\\hotel", pre_images[i]);
					if(preFile.exists() && !preFile.getName().equals("default.jpg")) {
						preFile.delete();
					}
				}
			}
			
			req.setAttribute("msg", "호텔수정 성공!! 호텔목록 페이지로 이동합니다.");
			req.setAttribute("url", "hotel_list");
        }else {
        	req.setAttribute("msg", "호텔수정 실패!! 호텔목록 페이지로 이동합니다.");
        	req.setAttribute("url", "hotel_list");
        }
		
		return "message";
	}
	
	@RequestMapping("/hotel_delete_ok")
	public String hotelDeleteOk(HttpServletRequest req, int h_num, String[] h_images) {
		try {
			// 호텔이 가진 객실 개수를 센다.
			int roomCount = hotelMapper.countRoomOnHotel(h_num);
			
			// 호텔이 객실을 가지고 있는 경우
			if(roomCount != 0) {
				// 객실 DB를 삭제하기 전에 이미지파일 정보를 가져와서 저장해둔다.
				List<RoomDTO> rlist = hotelMapper.getAllRoomImagesOnHotel(h_num);
				
				// 삭제할 호텔에 소속된 객실을 DB에서 전부 삭제한다.
				hotelMapper.deleteRoomOnHotel(h_num);
				
				// DB에서 삭제한 객실들의 이미지파일을 전부 삭제한다. (default.jpg는 남겨둠)
				for(RoomDTO rdto : rlist) {
					File file1 = new File(upPath+"\\room", rdto.getRoom_image1());
					File file2 = new File(upPath+"\\room", rdto.getRoom_image2());
					File file3 = new File(upPath+"\\room", rdto.getRoom_image3());
					
					if(file1.exists() && !file1.getName().equals("default.jpg")) {
						file1.delete();
					}
					if(file2.exists() && !file2.getName().equals("default.jpg")) {
						file2.delete();
					}
					if(file3.exists() && !file3.getName().equals("default.jpg")) {
						file3.delete();
					}
				}
			}
			
			// 호텔을 삭제한다.
			int res = hotelMapper.deleteHotel(h_num);
			
			if(res>0) {
				// 호텔 이미지를 삭제한다. (default.jpg일 경우는 남겨둠)
				for(int i=0; i<h_images.length; ++i) {
					File file = new File(upPath+"\\hotel", h_images[i]);
					if (file.exists() && !file.getName().equals("default.jpg")) {
						file.delete();
					}
				}
				
	            req.setAttribute("msg", "호텔삭제 성공!! 호텔목록 페이지로 이동합니다.");
	            req.setAttribute("url", "hotel_list");
	         }else {
	            req.setAttribute("msg", "호텔삭제 실패!! 호텔목록 페이지로 이동합니다.");
	            req.setAttribute("url", "hotel_list");
	         }
		}catch(DataIntegrityViolationException e) {
			req.setAttribute("msg", "객실 예약이 존재하므로 삭제가 불가능합니다.");
			req.setAttribute("url", "hotel_list");
			e.printStackTrace();
		}
		
		return "message";
	}
	
	@RequestMapping("/room_group_list")
	public String roomGroupList(HttpServletRequest req, int h_num) {
		// 해당하는 호텔의 객실 그룹을 list로 담아온다.
		List<RoomDTO> roomGroupList = hotelMapper.listRoomGroup(h_num);
		
		// 각 객실 그룹에 소속된 객실 수를 구해서 DTO에 담는다.
		for(RoomDTO rdto : roomGroupList) {
			rdto.setMax_count(hotelMapper.countRoomOnGroup(rdto.getRoom_code()));
		}
		
		req.setAttribute("roomGroupList", roomGroupList);
		
		return "hotel/room_group_list";
	}
	
	@RequestMapping("/room_list")
	public String roomList(HttpServletRequest req, String room_code) {
		// 해당하는 객실 그룹의 객실을 list로 담아온다.
		List<RoomDTO> roomList = hotelMapper.listRoom(room_code);
		
		req.setAttribute("roomList", roomList);
		
		return "hotel/room_list";
	}
	
	@RequestMapping("/room_group_input")
	public String roomGroupInput(HttpServletRequest req, @RequestParam(required=false) String num) {
		int h_num = 0;
		
		if(num==null) {
			// 호텔을 처음 등록할때 바로 객실을 등록하는 경우
			h_num = hotelMapper.getMaxHnum();
		}else {
			// 호텔 목록에서 객실을 등록하는 경우
			h_num = Integer.parseInt(num);
		}
		
		req.setAttribute("h_num", h_num);
		
		return "hotel/room_group_input";
	}
	
	@RequestMapping("/room_group_input_ok")
	public String roomGroupInputOk(HttpServletRequest req, RoomDTO rdto, BindingResult result, 
			int max_count) throws IllegalStateException, IOException {
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		
		// 업로드할 이미지들의 객체를 리스트로 담는다.
		List<MultipartFile> mfList = mr.getFiles("room_images");
		
		// 파일명을 담을 배열을 파일 개수만큼 생성한다.
		String[] images = new String[mfList.size()];

		// DTO에 담을 파일 이름을 설정한다.
		for(int i=0; i<mfList.size(); ++i) {
			// 우선 업로드할 파일 이름을 배열에 담고
			images[i] = mfList.get(i).getOriginalFilename();
			
			if(images[i] == null || images[i].trim().equals("")) {
				// 배열에 파일 이름이 없는 경우 (업로드를 안하는 경우) default.jpg로 통일
				images[i] = "default.jpg";
			}else {
				// 배열에 파일 이름이 있는 경우 (업로드를 하는 경우) 중복 방지 처리
				images[i] = UUID.randomUUID().toString()+"_"+images[i];
			}
		}
		
		// DTO에 room_image1,2,3의 이름을 한꺼번에 설정
		rdto.setRoom_images(images);

		// 객실 그룹용 변수 (h_num + 식별번호)
		String room_code = null;
		
		if(hotelMapper.checkRoomCodeExists(rdto.getH_num())==null) {
			// DB에 해당 호텔에 대한 room_code가 없을 경우 "호텔고유번호_1"로 설정
			room_code = rdto.getH_num()+"_"+"1";
		}else {
			room_code = rdto.getH_num()+"_"+(hotelMapper.getMaxRoomCode(rdto.getH_num())+1);
		}
		
		// 객실 그룹 정보를 DTO에 담는다
		rdto.setRoom_code(room_code);
		
		// 첫 객실 등록
		int res = hotelMapper.inputRoom(rdto);
		
		// 등록이 제대로 될 경우
		if(res>0) {
			// 실제 파일을 업로드
			for(int i=0; i<mfList.size(); ++i) {
				if(!images[i].equals("default.jpg")) {
					File file = new File(upPath+"\\room", images[i]);
					mfList.get(i).transferTo(file);
				}
			}
			
			// 나머지 객실수만큼 객실 등록
			for(int i=0; i<max_count-1; ++i) {
				res = hotelMapper.inputRoom(rdto);
			}
			
			req.setAttribute("msg", "객실 그룹 등록 성공!! 객실 그룹 목록 페이지로 이동합니다.");
			req.setAttribute("url", "room_group_list?h_num="+rdto.getH_num());
		}else {
			req.setAttribute("msg", "객실 그룹 등록 실패!! 다시 입력해 주세요.");
			req.setAttribute("url", "room_group_input?h_num="+rdto.getH_num());
		}
		
		return "message";
	}
	
	@RequestMapping("/room_input_ok")
	public String roomInputOk(HttpServletRequest req, String room_code) {
		// 객실 등록을 위해 동일한 정보를 가진 객실리스트를 room_code를 통해 가져옴
		List<RoomDTO> rList = hotelMapper.listRoom(room_code);
		
		// 객실 등록
		int res = hotelMapper.inputRoom(rList.get(0));
		
		if(res>0) {
			req.setAttribute("msg", "객실추가 성공!! 객실 목록 페이지로 이동합니다.");
            req.setAttribute("url", "room_list?room_code="+room_code);
		}else {
            req.setAttribute("msg", "객실추가 실패!! 다시 입력해 주세요.");
            req.setAttribute("url", "room_list?room_code="+room_code);
        }
		
		return "message";
	}
	
	@RequestMapping("/room_group_edit")
	public String roomGroupEdit(HttpServletRequest req, int room_num) {
		// 객실 수정을 위해 동일한 정보를 가진 DTO를 room_num을 통해 생성
		RoomDTO rdto = hotelMapper.getRoomByRoomNum(room_num);
		
		req.setAttribute("rdto", rdto);
		
		return "hotel/room_group_edit";
	}
	
	@RequestMapping("/room_group_edit_ok")
	public String roomGroupEditOk(HttpServletRequest req, RoomDTO rdto, BindingResult result, 
			String[] pre_images) throws IllegalStateException, IOException {
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> mfList = mr.getFiles("room_images");

		// DTO에 파일이름을 한꺼번에 설정하기 위한 배열
		String[] images = new String[mfList.size()];

		// 파일 이름을 설정
		for(int i=0; i<mfList.size(); ++i) {
			images[i] = mfList.get(i).getOriginalFilename();
			if(images[i] == null || images[i].trim().equals("")) {
				// 파일 업로드가 없으면 기존 파일의 이름을 그대로 설정
				images[i] = pre_images[i];
			}else {
				// 파일 업로드가 있으면 파일 이름 새로 설정
				images[i] = UUID.randomUUID().toString()+"_"+images[i];
			}
		}
		
		// room_image1,2,3의 이름을 한꺼번에 DTO에 설정하는 메소드
		rdto.setRoom_images(images);
		
		// DB 수정
		int res = hotelMapper.editRoomGroup(rdto);
		
		if(res>0) {
			// 실제 파일을 업로드
			for(int i=0; i<mfList.size(); ++i) {
				// 새 파일명이랑 기존 파일명이 다를 경우
				if(!images[i].equals(pre_images[i])) {
					// 새 파일 업로드
					File newFile = new File(upPath+"\\room", images[i]);
					mfList.get(i).transferTo(newFile);
					
					// 기존 파일 삭제 (default.jpg 예외)
					File preFile = new File(upPath+"\\room", pre_images[i]);
					if(preFile.exists() && !preFile.getName().equals("default.jpg")) {
						preFile.delete();
					}
				}
			}
			
            req.setAttribute("msg", "객실 그룹 수정 성공!! 객실 그룹 목록 페이지로 이동합니다.");
            req.setAttribute("url", "room_group_list?h_num="+rdto.getH_num());
        }else {
            req.setAttribute("msg", "객실 그룹 수정 실패!! 객실 그룹 목록 페이지로 이동합니다.");
            req.setAttribute("url", "room_group_list?h_num="+rdto.getH_num());
        }
		
		return "message";
	}
	
	@RequestMapping("/room_group_delete_ok")
	public String roomGroupDeleteOk(HttpServletRequest req, String room_code, int h_num, String[] room_images) {
		try {
			// DB 삭제
			int res = hotelMapper.deleteRoomGroup(room_code);
			
			// 삭제가 성공하면
			if(res>0) {
				// 실제 파일 삭제
				for(int i=0; i<room_images.length; ++i) {
					File file = new File(upPath+"\\room", room_images[i]);
					if (file.exists() && !file.getName().equals("default.jpg")) {
						file.delete();
					}
				}
				
	            req.setAttribute("msg", "객실 그룹 삭제 성공!! 객실 그룹 목록 페이지로 이동합니다.");
	            req.setAttribute("url", "room_group_list?h_num="+h_num);
	        }else {
	            req.setAttribute("msg", "객실 그룹 삭제 실패!! 다시 입력해 주세요.");
	            req.setAttribute("url", "room_group_list?h_num="+h_num);
	        }
			
		}catch(DataIntegrityViolationException e) {
			// foreign key로 인한 예외 처리
			req.setAttribute("msg", "객실 예약이 존재하므로 삭제가 불가능합니다.");
			req.setAttribute("url", "room_group_list?h_num="+h_num);
			e.printStackTrace();
		}
		
		return "message";
	}
	
	@RequestMapping("/room_delete_ok")
	public String roomDeleteOk(HttpServletRequest req, int room_num, String room_code) {
		// DB 삭제
		int res = hotelMapper.deleteRoom(room_num);
		
		if(res>0) {
			req.setAttribute("msg", "객실삭제 성공!! 객실 목록 페이지로 이동합니다.");
            req.setAttribute("url", "room_list?room_code="+room_code);
		}else {
            req.setAttribute("msg", "객실삭제 실패!! 다시 입력해 주세요.");
            req.setAttribute("url", "room_list?room_code="+room_code);
        }
		
		return "message";
	}
	
	@RequestMapping("/room_disable")
	public String roomDisable(HttpServletRequest req, int room_num, String room_code) {
		// room_enable을 'n'으로
		int res = hotelMapper.disableRoom(room_num);
		
		if(res>0) {
            req.setAttribute("msg", "객실 비활성화 성공!! 객실 목록 페이지로 이동합니다.");
            req.setAttribute("url", "room_list?room_code="+room_code);
        }else {
            req.setAttribute("msg", "객실 비활성화 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "room_list?room_code="+room_code);
        }
		
		return "message";
	}
	
	@RequestMapping("/room_enable")
	public String roomEnable(HttpServletRequest req, int room_num, String room_code) {
		// room_enable을 'y'로
		int res = hotelMapper.enableRoom(room_num);
		
		if(res>0) {
            req.setAttribute("msg", "객실 활성화 성공!! 객실 목록 페이지로 이동합니다.");
            req.setAttribute("url", "room_list?room_code="+room_code);
        }else {
            req.setAttribute("msg", "객실 활성화 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "room_list?room_code="+room_code);
        }
		
		return "message";
	}
	
	@RequestMapping("/hotel_booklist")
	public String hotelBooklist(HttpServletRequest req, int h_num) {
		List<BookingDTO> bookList = hotelMapper.listBookingByHotel(h_num);
		List<NUserBookingDTO> NUserbookList = hotelMapper.listNUBookingByHotel(h_num);
		
		for(BookingDTO bdto : bookList) {
			RoomDTO rdto = hotelMapper.getRoomByRoomNum(bdto.getRoom_num());
			
			bdto.setH_name(hotelMapper.getHnameByHnum(h_num));
			bdto.setRoom_image1(rdto.getRoom_image1());
			bdto.setRoom_name(rdto.getRoom_name());
			bdto.setRoom_capacity(rdto.getRoom_capacity());
		}
		
		for(NUserBookingDTO bdto : NUserbookList) {
			RoomDTO rdto = hotelMapper.getRoomByRoomNum(bdto.getRoom_num());
			
			bdto.setH_name(hotelMapper.getHnameByHnum(h_num));
			bdto.setRoom_image1(rdto.getRoom_image1());
			bdto.setRoom_name(rdto.getRoom_name());
			bdto.setRoom_capacity(rdto.getRoom_capacity());
		}
		
		req.setAttribute("bookList", bookList);
		req.setAttribute("nBookList", NUserbookList);
		
		return "hotel/hotel_booklist";
	}
	
	@RequestMapping("/confirm_booking")
	public String confirmBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.confirmBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "예약 승인 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "예약 승인 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/confirm_nbooking")
	public String confirmnBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.confirmnBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "예약 승인 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "예약 승인 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/deny_booking")
	public String denyBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.denyBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "예약 거부 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "예약 거부 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/deny_nbooking")
	public String denynBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.denynBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "예약 거부 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "예약 거부 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/checkin_booking")
	public String checkinBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.checkinBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "체크인 상태로 변경 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "체크인 상태로 변경 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/checkin_nbooking")
	public String checkinnBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.checkinnBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "체크인 상태로 변경 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "체크인 상태로 변경 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/checkout_booking")
	public String checkoutBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.checkoutBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "체크아웃 상태로 변경 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "체크아웃 상태로 변경 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/checkout_nbooking")
	public String checkoutnBooking(HttpServletRequest req, int book_num, int room_num, int h_num) {
		int res = hotelMapper.checkoutnBooking(book_num);
		
		if(res>0) {
            req.setAttribute("msg", "체크아웃 상태로 변경 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }else {
            req.setAttribute("msg", "체크아웃 상태로 변경 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "hotel_booklist?h_num="+h_num);
        }
		
		return "message";
	}
}
