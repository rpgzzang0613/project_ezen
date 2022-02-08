package com.ezen.project;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
	
//	호텔 검색후 HotelDTO리스트 반환 필터
	@RequestMapping("/display_hotelSearchOk")
	public String hotelSearchOk(HttpServletRequest req, @RequestParam Map<String,String> params) {
//		params로 검색어, 인원수, 체크인, 체크아웃을 받아 sql에서 조건으로 써야할듯(미완성)
		List<HotelDTO> hotelList = null;
		
		if(params.get("filter") == null) {
//			아래 메소드 실행
			searchResult(req, params);
			req.setAttribute("condition", params.get("condition"));
		}else {
			Map<Integer, Integer> countReview = null;
			Map<Integer, Double> starReview = null;
			List<HotelDTO> newHotelList = null;
			List<Map.Entry<Integer, Integer>> orderedByReviewCount = null;
			List<Map.Entry<Integer, Double>> orderedByStarCount = null;
			
			switch(params.get("filter")) {
				case "maxPrice":
					hotelList = displayHotelMapper.listHotelByMaxPrice(params.get("condition"));
					break;
				case "minPrice": 
					hotelList = displayHotelMapper.listHotelByMinPrice(params.get("condition"));
					break;
				case "maxReview": 
					hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
//					꺼내온 HotelDTO 리스트들의 후기갯수, 별점평균 계산후 map에 담아줌
//					Map<호텔고유값, 후기갯수>
					countReview = displayHotelMapper.countReview(hotelList);
//					후기 적은순대로 newHotelList라는 새로운 리스트에 정렬해넣기
					orderedByReviewCount = new LinkedList<>(countReview.entrySet());
					orderedByReviewCount.sort(Map.Entry.comparingByValue());
	         
					newHotelList = new ArrayList<HotelDTO>();
					
					for(Map.Entry<Integer, Integer> entry : orderedByReviewCount) {
						int order = entry.getKey();
						for(HotelDTO hdto : hotelList) {
							if(order == hdto.getH_num()) {
								newHotelList.add(hdto);
								break;
							}
						}
					}
					
					// 후기 적은순을 뒤집어서 후기 많은순으로 변경
					Collections.reverse(newHotelList);
					
					hotelList = newHotelList;
					
					break;
				case "minReview": 
					hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
//					꺼내온 HotelDTO 리스트들의 후기갯수, 별점평균 계산후 map에 담아줌
//					Map<호텔고유값, 후기갯수>
					countReview = displayHotelMapper.countReview(hotelList);
//					후기 적은순대로 newHotelList라는 새로운 리스트에 정렬해넣기
					orderedByReviewCount = new LinkedList<>(countReview.entrySet());
					orderedByReviewCount.sort(Map.Entry.comparingByValue());
	         
					newHotelList = new ArrayList<HotelDTO>();
					
					for(Map.Entry<Integer, Integer> entry : orderedByReviewCount){
						int order = entry.getKey();
						for(HotelDTO hdto : hotelList) {
							if(order == hdto.getH_num()) {
								newHotelList.add(hdto);
								break;
							}
						}
					}
					
					hotelList = newHotelList;
					
					break;
				case "maxStar": 
					hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
//					꺼내온 HotelDTO 리스트들의 후기갯수, 별점평균 계산후 map에 담아줌
//					Map<호텔고유값, 후기갯수>
					starReview = displayHotelMapper.averageReview(hotelList);
//					후기 적은순대로 newHotelList라는 새로운 리스트에 정렬해넣기
					orderedByStarCount = new LinkedList<>(starReview.entrySet());
					orderedByStarCount.sort(Map.Entry.comparingByValue());
					         
					newHotelList = new ArrayList<HotelDTO>();
									
					for(Map.Entry<Integer, Double> entry : orderedByStarCount){
						int order = entry.getKey();
						for(HotelDTO hdto : hotelList) {
							if(order == hdto.getH_num()) {
								newHotelList.add(hdto);
								break;
							}
						}
					}
									
					Collections.reverse(newHotelList);
									
					hotelList = newHotelList;
									
					break;
				case "minStar": 
					hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
//					꺼내온 HotelDTO 리스트들의 후기갯수, 별점평균 계산후 map에 담아줌
//					Map<호텔고유값, 후기갯수>
					starReview = displayHotelMapper.averageReview(hotelList);
//					후기 적은순대로 newHotelList라는 새로운 리스트에 정렬해넣기
					orderedByStarCount = new LinkedList<>(starReview.entrySet());
					orderedByStarCount.sort(Map.Entry.comparingByValue());
					         
					newHotelList = new ArrayList<HotelDTO>();
									
					for(Map.Entry<Integer, Double> entry : orderedByStarCount){
						int order = entry.getKey();
						for(HotelDTO hdto : hotelList) {
							if(order == hdto.getH_num()) {
								newHotelList.add(hdto);
								break;
							}
						}
					}
									
					hotelList = newHotelList;
									
					break;
			}
				         
//			꺼내온 HotelDTO 리스트들의 후기갯수, 별점평균 계산후 map에 담아줌
//			Map<호텔고유값, 후기갯수>
			countReview = displayHotelMapper.countReview(hotelList);
//			Map<호텔고유값, 별점평균>
			starReview = displayHotelMapper.averageReview(hotelList);
         
//			새로고침하거나 다른페이지를 다녀와도, 마지막 검색값이 그대로 남을수 있도록 session에 hotelList등록
			HttpSession session = req.getSession();
			req.setAttribute("condition", params.get("condition"));
			session.setAttribute("hotelList", hotelList);
         
			LoginOkBeanUser loginInfo = (LoginOkBeanUser)session.getAttribute("loginOkBean");
      
			try{
				int u_num = loginInfo.getU_num();
         
//				회원고유값으로 호텔이 wishList에 등록되어있는지 아닌지 확인(등록 1, 미등록 0)
				for(HotelDTO hdto : hotelList) {
					hdto.setWishList(displayHotelMapper.isWishCheck(hdto.getH_num(), u_num));
				}
			}catch(Exception e) {};
			
			String[] addrs = new String[hotelList.size()];
			for(int i=0; i<hotelList.size(); i++) {
				HotelDTO hdto = hotelList.get(i);
				String addr = hdto.getH_address();
				String[] fullAddress = addr.split("\\(");
				addrs[i] = fullAddress[0];
			}
			
			String[] names = new String[hotelList.size()];
			for(int i=0; i<hotelList.size(); i++) {
				HotelDTO hdto = hotelList.get(i);
				names[i] = hdto.getH_name();
			}
			
			req.setAttribute("names", names); 
			req.setAttribute("addrs", addrs); 
			req.setAttribute("hotelList", hotelList);
			req.setAttribute("countReview", countReview);
			req.setAttribute("averageReview", starReview);
		}
		 
		//		main.jsp검색창에서 설정한 체크인/아웃 날짜들을 session에 넣어둠(user_bookWrite.jsp에서 사용) 
		HttpSession session = req.getSession();
		
		if(params.get("indate") != null && params.get("outdate") != null ) {
			session.setAttribute("indate", params.get("indate"));
			session.setAttribute("outdate", params.get("outdate"));
		}else {
			if((String)session.getAttribute("indate") == null && (String)session.getAttribute("outdate") == null) {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date time = new Date();
				String today = sdf.format(time);

		        Calendar cal = new GregorianCalendar();
		        cal.add(Calendar.DATE, 1);
		        Date date = cal.getTime();
		        String tmr = sdf.format(date);
						
				session.setAttribute("indate", today);
				session.setAttribute("outdate", tmr);
			}
		}
		session.setAttribute("inwon", params.get("inwon"));
		
		return "display/display_hotelSearchOk";
	}
	
	protected void searchResult(HttpServletRequest req, Map<String, String> params) {
	
//		DB에서 condition에 맞는 모든 HotelDTO를 꺼내옴
		List<HotelDTO> hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
		
//		꺼내온 HotelDTO 리스트들의 후기갯수, 별점평균 계산후 map에 담아줌
//		Map<호텔고유값, 후기갯수>
		Map<Integer, Integer> countReview = displayHotelMapper.countReview(hotelList);
//		Map<호텔고유값, 별점평균>
		Map<Integer, Double> averageReview = displayHotelMapper.averageReview(hotelList);
		
//		새로고침하거나 다른페이지를 다녀와도, 마지막 검색값이 그대로 남을수 있도록 session에 hotelList등록
		HttpSession session = req.getSession();
		session.setAttribute("hotelList", hotelList);
		
		LoginOkBeanUser loginInfo = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		try{
			int u_num = loginInfo.getU_num();
		
//			회원고유값으로 호텔이 wishList에 등록되어있는지 아닌지 확인(등록 1, 미등록 0)
			for(HotelDTO hdto : hotelList) {
				hdto.setWishList(displayHotelMapper.isWishCheck(hdto.getH_num(), u_num));
			}
		}catch(Exception e) {};
		
		String[] addrs = new String[hotelList.size()];
		
		for(int i=0; i<hotelList.size(); i++) {
			HotelDTO hdto = hotelList.get(i);
			String addr = hdto.getH_address();
			String[] fullAddress = addr.split("\\(");
			addrs[i] = fullAddress[0];
		}
		
		String[] names = new String[hotelList.size()];
		
		for(int i=0; i<hotelList.size(); i++) {
			HotelDTO hdto = hotelList.get(i);
			names[i] = hdto.getH_name();
		}
		req.setAttribute("names", names); 
		req.setAttribute("addrs", addrs); 
		req.setAttribute("hotelList", hotelList);
		req.setAttribute("countReview", countReview);
		req.setAttribute("averageReview", averageReview);
	}
	
	
