package com.ezen.project;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.project.model.ActivityDTO;
import com.ezen.project.model.BookingActDTO;
import com.ezen.project.model.ProgramDTO;
import com.ezen.project.service.ActivityMapper;

@Controller
public class ActivityController {
	
	@Autowired
	ActivityMapper activityMapper;
	
	@Resource(name = "uploadPath")
	private String upPath;
	
	@RequestMapping("/activity_main")
	public String activityMain(HttpServletRequest req) {
		HttpSession session = req.getSession();
		LoginOkBeanCompany companyLoginOkBean = (LoginOkBeanCompany)session.getAttribute("companyLoginOkBean");
		session.setAttribute("c_num", companyLoginOkBean.getC_num());
		return "activity/activity_main";
	}
	
	@RequestMapping("/activity_input")
	public String activityInput() {
		return "activity/activity_input";
	}
	
	@RequestMapping("/activity_input_ok")
	public String activityInputOk(HttpServletRequest req, ActivityDTO adto, BindingResult result) 
			throws IllegalStateException, IOException {
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> mfList = mr.getFiles("a_images");
		
		// DTO에 파일이름을 한꺼번에 설정하기 위한 배열
		String[] images = new String[mfList.size()];
		
		// 업로드파일이 없는 경우와 있는 경우에 따라 파일 이름 설정
		for(int i=0; i<mfList.size(); ++i) {
			images[i] = mfList.get(i).getOriginalFilename();
			if(images[i] == null || images[i].trim().equals("")) {
				images[i] = "default.jpg";
			}else {
				images[i] = UUID.randomUUID().toString()+"_"+images[i];
			}
		}
		
		// 설정한 파일 이름을 한꺼번에 DTO에 넣음
		adto.setA_images(images);
		// 줄개행을 @로 치환
		adto.setA_info(adto.getA_info().replace("\r\n", "@"));
		adto.setA_notice(adto.getA_notice().replace("\r\n", "@"));
		
		int res = activityMapper.inputActivity(adto);
				
		// DB 등록이 성공하면
		if(res>0) {
			//파일 업로드
			for(int i=0; i<mfList.size(); ++i) {
				// 업로드할 파일명이 default.jpg면 업로드 안함
				if(!images[i].equals("default.jpg")) {
					File file = new File(upPath+"/activity", images[i]);
					mfList.get(i).transferTo(file);
				}
			}
			req.setAttribute("msg", "액티비티 등록 성공!!");
			req.setAttribute("url", "activity_list");
		}else {
			req.setAttribute("msg", "액티비티 등록 실패!! 다시 입력해 주세요.");
			req.setAttribute("url", "activity_list");
		}
		return "message";
	}
	
	@RequestMapping("/activity_list")
	public String activityList(HttpServletRequest req) {
		HttpSession session = req.getSession();
		int c_num = (Integer)session.getAttribute("c_num");
		
		List<ActivityDTO> activityList = activityMapper.listActivity(c_num);
		req.setAttribute("activityList", activityList);
		
		return "activity/activity_list";
	}
	
	@RequestMapping("/activity_edit")
	public String activityEdit(HttpServletRequest req, int a_num) {
		ActivityDTO adto = activityMapper.getActivity(a_num);
		
		// @를 줄개행으로 치환
		adto.setA_info(adto.getA_info().replace("@", "\r\n"));
		adto.setA_notice(adto.getA_notice().replace("@", "\r\n"));
		
		req.setAttribute("adto", adto);
		return "activity/activity_edit";
	}
	
