package com.myspring.springProWooks.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.springProWooks.entity.CartVO;
import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.mapper.CartDAO;

@Service("cartService")
public class CartService {
	@Autowired
	private CartDAO cartDAO;
	
	public Map<String ,List> myCartList(CartVO cartVO) throws Exception{
		Map<String,List> cartMap=new HashMap<String,List>();
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		if(myCartList.size()==0){ 
			return null;
		}
		List<GoodsVO> myGoodsList=cartDAO.selectGoodsList(myCartList);
		cartMap.put("myCartList", myCartList);
		cartMap.put("myGoodsList",myGoodsList);
		return cartMap;
	}
	
	//동일 상품 있는지 확인한다.
	public String findCartGoods(CartVO cartVO) throws Exception{

		return cartDAO.selectCountInCart(cartVO);
		
	}	
	//장바구니에 추가한다.
	public void addGoodsInCart(CartVO cartVO) throws Exception{
		cartDAO.insertGoodsInCart(cartVO);
	}
	
	public void modifyCartQty(CartVO cartVO) throws Exception{
		
	 System.out.println("cart qty             ============================================" + cartVO.getCart_id()); 	
		 cartDAO.updateCartGoodsQty(cartVO);
	}
	public void removeCartGoods(String cart_id) throws Exception{
		cartDAO.deleteCartGoods(cart_id);
	}
	
}
