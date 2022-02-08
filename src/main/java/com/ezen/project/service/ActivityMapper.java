package com.ezen.project.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.project.model.ActivityDTO;
import com.ezen.project.model.BookingActDTO;
import com.ezen.project.model.ProgramDTO;

@Service
public class ActivityMapper {
	@Autowired
	private SqlSession sqlSession;
	
	// 기업용 페이지에서 액티비티를 등록할 때 사용하는 메소드
	public int inputActivity(ActivityDTO adto) {
		return sqlSession.insert("inputActivity", adto);
	}
	
	// 기업용 페이지에서 액티비티를 삭제할 때 사용하는 메소드
	public int deleteActivity(int a_num) {
		return sqlSession.delete("deleteActivity", a_num);
	}
	
	// 기업용 페이지에서 액티비티를 수정할 때 사용하는 메소드
	public int editActivity(ActivityDTO adto) {
		return sqlSession.update("editActivity", adto);
	}
	
	// 기업이 등록한 액티비티 목록을 가져오는 메소드
	public List<ActivityDTO> listActivity(int c_num) {
		return sqlSession.selectList("listActivity", c_num);
	}
	
	// 액티비티 특정 정보를 가져오는 메소드
	public ActivityDTO getActivity(int a_num) {
		return sqlSession.selectOne("getActivity", a_num);
	}
	
	public int inputProgram(ProgramDTO pdto) {
		return sqlSession.insert("inputProgram", pdto);
	}
	
	public List<ProgramDTO> listProgram(int a_num){
		return sqlSession.selectList("listProgram", a_num);
	}
	
	public ProgramDTO getProgram(int p_num) {
		return sqlSession.selectOne("getProgram", p_num);
	}
	
	public int editProgram(ProgramDTO pdto) {
		return sqlSession.update("editProgram", pdto);
	}
	
	public int deleteProgram(int p_num) {
		return sqlSession.delete("deleteProgram", p_num);
	}
	
	public List<BookingActDTO> listBookingActByCompany(int a_num) {
		return sqlSession.selectList("listBookingActByCompany", a_num);
	}

	public int denyBookingAct(int ba_num) {
		return sqlSession.update("denyBookingAct", ba_num);
	}
	
	public int confirmBookingAct(int ba_num) {
		return sqlSession.update("confirmBookingAct", ba_num);
	}
	
	public int checkoutBookingAct(int ba_num) {
		return sqlSession.update("checkoutBookingAct", ba_num);
	}
}
