package com.ezen.project;

import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.project.model.CompanyDTO;
import com.ezen.project.service.CompanyMapper;

@Controller
public class CompanyController {
	 
	@Autowired
	private CompanyMapper companyMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	//파일경로
	@Resource(name = "uploadPath")
	private String upPath;
	
	@RequestMapping("/company_ssn")
	public String companySsn() {
		return "/company/company_ssn";
	}
	@RequestMapping("/company_check")
	public String companyCheck(String c_name, String c_bnum, HttpServletRequest req) {
		boolean isDupl = companyMapper.hasCompanyAccount(c_name, c_bnum);
		
		if (isDupl) {
			req.setAttribute("msg", "이미 가입된 이메일입니다. 로그인을 해 주세요!!");
			req.setAttribute("url", "company_login");
		}else {
			HttpSession session = req.getSession();
			session.setAttribute("c_name", c_name);
			session.setAttribute("c_bnum", c_bnum);
			req.setAttribute("msg", "회원가입페이지로 이동합니다.");
			req.setAttribute("url", "company_register");
		}
		return "message";
	}
	
	@RequestMapping("/company_register")
	public String companyRegister() {
		return "company/company_register";
	}
	
	//company_register에서 보냄
	@RequestMapping("/company_register_ok")
	public String companyRegisterOk (HttpServletRequest req, CompanyDTO cdto, BindingResult result) 
			throws IOException { 
		//Multipart로 image가져옴 
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile mf = mr.getFile("c_image");
		
		String c_image = mf.getOriginalFilename(); 
		
		if(c_image == null || c_image.trim().equals("")) {
			c_image = "default.jpg";
		}else{ 
			c_image = UUID.randomUUID().toString()+"_"+c_image;
		} 
	       
		//이미지 없으면 default사진 사용
		if(!c_image.equals("default.jpg")) {
			File file = new File(upPath+"\\company", c_image);
			mf.transferTo(file);
		}
	      
		//주소 저장시 @ 가지고 저장 
		//수정페이지에서는 @를 떼고 보여준다. 
		String addr1 = mr.getParameter("addr1");
		String addr2 = mr.getParameter("addr2");
		String addr3 = mr.getParameter("addr3");
		String addr4 = mr.getParameter("addr4");
		String addr = addr1 +"@"+ addr2 +"@"+ addr3 + "@" + addr4;
		
		String c_password = pwdEncoder.encode(cdto.getC_password());
		
		// DTO에 암호화한 비밀번호를 담음
		cdto.setC_password(c_password);
		cdto.setC_image(c_image);
		cdto.setC_address(addr);
		
		int res = companyMapper.insertCompany(cdto); 
	          
		if (res>0) {  
			req.setAttribute("msg", "회원가입성공!! 메인페이지로 이동합니다.");
			req.setAttribute("url", "company_main");
		}else{
			req.setAttribute("msg", "회원가입실패!! 다시 입력해 주세요!!");
			req.setAttribute("url",  "company_register");
		} 
		return "message";
	}
		
	//company_mypage에서 기업탈퇴 
	@RequestMapping("/company_delete")
	public String deletePage() {
		return "/company/company_delete";
	}
	
	//회원탈퇴 company_delete.jsp페이지에서 이동
	@RequestMapping("/company_delete_ok")
	public String deleteOkPage(HttpServletRequest req, int c_num, String raw_password) {
		String c_password = companyMapper.getCompanyByCnum(c_num).getC_password();
		String c_image = companyMapper.getCompanyByCnum(c_num).getC_image();
		
		if(pwdEncoder.matches(raw_password, c_password)) {
			int res = companyMapper.deleteCompany(c_num, c_password);
			
			if(res>0){
				HttpSession session = req.getSession();
				session.invalidate();
				
				File file = new File(upPath+"\\company", c_image);
				
				if(file.exists() && !file.getName().equals("default.jpg")) {
					file.delete();
				}
				
				req.setAttribute("msg", "회원 탈퇴되었습니다.");
				req.setAttribute("url", "company_main");
			}else {
				req.setAttribute("msg", "회원 탈퇴 실패하였습니다.");
				req.setAttribute("url", "company_delete");
			}
		}else {
			req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
			req.setAttribute("url", "company_delete");
		}

		return "message";
	} 
	
	//company_mypage.jsp c_num값을 받아온다. 
	@RequestMapping("/company_edit")
	public String companyEdit(HttpServletRequest req, int c_num) {
		CompanyDTO dto = companyMapper.getCompanyByCnum(c_num);
		req.setAttribute("cdto", dto);
		
		return "company/company_edit";
	} 
	
