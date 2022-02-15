package com.ezen.project;

import java.util.List;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ezen.project.model.CompanyDTO;
import com.ezen.project.model.UserDTO;
import com.ezen.project.service.CompanyMapper;
import com.ezen.project.service.UserMapper;

@Controller
public class AdminController {

	@Autowired
	private UserMapper userMapper;
	
	@Autowired 
	private CompanyMapper companyMapper;
	
	@Autowired
	private LoginOkBeanUser loginOkBean;
	
	@Autowired
	private LoginOkBeanCompany companyLoginOkBean;
	
	//list에서 유저 목록보여주기
	@RequestMapping("/admin_user_list")
	public ModelAndView adminUserList (HttpServletRequest req, 
			@RequestParam(required = false) String mode) {

		ModelAndView mav = new ModelAndView();
		
		if(loginOkBean.getA_level().equals("3")) {
			if (mode==null) {
				mode = "all";
			}
			
			List<UserDTO> uList = null; 
			
			if (mode.equals("all")) {
				uList = userMapper.listUser();
			}else {
				String search = req.getParameter("search");
				String searchString = req.getParameter("searchString");
				uList = userMapper.findUser(search, searchString);
			}
			
			mav.addObject("uList", uList);
			mav.addObject("mode", mode);
			mav.setViewName("admin/admin_user_list");
		}else {
			mav.addObject ("msg","admin만 입장 가능합니다");
			mav.addObject("url", "/project");
			mav.setViewName("message");
			}
		return mav;
	}
	
	//관리자가 유저 삭제
	@RequestMapping("/deleteUser")
	public String deleteUser(HttpServletRequest req, 
			@RequestParam int u_num) {
	
		//num값 받아서 넘겨줘서 유저 목록 삭제
		int res = userMapper.deleteUserByAdmin(u_num);

		if (res>0) {
			req.setAttribute("msg", "회원삭제성공!! 회원관리페이지로 이동합니다.");
			req.setAttribute("url", "admin_user_list");
		}else {
			req.setAttribute("msg", "회원삭제실패!! 회원관리페이지로 이동합니다.");
			req.setAttribute("url", "admin_user_list");
		}
		
		return "message";
	}
	
	//blacklist 등록 num값 받아서 실행
	@RequestMapping("/insertBlackUser")
	public String insertBlackUser(HttpServletRequest req,
		int u_num, String u_black) {
		
		//dto를 num값으로 DB꺼내주기 
		UserDTO udto = userMapper.getUserByUnum(u_num);
		
		//a_level을 0으로 설정하기 
		udto.setA_level(Integer.toString(0));
		udto.setU_black(u_black);
		//설정한 a_level을 DB에 등록하기
		int res = userMapper.addBlackList(udto);

		if (res>0) { 
			req.setAttribute("msg", "블랙리스트 등록 성공!!");
			req.setAttribute("url", "admin_user_list");
		}else {
			req.setAttribute("msg", "블랙리스트 등록 성공!!");
			req.setAttribute("url", "admin_user_list");
		} 
		return "message";
	}


	@RequestMapping("/saveBlackContent")
	public String saveBlackContent(HttpServletRequest req,
			int u_num, String u_black) {
		
		//u_num으로 dto 가져오기 
		UserDTO dto = userMapper.getUserByUnum(u_num); 
		//blacklist에 등록된 이유 dto에 저장하기 
		dto.setU_black(u_black); 

		int res = userMapper.saveBlackContent(dto);

		if (res>0) { 
			req.setAttribute("msg", "블랙리스트 사유 저장!!");
			req.setAttribute("url", "admin_user_blacklist");
		}else {
			req.setAttribute("msg", "블랙리스트 사유 저장 실패!!");
			req.setAttribute("url", "admin_user_blacklist");
		} 
		return "message";
	}

	//블랙리스트 유저 일반유저로 전환
	@RequestMapping("/deleteBlackUser")
	public String deleteBlackUser(HttpServletRequest req,
			@RequestParam int u_num) { 
		//dto에서 a_level 0에서 1로 변경
		UserDTO dto = userMapper.getUserByUnum(u_num);
		dto.setA_level(Integer.toString(1));
		
		int res = userMapper.deleteBlackList(dto);
 
		if (res>0) {
			req.setAttribute("msg", "블랙리스트 해제 성공!!");
			req.setAttribute("url", "admin_user_blacklist");
		}else {
			req.setAttribute("msg", "블랙리스트 해제 실패!!");
			req.setAttribute("url", "admin_user_blacklist");
		} 
		return "message";
	}