	@RequestMapping("/activity_edit_ok")
	public String activityEditOk(HttpServletRequest req, ActivityDTO adto, BindingResult result, 
			String[] pre_images) throws IllegalStateException, IOException {
		
		MultipartHttpServletRequest mr = (MultipartHttpServletRequest)req;
		List<MultipartFile> mfList = mr.getFiles("a_images");
		
		// DTO에 파일이름을 한꺼번에 설정하기 위한 배열 생성
		String[] images = new String[mfList.size()];
		
		// 파일 이름 설정
		for(int i=0; i<mfList.size(); ++i) {
			images[i] = mfList.get(i).getOriginalFilename();
			
			if(images[i] == null || images[i].trim().equals("")) {
				// 파일 업로드가 없으면 기존 파일의 이름을 그대로 설정
				images[i] = pre_images[i];
			}else {
				// 파일 업로드가 있으면 파일이름 새로 설정
				images[i] = UUID.randomUUID().toString()+"_"+images[i];
			}
		}
		
		// h_image1,2,3,4,5의 이름을 한꺼번에 DTO에 설정하는 메소드
		adto.setA_images(images);
		// 줄개행을 @로 치환
		adto.setA_info(adto.getA_info().replace("\r\n", "@"));
		adto.setA_notice(adto.getA_notice().replace("\r\n", "@"));
		
		// DB 등록
		int res = activityMapper.editActivity(adto);
		
		if(res>0) {
			// 실제 파일을 업로드
			for(int i=0; i<mfList.size(); ++i) {
				// 새 파일명이랑 기존 파일명이 다를 경우
				if(!images[i].equals(pre_images[i])) {
					// 새 파일 업로드
					File newFile = new File(upPath+"/activity", images[i]);
					mfList.get(i).transferTo(newFile);
					
					// 기존 파일 삭제 (default.jpg 예외)
					File preFile = new File(upPath+"/activity", pre_images[i]);
					if(preFile.exists() && !preFile.getName().equals("default.jpg")) {
						preFile.delete();
					}
				}
			}
			
			req.setAttribute("msg", "액티비티 수정 성공!! 액티비티 목록 페이지로 이동합니다.");
			req.setAttribute("url", "activity_list");
        }else {
        	req.setAttribute("msg", "액티비티 수정 실패!! 액티비티 목록 페이지로 이동합니다.");
        	req.setAttribute("url", "activity_list");
        }
		
		return "message";
	}
	
	@RequestMapping("/activity_delete_ok")
	public String activityDeleteOk(HttpServletRequest req, int a_num, String[] a_images) {
		int res = activityMapper.deleteActivity(a_num);
		
		if(res>0) {
			for(int i=0; i<a_images.length; ++i) {
				File file = new File(upPath+"/activity", a_images[i]);
				if (file.exists() && !file.getName().equals("default.jpg")) {
					file.delete();
					}
				}
			req.setAttribute("msg", "액티비티 삭제 성공!! 액티비티 목록 페이지로 이동합니다.");
			req.setAttribute("url", "activity_list");
		}else {
			req.setAttribute("msg", "액티비티 삭제 실패!! 액티비티 목록 페이지로 이동합니다.");
			req.setAttribute("url", "activity_list");
		}
		return "message";
	}
	
	@RequestMapping("/program_input")
	public String programInput(int a_num) {
			return "activity/program_input";
	}
	
	@RequestMapping("program_input_ok")
	public String programInputOk(ProgramDTO pdto, HttpServletRequest req) {		
		int res = activityMapper.inputProgram(pdto);
		if(res>0) {
			req.setAttribute("msg", "프로그램 등록 성공!! 프로그램 목록 페이지로 이동합니다.");
			req.setAttribute("url", "program_list?a_num="+pdto.getA_num());
		}else {
			req.setAttribute("msg", "프로그램 등록 실패!! 프로그램 목록 페이지로 이동합니다.");
			req.setAttribute("url", "program_list?a_num="+pdto.getA_num());
		}
		return "message";
	}
	
	@RequestMapping("/program_list")
	public String programList(HttpServletRequest req, int a_num) {
		// 해당하는 프로그램을 list로 담아온다.
		List<ProgramDTO> programList = activityMapper.listProgram(a_num);
		req.setAttribute("programList", programList);
		return "activity/program_list";
	}
	