		//company_edit.jsp에서 받아옴  
	@RequestMapping("/company_edit_ok")
	public String editCompanyOkForm(HttpServletRequest req, String pre_image) throws IOException { 
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile mf = mr.getFile("c_image");
		String c_image = mf.getOriginalFilename(); 
		
		HttpSession session = req.getSession();
		LoginOkBeanCompany cpLoginOkBean = (LoginOkBeanCompany)session.getAttribute("companyLoginOkBean");
		
		int c_num = cpLoginOkBean.getC_num();
		//세션의 c_num 값으로 로그인 중인 회사 정보 꺼냄
		CompanyDTO cdto = companyMapper.getCompanyByCnum(c_num);
	      
		if(c_image == null || c_image.trim().equals("")) {
			c_image = pre_image; 
		}else {
			// 새 파일 업로드
			c_image = UUID.randomUUID().toString()+"_"+c_image;
			File newFile = new File(upPath+"\\company", c_image);
			mf.transferTo(newFile);
			
			// 기존 파일 삭제 (default.jpg 예외)
			File preFile = new File(upPath+"\\company", pre_image);
			if(preFile.exists() && !preFile.getName().equals("default.jpg")) {
				preFile.delete();
			}
		}

		String addr1 = req.getParameter("addr1");
		String addr2 = req.getParameter("addr2");
		String addr3 = req.getParameter("addr3");
		String addr4 = req.getParameter("addr4");
		String addr = addr1 +"@"+ addr2 +"@"+ addr3 + "@" + addr4;
  
		cdto.setC_address(addr);
		cdto.setC_name(req.getParameter("c_name"));
		cdto.setC_tel(req.getParameter("c_tel"));
		cdto.setC_image(c_image);
	      
		int res = companyMapper.updateCompany(cdto);
	      
		if (res>0) {
			req.setAttribute("msg", "회원수정성공!!");
			req.setAttribute("url", "company_edit");
		}else{
			req.setAttribute("msg", "회원수정실패!! 다시 입력해 주세요.");
			req.setAttribute("url", "company_edit");
		} 
		return "message";
	}
	
