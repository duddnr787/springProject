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
  	<h1>비밀번호찾기</h1>
    <form action="/member/findPwd.do" id="logout" name="findPwd" method="post">
      <input type="text" class="text-field" name="id" placeholder="아이디" id="id">
      <input type="text" class="text-field" name="name1" placeholder="이름" id="name1">
      <input type="text"  name="email" placeholder="이메일" id="email1" class="email">@
      <input type="text"  name="email" placeholder="이메일" id="email2" class="email">
      <button class="mail_check_button" id="keySend">
			<span>인증번호 전송</span>
		</button>
	  <div class="mail_check_input_box" id="mail_check_input_box_false">
		<input class="mail_check_input" disabled="disabled" id="mail_check_input" >
	  </div>
          <span id="mail_check_input_box_warn"></span>
		<br><br>
		<button class="mail_check_button" id="keyCheck">
			<span>인증번호 확인</span>
		</button>
      <input type="button" value="찾기" class="find-btn">
      <input type="button" value="뒤로가기" class="submit-btn"  onClick="history.back()">
      <br/>
      <div id="result_id"></div>
  </form>
  </div>
 <script src="<c:url value='/resources/js/findPwd.js'/>"></script> 
</body>
</html>