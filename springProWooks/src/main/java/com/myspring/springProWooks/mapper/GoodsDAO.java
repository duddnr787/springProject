package com.myspring.springProWooks.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.entity.ImageFileVO;
import com.myspring.springProWooks.entity.OrderVO;


public interface GoodsDAO{

	public List<GoodsVO> selectGoodsList(String goodsStatus ) throws DataAccessException;
	
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	
	
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException;
	

	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException;
	
	
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException;

	public void deleteGoods(String goodsId) throws DataAccessException;

//	public OrderVO selectGoods(String goods_Id) throws DataAccessException;
	
}
