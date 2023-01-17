package com.myspring.springProWooks.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.entity.ImageFileVO;
import com.myspring.springProWooks.entity.OrderVO;
import com.myspring.springProWooks.mapper.GoodsDAO;

@Service("goodsService")

public class GoodsService{
	
	@Autowired
	private GoodsDAO goodsDAO;
	
	public Map<String,List<GoodsVO>> listGoods() throws Exception {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList=goodsDAO.selectGoodsList("1");
		goodsMap.put("bestseller",goodsList);
		goodsList=goodsDAO.selectGoodsList("3");
		goodsMap.put("newbook",goodsList);
		
		goodsList=goodsDAO.selectGoodsList("2");
		goodsMap.put("steadyseller",goodsList);
		goodsList=goodsDAO.selectGoodsList("4");
		goodsMap.put("onsale",goodsList);
		goodsList=goodsDAO.selectGoodsList("5");
		goodsMap.put("soldout",goodsList);
		goodsList=goodsDAO.selectGoodsList("6");
		goodsMap.put("outofprint",goodsList);
		return goodsMap;
	}
	
	public Map<String, Object> goodsDetail(String _goods_id) throws Exception {
		Map<String, Object> goodsMap=new HashMap<String, Object>();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		return goodsMap;
	}
	
	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	public List<GoodsVO> searchGoods(String searchWord) throws Exception{
		List<GoodsVO> goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}

	public void deleteGoods(String goodsId) {
		 
		goodsDAO.deleteGoods(goodsId);
	}

//	public OrderVO selectGoods(String goods_Id) {
//
//		return goodsDAO.selectGoods(goods_Id);
//	}
//	
	
	
}