//	h_num으로 호텔 상세정보 찾기
	@RequestMapping("/display_hotelContent")
	public String hotelContent(HttpServletRequest req, @RequestParam int h_num, String indate, String outdate, int inwon) {
		HttpSession session = req.getSession();
		session.setAttribute("indate", indate);
		session.setAttribute("outdate", outdate);
		session.setAttribute("inwon", inwon);

//		호텔 리뷰 갯수
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
//		호텔 별점 평균
		double starAverage = displayHotelMapper.reviewStar(h_num);
		starAverage = Math.round(starAverage*10)/10.0;//소수 1번째 자리까지 표기
		
//		방 타입별 정보
		List<RoomDTO> twinRoom = displayHotelMapper.listRoomByType(h_num, "TWIN");
		List<RoomDTO> doubleRoom = displayHotelMapper.listRoomByType(h_num, "DOUBLE");
		List<RoomDTO> deluxeRoom = displayHotelMapper.listRoomByType(h_num, "DELUXE");
		
//		위시리스트 체크
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		List<HotelDTO> hotelList = (List<HotelDTO>)session.getAttribute("hotelList");
		
		try {
			//회원로그인시 u_num으로 확인
			int u_num = loginOkBean.getU_num();
			for(HotelDTO hdto : hotelList) {
				if(hdto.getH_num() == h_num) {
					hdto.setWishList(displayHotelMapper.isWishCheck(h_num, u_num));
					req.setAttribute("hdto", hdto);
				}
			}
		
		}catch(Exception e) {
//			비회원은 u_num에서 error발생 위시리스트 체크 필요없음
			HotelDTO hdto = hotelMapper.getHotel(h_num);
			req.setAttribute("hdto", hdto);
		}
		
		
//		호텔에 대한 리뷰 리스트
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
//		비교할 오늘내일날짜 내려주기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date time = new Date();
		String today = sdf.format(time);
		Calendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, 1);
		Date date = cal.getTime();
		String tmr = sdf.format(date);
		
