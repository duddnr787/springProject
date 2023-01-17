<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>">
  
</head>

<body>
  <div class="logout-form" >
  	<h1>아이디 찾기</h1>
    <form action="/member/findPwd.do" id="logout" name="findPwd" method="post">
      <input type="text" class="text-field" name="name1" placeholder="이름" id="name1">
      <input type="text"  name="email" placeholder="이메일" id="email1" class="email">@
      <input type="text"  name="email" placeholder="이메일" id="email2" class="email">
      <input type="button" value="찾기" class="find-btn">
      <input type="button" value="취소" class="submit-btn"  onClick="history.back()">
      <br/>
      <div id="result_Id"></div>
  </form>
  </div>
 <script src="<c:url value='/resources/js/findId.js'/>"></script> 
</body>
</html>