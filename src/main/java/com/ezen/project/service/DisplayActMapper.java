package com.ezen.project.service;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.project.model.ActivityDTO;
import com.ezen.project.model.BookingActDTO;
import com.ezen.project.model.ProgramDTO;
import com.ezen.project.model.ReviewActDTO;
import com.ezen.project.model.WishListActDTO;

@Service
public class DisplayActMapper {
	
	@Autowired
	private SqlSession sqlSession;

	public int countSport() {
		return sqlSession.selectOne("sport");
	}
	public int countStudy() {
		return sqlSession.selectOne("study");
	}
	public int countEnt() {
		return sqlSession.selectOne("ent");
	}
	public int countMusic() {
		return sqlSession.selectOne("music");
	}
	public int countCulture() {
		return sqlSession.selectOne("culture");
	}
	public int countCooking() {
		return sqlSession.selectOne("cooking");
	}

	public List<ActivityDTO> activitySearchOk(String search){
		Map<String, String> map = new Hashtable<String, String>();
		map.put("search",search);
		return sqlSession.selectList("searchActivity", map);
	}

	public List<ActivityDTO> activitySearchOkfilter(String search, String code) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("search", search);
		map.put("a_code", code);
		return sqlSession.selectList("searchFilterActivity", map);
	}

	public List<ActivityDTO> activitySearchOkfilterall(String code) {
		Map<String, String> map = new Hashtable<String, String>();
		map.put("a_code", code);
		return sqlSession.selectList("searchFilterAllActivity", map);
	}

	public ActivityDTO activityContent(String a_num) {
		return sqlSession.selectOne("activityContent", a_num);
	}
	
//	해당엑티비티의 고유번호를 위시리스트에 저장
	public void wishCheck(Map<String, String> params) {
		sqlSession.insert("wishCheckAct", params);
	}
	
	public List<ActivityDTO> getActivity(Map<String,String> params){
		String str = "select count(*) from project_activity where a_name like'%"+
						params.get("location")+"%' or a_address like '%"+params.get("location")+
						"%' or a_code like '%"+params.get("location")+"%'";
		Map<String,String> map = new Hashtable<String, String>();
		map.put("sql", str);
		return sqlSession.selectList("getActivityList", map);
	}
	
	public List<WishListActDTO> getWishListAct(Map<String,String> params){
		return sqlSession.selectList("getWishListAct", params);
	}
	
	public void wishDelete(Map<String,String> params) {
		sqlSession.delete("wishDelete", params);
	}
	
//	자동완성
	public List<String> allActOptions() {
		List<String> totalList = new ArrayList<String>();
		List<String> allOptions = sqlSession.selectList("getActNames");
		List<String> actAddresses = sqlSession.selectList("getActAddresses");
		for(int i=0; i<allOptions.size(); i++) {
			String allOption = allOptions.get(i);
			String[] address = actAddresses.get(i).split("@");
			totalList.add(allOption + ", "+ address[0]);
		}
		return totalList;
	}
	
	public int insertBookAct(BookingActDTO badto) {
		return sqlSession.insert("insertBookAct", badto);
	}
	
	public int getMaxBooker(int p_num) {
		return sqlSession.selectOne("getMaxBooker", p_num);
	}
	
	public List<Integer> listCurrentBooker(int p_num, String book_date) {
		Map<String, String> map = new Hashtable<>();
		map.put("p_num", String.valueOf(p_num));
		map.put("ba_bookdate", book_date);
		
		return sqlSession.selectList("listCurrentBooker", map);
	}

	public BookingActDTO getBookAct(int ba_num) {
		return sqlSession.selectOne("getBookAct", ba_num);
	}
	
	public int deleteActBook(int ba_num) {
		return sqlSession.update("deleteActBook", ba_num);
	}

	public List<ActivityDTO> activityDoubleSearchOk(String aname, String addr) {
		Map<String, String> map = new Hashtable<>();
		map.put("addr", "%"+addr+"%");
		map.put("aname", "%"+aname+"%");
		return sqlSession.selectList("activityDoubleSearchOk", map);
	}
	
	public Map<Integer, Integer> countReview(List<ActivityDTO> activityList) {
		List<Integer> a_num = new ArrayList<Integer>();
		for(int i=0; i < activityList.size(); i++) {
			ActivityDTO adto = activityList.get(i);
			a_num.add(adto.getA_num());
		}
		
		List<ReviewActDTO> allReview = sqlSession.selectList("allActReview");
		Map<Integer, Integer> map = new Hashtable<Integer, Integer>();
		
		int count = 0;
		for(int j=0; j<a_num.size(); j++) {
			//등록된 모든 호텔
			int activityNum = a_num.get(j);
			//등록된 모든 후기
			for(int i=0; i<allReview.size(); i++) {
				ReviewActDTO radto = allReview.get(i);
				if(activityNum == radto.getA_num()) {
					count++;
				}
			}
			map.put(activityNum, count);
			count = 0;
		}
		return map;
	}
	
	public Map<Integer, Double> averageReview(List<ActivityDTO> activityList){
		List<Integer> a_num = new ArrayList<Integer>();
		for(int i=0; i < activityList.size(); i++) {
			ActivityDTO adto = activityList.get(i);
			a_num.add(adto.getA_num());
		}
		
		List<ReviewActDTO> allReview = sqlSession.selectList("allActReview");
		Map<Integer, Double> map = new Hashtable<Integer, Double>();
		
		int count = 0;
		int totalStar = 0;
		for(int j=0; j<a_num.size(); j++) {
			//등록된 모든 호텔
			int activityNum = a_num.get(j);
			//등록된 모든 후기
			for(int i=0; i<allReview.size(); i++) {
				ReviewActDTO radto = allReview.get(i);
				if(activityNum == radto.getA_num()) {
					count++;
					totalStar += radto.getReview_star();
				}
			}
			double average = (double)totalStar / count;
			average = Math.round(average*10)/10.0;//소수 1번째 자리까지 표기
			map.put(activityNum, average);
			count = 0;
			totalStar = 0;
		}
		return map;
		
	}
	
//	액티비티별 후기 갯수 반환
	public int getReviewCountByAct(int a_num) {
		return sqlSession.selectOne("getReviewCountByAct", a_num);
	}
	
//	액티비티별 별점 반환
	public double reviewActStar(int a_num) {
		List<Integer> star = new ArrayList<Integer>();
		star = sqlSession.selectList("reviewActStar", a_num);
		int totalStar = 0;
		for(int i = 0; i < star.size(); i++) {
			totalStar += star.get(i);
		}
		double averageStar = (double)totalStar/star.size();
		return averageStar;
	}
	
	public List<ReviewActDTO> listReviewByAct(int a_num) {
		List<ReviewActDTO> reviewList = sqlSession.selectList("listReviewByAct", a_num);
		return reviewList;
	}
}
