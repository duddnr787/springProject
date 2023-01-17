<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<c:url value='/resources/css/goodsregister.css'/>">


<script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<body>
        <div class="admin_content_wrap">
                    <div class="admin_content_subject"><h3>상품 등록</h3></div>
                    <div class="admin_content_main">
                    	<form action="/admin/insertNewGoods" method="post" id="enrollForm" name="insertGood" onsubmit="return false;">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_title" id="goods_title" >
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>작가</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_writer" id="goods_writer">
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판일</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_published_date" id="goods_published_date">
                    			</div>
                    		</div>            
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판사</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_publisher" id="goods_publisher">
                    			</div>
                    		</div>             
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 종류</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_sort" id="goods_sort">
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_price" value="0" id="goods_price">
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_point" value="0" id="goods_point">
                    			</div>
                    		</div>          
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 총 페이지</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_total_page" value="0" id="goods_total_page">
                    			</div>
                    		</div>       
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>isbn</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="goods_isbn" name="goods_isbn">
                    			</div>
                    		</div>   
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>배송비</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="goods_delivery_price" name="goods_delivery_price">
                    			</div>
                    		</div>   
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>배송기간</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="goods_delivery_date" autocomplete="off" id="goods_delivery_date" readonly="readonly">
                    			</div>
                    		</div>   
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 상태</label>
                    			</div>
                    			<div class="form_section_content">
                    				<select  id="goods_status" name="goods_status">
										<option value="1">베스트셀러</option>
										<option value="2">스테디셀러</option>
										<option value="3">신간</option>
										<option value="4">판매중</option>
										<option value="5">품절</option>
										<option value="6">절판</option>
									</select>
                    				</div>
                    		</div>    
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>글쓴이 한마디</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input id="goods_writer_intro" name="goods_writer_intro">
                    			</div>
                    		</div>      		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 소개</label>
                    			</div>
                    			<div class="form_section_content">
                    				<textarea name="bookIntro_textarea" id="bookIntro_textarea"></textarea>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>출판사 한마디</label>
                    			</div>
                    			<div class="form_section_content">
                    				<textarea name="bookContents_textarea" id="bookContents_textarea"></textarea>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이미지 파일</label>
                    			</div>
                    			<div class="form_section_content">
									<input type="button" value="파일 추가" onClick="fn_addFile()" id="addFile">
									<div id="d_file"></div>
                    			</div>
                    		</div> 
                   		</form>
            <div class="btn-section">
            	<button id="register" onclick="onRegist()">등록</button>
                <button id="cancel" onClick="history.back()">취소</button>
            </div>
        </div>
       </div> 
        <script >
        
        function onRegist(){
         bookIntro_textarea.value = document.querySelectorAll(".ck-content")[0].innerHTML
         bookContents_textarea.value = document.querySelectorAll(".ck-content")[1].innerHTML;
    				fetch("/admin/inserNewGoods.do", {
    					//option
    					 method: 'POST',
   			         	 cache: 'no-cache',
   			         	 body: new FormData(insertGood)
    				})
    				.then(response => response.json())
    				.then(jsonResult => {
    					console.log(jsonResult);
						alert(jsonResult.message);
    					if(jsonResult.status == true){
    						location.href = jsonResult.url;
    					}
    				});
    	}
        
        ClassicEditor
		.create(document.querySelector('#bookIntro_textarea'))
		.catch(error=>{
			console.error(error);
		});
		
	/* 책 목차 */	
	ClassicEditor
	.create(document.querySelector('#bookContents_textarea'))
	.catch(error=>{
		console.error(error);
	});
        
const config = {
		dateFormat: 'yy-mm-dd'	
	}
$(function() {
	  $( "input[name='goods_published_date']" ).datepicker(config);
	  $( "input[name='goods_delivery_date']" ).datepicker(config);
	});
var cnt = 0;
function fn_addFile(){
	if( cnt == 0 ){
		$("#d_file").append("<br>" + "<input type='file' id='main_image' name = 'main_image'/>");
	} else {
		$("#d_file").append("<br>" + "<input type='file' id='detail_image"  + cnt + "' name = 'detail_image' />");
	}
    
    cnt++;
}

</script>
</body>
</html>