	//mode따라서 email or password찾기 
	@RequestMapping("/company_search_ok")
	public String companySearchOk(HttpServletRequest req) {
		String mode = req.getParameter("mode");
		String c_email = req.getParameter("c_email");
		String c_name = req.getParameter("c_name");
		String c_bnum = req.getParameter("c_bnum");
		
		String msg = null, url = null;
		  
		msg = companyMapper.searchCompany(c_name, c_bnum, c_email);
		
		if (msg != null) {
			if(mode.equals("c_email")) {
				return "company_search_email_ok";
			}else if(mode.equals("c_password")) {
				req.setAttribute("c_email", c_email);
				return "company_update_password";
			}
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";
	}
	
	@RequestMapping("/company_password_edit")
	public String updateCompanyPassword() {
		return "/company/company_password_edit";
	}
	
	@RequestMapping("/company_search")
	public String companySearch() {
		return "company/company_search";
	}
	
	@RequestMapping("/company_search_email_ok")
	public String companySearchEmailOk(@RequestParam Map<String, String> params, 
			HttpServletRequest req) {
		String value = companyMapper.findEmail(params);
		if(value != null) {
			req.setAttribute("c_email", value);
			return "company/company_search_email_ok";
		}else {
			req.setAttribute("msg", "아이디를 찾을수 없습니다. 다시 확인해 주세요.");
			req.setAttribute("url", "company_search?mode=c_email");
			return "message";
		}
	}
	
//	비밀번호 변경 전 확인
	@RequestMapping("/company_passwordCheck")
	public String companyPasswordCheck(HttpServletRequest req) {
		return "company/company_passwordCheck";
	}
	
	//마이페이지에서 비밀번호 변경을 눌렀을 때 
	@RequestMapping("/company_password_edit_ok")
	public String companyPasswordEditOk(HttpServletRequest req, String c_email, 
			String raw_pre_password, String raw_new_password) {
		
		CompanyDTO dto = companyMapper.getCompanyByEmail(c_email);
		
		HttpSession session = req.getSession();
		LoginOkBeanCompany companyLoginOkBean = (LoginOkBeanCompany)session.getAttribute("companyLoginOkBean");
		
		// 현재 비밀번호
		String pre_password = companyLoginOkBean.getC_password();
		
		// 사용자가 입력한 현재 비밀번호와 실제 비밀번호를 비교
		if(pwdEncoder.matches(raw_pre_password, pre_password)) {
			// 현재 비밀번호를 맞게 입력했을 경우
			
			// DTO에 새 비밀번호 설정
			String new_password = pwdEncoder.encode(raw_new_password);
			dto.setC_password(new_password);
			
			// 비밀번호 업데이트
			int res = companyMapper.updateCompanyPassword(dto);
			
			if (res>0) {
				// 성공시 세션 만료
				session.invalidate();
				
				req.setAttribute("msg", "비밀번호 변경 성공!! 다시 로그인해주세요");
				req.setAttribute("url", "company_main");
			}else {
				req.setAttribute("msg", "비밀번호 변경 실패!! 다시 시도해주세요.");
				req.setAttribute("url", "company_passwordCheck");
			}
		}else {
			// 현재 비밀번호를 잘못 입력했을 경우
			req.setAttribute("msg", "현재 비밀번호를 잘못 입력하셨습니다. 다시 확인해주세요.");
			req.setAttribute("url", "company_passwordCheck");
		}
		
		return "message";
	}
	
	@RequestMapping("/company_update_password")
	public String companyUpdatePassword(HttpServletRequest req, String c_email,String c_name, String c_bnum) {
		int res = companyMapper.countCompanyforPassword(c_email, c_name, c_bnum);
		if(res==0) {
			req.setAttribute("msg", "정보를 다시 확인해주세요");
			req.setAttribute("url", "company_search?mode=c_password");
			return "message";
		}else {
			req.setAttribute("c_email",c_email);			
			return "company/company_update_password";
		}
	}
	
	//company정보 c_email로 구해온다음에 페스워드 변경 
	@RequestMapping("/company_update_password_ok")
	public String companyUpdatePasswordOk(HttpServletRequest req, @RequestParam String c_email) {
		CompanyDTO cdto = companyMapper.getCompanyByEmail(c_email);
		
		String new_password = pwdEncoder.encode(req.getParameter("raw_password"));
		cdto.setC_password(new_password);
		
		int res = companyMapper.updateCompanyPassword(cdto);
		HttpSession session = req.getSession();
		
		if (res>0) {
			session.invalidate();
			req.setAttribute("msg", "비밀번호 변경 성공!! 다시 로그인해주세요.");
			req.setAttribute("url", "company_login");
		}else {
			req.setAttribute("msg", "비밀번호 변경 실패!! 다시 시도해주세요.");
			req.setAttribute("url", "company_login");
		} 
		return "message";
	}
	
	@RequestMapping("/company_qna_writeform")
	public String companyQnaWriteform() {
		return "board/company_qna_writeform";
	}
	
	@RequestMapping("/company_myPage")
	public String companymyPage(HttpServletRequest req) {
		HttpSession session = req.getSession();
		LoginOkBeanCompany companyLoginOkBean = (LoginOkBeanCompany)session.getAttribute("companyLoginOkBean");
		int c_num = companyLoginOkBean.getC_num();
		req.setAttribute("c_num", c_num);
		return "company/company_myPage";
	}
	
	@RequestMapping("/company_partner_req")
	public String companyPartnerReq() {
		return "company/company_partner_req";
	}
	
	@RequestMapping("/company_partner_req_ok")
	public String companyPartnerReqOk(HttpServletRequest req, CompanyDTO cdto, BindingResult result) 
			throws IllegalStateException, IOException {
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		MultipartFile mf = mr.getFile("c_licenseimage");
		
		String c_licenseimage = mf.getOriginalFilename();
		c_licenseimage = UUID.randomUUID().toString()+"_"+c_licenseimage;

		cdto.setC_licenseimage(c_licenseimage);

		int res = companyMapper.requestPartnership(cdto);

		if(res>0) {
			File file = new File(upPath+"\\company\\license", c_licenseimage);
			mf.transferTo(file);
			
			HttpSession session = req.getSession();
			LoginOkBeanCompany loginOkBeanCompany = (LoginOkBeanCompany)session.getAttribute("companyLoginOkBean");
			loginOkBeanCompany.setA_level("1");
			
			req.setAttribute("msg", "제휴 신청 성공!! 마이페이지로 이동합니다.");
			req.setAttribute("url", "company_myPage");
		}else {
			req.setAttribute("msg", "제휴 신청 실패!! 다시 입력해 주세요.");
			req.setAttribute("url", "company_partner_req");
		}

		return "message";
	}
	
	@RequestMapping("/company_partner_req_wait")
	public String companyPartnerReqWait() {
		return "company/company_partner_req_wait";
	}
	
	@RequestMapping("/company_bank_edit")
	public String companyBankEdit(HttpServletRequest req, int c_num) {
		CompanyDTO cdto = companyMapper.getCompanyByCnum(c_num);
		req.setAttribute("cdto", cdto);
		return "company/company_bank_edit";
	}
	
	@RequestMapping("company_bank_edit_ok")
	public String companyBankEditOk(HttpServletRequest req, CompanyDTO cdto, BindingResult result) {
		int res = companyMapper.editCompanyBankInfo(cdto);
		
		if(res>0) {
			req.setAttribute("msg", "계좌 변경 성공!! 마이페이지로 이동합니다.");
			req.setAttribute("url", "company_myPage");
		}else {
			req.setAttribute("msg", "계좌 변경 실패!! 다시 시도해 주세요.");
			req.setAttribute("url", "company_bank_edit?c_num="+cdto.getC_num());
		}
		
		return "message";
	}
}
