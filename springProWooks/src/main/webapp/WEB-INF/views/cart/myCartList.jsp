<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="myCartList"  value="${cartMap.myCartList}"  />
<c:set var="myGoodsList"  value="${cartMap.myGoodsList}"  />

<c:set  var="totalGoodsNum" value="0" />  <!--주문 개수 -->
<c:set  var="totalDeliveryPrice" value="0" /> <!-- 총 배송비 --> 
<c:set  var="totalSalesPrice" value="0" /> <!-- 총 할인금액 -->
<head>
<script type="text/javascript">
function calcGoodsPrice(obj){
	
	var count = obj.getAttribute('data-count');
	var price = obj.getAttribute('data-price');
	var delivery = obj.getAttribute('data-delivery');
	var sale = obj.getAttribute('data-sale');
	var total = obj.getAttribute('data-total');

	var totalPrice,final_total_price,totalNum;
	var totalDeliveryPrice, totalSalePrice;

	var p_totalNum=document.getElementById("p_totalGoodsNum");
	var p_totalPrice=document.getElementById("p_totalGoodsPrice");
	var p_final_totalPrice=document.getElementById("p_final_totalPrice");
	var p_totalDelivery=document.getElementById("p_totalDeliveryPrice");
	var p_totalSalesPrice = document.getElementById("p_totalSalesPrice");
	
	var h_totalNum=document.getElementById("h_totalGoodsNum");
	var h_totalPrice=document.getElementById("h_totalGoodsPrice");
	var h_totalDelivery=document.getElementById("h_totalDeliveryPrice");
	var h_final_total_price=document.getElementById("h_final_totalPrice");
	var h_totalSalesPrice = document.getElementById("h_totalSalesPrice");
	
	if(obj.checked==true){
	//	alert("체크 했음")
	 
		//총 개수 
		
		totalNum = Number(h_totalNum.value) + Number(count);
		
		//총 가격
		totalPrice=Number(h_totalPrice.value) + Number(price);

		//총 배송비
		totalDeliveryPrice=Number(h_totalDelivery.value) + Number(delivery);
		
		//총 할인된 가격
		totalSalePrice = Number(h_totalSalesPrice.value) + Number(sale);
		
		// 결제 금액 
		final_total_price=totalPrice + totalDeliveryPrice - totalSalePrice;
		
	}else{
		
		totalNum=Number(h_totalNum.value)-Number(count);
		
	 	totalPrice=Number(h_totalPrice.value)-Number(price);
		
	 	totalDeliveryPrice=Number(h_totalDelivery.value) - Number(delivery);
		
	 	totalSalePrice = Number(h_totalSalesPrice.value) - Number(sale);
	 	
	 	final_total_price=totalPrice + totalDeliveryPrice - totalSalePrice;;
		
	}
	
	h_totalNum.value=totalNum; 
	
	h_totalPrice.value=totalPrice;
	
	h_totalDelivery.value=totalDeliveryPrice;
	
	h_final_total_price.value=final_total_price;
	 
	h_totalSalesPrice.value=totalSalePrice;
	
	p_totalNum.innerHTML = totalNum + "개";
	
	p_totalPrice.innerHTML = totalPrice + "원";
	
	p_totalDelivery.innerHTML = totalDeliveryPrice + "원";
	
	p_totalSalesPrice.innerHTML = totalSalePrice + "원";
	
	p_final_totalPrice.innerHTML=final_total_price + "원"; 
}

function modify_cart_qty(obj){
	var goods_id = obj.getAttribute('data-goods_id');
	var goods_count = obj.parentElement.querySelector(".goods_count").value;

	  fetch('/cart/modifyCartQty.do', {
		//option
		method : 'POST',
		headers: {
		    'Content-Type': 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			"goods_id" : goods_id,
			"goods_count" : goods_count
			})			
	})
	.then(response => response.json())
	.then(jsonResult => {
		alert(jsonResult.message);
		location.reload();
	}); 
	} 

