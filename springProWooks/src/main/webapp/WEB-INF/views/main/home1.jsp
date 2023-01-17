<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>나무늘보 서점</title>
<link href="<c:url value='/resources/css/town.css'/> " rel="stylesheet" />
</head>

<body>
  <h1><a href="/homeForm.do">나무늘보 서점(클릭..)</a></h1>

  <section>
    <article class="sky">
      <img src="/resources/image/나무늘보1.png" alt="" class="sun">
      <img src="img/cloud1.png" alt="" class="cloud1">
      <img src="img/cloud2.png" alt="" class="cloud2">
    </article>
    <article class="town">

      <img src="/resources/image/circle.png" alt="" class="circle">
      <img src="/resources/image/town_night.png" alt="" class="night">
      <img src="/resources/image/town_day.png" alt="" class="day">

    </article>
    <article class="people">
      <img src="/resources/image/family.png" alt="" class="family">
      <img src="/resources/image/man.png" alt="" class="man">
    </article>
  </section>
  
</body>
</html>