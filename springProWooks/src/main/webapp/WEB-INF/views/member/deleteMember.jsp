<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/resources/css/mypage.css'/>">
<script>

function ondelete(){
	 	if(pwd.value === ''){
	 		alert("비밀번호를 입력해주세요.");
	 		return;
	 	}
		let param = {
					"pwd" : pwd.value
					
				};
				fetch("/member/deleteUser.do", {
					//option
					method : 'POST',
					headers: {
					    'Content-Type': 'application/json;charset=utf-8'
					},
					body: JSON.stringify(param)		
				})
				.then(response => response.json())
				.then(jsonResult => {
					if(jsonResult.status == true){
						alert(jsonResult.message);
						location.href = jsonResult.url;
					} else {
						alert(jsonResult.message);
					}
				});
	}
</script>
</head>
<body>	
	<h2 id="h2">나무늘보 서점 회원 탈퇴</h2>
	<div id="member_id">${memberInfo.member_id}님</div>
	<div class="userResult" id="user-delete">
		<input type="password" class="text-pwd" name="pwdDelete" placeholder="비밀번호를 입력해주세요." id="pwd">
		<br><br>
      <input type="button" value="회원탈퇴" class="delete-user" onclick="ondelete()"/>
      </div>
</body>
</html>