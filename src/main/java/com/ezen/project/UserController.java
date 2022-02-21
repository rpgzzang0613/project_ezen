package com.ezen.project;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ezen.project.model.UserDTO;
import com.ezen.project.service.UserMapper;
import com.ezen.project.service.UserMyPageMapper;

@Controller
public class UserController {

	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private UserMyPageMapper userMyPageMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	//마이페이지로 이동
	@RequestMapping("/user_myPage")
	public String userMyPage() {
		return "user/user_myPage";
	}
	
	//user_join_check.jsp에서 보냄 
	@RequestMapping("/user_join_ok")
	public String userJoinOk(HttpServletRequest req, UserDTO udto) {
		
		// 비밀번호 암호화
		String u_password = pwdEncoder.encode(udto.getU_password());
		
		// DTO에 암호화한 비밀번호를 담음
		udto.setU_password(u_password);
		int res = userMapper.insertUser(udto);
		if (res>0) {
			req.setAttribute("msg", "회원가입성공!! 메인페이지로 이동합니다.");
			req.setAttribute("url", "main");
		}else {
			req.setAttribute("msg", "회원가입실패!! 다시 입력해 주세요!!");
			req.setAttribute("url", "user_join");
		}
		return "message";
	}
	
	//회원 탈퇴페이지 user_mypage.jsp에서 보냄 
	@RequestMapping("/user_delete")
	public String userDelete() {
		return "/user/user_delete";
	}
	
