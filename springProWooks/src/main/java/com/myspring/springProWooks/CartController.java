package com.myspring.springProWooks;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.springProWooks.entity.CartVO;
import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.service.CartService;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartController extends BaseController {
	@Autowired
	private CartService cartService;
	
	MemberVO memberVO = new MemberVO();
	
	@RequestMapping(value = "/myCartListForm.do", method = RequestMethod.GET)
	public String findIdForm(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session=request.getSession();	
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		CartVO cartVO = new CartVO();
		String member_id=memberVO.getMember_id();
		cartVO.setMember_id(member_id);
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap);
		return "/cart/myCartList";
	}
	
	
	@RequestMapping(value="/addGoodsInCart.do" ,method = RequestMethod.POST,produces = "application/json; charset=utf8")
	public  @ResponseBody Map<String, Object> addGoodsInCart(@RequestBody HashMap<String, String> goodsid,
			                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String goods_id = goodsid.get("goods_id");
		String goods_count = goodsid.get("goods_count");
		String member_id=memberVO.getMember_id();
		CartVO cartVO = new CartVO();
		Map<String, Object> result = new HashMap<String, Object>();
		
		cartVO.setMember_id(member_id);
		cartVO.setGoods_id(goods_id);
		cartVO.setGoods_count(goods_count);
		
		String isAreadyExisted=cartService.findCartGoods(cartVO); //상품 번호가 장바구니 테이블에 있는지 조회한다.
		
		System.out.println("isAreadyExisted:"+isAreadyExisted);
		
		if(isAreadyExisted.equals("false")){
			cartService.addGoodsInCart(cartVO);
			result.put("status", true);
			result.put("message", "등록을 완료하였습니다.");
			result.put("url", "/homeForm.do");
		}else{
			result.put("status", false);
			result.put("message", "이미 카트에 등록된 제품입니다.");
			result.put("url", "/homeForm.do");
		}
		return result;
	}
	
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody Map<String, Object>  modifyCartQty(@RequestBody HashMap<String, String> modi,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		String goods_id = modi.get("goods_id");
		String goods_count = modi.get("goods_count");
		System.out.println("goodsid = " + goods_id + "  goodscount =  " + goods_count);
		CartVO cartVO = new CartVO();
		cartVO.setGoods_id(goods_id);
		cartVO.setMember_id(member_id);
		cartVO.setGoods_count(goods_count);
		
		System.out.println("cartVO : "+cartVO);
		
		
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			cartService.modifyCartQty(cartVO);
			result.put("message", "변경 되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("message", "변경에 실패하였습니다..");
		}
		return result;
	}
	
	@RequestMapping(value="/removeCartGoods.do" ,method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> removeCartGoods(@RequestBody HashMap<String, String> cart_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String cartId = cart_id.get("cart_id");
		
		Map<String, Object> result = new HashMap<String, Object>();	
		try {
			cartService.removeCartGoods(cartId);
			result.put("status", true);
			result.put("message", "삭제되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", false);
			result.put("message", "삭제를 실패하였습니다.");
		}
		return result;
	}
}
