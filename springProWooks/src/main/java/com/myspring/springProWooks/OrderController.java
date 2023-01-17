package com.myspring.springProWooks;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.myspring.springProWooks.entity.OrderVO;
import com.myspring.springProWooks.service.GoodsService;
import com.myspring.springProWooks.service.OrderService;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderController extends BaseController {
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private GoodsService goodsService;
//	@RequestMapping(value="/orderEachGoods.do" ,method = RequestMethod.POST)
//	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,
//			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
//		OrderVO orderVO = new OrderVO();
//		request.setCharacterEncoding("utf-8");
//		HttpSession session=request.getSession();
//		session=request.getSession();
//		
//		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
//		String action=(String)session.getAttribute("action");
//		
//		if(isLogOn==null || isLogOn==false){
//			session.setAttribute("orderInfo", _orderVO);
//			session.setAttribute("action", "/order/orderEachGoods.do");
//			return new ModelAndView("redirect:/member/loginForm.do");
//		}else{
//			 if(action!=null && action.equals("/order/orderEachGoods.do")){
//				orderVO=(OrderVO)session.getAttribute("orderInfo");
//				session.removeAttribute("action");
//			 }else {
//				 orderVO=_orderVO;
//			 }
//		 }
//		
//		String viewName=(String)request.getAttribute("viewName");
//		ModelAndView mav = new ModelAndView(viewName);
//		
//		List myOrderList=new ArrayList<OrderVO>();
//		myOrderList.add(orderVO);
//
//		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
//		
//		session.setAttribute("myOrderList", myOrderList);
//		session.setAttribute("orderer", memberInfo);
//		return mav;
//	}
//	
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("goods_count")  String[] goods_count,
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap");
		List myOrderList=new ArrayList<OrderVO>();
		
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		for(int i=0; i<goods_count.length;i++){
			String[] cart_goods=goods_count[i].split(":");
			for(int j = 0; j< myGoodsList.size();j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goods_id = goodsVO.getGoods_id();
				if(goods_id==Integer.parseInt(cart_goods[0])) {
					OrderVO _orderVO=new OrderVO();
					String goods_title=goodsVO.getGoods_title();
					int goods_sales_price=goodsVO.getGoods_sales_price();
					String goods_fileName=goodsVO.getGoods_fileName();
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));
					myOrderList.add(_orderVO);
					break;
				}
			}
		}
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}	
	
	@RequestMapping(value="/payToOrderGoods.do" ,method = RequestMethod.POST)
	public String payToOrderGoods(@RequestParam Map<String, String> receiverMap,
			                       HttpServletRequest request, HttpServletResponse response, Model model)  throws Exception{
		
		
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
		String member_id=memberVO.getMember_id();
		String orderer_name=memberVO.getMember_name();
		String orderer_hp = memberVO.getHp1()+"-"+memberVO.getHp2()+"-"+memberVO.getHp3();
		List<OrderVO> myOrderList=(List<OrderVO>)session.getAttribute("myOrderList");
		Map<String, Object> result = new HashMap<String, Object>();
		
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO=(OrderVO)myOrderList.get(i);
			orderVO.setMember_id(member_id);
			orderVO.setOrderer_name(orderer_name);
			orderVO.setReceiver_name(receiverMap.get("receiver_name"));
			
			orderVO.setReceiver_hp1(receiverMap.get("receiver_hp1"));
			orderVO.setReceiver_hp2(receiverMap.get("receiver_hp2"));
			orderVO.setReceiver_hp3(receiverMap.get("receiver_hp3"));
			orderVO.setReceiver_tel1(receiverMap.get("receiver_tel1"));
			orderVO.setReceiver_tel2(receiverMap.get("receiver_tel2"));
			orderVO.setReceiver_tel3(receiverMap.get("receiver_tel3"));
			
			orderVO.setDelivery_address(receiverMap.get("delivery_address"));
			orderVO.setDelivery_message(receiverMap.get("delivery_message"));
			orderVO.setDelivery_method(receiverMap.get("delivery_method"));
			orderVO.setGift_wrapping(receiverMap.get("gift_wrapping"));
			orderVO.setPay_method(receiverMap.get("pay_method"));
			orderVO.setCard_com_name(receiverMap.get("card_com_name"));
			orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
			orderVO.setPay_orderer_hp_num(receiverMap.get("pay_orderer_hp_num"));	
			orderVO.setOrderer_hp(orderer_hp);	
			myOrderList.set(i, orderVO); 
		}//end for
		
	    orderService.addNewOrder(myOrderList);
	    model.addAttribute("myOrderInfo", receiverMap);
	    model.addAttribute("myOrderList", myOrderList);
		return "/order/orderResult";
	}
	@RequestMapping(value = "/OrderGoods.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> OrderGoods(@RequestBody HashMap<String, String> goodsMap,
            HttpServletRequest request, HttpServletResponse response ) throws Exception {
			HttpSession session=request.getSession();
			OrderVO orderVO = new OrderVO();
			
			MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
			
			int goods_Id = Integer.parseInt(goodsMap.get("goods_id"));
			String goods_title = goodsMap.get("goods_title");
			int goods_price = Integer.parseInt(goodsMap.get("goods_price"));
			String fileName = goodsMap.get("fileName");
			int goods_delivery_price = Integer.parseInt(goodsMap.get("goods_delivery_price"));
			int order_goods_qty = Integer.parseInt(goodsMap.get("order_goods_qty"));
		
			orderVO.setGoods_id(goods_Id);
			orderVO.setGoods_title(goods_title);
			orderVO.setGoods_sales_price(goods_price);
			orderVO.setGoods_fileName(fileName);
			orderVO.setGoods_delivery_price(goods_delivery_price);
			orderVO.setOrder_goods_qty(order_goods_qty);
			
			List myOrderList=new ArrayList<OrderVO>();
			myOrderList.add(orderVO);
			
			session.setAttribute("orderer", memberInfo);
			session.setAttribute("goods_id", goods_Id);
			session.setAttribute("goods_title", goods_title);
			session.setAttribute("goods_price", goods_price);
			session.setAttribute("fileName", fileName);
			session.setAttribute("goods_delivery_price", goods_delivery_price);
			session.setAttribute("order_goods_qty", order_goods_qty);
			session.setAttribute("myOrderList", myOrderList);
			session.setAttribute("orderer", memberInfo);
			
			Map<String, Object> result = new HashMap<String, Object>();
			try {
				
				result.put("url", "/order/orderGoodsForm.do");
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}	

	@RequestMapping(value = "/orderGoodsForm.do", method = RequestMethod.GET)
	public String memberForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		return "/order/orderGoodsForm";
	}
	
}
