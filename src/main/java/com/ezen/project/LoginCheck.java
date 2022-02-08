package com.ezen.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;

import com.ezen.project.model.CompanyDTO;
import com.ezen.project.model.UserDTO;
import com.ezen.project.service.CompanyMapper;
import com.ezen.project.service.UserMapper;

@Controller
public class LoginCheck {
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CompanyMapper companyMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;
	
	public static final int OK = 0;
	public static final int NOT_email = 1;
	public static final int NOT_password = 2;
	public static final int ERROR = -1;

	private String u_email;
	private String u_password;
	
	private String c_email;
	private String c_password;

	public String getU_email() {
		return u_email;
	}
	public void setU_email(String u_email) {
		this.u_email = u_email;
	}

	public String getU_password() {
		return u_password;
	}
	public void setU_password(String u_password) {
		this.u_password = u_password;
	}
	
	public String getC_email() {
		return c_email;
	}
	public void setC_email(String c_email) {
		this.c_email = c_email;
	}

	public String getC_password() {
		return c_password;
	}
	public void setC_password(String c_password) {
		this.c_password = c_password;
	}

	//로그인 성공여부 
	public int checkULogin() {
		
		try {
			UserDTO dto = userMapper.getUserByEmail(u_email);
			if(dto == null) {
				return NOT_email;
			}else {
				if (pwdEncoder.matches(u_password, dto.getU_password())) {
					return OK;
				}else {
					return NOT_password;
				}
			} 
		}catch(EmptyResultDataAccessException e) {
			return ERROR;
		} 

	}
	
	public int checkCLogin() {
	      try {
	         CompanyDTO dto = companyMapper.getCompanyByEmail(c_email);
	         if(dto == null) {
	            return NOT_email;
	         }else {
	         if (pwdEncoder.matches(c_password, dto.getC_password())) {
	            return OK;
	         }else {
	            return NOT_password;
	         }
	         } 
	      }catch(EmptyResultDataAccessException e) {
	         return ERROR;
	      } 
	}
}
