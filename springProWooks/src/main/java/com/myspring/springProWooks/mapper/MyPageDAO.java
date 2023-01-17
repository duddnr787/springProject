package com.myspring.springProWooks.mapper;


import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.entity.OrderVO;

@Repository("myPageDAO")
public interface MyPageDAO{

	
	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException;
	
	public List<OrderVO> selectMyOrderInfo(String order_id) throws DataAccessException;

	public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException;
	
	public void updateMyInfo(Map memberMap) throws DataAccessException;
	
	public MemberVO selectMyDetailInfo(String member_id) throws DataAccessException;
	
	public void updateMyOrderCancel(String order_id) throws DataAccessException;
}
