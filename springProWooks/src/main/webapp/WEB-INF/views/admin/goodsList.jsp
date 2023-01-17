<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script>
    <script src="www.cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css"></script>
    <link rel="stylesheet" href="<c:url value='/resources/css/mypage.css'/>">
    
</head>

<body>
<div class="table_wrap">
<table id="data_list" class="table table-striped dataTable mt-0">
    <thead class="bg-secondary">
        <tr>
            <th>번호</th>
            <th>출판사</th>
            <th>책제목</th>
            <th>글쓴이</th>
            <th>등록일</th>
            <th>삭제</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</div>
</body>
<script type="text/javascript">

function deleteBtn(btn, goods_id)  {
	  fetch("/admin/deleteGoods.do", {
			method : 'POST',
			headers: {
			    'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"goods_id" : goods_id
			})		
		})
		.then(response => response.json())
		.then(jsonResult => {
			alert(jsonResult.message);
			location.reload();
		});
return false;
} 


$(document).ready(function() {
	$("#data_list").DataTable({
	    ajax: { url: "/admin/goodsList.do", dataSrc: '' , type:"GET"},
	    columns: [
	        { data: "goods_id" },
	        { data: "goods_publisher" },
	        { data: 
		     function (data, type, row, meta){// data: 데이터, 
			           return '<a href="/goods/goodsDetail.do?goods_id=' + data.goods_id +'">'+data.goods_title+'</a>';
		      }
			 },
	        { data: "goods_writer" },
	        { data: "goods_published_date" },
	        { data: 
	 	         function (data, type, row, meta){// data: 데이터, 
	 	           return '<button id="btn" onclick="deleteBtn(this, ' + '\'' + data.goods_id + '\' ' + ');">삭제</button>';
	 	            }
	 	          }
	    ]
	});
})

</script>
</html>