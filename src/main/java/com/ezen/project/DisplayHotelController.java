package com.ezen.project;

import java.util.Comparator;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.project.model.HotelDTO;
import com.ezen.project.model.ReviewDTO;
import com.ezen.project.model.RoomDTO;
import com.ezen.project.model.WishListDTO;
import com.ezen.project.service.DisplayHotelMapper;
import com.ezen.project.service.HotelMapper;
import com.ezen.project.service.UserMyPageMapper;

@Controller
public class DisplayHotelController {
	
	@Autowired
	private DisplayHotelMapper displayHotelMapper;
	
	@Autowired
	private HotelMapper hotelMapper;
	
	@Autowired
	private UserMyPageMapper userMyPageMapper;
	
	// HotelDTO에 리뷰개수, 별점평균, 위시체크여부를 담는 메소드
	private void addReviewCntAvgWish(List<HotelDTO> hotelList, LoginOkBeanUser loginOkBean) {
		for(HotelDTO hdto : hotelList) {
			hdto.setReviewCount(displayHotelMapper.getReviewCountByHotel(hdto.getH_num()));
			
			//호텔 별점 평균
			List<Integer> star = displayHotelMapper.listReviewStar(hdto.getH_num());
			int totalStar = 0;
			for(int i=0; i<star.size(); i++) {
				totalStar += star.get(i);
			}
			double starAverage = Math.round((double)totalStar/star.size()*10)/10.0;
			hdto.setReviewAvg(starAverage);
			
			if(loginOkBean != null) {
				int u_num = loginOkBean.getU_num();
				hdto.setWishList(displayHotelMapper.isWishCheck(hdto.getH_num(), u_num));
			}
		}
	}
	
