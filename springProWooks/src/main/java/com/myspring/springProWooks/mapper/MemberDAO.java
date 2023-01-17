package com.myspring.springProWooks.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.springProWooks.entity.MemberVO;

@Repository("memberDAO")
public interface MemberDAO{
	
	
	
	public MemberVO login(HashMap<String, String> loginMap) throws DataAccessException;
	
	public MemberVO findMember(HashMap<String, String> loginMap) throws DataAccessException;
	
	public void insertNewMember(HashMap<String, String> registerMap) throws DataAccessException;

	
	public String selectOverlappedID(String id) throws DataAccessException ;
	
	public String checkPwd(Map<String, String> check) throws DataAccessException ;

	public void editUser(Map<String, String> editMap) throws DataAccessException ;

	public void deleteUser(Map<String, String> editResult)throws DataAccessException;

	public List<MemberVO> memberList() throws DataAccessException ;

	public void permitUser(HashMap<String, String> member_id) throws DataAccessException ;
	
	
}
