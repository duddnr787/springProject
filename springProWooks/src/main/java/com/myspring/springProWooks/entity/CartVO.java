package com.myspring.springProWooks.entity;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CartVO {
	private String cart_id;
	private String goods_id;
	private String member_id;
	private String goods_count;
	private String creDate;
	
	private int  goods_price;
	private String goods_title;
	
	private int totalPrice;
	
//	public void initTotal() {
//		this.totalPrice = this.goods_price*this.goods_count;
//	}
//	
}
