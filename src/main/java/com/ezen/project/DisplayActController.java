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
import com.ezen.project.model.WishListActDTO;
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
		session.setAttribute("bookdate", bookdate);
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		List<ActivityDTO> activityList = null;
		if(search.contains(", ")) {
			String[]array = search.split(", ");
			String a_name = array[0];
			String addr = array[1];
			activityList = displayActMapper.activityDoubleSearchOk(a_name, addr);
		}else if(!code.equals("")) {
			activityList = displayActMapper.activitySearchOkfilterall(code);
		}else {
			activityList = displayActMapper.activitySearchOk(search);
		}
		for(ActivityDTO adto : activityList) {
			int reviewCount = displayActMapper.countReview(adto.getA_num());
			List<Integer> allRPList = displayActMapper.allReviewPointList(adto.getA_num());
			int totalPoint = 0;
			for(int i : allRPList) {
				totalPoint += i;
			}
			double avgReviewPoint = (double)totalPoint/reviewCount;
			avgReviewPoint = Math.round(avgReviewPoint*10)/10.0;
			
			adto.setReviewCount(reviewCount);
			adto.setAvgReviewPoint(avgReviewPoint);
			
			if(loginOkBean != null) {
				int u_num = loginOkBean.getU_num();
				List<WishListActDTO> wishList = displayActMapper.getWishListAct(u_num);
				for(WishListActDTO wdto : wishList) {
					if(adto.getA_num() == wdto.getA_num()) {
						adto.setWishList(1);
					}
				}
			}
		}
		req.setAttribute("activityList", activityList);
		req.setAttribute("search", search);
		return "display/display_activitySearchOk";
	}
	
	@RequestMapping("/display_activitySearchOkfilter")
	public String activitySearchOkfilter(HttpServletRequest req, String search, String code, String bookdate) {
		List<ActivityDTO> activityList = null;
		
		if(search.equals("")) {
			activityList = displayActMapper.activitySearchOkfilterall(code);
		}else {
			activityList = displayActMapper.activitySearchOkfilter(search, code);
		}
		
		HttpSession session = req.getSession();
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		if(loginOkBean != null) {
			int u_num = loginOkBean.getU_num();
			List<WishListActDTO> wishList = displayActMapper.getWishListAct(u_num);
			
			for(ActivityDTO adto : activityList) {
				for(WishListActDTO wdto : wishList) {
					if(adto.getA_num() == wdto.getA_num()) {
						adto.setWishList(1);
					}
				}
			}
		}
		
		req.setAttribute("activityList", activityList);
		session.setAttribute("bookdate", bookdate);
		return "display/display_activitySearchOk";
	}
	
	@RequestMapping("/display_activityContent")
	public String activityContent(HttpServletRequest req, HttpServletResponse resp, int a_num) {
		activityContentInfo(req, a_num);
		
		resp.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
		resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		resp.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		resp.setHeader("Pragma", "no-cache");
		
		return "display/display_activityContent";
	}
	
	protected void activityContentInfo(HttpServletRequest req, int a_num) {
		HttpSession session = req.getSession();
		
		ActivityDTO adto = activityMapper.getActivity(a_num);
		String[] addr = adto.getA_address().split("@");
		
		List<ProgramDTO> programList = activityMapper.listProgram(a_num);
		
		adto.setA_info(adto.getA_info().replace("@", "\r\n"));
		adto.setA_notice(adto.getA_notice().replace("@", "\r\n"));
		adto.setA_address(adto.getA_address().replace("@", "\r\n"));
		
		for(ProgramDTO pdto : programList) {
			List<Integer> cBookerList = displayActMapper.listCurrentBooker(pdto.getP_num(), (String)session.getAttribute("bookdate"));
			int currentBooker = 0;
			for(int i=0; i<cBookerList.size(); ++i) {
				currentBooker += cBookerList.get(i);
			}
			pdto.setP_currentbooker(currentBooker);
		}
		
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		if(loginOkBean != null) {
			int u_num = loginOkBean.getU_num();
			List<WishListActDTO> wishList = displayActMapper.getWishListAct(u_num);
			
			for(WishListActDTO wdto : wishList) {
				if(adto.getA_num() == wdto.getA_num()) {
					adto.setWishList(1);
				}
			}
			
		}
			
		int reviewCount = displayActMapper.countReview(a_num);
		List<Integer> allRPList = displayActMapper.allReviewPointList(a_num);
		int totalPoint = 0;
		for(int i : allRPList) {
			totalPoint += i;
		}
		double avgReviewPoint = (double)totalPoint/reviewCount;
		avgReviewPoint = Math.round(avgReviewPoint*10)/10.0;
		List<ReviewActDTO> reviewList = displayActMapper.listReviewByAct(a_num);
		
		req.setAttribute("reviewCount", reviewCount);
		req.setAttribute("avgReviewPoint", avgReviewPoint);
		req.setAttribute("reviewList", reviewList);
		req.setAttribute("showAddr", addr[0]);
		req.setAttribute("adto", adto);
		req.setAttribute("programList", programList);
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
	
//	wishList 페이지에서 액티비티 위시리스트 해제
	@RequestMapping(value="/wishActReleaseWL")
	public String wishActReleaseWL(HttpServletRequest req, @RequestParam int w_num) {
		displayActMapper.wishActReleaseWL(w_num);
		return "user/user_wishlist";
	}
	
//	ActivitySeachOk 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishActReleaseOK")
	public String wishActReleaseOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActReleaseOK(params);
		List<ActivityDTO> actList = displayActMapper.getActivity(params);
		HttpSession session = req.getSession();
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		int u_num = loginOkBean.getU_num();
		List<WishListActDTO> wishList = displayActMapper.getWishListAct(u_num);
		for(ActivityDTO adto : actList) {
			for(WishListActDTO wdto : wishList) {
				if(adto.getA_num() == wdto.getA_num()) {
					adto.setWishList(1);
				}
			}
		}
		req.setAttribute("activityList", actList);
		return "displayact/display_activitySearchOk";
	}
	
	@RequestMapping(value="/wishActCheckOK")
	public String wishActCheckOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActCheckOK(params);
		List<ActivityDTO> actList = displayActMapper.getActivity(params);
		HttpSession session = req.getSession();
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		int u_num = loginOkBean.getU_num();
		List<WishListActDTO> wishList = displayActMapper.getWishListAct(u_num);
		for(ActivityDTO adto : actList) {
			for(WishListActDTO wdto : wishList) {
				if(adto.getA_num() == wdto.getA_num()) {
					adto.setWishList(1);
				}
			}
		}
		req.setAttribute("activityList", actList);
		return "displayact/display_activitySearchOk";
	}
	
//	ActivityContent 페이지에서 위시리스트 체크/해제
	@RequestMapping(value="/wishActCCheckOK")
	public String wishActCCheckOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActCheckOK(params);
		activityContentInfo(req, Integer.parseInt(params.get("a_num")));
		return "displayact/display_activityContent";
	}
	
	@RequestMapping(value="/wishActCReleaseOK")
	public String wishActCReleaseOK(HttpServletRequest req, @RequestParam Map<String, String> params) {
		displayActMapper.wishActReleaseOK(params);
		activityContentInfo(req, Integer.parseInt(params.get("a_num")));
		return "displayact/display_activityContent";
	}
}