function delete_cart_goods(cart_id){
	fetch("/cart/removeCartGoods.do", {
		//option
		method : 'POST',
		headers: {
		    'Content-Type': 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			"cart_id" : cart_id
		})		
	})
	.then(response => response.json())
	.then(jsonResult => {
		alert(jsonResult.message);
		location.reload();
	});
	
}


function fn_show_order_detail(){
	goods_id="";
	goods_title="";
	
	var frm=document.form_order;
	var h_goods_id=frm.h_goods_id;
	var h_goods_title=frm.h_goods_title;
	var h_goods_fileName=frm.h_goods_fileName;
	var r_delivery_method  =  frm.delivery_method;
	var h_order_goods_qty=document.getElementById("h_order_goods_qty");
	var h_total_order_goods_qty=document.getElementById("h_total_order_goods_qty");
	var h_total_sales_price=document.getElementById("h_total_sales_price");
	var h_final_total_Price=document.getElementById("h_final_total_Price");
	var h_orderer_name=document.getElementById("h_orderer_name");
	var i_receiver_name=document.getElementById("receiver_name");
	
	
	if(h_goods_id.length <2 ||h_goods_id.length==null){
		goods_id+=h_goods_id.value;
	}else{
		for(var i=0; i<h_goods_id.length;i++){
			goods_id+=h_goods_id[i].value+"<br>";
			
		}	
	}
	
	if(h_goods_title.length <2 ||h_goods_title.length==null){
		goods_title+=h_goods_title.value;
	}else{
		for(var i=0; i<h_goods_title.length;i++){
			goods_title+=h_goods_title[i].value+"<br>";
			
		}	
	}
	
	
	if(h_goods_fileName.length <2 ||h_goods_fileName.length==null){
		goods_fileName+=h_goods_fileName.value;
	}else{
		for(var i=0; i<h_goods_fileName.length;i++){
			goods_fileName+=h_goods_fileName[i].value+"<br>";
			
		}	
	}
	
	
	total_order_goods_price=h_final_total_Price.value;
	total_order_goods_qty=h_total_order_goods_qty.value;
	
	for(var i=0; i<r_delivery_method.length;i++){
	  if(r_delivery_method[i].checked==true){
		 delivery_method=r_delivery_method[i].value
		 break;
	  }
	} 
		
	var r_gift_wrapping  =  frm.gift_wrapping;
	
	
	for(var i=0; i<r_gift_wrapping.length;i++){
	  if(r_gift_wrapping[i].checked==true){
		  gift_wrapping=r_gift_wrapping[i].value
		 break;
	  }
	} 
	
	var r_pay_method  =  frm.pay_method;
	
	for(var i=0; i<r_pay_method.length;i++){
	  if(r_pay_method[i].checked==true){
		  pay_method=r_pay_method[i].value
		  if(pay_method=="신용카드"){
			var i_card_com_name=document.getElementById("card_com_name");
			var i_card_pay_month=document.getElementById("card_pay_month");
			card_com_name=i_card_com_name.value;
			card_pay_month=i_card_pay_month.value;
			pay_method+="<Br>"+
				 		"카드사:"+card_com_name+"<br>"+
				 		"할부개월수:"+card_pay_month;
			pay_orderer_hp_num="해당없음";
			
		  }else if(pay_method=="휴대폰결제"){
			var i_pay_order_tel1=document.getElementById("pay_order_tel1");
			var i_pay_order_tel2=document.getElementById("pay_order_tel2");
			var i_pay_order_tel3=document.getElementById("pay_order_tel3");
			pay_orderer_hp_num=i_pay_order_tel1.value+"-"+
						   	    i_pay_order_tel2.value+"-"+
							    i_pay_order_tel3.value;
			pay_method+="<Br>"+"결제휴대폰번호:"+pay_orderer_hp_num;
			card_com_name="해당없음";
			card_pay_month="해당없음";
		  } //end if
		 break;
	  }// end for
	}
	
	var i_hp1=document.getElementById("hp1");
	var i_hp2=document.getElementById("hp2");
	var i_hp3=document.getElementById("hp3");
	
	var i_tel1=document.getElementById("tel1");
	var i_tel2=document.getElementById("tel2");
	var i_tel3=document.getElementById("tel3");
	
	var i_zipcode=document.getElementById("zipcode");
	var i_roadAddress=document.getElementById("roadAddress");
	var i_jibunAddress=document.getElementById("jibunAddress");
	var i_namujiAddress=document.getElementById("namujiAddress");
	var i_delivery_message=document.getElementById("delivery_message");
	var i_pay_method=document.getElementById("pay_method");

//	alert("총주문 금액:"+total_order_goods_price);
	order_goods_qty=h_order_goods_qty.value;
	//order_total_price=h_order_total_price.value;
	
	orderer_name=h_orderer_name.value;
	receiver_name=i_receiver_name.value;
	hp1=i_hp1.value;
	hp2=i_hp2.value;
	hp3=i_hp3.value;
	
	tel1=i_tel1.value;
	tel2=i_tel2.value;
	tel3=i_tel3.value;
	
	receiver_hp_num=hp1+"-"+hp2+"-"+hp3;
	receiver_tel_num=tel1+"-"+tel2+"-"+tel3;
	
	delivery_address="우편번호:"+i_zipcode.value+"<br>"+
						"도로명 주소:"+i_roadAddress.value+"<br>"+
						"[지번 주소:"+i_jibunAddress.value+"]<br>"+
								  i_namujiAddress.value;
	
	delivery_message=i_delivery_message.value;
	
	var p_order_goods_id=document.getElementById("p_order_goods_id");
	var p_order_goods_title=document.getElementById("p_order_goods_title");
	var p_order_goods_qty=document.getElementById("p_order_goods_qty");
	var p_total_order_goods_qty=document.getElementById("p_total_order_goods_qty");
	var p_total_order_goods_price=document.getElementById("p_total_order_goods_price");
	var p_orderer_name=document.getElementById("p_orderer_name");
	var p_receiver_name=document.getElementById("p_receiver_name");
	var p_delivery_method=document.getElementById("p_delivery_method");
	var p_receiver_hp_num=document.getElementById("p_receiver_hp_num");
	var p_receiver_tel_num=document.getElementById("p_receiver_tel_num");
	var p_delivery_address=document.getElementById("p_delivery_address");
	var p_delivery_message=document.getElementById("p_delivery_message");
	var p_gift_wrapping=document.getElementById("p_gift_wrapping");	
	var p_pay_method=document.getElementById("p_pay_method");
	
	p_order_goods_id.innerHTML=goods_id;
	p_order_goods_title.innerHTML=goods_title;
	p_total_order_goods_qty.innerHTML=total_order_goods_qty+"개";
	p_total_order_goods_price.innerHTML=total_order_goods_price+"원";
	p_orderer_name.innerHTML=orderer_name;
	p_receiver_name.innerHTML=receiver_name;
	p_delivery_method.innerHTML=delivery_method;
	p_receiver_hp_num.innerHTML=receiver_hp_num;
	p_receiver_tel_num.innerHTML=receiver_tel_num;
	p_delivery_address.innerHTML=delivery_address;
	p_delivery_message.innerHTML=delivery_message;
	p_gift_wrapping.innerHTML=gift_wrapping;
	p_pay_method.innerHTML=pay_method;
	imagePopup('open');
}