	@RequestMapping("/program_delete_ok")
	public String programDeleteOk(HttpServletRequest req, int p_num, int a_num) {
		int res = activityMapper.deleteProgram(p_num);
		
		if(res>0) {
			req.setAttribute("msg", "프로그램 삭제 성공!! 프로그램 목록 페이지로 이동합니다.");
			req.setAttribute("url", "program_list?a_num="+a_num);
		}else {
			req.setAttribute("msg", "프로그램 삭제 실패!! 프로그램 목록 페이지로 이동합니다.");
			req.setAttribute("url", "program_list?a_num="+a_num);
		}
		return "message";
	}
	
	@RequestMapping("/program_edit")
	public String editProgram(HttpServletRequest req, int p_num) {
		ProgramDTO pdto = activityMapper.getProgram(p_num);
		String str = pdto.getP_name();
		String[] pname = str.split("\\[");
		String p_name1 = pname[0];
		req.setAttribute("p_name1", p_name1);
		req.setAttribute("pdto",pdto);
		return "activity/program_edit";
	}
	
	@RequestMapping("program_edit_ok")
	public String programEditOk(HttpServletRequest req, ProgramDTO pdto) {
		int res = activityMapper.editProgram(pdto);
		if(res>0) {
			req.setAttribute("msg", "프로그램 수정 성공!! 프로그램 목록 페이지로 이동합니다.");
			req.setAttribute("url", "program_list?a_num="+pdto.getA_num());
		}else {
			req.setAttribute("msg", "프로그램 수정 실패!! 프로그램 목록 페이지로 이동합니다.");
			req.setAttribute("url", "program_list?a_num="+pdto.getA_num());
		}
		return "message";
	}

	@RequestMapping("/activity_booklist")
	public String activityBooklist(HttpServletRequest req, int a_num) {
		List<BookingActDTO> bookActList = activityMapper.listBookingActByCompany(a_num);
		
		for(BookingActDTO badto : bookActList) {
			ProgramDTO pdto = activityMapper.getProgram(badto.getP_num());
			ActivityDTO adto = activityMapper.getActivity(badto.getA_num());
			
			badto.setA_image1(adto.getA_image1());
			badto.setP_name(pdto.getP_name());
		}
		
		req.setAttribute("bookActList", bookActList);
		
		return "activity/activity_booklist";
	}

	@RequestMapping("/deny_bookingAct")
	public String denyBookingAct(HttpServletRequest req, int ba_num, int a_num) {
		int res = activityMapper.denyBookingAct(ba_num);
		
		if(res>0) {
            req.setAttribute("msg", "예약 거부 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "activity_booklist?a_num="+a_num);
        }else {
            req.setAttribute("msg", "예약 거부 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "activity_booklist?a_num="+a_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/confirm_bookingAct")
	public String confirmBookingAct(HttpServletRequest req, int ba_num, int a_num) {
		int res = activityMapper.confirmBookingAct(ba_num);
		
		if(res>0) {
            req.setAttribute("msg", "예약 승인  성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "activity_booklist?a_num="+a_num);
        }else {
            req.setAttribute("msg", "예약 승인  실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "activity_booklist?a_num="+a_num);
        }
		
		return "message";
	}
	
	@RequestMapping("/checkout_bookingAct")
	public String checkoutBookingAct(HttpServletRequest req, int ba_num, int a_num) {
		int res = activityMapper.checkoutBookingAct(ba_num);
		
		if(res>0) {
            req.setAttribute("msg", "체크 아웃 성공!! 예약 목록 페이지로 이동합니다.");
            req.setAttribute("url", "activity_booklist?a_num="+a_num);
        }else {
            req.setAttribute("msg", "체크 아웃 실패!! 다시 시도해 주세요.");
            req.setAttribute("url", "activity_booklist?a_num="+a_num);
        }
		
		return "message";
	}
}
