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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.service.GoodsService;

@Controller("goodsController")
@RequestMapping("/goods")
public class GoodsController extends BaseController  {
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public String goodsDetail(@RequestParam("goods_id") String goods_id,
			                       HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session=request.getSession();
		Map<String,Object>  goodsMap=goodsService.goodsDetail(goods_id);
		model.addAttribute("goodsMap", goodsMap);
		GoodsVO goodsVO=(GoodsVO)goodsMap.get("goodsVO");
		addGoodsInQuick(goods_id,goodsVO,session);
		return "/goods/goodsDetail";
	}
	
	@RequestMapping(value="/bestForm.do" ,method = RequestMethod.GET)
	public String best(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session;
		session=request.getSession();
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/goods/best";
	}
	@RequestMapping(value="/steadyForm.do" ,method = RequestMethod.GET)
	public String steady(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session;
		session=request.getSession();
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/goods/steady";
	}
	
	@RequestMapping(value="/newForm.do" ,method = RequestMethod.GET)
	public String news(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session;
		session=request.getSession();
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/goods/new";
	}
	@RequestMapping(value="/soldOutForm.do" ,method = RequestMethod.GET)
	public String soldOut(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session;
		session=request.getSession();
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/goods/soldout";
	}
	@RequestMapping(value="/outofprintForm.do" ,method = RequestMethod.GET)
	public String outofprint(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session;
		session=request.getSession();
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/goods/outofprint";
	}
	
	@RequestMapping(value="/onsaleForm.do" ,method = RequestMethod.GET)
	public String onsale(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
		HttpSession session;
		session=request.getSession();
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		model.addAttribute("goodsMap", goodsMap);
		model.addAttribute("goods_count", 0);
		return "/goods/onsale";
	}
	
	@RequestMapping(value = "/keywordSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> keywordSearch(@RequestBody HashMap<String, String> searchMap) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String keyword = searchMap.get("keyword");
		// System.out.println(keyword);
		if (keyword == null || keyword.equals(""))
			return map;

		keyword = keyword.toUpperCase();
		List<String> keywordList = goodsService.keywordSearch(keyword);

		map.put("keyword", keywordList);
		return map;
	}

	
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public String searchGoods(@RequestParam("searchWord") String searchWord,
			                       HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		
		model.addAttribute("goodsList", goodsList);
		return "/goods/searchGoods";
		
	}
	
	private void addGoodsInQuick(String goods_id,GoodsVO goodsVO,HttpSession session){
		boolean already_existed=false;
		List<GoodsVO> quickGoodsList; 
		quickGoodsList=(ArrayList<GoodsVO>)session.getAttribute("quickGoodsList");
		
		if(quickGoodsList!=null){
			if(quickGoodsList.size() < 4){ 
				for(int i=0; i<quickGoodsList.size();i++){
					GoodsVO _goodsBean=(GoodsVO)quickGoodsList.get(i);
					if(goods_id.equals(_goodsBean.getGoods_id())){
						already_existed=true;
						break;
					}
				}
				if(already_existed==false){
					quickGoodsList.add(goodsVO);
				}
			}
			
		}else{
			quickGoodsList =new ArrayList<GoodsVO>();
			quickGoodsList.add(goodsVO);
			
		}
		session.setAttribute("quickGoodsList",quickGoodsList);
		session.setAttribute("quickGoodsListNum", quickGoodsList.size());
	}
}
