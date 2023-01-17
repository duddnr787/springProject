package com.myspring.springProWooks.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.springProWooks.entity.OrderVO;
import com.myspring.springProWooks.mapper.OrderDAO;


@Service("orderService")

public class OrderService {
	@Autowired
	private OrderDAO orderDAO;
	
	public List<OrderVO> listMyOrderGoods(OrderVO orderVO) throws Exception{
		List<OrderVO> orderGoodsList;
		orderGoodsList=orderDAO.selectMyOrderList(orderVO);
		return orderGoodsList;
	}
	
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception{
		int order_id=orderDAO.selectOrderID();
		System.out.println(order_id);
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			orderVO.setOrder_id(order_id);
			myOrderList.set(i, orderVO); 
			
			orderDAO.insertNewOrder(orderVO);
			orderDAO.deleteGoodsFromCart(orderVO);
		}
		
		
	}	

	
	public OrderVO findMyOrder(String order_id) throws Exception{
		return orderDAO.selectMyOrder(order_id);
	}

}
