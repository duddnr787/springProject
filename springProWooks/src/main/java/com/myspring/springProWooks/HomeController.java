package com.myspring.springProWooks;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.service.GoodsService;

/**
 * Handles requests for the application home page.
 */
@Controller("HomeController")
public class HomeController {

	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home1(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		
		
		return "/main/home1";
	}
	
	@RequestMapping(value = "/homeForm.do", method = RequestMethod.GET)
	public String home(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception {
		
		session=request.getSession();
		
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/main/home";
	}
	
}
