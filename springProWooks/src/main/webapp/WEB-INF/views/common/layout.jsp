<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("utf-8");
%> --%>

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>나무늘보 서점</title>
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<link href= "<c:url value='/resources/css/basic-jquery-slider.css'/>" rel="stylesheet" type="text/css" media="screen">  
<script src="/resources/jquery/jquery-1.6.2.min.js" type="text/javascript"></script>
<script src="/resources/jquery/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="/resources/jquery/stickysidebar.jquery.js" type="text/javascript"></script>
<script src="/resources/jquery/basic-jquery-slider.js" type="text/javascript"></script>
<script src="/resources/jquery/tabs.js" type="text/javascript"></script>
<script src="/resources/jquery/carousel.js" type="text/javascript"></script>  
<link href="<c:url value='/resources/css/styles.css'/> " rel="stylesheet" />
<link href="<c:url value='/resources/css/main.css'/> " rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>


<title><tiles:insertAttribute name="title" /></title>
	
</head>
<body>
	
		<div id="wrap">
			<div id="headerYW">
				   <tiles:insertAttribute name="header" />
			</div>
			<div id="mainYW">
			<div id="asideYW">
				 <tiles:insertAttribute name="side" />
			</div>
			<div id="articleYW">
			 	<tiles:insertAttribute name="body" />
			</div>
			</div>
			<div id="footerYW">
        		<tiles:insertAttribute name="footer" />
        	</div>
		<%-- </div>
		 <tiles:insertAttribute name="quickMenu" />
    </div>  --%>  
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="<c:url value='/resources/js/scripts.js'/> "></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src= "<c:url value='/resources/js/assets/demo/chart-area-demo.js'/>"></script>
        <script src="<c:url value='/resources/js/assets/demo/chart-bar-demo.js'/>" ></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="<c:url value='/resources/js/datatables-simple-demo.js'/> "></script>  	
</body>      
        
        