//      맵에 쓸 주소값
		HotelDTO hdtoForAddress = null;
		
		try{
			//회원로그인시 u_num으로 확인
			int u_num = loginOkBean.getU_num();
			for(HotelDTO hdto : hotelList) {
				if(hdto.getH_num() == h_num) {
					hdto.setWishList(displayHotelMapper.isWishCheck(h_num, u_num));
					hdtoForAddress = hdto;
					req.setAttribute("hdto", hdto);
				}
			}
		}catch(Exception e) {
//	         비회원은 u_num에서 error발생 위시리스트 체크 필요없음
			HotelDTO hdto = hotelMapper.getHotel(h_num);
			hdtoForAddress = hdto;
			req.setAttribute("hdto", hdto);
		}
	      
		String addr = "";
		String h_address = hdtoForAddress.getH_address();

		for(int i=0; i<h_address.length(); i++) {
			String letter = String.valueOf(h_address.charAt(i));
			
			if(!letter.equals("@")) {
				addr += letter;
			} else {
				break;
			}
		}
		
		req.setAttribute("map_addr", addr);
		
		req.setAttribute("today", today);
		req.setAttribute("tmr", tmr);

		req.setAttribute("reviewCount", reviewCount);
		req.setAttribute("starAverage", starAverage);
		req.setAttribute("twinRoom", twinRoom);
		req.setAttribute("doubleRoom", doubleRoom);
		req.setAttribute("deluxeRoom", deluxeRoom);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("loginOkBean", loginOkBean);
		
		return "display/display_hotelContent";
	}
	
	
