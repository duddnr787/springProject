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
            <th>아이디</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>주소</th>
            <th>가입일</th>
            <th>회원관리</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>
</div>
</body>
<script type="text/javascript">

 function changeBtn(btn, member_id, permit)  {
		  fetch("/admin/permitUser.do", {
				method : 'POST',
				headers: {
				    'Content-Type': 'application/json;charset=utf-8'
				},
				body: JSON.stringify({
					"member_id" : member_id,
					"permit" : permit
				})		
			})
			.then(response => response.json())
			.then(jsonResult => {
				alert(jsonResult.message);
				btn.innerText = jsonResult.button
			});
	  return false;
	} 
	
	/* function changeBtn(btn, memberid)  {
		  if(btn.innerText === '로그인 가능'){
			  btn.innerText = '로그인 불가';
		  } else btn.innerText ='로그인 가능';
		  return false;
		} */
$(document).ready(function() {
	$("#data_list").DataTable({
	    ajax: { url: "/admin/memberList.do", dataSrc: '' , type:"GET"},
	    columns: [
	        { data: "member_id" },
	        { data: "member_name" },
	        { data: function (data, type, dataToSet) {
	            return data.hp1 + "-" + data.hp2 + "-" + data.hp3;
	        }},
	        { data: function (data, type, dataToSet) {
	            return data.email1 + "@" + data.email2;
	        }},
	        { data: "jibunAddress" },
	        { data: "joinDate" },
	        /* { data: 
	         function (data, type, row, meta){// data: 데이터, 
	           return '<button id="btn" onclick="return changeBtn(this," '+data.member_id+'");">로그인 가능</button>';// 이 부분이 실제로 표현됨
	            }
	          } */
	          { data: 
		 	         function (data, type, row, meta){// data: 데이터, 
	        	  var loginBtn ;
	        	  if(data.permit==='Y'){
	        		  loginBtn = '로그인 가능';
	        	  } else loginBtn = '로그인 불가능'; 
		 	           return '<button id="btn" onclick="changeBtn(this, ' + '\'' + data.member_id + '\'' + ', ' + '\'' + data.permit + '\'' + ');">'+loginBtn+'</button>';// 이 부분이 실제로 표현됨
		 	            }
		 	          }
	    ]
	});
})

</script>
</html>