package com.ezen.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.ezen.project.model.UserDTO;
import com.ezen.project.service.UserMapper;

@Controller
public class LoginOkBeanUser {
	
	@Autowired
	UserMapper userMapper;
	
	private int u_num;
	private String u_name;
	private String u_password;
	private String u_email;
	private String u_birth;
	private String u_tel;
	private String a_level;
	private String u_nickname;
	private int u_point;
	private String u_black;
	private String u_joindate;
	
	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}

	public int getU_num() {
		return u_num;
	}

	public String getU_name() {
		return u_name;
	}

	public String getU_password() {
		return u_password;
	}

	public String getU_birth() {
		return u_birth;
	}

	public String getU_tel() {
		return u_tel;
	}
	public void setU_tel(String u_tel) {
		this.u_tel = u_tel;
	}

	public String getA_level() {
		return a_level;
	}

	public String getU_nickname() {
		return u_nickname;
	}
	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}

	public int getU_point() {
		return u_point;
	}

	public String getU_black() {
		return u_black;
	}

	public String getU_joindate() {
		return u_joindate;
	}

	//로그인에 따른 user 정보 
	public boolean isUserSetting() {
		UserDTO dto = userMapper.getUserByEmail(u_email);
		if (dto != null) {
			u_num = dto.getU_num();
			u_name = dto.getU_name();
			u_password = dto.getU_password();
			u_email = dto.getU_email();
			u_birth = dto.getU_birth();
			u_tel = dto.getU_tel();
			a_level = dto.getA_level();
			u_nickname = dto.getU_nickname();
			u_point = dto.getU_point();
			u_black = dto.getU_black();
			u_joindate = dto.getU_joindate();
			
			return true;
		}
		return false;
		
	}
}
