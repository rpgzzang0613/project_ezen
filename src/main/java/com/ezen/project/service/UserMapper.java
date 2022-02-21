package com.ezen.project.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.project.model.UserDTO;

@Service
public class UserMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	//유저등록
	public int insertUser(UserDTO udto) {
		return sqlSession.insert("insertUser", udto);
	}
	
	//email 받았으면 비밀번호 찾기 안받았으면 email찾기 이므로 if문으로 구분지어서 xml로 보내준다. 
	public String searchUserInfo(String u_name, String u_tel, String u_email) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("u_name", u_name);
		map.put("u_tel", u_tel);
		
		if(map.get("u_email") == null) {
			return sqlSession.selectOne("searchUser_email", map);
		}else {
			return sqlSession.selectOne("searchUser_password", map);
		} 
	}
	
	//email값으로 user의 DTO DB에서 꺼내오기 
	public UserDTO getUserByEmail(String u_email) {
		return sqlSession.selectOne("getUserByEmail", u_email);
	}
	
	//u_num값으로 user의 DTO DB에서 꺼내오기
	public UserDTO getUserByUnum(int u_num) {
		return sqlSession.selectOne("getUserByUnum", u_num);
	}
	
	//user 비밀번호 변경
	public int updateUserPassword(UserDTO udto) {
		return sqlSession.update("updateUserPassword", udto); 
	}
	
	//유저 블랙리스트 등록 .   AdminController
	public int addBlackList(UserDTO dto) {
		return sqlSession.update("addBlackList", dto);
	}
	
	public int deleteBlackList(UserDTO dto) {
		return sqlSession.update("deleteBlackList", dto);
	}
	
	//블랙리스트 사유 저장. AdminController
	public int saveBlackContent(UserDTO dto) {
		return sqlSession.update("saveBlackContent", dto);
	}
	
	//유저 리스트 뽑기  AdminController
	public List<UserDTO> listUser(){
		return sqlSession.selectList("listUser");
	}
	
	//블랙리스트 뽑기  AdminController
	public List<UserDTO> listBlackUser(){
		return sqlSession.selectList("listBlackUser");
	} 
	 
	//list에서 유저 검색  AdminController
	public List<UserDTO> findUser(String search, String searchString){
		//찾는 멤버중에서 a_level 이 0 or 1인사람들만 검색
		String sql = "select * from project_useraccount where " + search + " like '%" + searchString + "%' and a_level between '0' and '1' "; 
		Map<String, String> map = new Hashtable<String, String>();  
		map.put("sql", sql); 
		return sqlSession.selectList("findUser", map);
	} 
	
	//블랙리스트에서 유저 검색  AdminController
	public List<UserDTO> findUserOnBlack(String search, String searchString){
		//a_level이 0인사람만 검색
		String sql = "select * from project_useraccount where " + search + " like '%" + searchString + "%' and a_level = '0'";
		Map<String, String> map = new Hashtable<String, String>(); 
		map.put("sql", sql);
		return sqlSession.selectList("findUserOnBlack", map);
	}
	
	public String getUserPassword(int u_num) {
		return sqlSession.selectOne("getUserPassword", u_num);
	}
	
	//회원탈퇴 
	public int deleteUser(int u_num, String u_password) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("u_num", String.valueOf(u_num));
		map.put("u_password", u_password);
		return sqlSession.update("deleteUser", map);
	}	
	
	//관리자가 유저 계정 삭제
	public int deleteUserByAdmin(int u_num) {
		return sqlSession.update("deleteUserByAdmin", u_num);
	}
	
}
