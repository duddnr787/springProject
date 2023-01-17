package com.myspring.springProWooks.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.springProWooks.entity.OrderVO;

@Repository("orderDAO")
public interface OrderDAO {
	
	
	public List<OrderVO> selectMyOrderList(OrderVO orderVO) throws DataAccessException;
	
	
	public void insertNewOrder(OrderVO orderVO) throws DataAccessException;

		
	
	public OrderVO selectMyOrder(String order_id) throws DataAccessException;
		
	
	public void deleteGoodsFromCart(OrderVO orderVO)throws DataAccessException;
//		for(int i=0; i<myOrderList.size();i++){
//			OrderVO orderVO =(OrderVO)myOrderList.get(i);
		
	public int selectOrderID() throws DataAccessException;
}

