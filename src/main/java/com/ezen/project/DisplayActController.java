package com.ezen.project;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.project.model.ActivityDTO;
import com.ezen.project.model.ProgramDTO;
import com.ezen.project.model.ReviewActDTO;
import com.ezen.project.service.ActivityMapper;
import com.ezen.project.service.DisplayActMapper;

@Controller
public class DisplayActController {
	
	@Autowired
	private DisplayActMapper displayActMapper;
	
	@Autowired
	private ActivityMapper activityMapper;
	
	@RequestMapping(value="/display_activitySearchOk" , method=RequestMethod.POST)
	public String activitySearchOk(HttpServletRequest req, String code, 
			@RequestParam(required = false) String search, String bookdate) {
		
		HttpSession session = req.getSession();
		
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		List<ActivityDTO> activityList = null;
		
		if(!search.equals("") && !code.equals("")) {
			// 검색어도, 코드도 있는 경우
			activityList = displayActMapper.listActBySearchAndCode(search, code);
		}else if(!search.equals("") && code.equals("")) {
			// 검색어만 있는 경우
			if(search.contains(", ")) {
				//검색어에 ,가 있는 경우
				String[] arr = search.split(", ");
				String a_name = arr[0];
				String addr = arr[1];
				activityList = displayActMapper.listActByNameAndAddr(a_name, addr);
			}else {
				//검색어에 ,가 없는 경우
				activityList = displayActMapper.listActBySearch(search);
			}
		}else if(search.equals("") && !code.equals("")) {
			// 코드만 있는 경우
			activityList = displayActMapper.listActByCode(code);
		}else {
			// 둘다 없는 경우
			activityList = displayActMapper.listActBySearch(search); // search 변수는 빈 값
		}
		
		// 액티비티별 리뷰개수, 별점평균, 로그인했을 경우엔 위시리스트 체크여부까지 DTO에 설정
		for(ActivityDTO adto : activityList) {
			int reviewCount = displayActMapper.countReview(adto.getA_num());
			
			List<Integer> allRPList = displayActMapper.allReviewPointList(adto.getA_num());
			
			int totalPoint = 0;
			
			for(int i : allRPList) {
				totalPoint += i;
			}
			
			double avgReviewPoint = Math.round((double)totalPoint/reviewCount*10)/10.0;
			
			adto.setReviewCount(reviewCount);
			adto.setAvgReviewPoint(avgReviewPoint);
			
			if(loginOkBean != null) {
				int u_num = loginOkBean.getU_num();
				adto.setWishList(displayActMapper.isWishActCheck(adto.getA_num(), u_num));
			}
		}
		
		session.setAttribute("bookdate", bookdate);
		session.setAttribute("activityList", activityList);
		session.setAttribute("search", search);
		
		return "display/display_activitySearchOk";
	}
	
	@RequestMapping("/display_activityContent")
	public String activityContent(HttpServletRequest req, HttpServletResponse resp, int a_num) {
		
		// 액티비티DTO 가져오기
		ActivityDTO adto = activityMapper.getActivity(a_num);
		
		// 해당 액티비티의 리뷰를 전부 가져옴
		List<ReviewActDTO> reviewList = displayActMapper.listReviewByAct(a_num);
		
		// 리뷰 개수 저장
		int reviewCount = displayActMapper.countReview(a_num);
		
		// 별점 평균을 구해서 저장
		List<Integer> allRPList = displayActMapper.allReviewPointList(a_num);
		int totalPoint = 0;
		for(int i : allRPList) {
			totalPoint += i;
		}
		double avgReviewPoint = Math.round((double)totalPoint/reviewCount*10)/10.0;
		
		// 해당 액티비티의 프로그램 리스트 가져오기
		List<ProgramDTO> programList = activityMapper.listProgram(a_num);
		
		// 현재 예약 인원 설정
		HttpSession session = req.getSession();
		
		for(ProgramDTO pdto : programList) {
			List<Integer> cBookerList = displayActMapper.listCurrentBooker(pdto.getP_num(), (String)session.getAttribute("bookdate"));
			int currentBooker = 0;
			for(int i=0; i<cBookerList.size(); ++i) {
				currentBooker += cBookerList.get(i);
			}
			pdto.setP_currentbooker(currentBooker);
		}
		
		// 로그인한 경우만 위시리스트 체크여부 반영
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		if(loginOkBean != null) {
			adto.setWishList(displayActMapper.isWishActCheck(a_num, loginOkBean.getU_num()));
		}
		
		// 지도에 사용할 주소값 추출 (배열 0번째만 사용)
		String[] addr = adto.getA_address().split("@");
		
		// 정보, 공지, 주소 표기방법 변경해서 다시 세팅
		adto.setA_info(adto.getA_info().replace("@", "\r\n"));
		adto.setA_notice(adto.getA_notice().replace("@", "\r\n"));
		adto.setA_address(adto.getA_address().replace("@", "\r\n"));
		
		session.setAttribute("adto", adto);
		session.setAttribute("showAddr", addr[0]);
		session.setAttribute("reviewCount", reviewCount);
		session.setAttribute("avgReviewPoint", avgReviewPoint);
		session.setAttribute("programList", programList);
		session.setAttribute("reviewList", reviewList);
		
		// 브라우저 뒤로가기시 캐시에서 페이지 불러오는걸 방지
		resp.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "display/display_activityContent";
	}
	
	@RequestMapping("/reviewAct")
	public String reviewAct(HttpServletRequest req, @RequestParam int a_num) {
		List<ReviewActDTO> reviewList = displayActMapper.listReviewByAct(a_num);
		int reviewCount = displayActMapper.getReviewCountByAct(a_num);
		List<Integer> allRPList = displayActMapper.allReviewPointList(a_num);
		int totalPoint = 0;
		for(int i : allRPList) {
			totalPoint += i;
		}
		double avgReviewPoint = (double)totalPoint/reviewCount;
		avgReviewPoint = Math.round(avgReviewPoint*10)/10.0;
		
		req.setAttribute("reviewCount", reviewCount);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("avgReviewPoint", avgReviewPoint);
		return "board/reviewAct";
	}
	
	// WishList 페이지에서 위시리스트 해제
	@RequestMapping(value="/wishActReleaseWL")
	public String wishActReleaseWL(HttpServletRequest req, @RequestParam int w_num) {
		displayActMapper.wishActReleaseWL(w_num);
		return "user/user_wishlist";
	}
	
	// ActivitySeachOk 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishActReleaseOK")
	public String wishActReleaseOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActReleaseOK(params);
		return "displayact/display_activitySearchOk";
	}
	
	@RequestMapping(value="/wishActCheckOK")
	public String wishActCheckOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActCheckOK(params);
		return "displayact/display_activitySearchOk";
	}
	
	// ActivityContent 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishActCCheckOK")
	public String wishActCCheckOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActCheckOK(params);
		return "displayact/display_activityContent";
	}
	
	@RequestMapping(value="/wishActCReleaseOK")
	public String wishActCReleaseOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActReleaseOK(params);
		return "displayact/display_activityContent";
	}
}