	//user_delete.jsp에서 보냄 회원탈퇴 실행
	@RequestMapping("/user_delete_user")
	public String userDeleteUser(HttpServletRequest req, String raw_password) {
		HttpSession session = req.getSession();
		
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		int u_num = loginOkBean.getU_num();
		
		// 암호화된 현재 비밀번호를 가져옴
		String u_password = userMapper.getUserPassword(u_num);
		
		// 현재 비밀번호와 입력한 비밀번호가 일치하면 삭제
		if(pwdEncoder.matches(raw_password, u_password)) {
			int res = userMapper.deleteUser(u_num, u_password);
			
			if(res>0){
				session.invalidate();
				
				req.setAttribute("msg", "회원 탈퇴되었습니다.");
				req.setAttribute("url", "main");
			}else { 
				req.setAttribute("msg", "회원 탈퇴에 실패하였습니다. 다시 시도해주세요.");
				req.setAttribute("url", "user_delete");
			}
		}else {
			req.setAttribute("msg", "비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
			req.setAttribute("url", "user_delete");
		}
		
		return "message"; 
	}
	
	//user_join에서 보냄 email 중복검사 진행 
	@RequestMapping("/checkUseremail")
	public String checkUserEmail(@RequestParam String u_email, 
			String u_password, String u_password2, String u_name, String u_nickname, 
			String u_tel, String u_birth, HttpServletRequest req) {

		if(u_email.equals("")) {
			req.setAttribute("msg", "이메일을 입력해야 합니다.");
			req.setAttribute("url", "user_join");
			return "message";
		}
		UserDTO udto = userMapper.getUserByEmail(u_email);
		if (udto != null) {
			req.setAttribute("msg", "이미 가입된 계정입니다.");
			req.setAttribute("url", "user_join");
		}else {
			HttpSession session = req.getSession();
			session.setAttribute("u_email", u_email);
			session.setAttribute("u_password", u_password);
			session.setAttribute("u_password2", u_password2);
			session.setAttribute("u_name", u_name);
			session.setAttribute("u_nickname", u_nickname);
			session.setAttribute("u_tel", u_tel);
			session.setAttribute("u_birth", u_birth);

			req.setAttribute("msg", "사용 가능한 이메일 입니다.");
			req.setAttribute("url", "user_join_check");
		}
		return "message";
	} 
	
	//중복검사 후 회원가입 페이지로 이동
	@RequestMapping("/user_join_check")
	public String userJoinCheck(String u_email) {

		return "user/user_join_check";
	}
	
	//user_search에서 보냄  mode로 구별 한 뒤 email or password찾기
	@RequestMapping("/user_search_ok")
	public String userSearchOk(HttpServletRequest req) {
		String mode = req.getParameter("mode");
		String u_name = req.getParameter("u_name");
		String u_tel = req.getParameter("u_tel");
		String u_email = req.getParameter("u_email");
		String msg = null, url = null; 
		  
		msg = userMapper.searchUserInfo(u_name, u_tel, u_email);
		url = null;
		req.setAttribute("msg", msg);
		
		if (msg != null) {
			if(mode.equals("u_email")) {
				return "user/user_search_email_ok";
			}else if(mode.equals("u_password")) {
				req.setAttribute("u_email", u_email);
				return "user/user_update_password";
			}
		}
		
		if(u_email == null) {
			msg = "아이디를 찾을수 없습니다. 다시 확인해 주세요.";
			url = "user_search?mode=u_email";
		}else {
			msg = "해당하는 정보가 일치하지 않습니다. 다시 확인해주세요";
			url = "user_search?mode=u_password";
		} 
		req.setAttribute("msg", msg);
		req.setAttribute("url", url);
		return "message";

	}
	
	//유저 닉네임 변경
		@RequestMapping("/user_nickChange")
		public String changeNickName(HttpServletRequest req, @RequestParam String nickname) {
			HttpSession session = req.getSession();
			LoginOkBeanUser loginokbean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
			int u_num = loginokbean.getU_num();
			
			int res = userMyPageMapper.changeNickName(u_num, nickname);
			String msg = null , url = null;
			if(res > 0) {
				loginokbean.setU_nickname(nickname);
				session.setAttribute("loginOkBean", loginokbean);
				msg="닉네임이 수정되었습니다";
				url="user_info";
			} else {
				msg="닉네임 수정에 실패했습니다";
				url="user_info";
			}

			req.setAttribute("msg", msg);
			req.setAttribute("url", url);
			
			return "message";
		}

		//유저 전화번호 변경
		@RequestMapping("/user_telChange")
		public String userTelChange(HttpServletRequest req, @RequestParam String u_tel) {
			HttpSession session = req.getSession();
			LoginOkBeanUser loginokbean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
			int u_num = loginokbean.getU_num();
			
			int res = userMyPageMapper.changeUserTel(u_num, u_tel);
			String msg = null , url = null;
			if(res > 0) {
				loginokbean.setU_tel(u_tel);
				session.setAttribute("loginOkBean", loginokbean);
				msg="전화번호가 수정되었습니다";
				url="user_info";
			} else {
				msg="전화번호 수정에 실패했습니다";
				url="user_info";
			}
			req.setAttribute("msg", msg);
			req.setAttribute("url", url);
			
			return "message";
		}
	
//	비회원이 회원전용 페이지 들어가려고 할때 실행
	@RequestMapping("/user_needLogin")
	public String userNeedLogin(HttpServletRequest req) {
		req.setAttribute("msg", "로그인이 필요한 서비스 입니다");
		req.setAttribute("url", "user_login");
		return "message";
	}
	
//	비밀번호 변경 전 확인
	@RequestMapping("/user_passwordCheck")
	public String userPasswordCheck(HttpServletRequest req) {
		return "user/user_passwordCheck";
	}
	
	//마이페이지에서 비밀번호 변경을 눌렀을 때 
	@RequestMapping("/user_password_edit_ok")
	public String userPasswordEditOk(HttpServletRequest req, String u_email, 
			String raw_pre_password, String raw_new_password) {
		
		UserDTO udto = userMapper.getUserByEmail(u_email);
		
		HttpSession session = req.getSession();
		LoginOkBeanUser loginOkBean = (LoginOkBeanUser)session.getAttribute("loginOkBean");
		
		// 현재 비밀번호
		String pre_password = loginOkBean.getU_password();
		
		// 사용자가 입력한 현재 비밀번호와 실제 비밀번호를 비교
		if(pwdEncoder.matches(raw_pre_password, pre_password)) {
			// 현재 비밀번호를 맞게 입력했을 경우
			
			// DTO에 새 비밀번호 설정
			String new_password = pwdEncoder.encode(raw_new_password);
			udto.setU_password(new_password);
			
			// 비밀번호 업데이트
			int res = userMapper.updateUserPassword(udto);
			
			if (res>0) {
				// 성공시 세션 만료
				session.invalidate();
				
				req.setAttribute("msg", "비밀번호 변경 성공!! 다시 로그인해주세요");
				req.setAttribute("url", "main");
			}else {
				req.setAttribute("msg", "비밀번호 변경 실패!! 다시 시도해주세요.");
				req.setAttribute("url", "user_passwordCheck");
			}
		}else {
			// 현재 비밀번호를 잘못 입력했을 경우
			req.setAttribute("msg", "현재 비밀번호를 잘못 입력하셨습니다. 다시 확인해주세요.");
			req.setAttribute("url", "user_passwordCheck");
		}
		
		return "message";
	} 
	
	// 로그인 전에 비밀번호 찾기에서 비밀번호를 변경할 때
	@RequestMapping("/user_update_password")
	public String userUpdatePassword() {
		return "user/user_update_password";
	}
	
	@RequestMapping("/user_update_password_ok")
	public String userUpdatePasswordOk(HttpServletRequest req, @RequestParam String u_email) {
		UserDTO udto = userMapper.getUserByEmail(u_email);
		
		// 새 비밀번호 암호화
		String new_password = pwdEncoder.encode(req.getParameter("raw_password"));
		
		// DTO에 새 비밀번호 설정
		udto.setU_password(new_password);
		
		// 비밀번호 업데이트
		int res = userMapper.updateUserPassword(udto);
		HttpSession session = req.getSession();
		
		if (res>0) {
			session.invalidate();
			req.setAttribute("msg", "비밀번호 변경 성공!! 다시 로그인해주세요.");
			req.setAttribute("url", "user_login");
		}else {
			req.setAttribute("msg", "비밀번호 변경 실패!! 다시 시도해주세요.");
			req.setAttribute("url", "user_login");
		} 
		return "message";
	}

	//user_login에서 mode값이랑 같이 넘겨준다. 
	@RequestMapping("/user_search")
	public String userSearch() {
		return "user/user_search";
	}
 
	@RequestMapping("/user_search_email_ok")
	public String userSearchEmailOk() {
		return "user/user_search_email_ok";
	}

	@RequestMapping("/user_joinchoose")
	public String userJoinchoose() {
		return "user/user_joinchoose"; 
	}
	@RequestMapping("/user_join")
	public String userJoin() {
		return "user/user_join";
	}

	@RequestMapping("/user_info")
	public String userInfo() {
		return "user/user_info";
	}
	
	@RequestMapping("/nonUserInfoCheck")
	public String nonUserInfoCheck() {
		return "nonUser/enter_info";
	}
	
}
