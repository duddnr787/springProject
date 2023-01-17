package com.myspring.springProWooks.mapper;

import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.myspring.springProWooks.entity.CartVO;
import com.myspring.springProWooks.entity.GoodsVO;


public interface CartDAO{
	
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException ;

	public List<GoodsVO> selectGoodsList(List<CartVO> cartList) throws DataAccessException ;
	
	public String selectCountInCart(CartVO cartVO) throws DataAccessException;

	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException;
	
	
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException;
	
	public void deleteCartGoods(String cart_id) throws DataAccessException;
	
	public int selectMaxCartId() throws DataAccessException;

}
