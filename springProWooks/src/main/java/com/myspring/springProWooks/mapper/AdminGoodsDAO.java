package com.myspring.springProWooks.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.entity.ImageFileVO;
@Repository("adminGoodsDAO")
public interface AdminGoodsDAO {
	
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException;
	
	public void addImage(HashMap<String, String> registerMap) throws DataAccessException;

	public void insertGoodsImageFile(ImageFileVO imageFileVO) throws DataAccessException;

	public List<GoodsVO> goodsList()throws DataAccessException;
}