	// 호텔 검색 결과 페이지를 보여주기 위한 설정
	@RequestMapping("/display_hotelSearchOk")
	public String hotelSearchOk(HttpServletRequest req, @RequestParam Map<String,String> params) {
		// params에 담긴 것들 : condition(직접 입력한 검색어나 지역키워드), indate, outdate, inwon
		// filter는 필터누를때만 담김
		
		// 검색한 호텔을 담을 List 생성해서 검색조건에 맞는 모든 DTO를 꺼내옴
		List<HotelDTO> hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
		
		HttpSession session = req.getSession();
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		// 꺼낸 List의 DTO에 리뷰개수와 별점평균을 담고, 로그인했을 경우엔 위시리스트 체크여부도 담음
		addReviewCntAvgWish(hotelList, loginOkBean);
		
		// 처음 검색할땐 조건문을 안타고, 필터를 누를때만 조건문을 타게됨
		if(params.get("filter") != null) {
			// 누른 필터에 따라 리스트 재정렬
			switch(params.get("filter")) {
				case "maxPrice":
					// DB에서 가격 높은 순으로 다시 뽑아옴
					hotelList = displayHotelMapper.listHotelByMaxPrice(params.get("condition"));
					
					// DB에는 리뷰개수, 별점평균, 위시체크여부가 없으므로 다시 담음
					addReviewCntAvgWish(hotelList, loginOkBean);
					
					break;
				case "minPrice":
					// DB에서 가격 낮은 순으로 다시 뽑아옴
					hotelList = displayHotelMapper.listHotelByMinPrice(params.get("condition"));
					
					// DB에는 리뷰개수, 별점평균, 위시체크여부가 없으므로 다시 담음
					addReviewCntAvgWish(hotelList, loginOkBean);
					
					break;
				case "maxReview": 
					// 최초 검색때 뽑은 List를 DTO의 reviewCount가 큰순으로 재정렬
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewCount).reversed())
					.collect(Collectors.toList());
					break;
				case "minReview": 
					// 최초 검색때 뽑은 List를 DTO의 reviewCount가 작은순으로 재정렬
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewCount))
					.collect(Collectors.toList());
					break;
				case "maxStar": 
					// 최초 검색때 뽑은 List를 DTO의 reviewAvg가 큰순으로 재정렬
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewAvg).reversed())
					.collect(Collectors.toList());
					break;
				case "minStar":
					// 최초 검색때 뽑은 List를 DTO의 reviewAvg가 작은순으로 재정렬
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewAvg))
					.collect(Collectors.toList());
					break;
				default:
					break;
			}
		}

		// 지도API에서 쓰기 위한 주소 배열 만들기
		String[] addrsForMap = new String[hotelList.size()];
		
		// DTO의 h_address에서 이름 부분만 뽑아서 넣음
		for(int i=0; i<hotelList.size(); i++) {
			HotelDTO hdto = hotelList.get(i);
			String addr = hdto.getH_address();
			String[] fullAddress = addr.split("\\(");
			addrsForMap[i] = fullAddress[0];
		}
		
		session.setAttribute("indate", params.get("indate"));
		session.setAttribute("outdate", params.get("outdate"));
		session.setAttribute("inwon", params.get("inwon"));
		session.setAttribute("hotelList", hotelList);
		session.setAttribute("addrsForMap", addrsForMap);	// 타입이 Map이 아니라 카카오맵에 사용될 String배열임
		session.setAttribute("condition", params.get("condition"));
		
		return "display/display_hotelSearchOk";
	}
	
	// 호텔 상세정보 페이지
	@RequestMapping("/display_hotelContent")
	public String hotelContent(HttpServletRequest req, int h_num) {
		
		// 호텔DTO 가져오기
		HotelDTO hdto = hotelMapper.getHotel(h_num);
		
		// 호텔에 리뷰 리스트 가져오기
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
		// 호텔 리뷰 개수 가져오기
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
		// 호텔 별점 평균 가져오기
		List<Integer> star = displayHotelMapper.listReviewStar(h_num);
		int totalStar = 0;
		for(int i=0; i<star.size(); i++) {
			totalStar += star.get(i);
		}
		double starAverage = Math.round((double)totalStar/star.size()*10)/10.0;

		// 객실 타입별로 List 뽑아오기
		List<RoomDTO> twinList = displayHotelMapper.listRoomByType(h_num, "TWIN");
		List<RoomDTO> doubleList = displayHotelMapper.listRoomByType(h_num, "DOUBLE");
		List<RoomDTO> deluxeList = displayHotelMapper.listRoomByType(h_num, "DELUXE");
		
		// List에 전체 객실 수와 예약된 객실 수 담기
		HttpSession session = req.getSession();
		
		Map<String, String> params = new Hashtable<>();
		params.put("book_indate", (String)session.getAttribute("indate"));
		params.put("book_outdate", (String)session.getAttribute("outdate"));
		
		for(RoomDTO rdto : twinList) {
			params.put("room_code", rdto.getRoom_code());
			
			rdto.setMax_count(hotelMapper.countRoomOnGroup(rdto.getRoom_code()));
			rdto.setBooked_count(displayHotelMapper.countBookedRoom(params));
			rdto.setNbooked_count(displayHotelMapper.countBookedRoomNonUser(params));
		}
		for(RoomDTO rdto : doubleList) {
			params.put("room_code", rdto.getRoom_code());
			
			rdto.setMax_count(hotelMapper.countRoomOnGroup(rdto.getRoom_code()));
			rdto.setBooked_count(displayHotelMapper.countBookedRoom(params));
			rdto.setNbooked_count(displayHotelMapper.countBookedRoomNonUser(params));
		}
		for(RoomDTO rdto : deluxeList) {
			params.put("room_code", rdto.getRoom_code());
			
			rdto.setMax_count(hotelMapper.countRoomOnGroup(rdto.getRoom_code()));
			rdto.setBooked_count(displayHotelMapper.countBookedRoom(params));
			rdto.setNbooked_count(displayHotelMapper.countBookedRoomNonUser(params));
		}
		
		// 로그인할 경우만 위시리스트 체크
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		if(loginOkBean != null) {
			hdto.setWishList(displayHotelMapper.isWishCheck(h_num, loginOkBean.getU_num()));
		}
		
		// 지도에 쓸 주소값 뽑기
		String addrForMap = "";
		String h_address = hdto.getH_address();
		
		for(int i=0; i<h_address.length(); i++) {
			String letter = String.valueOf(h_address.charAt(i));
			
			if(!letter.equals("@")) {
				addrForMap += letter;
			} else {
				break;
			}
		}
		
		session.setAttribute("hdto", hdto);
		session.setAttribute("map_addr", addrForMap);
		session.setAttribute("reviewCount", reviewCount);
		session.setAttribute("starAverage", starAverage);
		session.setAttribute("twinRoom", twinList);
		session.setAttribute("doubleRoom", doubleList);
		session.setAttribute("deluxeRoom", deluxeList);
		session.setAttribute("reviewList", reviewList);
		
		return "display/display_hotelContent";
	}
	
	
	// h_num과 room_num에 일치하는 결과 찾기
	@RequestMapping("/display_roomContent")
	public String roomContent(HttpServletRequest req, HttpServletResponse resp, @RequestParam(required=false) String room_code, 
			int h_num, String mode) {
		// 호텔 정보 (h_num, h_address)
		HotelDTO hdto = hotelMapper.getHotel(h_num);
		List<RoomDTO> roomList = hotelMapper.listRoom(room_code);
		RoomDTO room = roomList.get(0);
		
		HttpSession session = req.getSession();
		
		// 예약여부 확인
		Map<String, String> params = new Hashtable<>();
		params.put("book_indate", (String)session.getAttribute("indate"));
		params.put("book_outdate", (String)session.getAttribute("outdate"));
		params.put("room_code", room_code);
		
		for(RoomDTO rdto : roomList) {
			params.put("room_num", String.valueOf(rdto.getRoom_num()));
			
			boolean userBooked = displayHotelMapper.isBookedRoom(params);
			boolean nonUserBooked = displayHotelMapper.isBookedRoomNonUser(params);
			
			rdto.setRoom_booked(userBooked || nonUserBooked ? "y" : "n");
		}
		
		// 예약된 객실은 List에서 삭제
		roomList.removeIf(k -> k.getRoom_booked().equals("y"));
		
		// 호텔 정보와 공지를 @ 기준으로 나눠서 배열에 담음
		String[] hotelInfo = hdto.getH_info().split("@");
		String[] hotelNotice = hdto.getH_notice().split("@");
		
		if(mode != null) {
			req.setAttribute("mode", mode);
		}
		
		req.setAttribute("hdto", hdto);
		req.setAttribute("rdto", room);
		req.setAttribute("roomList", roomList);
		req.setAttribute("hotelInfo", hotelInfo);
		req.setAttribute("hotelNotice", hotelNotice);
		req.setAttribute("bookable_roomCount", roomList.size());
		
		resp.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "display/display_roomContent";
	}
	
	@RequestMapping("/review")
	public String review(HttpServletRequest req, @RequestParam int h_num) {
		
//		호텔에 대한 리뷰 리스트
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
//		호텔 리뷰 갯수
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
//		호텔 별점 평균
		List<Integer> star = displayHotelMapper.listReviewStar(h_num);
		int totalStar = 0;
		for(int i=0; i<star.size(); i++) {
			totalStar += star.get(i);
		}
		double starAverage = Math.round((double)totalStar/star.size()*10)/10.0;

		
		req.setAttribute("reviewCount", reviewCount);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("starAverage", starAverage);
		return "board/review";
	}
	
	//포인트페이지로 이동할 때
	@RequestMapping("/user_pointList")
	public ModelAndView userpointList(HttpServletRequest req, @RequestParam(required = false) String pageNum) {
		
		HttpSession session = req.getSession();
		LoginOkBeanUser loginokbean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		int u_num = loginokbean.getU_num();
		
		ModelAndView mav = new ModelAndView();
		if(pageNum == null) {
			pageNum = "1";
		}
		int pageSize = 10;
		int currentPage = Integer.parseInt(pageNum);
		int startRow = (currentPage-1) * pageSize + 1;
		int endRow = startRow + pageSize - 1;
		int number = 0;
		int rowCount = 0;
		
		rowCount = userMyPageMapper.getPointCount(u_num);
		
		if (endRow>rowCount) endRow = rowCount;
		number = rowCount - startRow + 1;
		
		List<ReviewDTO> pointList = userMyPageMapper.listPoint(startRow, endRow, u_num);
		
		mav.addObject("pointList", pointList);
		mav.addObject("number", number);
		mav.addObject("rowCount", rowCount);
		
		if (rowCount>0) {
//				[1] [2] [3]
			int pageBlock = 2;
//				31(게시글수) / 5  =  몫 : 6, 나머지 = 1
			int pageCount = rowCount / pageSize;
//				나머지가 0이 아니면, 나머지 게시글 보여주기 위해 몫++ 해줌
			if (rowCount%pageSize != 0){
				pageCount++;
			}
//										(1-1)	/	3		*	3		+ 1   = 1
//										(2-1)	/	3		*	3		+ 1   = 1
//										(4-1)	/	3		*	3		+ 1	  = 4
			int startPage = ((currentPage-1)/pageBlock) * pageBlock + 1;
//									1	+	3	-	1	= 3..
//									4	+	3	-	1	= 6..
//									7	+	3	-	1	= 9
			int endPage = startPage + pageBlock - 1;
//						3	>	7	거짓
//						9	>	7	참		endPage = 7(마지막페이지 넘버는 7이 됨)
			if (endPage > pageCount) endPage = pageCount;
			
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
		}
		
		mav.setViewName("user/user_pointList");
		
		return mav;
	}

	//위시리스트로 이동
	@RequestMapping("/user_wishlist")
	public ModelAndView userWishlist(HttpServletRequest req) {
		HttpSession session = req.getSession();
		LoginOkBeanUser loginokbean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		int u_num = loginokbean.getU_num();
		List<WishListDTO> wdto = userMyPageMapper.listWishList(u_num);
		List<WishListDTO> wdtoAct = userMyPageMapper.listWishListAct(u_num);
		req.setAttribute("wishListAct", wdtoAct);
		req.setAttribute("wishList", wdto);
		return new ModelAndView("user/user_wishlist", "wishList", wdto);
	}
	
//	wishList 페이지에서 호텔 위시리스트 해제
	@RequestMapping(value="/wishReleaseWL")
	public String wishReleaseWL(HttpServletRequest req, @RequestParam int w_num) {
		displayHotelMapper.wishReleaseWL(w_num);
		return "user/user_wishlist";
	}
	
//	hotelSeachOk 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishReleaseOK")
	public String wishReleaseOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayHotelMapper.wishRelease(params);
		return "display/display_hotelSearchOk";
	}
	
	@RequestMapping(value="/wishCheckOK")
	public String wishCheckOK(HttpServletRequest req,@RequestParam Map<String, String> params) {
		displayHotelMapper.wishCheck(params);
		return "display/display_hotelSearchOk";
	}
	
	// hotelContent 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishReleaseHC")
	public String wishReleaseHC(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayHotelMapper.wishRelease(params);
		return "display/display_hotelContent";
	}
	@RequestMapping(value="/wishCheckHC")
	public String wishCheckHC(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayHotelMapper.wishCheck(params);
		return "display/display_hotelContent";
	}
	
}
