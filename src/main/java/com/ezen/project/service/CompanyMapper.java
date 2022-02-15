package com.ezen.project.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.project.model.CompanyDTO;


@Service
public class CompanyMapper {
	 
	@Autowired 
	private SqlSession sqlSession;
	
	public int insertCompany(CompanyDTO cdto) {
		return sqlSession.insert("insertCompany", cdto);
	}
	
	//company 수정
	public int updateCompany(CompanyDTO cdto) {
		return sqlSession.update("updateCompany", cdto); 
	}
	
	//아이디, 비밀번호 찾기 
	public String searchCompany(String c_name, String c_bnum, String c_email) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("c_name", c_name);
		map.put("c_bnum", c_bnum);
		map.put("c_email", c_email);
		
	//c_email을 받으면 비밀번호 찾기 이므로 password로 보낸다
		if(map.get("c_email") != null) {
			return sqlSession.selectOne("searchCompany_password", map);
		}else {
			return sqlSession.selectOne("searchCompany_email", map);
		}
	}
	
	//email로 company 정보 DB에서 가져오기
	public CompanyDTO getCompanyByEmail(String c_email) {
		return sqlSession.selectOne("getCompanyByEmail", c_email);
	}
	
	//c_num으로 company 정보 DB에서 가져오기
	public CompanyDTO getCompanyByCnum(int c_num) { 
		return sqlSession.selectOne("getCompanyByCnum", c_num);
	}
	
	//컴퍼니 비밀번호 변경
	public int updateCompanyPassword(CompanyDTO dto) {
		return sqlSession.update("updateCompanyPassword", dto); 
	}
	
	//admin이 company list볼때 사용
	public List<CompanyDTO> listCompany(){
		return sqlSession.selectList("listCompany");
	}
	
	//admin이 list검색할 때 사용 a_level가 2 (기업) 인 것들만 검색
	public List<CompanyDTO> findCompany(String search, String searchString){
		String sql = "select * from project_companyaccount where " + search + 
				" like '%" + searchString + "%' and a_level='2'";
		Map<String, String> map = new Hashtable<String, String>(); 
		map.put("sql", sql);
		return sqlSession.selectList("findCompany", map);
	}
	
	//기업이 회원탈퇴할때 사용 
	public int deleteCompany(int c_num, String c_password) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("c_num", String.valueOf(c_num));
		map.put("c_password", c_password);
		return sqlSession.update("deleteCompany", map);
	}
	
	//admin이 기업 삭제
	public int deleteCompanyByAdmin(int c_num) {
		return sqlSession.update("deleteCompanyByAdmin", c_num);
	}
	
	//찾은 email값 보내주기 
	public String findEmail(Map<String, String> params) {
		return  sqlSession.selectOne("findEmail", params);
	}

	public boolean hasCompanyAccount(String c_email, String c_bnum) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("c_email", c_email);
		map.put("c_bnum", c_bnum);
		
		CompanyDTO cdto = sqlSession.selectOne("hasCompanyAccount", map);
		
		if(cdto != null) {
			return true;
		}else {
			return false;
		}
	}
	
	public int countCompanyforPassword(String c_email, String c_name, String c_bnum) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("c_name", c_name);
		map.put("c_bnum", c_bnum);
		map.put("c_email", c_email);
		return sqlSession.selectOne("countCompanyforPassword", map);
	}
	
	public int requestPartnership(CompanyDTO cdto) {
		return sqlSession.update("requestPartnership", cdto);
	}

	public List<CompanyDTO> listPartnerReqestCompany() {
		return sqlSession.selectList("listPartnerReqestCompany");
	}
	
	public int acceptPartnership(int c_num) {
		return sqlSession.update("acceptPartnership", c_num);
	}
	
	public int editCompanyBankInfo(CompanyDTO cdto) {
		return sqlSession.update("editCompanyBankInfo", cdto);
	}
} 