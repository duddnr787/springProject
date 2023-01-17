<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>">
</head>
<body>
<div class="login-form">
        <h1><a href="/" >나무늘보 서점</a></h1>
        <form action="/member/login.do" method="post">
            <input type="text" class="text-field" name="member_id" placeholder="아이디" id="id">
            <input type="password" class="text-field" name="member_pwd" placeholder="비밀번호" id="pwd">
            <input type="submit" value="로그인" class="submit-btn" id="login">
        </form>
        <div class="links">
            <a href="<c:url value='/member/memberForm.do'/>">회원가입을 하시겠습니까 ?</a>
            <br>
            <br>
            <a href="<c:url value='/member/findIdForm.do'/>">아이디를 까먹었습니까 ?</a>
            <div>---------------</div>
            <a href="<c:url value='/member/findPwdForm.do'/>">비밀번호를 까먹었습니까 ?</a>
        </div>
    </div>
    <script src="<c:url value='/resources/js/login.js'/>"></script> 
</body>
</html>