function fn_order_each_goods(goods_id, goods_title, goods_price, fileName, goods_delivery_price){
	 fetch('/order/OrderGoods.do', {
			//option
			method : 'POST',
			headers: {
			    'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"goods_id" : goods_id,
				"goods_title" : goods_title,
				"goods_price" : goods_price,
				"fileName" : fileName,
				"goods_delivery_price" : goods_delivery_price,
				"order_goods_qty" : goods_count.value
				})			
		})
		.then(response => response.json())
		.then(jsonResult => {
			location.href = jsonResult.url;
		});	
}



function fn_order_all_cart_goods(){
//	alert("모두 주문하기");
	var order_goods_qty;
	var order_goods_id;
	var objForm=document.frm_order_all_cart;
	var goods_count=objForm.goods_count;
	var h_order_each_goods_qty=objForm.h_order_each_goods_qty;
	var checked_goods=objForm.checked_goods;
	var length=checked_goods.length;
	
	
	//alert(length);
	if(length>1){
		for(var i=0; i<length;i++){
			if(checked_goods[i].checked==true){
				order_goods_id=checked_goods[i].value;
				order_goods_qty=goods_count[i].value;
				goods_count[i].value="";
				goods_count[i].value=order_goods_id+":"+order_goods_qty;
				//alert(select_goods_qty[i].value);
				console.log(goods_count[i].value);
			}
		}	
	}else{
		order_goods_id=checked_goods.value;
		order_goods_qty=goods_count.value;
		goods_count.value=order_goods_id+":"+order_goods_qty;
		//alert(select_goods_qty.value);
	}
		
 	objForm.method="post";
 	objForm.action="/order/orderAllCartGoods.do";
	objForm.submit();
}
</script>
<style type="text/css">
.button_submit {
    font-weight: bold;
    display: inline-block;
    width: 215px;
    height: 48px;
    padding: 0;
    line-height: 48px;
    font-size: 16px;
    color: rgb(5, 3, 3);
    background-color: rgb(166, 212, 252);
    border: 1px solid #d6d6d6;
    box-sizing: border-box;
}
.button_cancel {
    font-weight: bold;
    display: inline-block;
    width: 215px;
    height: 48px;
    padding: 0;
    line-height: 48px;
    font-size: 16px;
    color: #222;
    background-color: #ffffff;
    border: 1px solid #d6d6d6;
    box-sizing: border-box;
}
</style>
</head>
<body>
	<table class="list_view">
		<tbody align=center >
			<tr style="background:rgb(166, 212, 252)" >
				<!-- <td class="fixed" >책표지</td>
				<td class="fixed">상품명</td> -->
				<td class="fixed" >구분</td>
				<td colspan=2 class="fixed">상품명</td>
				<td>정가</td>
				<td>판매가</td>
				<td>수량</td>
				<td>합계</td>
				<td>삭제</td>
			</tr>
			
			 <c:choose>
				    <c:when test="${ empty myCartList }">
				    <tr>
				       <td colspan=8 class="fixed">
				         <strong>장바구니에 상품이 없습니다.</strong>
				       </td>
				     </tr>
				    </c:when>
			        <c:otherwise>
			 <tr>       
               <form name="frm_order_all_cart" onsubmit="return false;">
				      <c:forEach var="item" items="${myGoodsList}" varStatus="cnt">
				       <c:set var="goods_count" value="${myCartList[cnt.count-1].goods_count}" />
				       <c:set var="cart_id" value="${myCartList[cnt.count-1].cart_id}" />
				      	
					  <td>
					<input type="checkbox" name="checked_goods"  checked
					data-count="${goods_count }" 
					data-price="${ item.goods_price * goods_count}"
					data-delivery="${item.goods_delivery_price}" 
					data-sale="${ (item.goods_price - item.goods_sales_price) * goods_count}" 
					data-total="${ item.goods_sales_price * goods_count +  item.goods_delivery_price}" 
					value="${item.goods_id }"  onClick="calcGoodsPrice(this)">
					</td>  
					<td class="goods_image">
					<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
						<img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}"  />
					</a>
					</td>
					<td>
						<h2>
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
						</h2>
					</td>
					<td class="price"><span>${item.goods_price }원</span></td>
					<td>
					   <strong>
					      <fmt:formatNumber  value="${item.goods_price*0.9}" type="number" var="discounted_price" />
				            ${discounted_price}원(10%할인)
				         </strong>
					</td>
					<td>
					   <input type="text"  class="goods_count" name="goods_count" size=3  value="${goods_count}"> <br>
						<a
						data-goods_id = "${item.goods_id }"
						 onclick="modify_cart_qty(this)" >
						    <img width=25 alt=""  src="${contextPath}/resources/image/btn_modify_qty.jpg">
						</a>
					</td>
					<td>
					   <strong>
					    <fmt:formatNumber  value="${item.goods_price*0.9*goods_count}" type="number" var="total_sales_price" />
				         ${total_sales_price}원
					</strong> </td>
					<td>
						<a href="javascript:delete_cart_goods('${cart_id}');"> 
						   <img id="deleteCartBtn" width="75" alt="" 
							   src="/resources/image/btn_delete.jpg">
					   </a>
					</td>
			</tr>
				<c:set  var="totalGoodsPrice" value="${totalGoodsPrice + item.goods_price * goods_count}" />
				<c:set  var="totalGoodsNum" value="${totalGoodsNum + goods_count}" /> 
				<c:set  var="totalDeliveryPrice" value="${totalDeliveryPrice+item.goods_delivery_price }" />
				<c:set  var="totalSalesPrice" value="${totalSalesPrice+item.goods_price*0.1 * goods_count }" />
			   </c:forEach>
		    
		</tbody>
	</table>
     	
	<div class="clear"></div>
	 </c:otherwise>
	</c:choose> 
	<br>
	<br>
	
	<table  width=80%   class="list_view" style="background:rgb(166, 212, 252);">
	<tbody>
	     <tr  align=center  class="fixed" >
	       <td class="fixed">총 상품수 </td>
	       <td>총 상품금액</td>
	       <td>  </td>
	       <td>총 배송비</td>
	       <td>  </td>
	       <td>총 할인 금액 </td>
	       <td>  </td>
	       <td>최종 결제금액</td>
	     </tr>
		<tr cellpadding=40  align=center >
			<td id="">
			  <p id="p_totalGoodsNum">${totalGoodsNum}개</p>
			  <input id="h_totalGoodsNum"type="hidden" value="${totalGoodsNum}"  />
			</td>
	       <td>
	          <p id="p_totalGoodsPrice">
	          <fmt:formatNumber  value="${totalGoodsPrice}" type="number" var="total_goods_price" />
				         ${total_goods_price}원
	          </p>
	          <input id="h_totalGoodsPrice"type="hidden" value="${totalGoodsPrice}" />
	       </td>
	       <td> 
	          <img width="25" alt="" src="${contextPath}/resources/image/plus.jpg">  
	       </td>
	       <td>
	         <p id="p_totalDeliveryPrice">${totalDeliveryPrice }원  </p>
	         <input id="h_totalDeliveryPrice"type="hidden" value="${totalDeliveryPrice}" />
	       </td>
	       <td> 
	         <img width="25" alt="" src="${contextPath}/resources/image/minus.jpg"> 
	       </td>
	       <td>  
	         <p id="p_totalSalesPrice"> 
				         ${totalSalesPrice}원
	         </p>
	         <input id="h_totalSalesPrice"type="hidden" value="${totalSalesPrice}" />
	       </td>
	       <td>  
	         <img width="25" alt="" src="${contextPath}/resources/image/equal.jpg">
	       </td>
	       <td>
	          <p id="p_final_totalPrice">
	          <fmt:formatNumber  value="${totalGoodsPrice+totalDeliveryPrice-totalSalesPrice}" type="number" var="total_price" />
	            ${total_price}원
	          </p>
	          <input id="h_final_totalPrice" type="hidden" value="${totalGoodsPrice+totalDeliveryPrice-totalSalesPrice}" />
	       </td>
		</tr>
		</tbody>
	</table>
	 <center>
    <br><br>	
		 <div class="box_buttons"> 
        <input type="submit" id="insertButton" class="button_submit" value="주문하기" onclick="fn_order_all_cart_goods()">
        <input type="reset"  class="button_cancel" onClick="history.back();" value="취소">
    </div>
	<center> 
	
</form>	

	