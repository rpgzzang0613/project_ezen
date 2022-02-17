package com.ezen.project.service;

import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.project.model.BookingActDTO;
import com.ezen.project.model.BookingDTO;
import com.ezen.project.model.ReviewActDTO;
import com.ezen.project.model.ReviewDTO;
import com.ezen.project.model.WishListDTO;

@Service
public class UserMyPageMapper {
	
	@Autowired
	private SqlSession sqlSession;
	
	public  List<WishListDTO> listWishList(int u_num) {
		return sqlSession.selectList("listWishList", u_num);
	}

	public  List<WishListDTO> listWishListAct(int u_num) {
		return sqlSession.selectList("listWishListAct", u_num);
	}
	
	public List<BookingDTO> listBookingByUser(int start, int end, int u_num){
		Map<String, Integer> map = new Hashtable<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("u_num", u_num);
		return sqlSession.selectList("listBookingByUser", map);
	}
	
	public List<ReviewDTO> listReviewByUser(int start, int end, int u_num){
		Map<String, Integer> map = new Hashtable<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("u_num", u_num);
		return sqlSession.selectList("listReviewByUser", map);
	}
	
	public List<ReviewDTO> listPoint(int start, int end, int u_num){
		Map<String, Integer> map = new Hashtable<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("u_num", u_num);
		return sqlSession.selectList("listPoint", map);
	}
	
	public int getBookingCount(int u_num){
		return sqlSession.selectOne("getBookingCount", u_num);
	}
	
	public int getReviewCount(int u_num){
		return sqlSession.selectOne("getReviewCount", u_num);
	}
	
	public int getPointCount(int u_num){
		return sqlSession.selectOne("getPointCount", u_num);
	}

	public int insertReview(MultipartHttpServletRequest mr, String review_image) {
		Map<String, String> map = new Hashtable<String, String>();
		
		map.put("h_num", mr.getParameter("h_num"));
		map.put("u_num", mr.getParameter("u_num"));
		map.put("review_contents", mr.getParameter("review_contents"));
		map.put("review_image", review_image);
		map.put("review_star", mr.getParameter("star"));
		map.put("review_nickname", mr.getParameter("review_nickname"));
		map.put("review_roomtype", mr.getParameter("room_type"));
		sqlSession.update("checkReview", mr.getParameter("book_num"));
		return sqlSession.insert("insertReview", map);
	}
	
	public int editReview(MultipartHttpServletRequest mr, String review_image) throws Exception{
		Map<String, String> map = new Hashtable<String, String>();
		
		map.put("review_num", mr.getParameter("review_num"));
		map.put("review_contents", mr.getParameter("review_contents"));
		map.put("review_star", mr.getParameter("star"));
		map.put("review_image", review_image);
	    
		return sqlSession.update("editReview", map);
	}
	
	public int deleteReview(int review_num) {
		return sqlSession.delete("deleteReview", review_num);
	}
	
	public ReviewDTO getReview(int review_num) {
		return sqlSession.selectOne("getReview", review_num);
	}
	
	public String getReview_image(int review_num) {
		return sqlSession.selectOne("getReview_image", review_num);
	}
	
	public String getReview_imageAct(int review_num) {
		return sqlSession.selectOne("getReview_imageAct", review_num);
	}
	
	public int changeNickName(int u_num, String nickname) {
		Map<String, String> map = new Hashtable <String, String>();
		map.put("u_num", String.valueOf(u_num));
		map.put("nickname", nickname);
		return sqlSession.update("changeNickName", map);
	}

	public int changeUserTel(int u_num, String u_tel) {
		Map<String, String> map = new Hashtable <String, String>();
		map.put("u_num", String.valueOf(u_num));
		map.put("u_tel", u_tel);
		return sqlSession.update("changeUserTel", map);
	}

	public int countBookingAct(int u_num) {
		return sqlSession.selectOne("countBookingAct", u_num);
	}

	public List<BookingActDTO> listBookingActByUser(int startRow, int endRow, int u_num) {
		Map<String, Integer> map = new Hashtable<String, Integer>();
		map.put("start", startRow);
		map.put("end", endRow);
		map.put("u_num", u_num);
		return sqlSession.selectList("listBookingActByUser", map);
	}

	public String getProgramType(int p_num) {
		return sqlSession.selectOne("getProgramType", p_num);
	}
	
	public int insertActReview(MultipartHttpServletRequest mr, String review_image) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("a_num", mr.getParameter("a_num"));
		map.put("u_num", mr.getParameter("u_num"));
		map.put("review_contents", mr.getParameter("review_contents"));
		map.put("review_image", review_image);
		map.put("review_star", mr.getParameter("star"));
		map.put("review_nickname", mr.getParameter("review_nickname"));
		map.put("review_programtype", mr.getParameter("program_type"));
		sqlSession.update("checkActReview", mr.getParameter("ba_num"));
		return sqlSession.insert("insertActReview", map);
	}

	public int getReviewActCount(int u_num) {
		return sqlSession.selectOne("getReviewActCount", u_num);
	}

	public List<ReviewDTO> listReviewActByUser(int start, int end, int u_num){
		Map<String, Integer> map = new Hashtable<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		map.put("u_num", u_num);
		return sqlSession.selectList("listReviewActByUser", map);
	}

	public int deleteActReview(int review_num) {
		return sqlSession.delete("deleteActReview", review_num);
	}

	public ReviewActDTO getActReview(int review_num) {
		return sqlSession.selectOne("getActReview", review_num);
	}

	public int editActReview(MultipartHttpServletRequest mr, String review_image) throws Exception{
		Map<String, String> map = new Hashtable<String, String>();
		
		map.put("review_num", mr.getParameter("review_num"));
		map.put("review_contents", mr.getParameter("review_contents"));
		map.put("review_star", mr.getParameter("star"));
		map.put("review_image", review_image);
	    
		return sqlSession.update("editActReview", map);
	}

	public List<ReviewDTO> listReview(int u_num, int h_num) {
		Hashtable<String, Integer> map = new Hashtable<String, Integer>();
		map.put("u_num", u_num);
		map.put("h_num", h_num);
		return sqlSession.selectList("listReview", map);
	}
}