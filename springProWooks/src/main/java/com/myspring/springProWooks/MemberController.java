package com.myspring.springProWooks;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.service.MemberService;

@Controller("memberController")
@RequestMapping(value="/member")
public class MemberController extends BaseController {
	
	@Autowired
	private MemberService memberService;
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	

	
	@RequestMapping(value="/login.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> login(@RequestBody HashMap<String, String> loginMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		 MemberVO memberVO = memberService.login(loginMap);
	
		if(memberVO != null ){
			if(memberVO.getMember_id().equals("admin") && memberVO.getPermit().equals("Y")) {
				HttpSession session=request.getSession();
				session=request.getSession();
				session.setAttribute("isLogOn", true);
				session.setAttribute("memberInfo",memberVO);
				result.put("status", "1");
				result.put("message", "안녕하세요. 관리자님 ");
				result.put("url", "/homeForm.do");
			} else if (!memberVO.getMember_id().equals("admin") && memberVO.getPermit().equals("Y")) {
			HttpSession session=request.getSession();
			session=request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo",memberVO);
			result.put("status", "2");
			result.put("message", "반가워요");
			result.put("url", "/homeForm.do");
			}
			else {
				result.put("status", "3");
				result.put("message", "로그인 정지 당하셨습니다..");
			}
		} else {
			result.put("status", "4");
			result.put("message", "아이디와 비밀번호를 확인해주세요.");
		}
		return result;
	}
	
	@RequestMapping(value = "/loginForm.do", method = RequestMethod.GET)
	public String loginForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/member/loginForm";
	}
	@RequestMapping(value = "/deleteMemberForm.do", method = RequestMethod.GET)
	public String deleteForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/member/deleteMember";
	}
	
	@RequestMapping(value="/logout.do" ,method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/");
		return mav;
	}
	
	@RequestMapping(value = "/memberForm.do", method = RequestMethod.GET)
	public String memberForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/member/memberForm";
	}
	
	@RequestMapping(value = "/findPwdForm.do", method = RequestMethod.GET)
	public String findPwdForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/member/findPwd";
	}
	@RequestMapping(value = "/findIdForm.do", method = RequestMethod.GET)
	public String findIdForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		
		return "/member/findId";
	}
	@RequestMapping(value = "/findId.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findId(@RequestBody HashMap<String, String> findMap,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

			Map<String, Object> result = new HashMap<String, Object>();
			
			MemberVO memberVO = memberService.find(findMap);
			
			if(memberVO != null){
				result.put("status", true);
				result.put("message",  memberVO.getMember_name() + "님의 " + "ID는 " + memberVO.getMember_id() + "입니다.");
//				result.put("url", "/");
			} else {
				result.put("status", false);
				result.put("message", "해당에 맞는 ID가 없습니다.");
			}
			return result;
		}
		
	@RequestMapping(value = "/findPwd.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findPwd(@RequestBody HashMap<String, String> findMap,
            HttpServletRequest request, HttpServletResponse response) throws Exception {

			Map<String, Object> result = new HashMap<String, Object>();
			
			MemberVO memberVO = memberService.find(findMap);
			
			if(memberVO != null){
				result.put("status", true);
				result.put("message",  memberVO.getMember_name() + "님의 " + "비밀번호는 " + memberVO.getMember_pw() + "입니다.");
//				result.put("url", "/");
			} else {
				result.put("status", false);
				result.put("message", "해당에 맞는 ID가 없습니다.");
			}
			return result;
		}	
	
	
	
	
	@RequestMapping(value="/addMember.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> addMember(@RequestBody HashMap<String, String> registerMap,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		String check = memberService.overlapped(registerMap.get("id"));
		if ( check.equals("false")) {
			memberService.addMember(registerMap);
			result.put("status", true);
			result.put("message", "회원가입 축하드려요");
			result.put("url", "/member/loginForm.do");
		} else {
			result.put("status", false);
			result.put("message", "회원 가입에 실패했습니다.");
		}
		return result;
	}
	
	
	@RequestMapping(value="/overlapped.do" ,method = RequestMethod.POST)
	public ResponseEntity overlapped(@RequestParam("id") String id,HttpServletRequest request, HttpServletResponse response) throws Exception{
		ResponseEntity resEntity = null;
		String result = memberService.overlapped(id);
		resEntity =new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}
	
	@RequestMapping(value="/editUser.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> editUser(@RequestBody HashMap<String, String> editMap,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		String check = memberService.overlapped(editMap.get("id"));
		if( check.equals("true") ){
			memberService.editUser(editMap);
			result.put("status", true);
			result.put("message",  "수정 완료되었습니다.");
			result.put("url", "/");
		} else {
			result.put("status", false);
			result.put("message", "수정에 실패하였습니다..");
		}
		return result;
	}
	
	@RequestMapping(value="/deleteUser.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> deleteUser(@RequestBody HashMap<String, String> deleteMap,
			                HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		HttpSession session=request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String id = memberVO.getMember_id();
		String pwd = deleteMap.get("pwd");
		
		Map<String, String> check = new HashMap<String, String>(); 
		check.put("id", id);
		check.put("pwd", pwd);
		
		
		 String check_id = memberService.check(check);
		 System.out.println("asdasd" + check_id);
		 
		if( check_id.equals("true") ){
			memberService.deleteUser(deleteMap);
			result.put("status", true);
			result.put("message",  "삭제되었습니다.");
			result.put("url", "/");
			session.setAttribute("isLogOn", false);
			session.removeAttribute("memberInfo");
		} else {
			result.put("status", false);
			result.put("message", "비밀번호를 틀렸습니다.");
		}
		return result;
	}
	
}