	//blacklist 목록 보기 & 찾기
	@RequestMapping("/admin_user_blacklist")
	public ModelAndView adminUserBlackList (HttpServletRequest req, 
			@RequestParam(required = false) String mode){
		
		//userlist와 마찬가지로 mode값 받아서 진행 
		ModelAndView mav = new ModelAndView();
		if(loginOkBean.getA_level().equals("3")) {
			if (mode==null) {
				mode = "all";
			}
			
			List<UserDTO> buList = null;
			
			if (mode.equals("all")) {
				buList = userMapper.listBlackUser();
			}else {
				String search = req.getParameter("search");
				String searchString = req.getParameter("searchString");
				buList = userMapper.findUserOnBlack(search, searchString);
			}
			
			mav.addObject("buList", buList);
			mav.addObject("mode", mode);
			mav.setViewName("admin/admin_user_blacklist");
		}else {
			mav.addObject ("msg","admin만 입장 가능합니다");
			mav.addObject("url", "main");
			mav.setViewName("message");
		}
		return mav;
	}
	
	//company도 마찬가지
	@RequestMapping("/admin_company_list")
	public ModelAndView adminCompanyList (HttpServletRequest req, 
			@RequestParam(required = false) String mode) {

		ModelAndView mav = new ModelAndView();
		if(companyLoginOkBean.getA_level().equals("3")) {
			if (mode==null) {
				mode = "all";
			}
			List<CompanyDTO> cList = null;
			if (mode.equals("all")) {
				cList = companyMapper.listCompany();
			}else {
				String search = req.getParameter("search");
				String searchString = req.getParameter("searchString");
				cList = companyMapper.findCompany(search, searchString);
			}
			mav.addObject("cList", cList);
			mav.addObject("mode", mode);
			mav.setViewName("admin/admin_company_list");
		}else {
			mav.addObject ("msg","admin만 입장 가능합니다");
			mav.addObject("url", "company_main");
			mav.setViewName("message");
		}
		return mav;
	}
	
	//admin이 기업 삭제
	@RequestMapping("/deleteCompany")
	public ModelAndView deleteCompany(HttpServletRequest req, 
			@RequestParam int c_num) {
		ModelAndView mav = new ModelAndView();

		int res = companyMapper.deleteCompanyByAdmin(c_num);

		if (res>0) {
			mav.addObject("msg", "기업삭제성공!! 기업관리페이지로 이동합니다.");
			mav.addObject("url", "admin_company_list");
		}else {
			mav.addObject("msg", "기업삭제실패!! 기업관리페이지로 이동합니다.");
			mav.addObject("url", "admin_company_list");
		}
		mav.setViewName("message");
		return mav;
	}
	
	@RequestMapping("/admin_user_qna")
	public String adminUserQna() {
		return "board/admin_user_qna";
	}
	
	@RequestMapping("/admin_company_qna")
	public String adminCompanyQna() {
		return "board/admin_company_qna";
	}
	
	@RequestMapping("admin_partner_req_list")
	public String adminPartnerReqList(HttpServletRequest req) {
		List<CompanyDTO> reqList = companyMapper.listPartnerReqestCompany();
		
		req.setAttribute("reqList", reqList);
		
		return "admin/admin_partner_req_list";
	}
	
	@RequestMapping("admin_partner_req_detail")
	public String adminPartnerReqDetail(HttpServletRequest req, int c_num) {
		CompanyDTO cdto = companyMapper.getCompanyByCnum(c_num);
		req.setAttribute("cdto", cdto);
		
		return "admin/admin_partner_req_detail";
	}
	
	@RequestMapping("admin_partner_req_ok")
	public String adminPartnerReqOk(HttpServletRequest req, int c_num) {
		int res = companyMapper.acceptPartnership(c_num);
		
		if(res>0) {
			req.setAttribute("msg", "제휴요청 승인 완료. 제휴 현황 페이지로 이동합니다.");
			req.setAttribute("url", "admin_partner_req_list");
		}else {
			req.setAttribute("msg", "제휴요청 승인 실패. 다시 시도해주시기 바랍니다.");
			req.setAttribute("url", "admin_partner_req_detail?c_num="+c_num);
		}
		
		return "message";
	}
}