//	h_num과 room_num에 일치하는 결과 찾기
	@RequestMapping("/display_roomContent")
	public String roomContent(HttpServletRequest req, @RequestParam(required=false) String room_code, 
			int h_num) {
//		호텔정보
		HotelDTO hdto = hotelMapper.getHotel(h_num);
		List<RoomDTO> roomList = hotelMapper.listRoomInGroupByRoomCode(room_code);
		RoomDTO room = roomList.get(0);
		
		HttpSession session = req.getSession();
		
		Map<String, String> map = new Hashtable<>();
		map.put("book_indate", (String)session.getAttribute("indate"));
		map.put("book_outdate", (String)session.getAttribute("outdate"));
		
		for(RoomDTO rdto : roomList) {
			map.put("room_num", String.valueOf(rdto.getRoom_num()));
			rdto.setRoom_booked(displayHotelMapper.isBookedRoom(map));
		}
		
		List<RoomDTO> roomList2 = new ArrayList<RoomDTO>();
		for(RoomDTO rdto : roomList) {
			if(rdto.getRoom_booked().equals("n")) {
				roomList2.add(rdto);
			}
		}
		
		roomList = roomList2;
		
		req.setAttribute("hdto", hdto);
		req.setAttribute("Room", room);
		req.setAttribute("roomList", roomList);
		
		
		Map<String, String> map2 = new Hashtable<String, String>();
		
		map2.put("book_indate", (String)session.getAttribute("indate"));
		map2.put("book_outdate", (String)session.getAttribute("outdate"));
		map2.put("room_code", room.getRoom_code());
		
		int max_roomCount = hotelMapper.countRoomOnGroup(room.getRoom_code());
		
		int booked_roomCount = displayHotelMapper.countBookedRoom(map2);
		
		int bookable_roomCount = max_roomCount - booked_roomCount;
		
		System.out.println("총 방 수 : " + max_roomCount);
		System.out.println("예약된 방 수 : " + booked_roomCount);
		System.out.println("예약가능 방 수 : " + bookable_roomCount);
		
//		호텔기본정보
//		@구분자로 사항들을 나눠서 배열에 담아줌 -> jsp에서 배열 하나씩 출력+줄개행
		String[] hotelInfo = hdto.getH_info().split("@");
		String[] hotelNotice = hdto.getH_notice().split("@");
		req.setAttribute("hotelInfo", hotelInfo);
		req.setAttribute("hotelNotice", hotelNotice);
		req.setAttribute("bookable_roomCount", bookable_roomCount);
		
		return "display/display_roomContent";
	}
	
	@RequestMapping("/review")
	public String review(HttpServletRequest req, @RequestParam int h_num) {
		
//		호텔에 대한 리뷰 리스트
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
//		호텔 리뷰 갯수
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
//		호텔 별점 평균
		double starAverage = displayHotelMapper.reviewStar(h_num);
		starAverage = Math.round(starAverage*10)/10.0;//소수 1번째 자리까지 표기
		
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
		List<WishListDTO> wdtoAct = userMyPageMapper.wishListActView(u_num);
		req.setAttribute("wishListAct", wdtoAct);
		req.setAttribute("wishList", wdto);
		return new ModelAndView("user/user_wishlist", "wishList", wdto);
	}
	
//	hotelSeachOk 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishRelease")
	public String wishRelease(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayHotelMapper.wishRelease(params);
		searchResult(req, params);
		return "display/display_hotelSearchOk";
	}
	@RequestMapping(value="/wishCheck")
	public String wishCheck(HttpServletRequest req,@RequestParam Map<String, String> params) {
		displayHotelMapper.wishCheck(params);
		searchResult(req, params);
		return "display/display_hotelSearchOk";
	}
	
