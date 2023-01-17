<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <c:set var="contextPath"  value="${pageContext.request.contextPath}" /> --%>

<script type="text/javascript">
	var loopSearch=true;
	function keywordSearch() {
		if(loopSearch==false)
			return;
		var value = document.getElementById('search').value;
		fetch('/goods/keywordSearch.do', {
			//option
			method : 'POST',
			headers: {
			    'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"keyword" : value
				})			
		})
		.then(response => response.json())
		.then(jsonResult => {
			displayResult(jsonResult);
		});
		}
	
	function displayResult(jsonInfo){
		
		if(jsonInfo.keyword != '') {
		    var html = '';
		    for(var i in jsonInfo.keyword){
			   html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
		    }
		    var listView = document.getElementById("suggestList");
		    listView.innerHTML = html;
		    show('suggest');
		}else{
		    hide('suggest');
		} 
	}
	
	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword;
		 loopSearch = false;
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}

	/* function goodslist() {
		fetch('/admin/goodsList.do', {
			//option
			method : 'GET',
			headers: {
			    'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify(param)
		.then(response => response.json({
			
		}))
		}
		.then(jsonResult => {
			location.href = jsonResult.url;
		});
		} */
	
</script>

 <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="/homeForm.do"> : : : 나무늘보 서점 : : :</a>
            <!-- Sidebar Toggle-->

            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
          
            <form id="formsearch" name="frmSearch" class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0" action="/goods/searchGoods.do" >
                <div class="input-group">
                    <input id="search" class="form-control" type="text" placeholder="원하는 책을 검색해보세요 !" aria-label="Search for..." name="searchWord" aria-describedby="btnNavbarSearch" onKeyUp="keywordSearch()"/>
                    <button class="btn btn-primary" id="btnNavbarSearch" type="submit"><i class="fas fa-search"></i></button>
                </div>
                <div id="suggest">
       				<div id="suggestList"></div>
   				</div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                      <!--   <li><a class="dropdown-item" href="#!">Settings</a></li> -->
                      	<c:choose>
                      	<c:when test="${isLogOn==true and not empty memberInfo and memberInfo.member_id != 'admin'}">
                      	<li><a class="dropdown-item" href="<c:url value='/mypage/memberInfo.do'/>">${memberInfo.member_id}님 정보</a></li>
                      	<li><hr class="dropdown-divider" /></li>
                      	<li><a class="dropdown-item" href="<c:url value='/mypage/mypageForm.do'/>">마이페이지</a></li> 
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="<c:url value='/cart/myCartListForm.do'/>">장바구니</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="<c:url value='/member/deleteMemberForm.do'/>">회원탈퇴</a></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="/member/logout.do">로그아웃</a></li>
                        </c:when>
                      	<c:when test="${isLogOn==true and not empty memberInfo and memberInfo.member_id == 'admin'}">
                      	<li><a class="dropdown-item" href="/mypage/memberInfo.do"> 관리자님 정보 </a></li>
                      	<li><hr class="dropdown-divider" /></li>
                      	<li><a class="dropdown-item" href="<c:url value='/admin/goodsForm.do'/>">상품등록</a></li> 
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="<c:url value='/admin/goodsListForm.do'/>">상품목록</a></li> 
                        <li><hr class="dropdown-divider" /></li>
                      	<li><a class="dropdown-item" href="<c:url value='/admin/memberListForm.do'/>">회원관리</a></li> 
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="/member/logout.do">로그아웃</a></li>
                      	</c:when>
                      	<c:when test="${empty memberInfo }">
                     	<li><a class="dropdown-item" href="<c:url value='/member/loginForm.do'/>">로그인</a></li> 
                        <li><hr class="dropdown-divider" /></li>
                        <li><a class="dropdown-item" href="/member/memberForm.do">회원가입</a></li>
                        </c:when>
                       </c:choose>
                    </ul>
                </li>
            </ul>
        </nav>
</html>