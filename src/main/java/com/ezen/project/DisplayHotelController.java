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
	
	// HotelDTO�� ���䰳��, �������, ����üũ���θ� ��� �޼ҵ�
	private void addReviewCntAvgWish(List<HotelDTO> hotelList, LoginOkBeanUser loginOkBean) {
		for(HotelDTO hdto : hotelList) {
			hdto.setReviewCount(displayHotelMapper.getReviewCountByHotel(hdto.getH_num()));
			
			//ȣ�� ���� ���
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
	
	// ȣ�� �˻� ��� �������� �����ֱ� ���� ����
	@RequestMapping("/display_hotelSearchOk")
	public String hotelSearchOk(HttpServletRequest req, @RequestParam Map<String,String> params) {
		// params�� ��� �͵� : condition(���� �Է��� �˻�� ����Ű����), indate, outdate, inwon
		// filter�� ���ʹ������� ���
		
		// �˻��� ȣ���� ���� List �����ؼ� �˻����ǿ� �´� ��� DTO�� ������
		List<HotelDTO> hotelList = displayHotelMapper.listHotelByLocation(params.get("condition"));
		
		HttpSession session = req.getSession();
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		// ���� List�� DTO�� ���䰳���� ��������� ���, �α������� ��쿣 ���ø���Ʈ üũ���ε� ����
		addReviewCntAvgWish(hotelList, loginOkBean);
		
		// ó�� �˻��Ҷ� ���ǹ��� ��Ÿ��, ���͸� �������� ���ǹ��� Ÿ�Ե�
		if(params.get("filter") != null) {
			// ���� ���Ϳ� ���� ����Ʈ ������
			switch(params.get("filter")) {
				case "maxPrice":
					// DB���� ���� ���� ������ �ٽ� �̾ƿ�
					hotelList = displayHotelMapper.listHotelByMaxPrice(params.get("condition"));
					
					// DB���� ���䰳��, �������, ����üũ���ΰ� �����Ƿ� �ٽ� ����
					addReviewCntAvgWish(hotelList, loginOkBean);
					
					break;
				case "minPrice":
					// DB���� ���� ���� ������ �ٽ� �̾ƿ�
					hotelList = displayHotelMapper.listHotelByMinPrice(params.get("condition"));
					
					// DB���� ���䰳��, �������, ����üũ���ΰ� �����Ƿ� �ٽ� ����
					addReviewCntAvgWish(hotelList, loginOkBean);
					
					break;
				case "maxReview": 
					// ���� �˻��� ���� List�� DTO�� reviewCount�� ū������ ������
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewCount).reversed())
					.collect(Collectors.toList());
					break;
				case "minReview": 
					// ���� �˻��� ���� List�� DTO�� reviewCount�� ���������� ������
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewCount))
					.collect(Collectors.toList());
					break;
				case "maxStar": 
					// ���� �˻��� ���� List�� DTO�� reviewAvg�� ū������ ������
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewAvg).reversed())
					.collect(Collectors.toList());
					break;
				case "minStar":
					// ���� �˻��� ���� List�� DTO�� reviewAvg�� ���������� ������
					hotelList = hotelList.stream()
					.sorted(Comparator.comparing(HotelDTO::getReviewAvg))
					.collect(Collectors.toList());
					break;
				default:
					break;
			}
		}

		// ����API���� ���� ���� �ּ� �迭 �����
		String[] addrsForMap = new String[hotelList.size()];
		
		// DTO�� h_address���� �̸� �κи� �̾Ƽ� ����
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
		session.setAttribute("addrsForMap", addrsForMap);	// Ÿ���� Map�� �ƴ϶� īī���ʿ� ���� String�迭��
		session.setAttribute("condition", params.get("condition"));
		
		return "display/display_hotelSearchOk";
	}
	
	// ȣ�� ������ ������
	@RequestMapping("/display_hotelContent")
	public String hotelContent(HttpServletRequest req, int h_num) {
		
		// ȣ��DTO ��������
		HotelDTO hdto = hotelMapper.getHotel(h_num);
		
		// ȣ�ڿ� ���� ����Ʈ ��������
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
		// ȣ�� ���� ���� ��������
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
		// ȣ�� ���� ��� ��������
		List<Integer> star = displayHotelMapper.listReviewStar(h_num);
		int totalStar = 0;
		for(int i=0; i<star.size(); i++) {
			totalStar += star.get(i);
		}
		double starAverage = Math.round((double)totalStar/star.size()*10)/10.0;

		// ���� Ÿ�Ժ��� List �̾ƿ���
		List<RoomDTO> twinList = displayHotelMapper.listRoomByType(h_num, "TWIN");
		List<RoomDTO> doubleList = displayHotelMapper.listRoomByType(h_num, "DOUBLE");
		List<RoomDTO> deluxeList = displayHotelMapper.listRoomByType(h_num, "DELUXE");
		
		// List�� ��ü ���� ���� ����� ���� �� ���
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
		
		// �α����� ��츸 ���ø���Ʈ üũ
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		if(loginOkBean != null) {
			hdto.setWishList(displayHotelMapper.isWishCheck(h_num, loginOkBean.getU_num()));
		}
		
		// ������ �� �ּҰ� �̱�
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
	
	
	// h_num�� room_num�� ��ġ�ϴ� ��� ã��
	@RequestMapping("/display_roomContent")
	public String roomContent(HttpServletRequest req, HttpServletResponse resp, @RequestParam(required=false) String room_code, 
			int h_num, String mode) {
		// ȣ�� ���� (h_num, h_address)
		HotelDTO hdto = hotelMapper.getHotel(h_num);
		List<RoomDTO> roomList = hotelMapper.listRoom(room_code);
		RoomDTO room = roomList.get(0);
		
		HttpSession session = req.getSession();
		
		// ���࿩�� Ȯ��
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
		
		// ����� ������ List���� ����
		roomList.removeIf(k -> k.getRoom_booked().equals("y"));
		
		// ȣ�� ������ ������ @ �������� ������ �迭�� ����
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
		
//		ȣ�ڿ� ���� ���� ����Ʈ
		List<ReviewDTO> reviewList = displayHotelMapper.listReviewByHotel(h_num);
		
//		ȣ�� ���� ����
		int reviewCount = displayHotelMapper.getReviewCountByHotel(h_num);
		
//		ȣ�� ���� ���
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
	
	//����Ʈ�������� �̵��� ��
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
//				31(�Խñۼ�) / 5  =  �� : 6, ������ = 1
			int pageCount = rowCount / pageSize;
//				�������� 0�� �ƴϸ�, ������ �Խñ� �����ֱ� ���� ��++ ����
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
//						3	>	7	����
//						9	>	7	��		endPage = 7(������������ �ѹ��� 7�� ��)
			if (endPage > pageCount) endPage = pageCount;
			
			mav.addObject("startPage", startPage);
			mav.addObject("endPage", endPage);
			mav.addObject("pageBlock", pageBlock);
			mav.addObject("pageCount", pageCount);
		}
		
		mav.setViewName("user/user_pointList");
		
		return mav;
	}

	//���ø���Ʈ�� �̵�
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
	
//	wishList ���������� ȣ�� ���ø���Ʈ ����
	@RequestMapping(value="/wishReleaseWL")
	public String wishReleaseWL(HttpServletRequest req, @RequestParam int w_num) {
		displayHotelMapper.wishReleaseWL(w_num);
		return "user/user_wishlist";
	}
	
//	hotelSeachOk ���������� ���ø���Ʈ üũ/����
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
	
	// hotelContent ���������� ���ø���Ʈ üũ/����
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