//	hotelContent 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishReleaseHC")
	public String wishReleaseHC(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayHotelMapper.wishRelease(params);
		hotelContentWish(req, Integer.parseInt(params.get("h_num")), params.get("indate"), params.get("outdate"), Integer.parseInt(params.get("inwon")));
		return "display/display_hotelContent";
	}
	@RequestMapping(value="/wishCheckHC")
	public String wishCheckHC(HttpServletRequest req,@RequestParam Map<String, String> params) {
		displayHotelMapper.wishCheck(params);
		hotelContentWish(req, Integer.parseInt(params.get("h_num")), params.get("indate"), params.get("outdate"), Integer.parseInt(params.get("inwon")));
		return "display/display_hotelContent";
	}
	
	protected void hotelContentWish(HttpServletRequest req, @RequestParam int h_num, String indate, String outdate, int inwon) {
		HttpSession session = req.getSession();
		session.setAttribute("indate", indate);
		session.setAttribute("outdate", outdate);
		session.setAttribute("inwon", inwon);

//		호텔 리뷰 갯수
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
//		호텔 별점 평균
		double starAverage = displayHotelMapper.reviewStar(h_num);
		starAverage = Math.round(starAverage*10)/10.0;//소수 1번째 자리까지 표기
		
//		방 타입별 정보
		List<RoomDTO> twinRoom = displayHotelMapper.listRoomByType(h_num, "TWIN");
		List<RoomDTO> doubleRoom = displayHotelMapper.listRoomByType(h_num, "DOUBLE");
		List<RoomDTO> deluxeRoom = displayHotelMapper.listRoomByType(h_num, "DELUXE");
		
//		위시리스트 체크
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		List<HotelDTO> hotelList = (List<HotelDTO>)session.getAttribute("hotelList");
		
		try {
			//회원로그인시 u_num으로 확인
			int u_num = loginOkBean.getU_num();
			for(HotelDTO hdto : hotelList) {
				if(hdto.getH_num() == h_num) {
					hdto.setWishList(displayHotelMapper.isWishCheck(h_num, u_num));
					req.setAttribute("hdto", hdto);
				}
			}
		
		}catch(Exception e) {
//			비회원은 u_num에서 error발생 위시리스트 체크 필요없음
			HotelDTO hdto = hotelMapper.getHotel(h_num);
			req.setAttribute("hdto", hdto);
		}
		
		
//		호텔에 대한 리뷰 리스트
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
//		비교할 오늘내일날짜 내려주기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date time = new Date();
		String today = sdf.format(time);
		Calendar cal = new GregorianCalendar();
		cal.add(Calendar.DATE, 1);
		Date date = cal.getTime();
		String tmr = sdf.format(date);
		
//      맵에 쓸 주소값
		HotelDTO hdtoForAddress = null;
		
		try{
			//회원로그인시 u_num으로 확인
			int u_num = loginOkBean.getU_num();
			for(HotelDTO hdto : hotelList) {
				if(hdto.getH_num() == h_num) {
					hdto.setWishList(displayHotelMapper.isWishCheck(h_num, u_num));
					hdtoForAddress = hdto;
					req.setAttribute("hdto", hdto);
				}
			}
		}catch(Exception e) {
//	         비회원은 u_num에서 error발생 위시리스트 체크 필요없음
			HotelDTO hdto = hotelMapper.getHotel(h_num);
			hdtoForAddress = hdto;
			req.setAttribute("hdto", hdto);
		}
	      
		String addr = "";
		String h_address = hdtoForAddress.getH_address();

		for(int i=0; i<h_address.length(); i++) {
			String letter = String.valueOf(h_address.charAt(i));
			
			if(!letter.equals("@")) {
				addr += letter;
			} else {
				break;
			}
		}
		
		req.setAttribute("map_addr", addr);
		
		req.setAttribute("today", today);
		req.setAttribute("tmr", tmr);

		req.setAttribute("reviewCount", reviewCount);
		req.setAttribute("starAverage", starAverage);
		req.setAttribute("twinRoom", twinRoom);
		req.setAttribute("doubleRoom", doubleRoom);
		req.setAttribute("deluxeRoom", deluxeRoom);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("loginOkBean", loginOkBean);
	}
	
//	wishList페이지 에서 위시리스트 해제
	@RequestMapping(value="/wishRelease3")
	public String wishRelease3(HttpServletRequest req, @RequestParam int w_num) {
		displayHotelMapper.wishRelease2(w_num);
		return "user/user_wishlist";
	}
	
//	wishList페이지 에서 위시리스트 해제
	@RequestMapping(value="/wishRelease5")
	public String wishRelease5(HttpServletRequest req, @RequestParam int w_num) {
		displayHotelMapper.wishRelease3(w_num);
		return "user/user_wishlist";
	}
}
