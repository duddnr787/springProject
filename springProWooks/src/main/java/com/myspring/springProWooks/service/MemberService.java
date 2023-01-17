package com.myspring.springProWooks.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.mapper.MemberDAO;

@Service("memberService")

public class MemberService {
	@Autowired
	private  MemberDAO memberDAO;
	
	
	public MemberVO login(HashMap<String, String>  loginMap) throws Exception{
		MemberVO memberVO = memberDAO.login(loginMap);
		if (memberVO != null && memberVO.getMember_pw().equals(loginMap.get("pwd"))) {
			return memberVO;
		}
		return null;
	}
	
	public MemberVO find(HashMap<String, String>  loginMap) throws Exception{
		MemberVO memberVO = memberDAO.findMember(loginMap);
		if (memberVO != null ) {
			return memberVO;
		}
		return null;
	}
	
	public void addMember(HashMap<String, String>  registerMap) throws Exception{
		memberDAO.insertNewMember(registerMap);
	}
	
	
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}
	public String check(Map<String, String> check) throws Exception{
		return memberDAO.checkPwd(check);
	}
	
	public void editUser(Map<String, String> editResult) throws Exception {
		 memberDAO.editUser(editResult);
	}
	public void deleteUser(Map<String, String> editResult) throws Exception {
		 memberDAO.deleteUser(editResult);
	}

	public List<MemberVO> memberList() {
		
		return memberDAO.memberList();
	}

	public void permitUser(HashMap<String, String> member_id) {
 
		memberDAO.permitUser(member_id);
	}
}
