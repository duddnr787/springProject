package com.myspring.springProWooks.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.springProWooks.entity.GoodsVO;
import com.myspring.springProWooks.entity.ImageFileVO;
import com.myspring.springProWooks.entity.MemberVO;
import com.myspring.springProWooks.mapper.AdminGoodsDAO;




@Service("adminService")
public class AdminService {
	
	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	
	
	public void addImage(HashMap<String, String>  registerMap) throws Exception{
		adminGoodsDAO.addImage(registerMap);
	}

	public int addNewGoods(Map<String, Object> newGoodsMap) throws Exception { 
		adminGoodsDAO.insertNewGoods(newGoodsMap);  //goodsdb에 넣어주기
		int goods_id = (Integer)newGoodsMap.get("goods_id"); // 반환값이 int = 1 로 들어와서 그것을 바꿔준것 
		
		List<ImageFileVO> imageFileList = (List<ImageFileVO>)newGoodsMap.get("imageFileList");
		for(ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setGoods_id(goods_id);
			adminGoodsDAO.insertGoodsImageFile(imageFileVO); // image 디비에 넣어주기
		}
		System.out.println("newGoodsMap -> " + newGoodsMap);
		System.out.println("imageFileList -> " + imageFileList);
		
		return goods_id;
	}

	public List<GoodsVO> goodsList() {
		
		return adminGoodsDAO.goodsList();
	}

	
}
