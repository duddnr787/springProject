<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
 <link rel="stylesheet" href="<c:url value='/resources/css/signUp.css'/>">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
var code = "";  

function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;
     
      autoClose: true;

    }
  }).open();
}

function fn_overlapped(){
    var _id=$("#_member_id").val();
    if(_id==''){
   	 alert("ID를 입력하세요");
   	 return;
    }
    $.ajax({
       type:"post",
       async:false,  
       url:"${contextPath}/member/overlapped.do",
       dataType:"text",
       data: {id:_id},
       success:function (data,textStatus){
          if(data=='false'){
       	    alert("사용할 수 있는 ID입니다.");
       	    $('#btnOverlapped').prop("disabled", true);
       	    $('#_member_id').prop("disabled", true);
       	    $('#member_id').val(_id);
          }else{
        	  alert("사용할 수 없는 ID입니다.");
          }
       },
       error:function(data,textStatus){
          alert("에러가 발생했습니다.");ㅣ
       },
       complete:function(data,textStatus){
          //alert("작업을완료 했습니다");
       }
    });  //end ajax	 
 }	
 
	

	
	function onCheck(){
		
		 var inputCode = mail_check_input.value;           
		 var checkResult = document.getElementById("mail_check_input_box_warn");
		 if(inputCode == code){                            
		        checkResult.innerHTML = "인증번호가 일치합니다." ;
		        checkResult.setAttribute("class", "correct");        
		    } else {                                           
		        checkResult.innerHTML = "인증번호를 다시 확인해주세요.";
		        checkResult.setAttribute("class", "incorrect");
		    }    
		 
	}

	 function mailKey() {
		var checkBox = document.getElementById("mail_check_input");
		var boxWrap = document.querySelector(".mail_check_input_box");
		let param = {
					"email1" : email1.value,
					"email2" : email2.value
				};
		alert(email1.value+"@"+email2.value+"에 인증번호를 보냈습니다.");
				fetch("/mail/mailCheck.do", {
					//option
					method : 'POST',
					headers: {
					    'Content-Type': 'application/json;charset=utf-8'
					},
					body: JSON.stringify(param)		
				})
				.then(response => response.json())
				.then(jsonResult => {
					
					//console.log(jsonResult.key);
					checkBox.removeAttribute("disabled");
					boxWrap.setAttribute("id", "mail_check_input_box_true");
					code = jsonResult.key;
				});
	}
	 function register() {
		 let sex= document.querySelector('input[name="member_gender"]:checked');
		 let member_birth_gn = document.querySelector('input[name="member_birth_gn"]:checked');
			let param = {
						"gender" : sex.value,
						"member_birth_gn" : member_birth_gn.value,
						"id" : _member_id.value,
						"pwd" : member_pwd.value,
						"name" : name1.value,
						"member_birth_y" : member_birth_y.value,
						"member_birth_m" : member_birth_m.value,
						"member_birth_d" : member_birth_d.value,
						"tel1" : tel1.value,
						"tel2" : tel2.value,
						"tel3" : tel3.value,
						"hp1" : hp1.value,
						"hp2" : hp2.value,
						"hp3" : hp3.value,
						"email1" : email1.value,
						"email2" : email2.value,
						"zipcode" : zipcode.value,
						"roadAddress" : roadAddress.value,
						"jibunAddress" : jibunAddress.value,
						"namujiAddress" : namujiAddress.value
					};
					fetch("/member/addMember.do", {
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
	<h3>나무늘보 서점 회원가입</h3>
	<form action="/member/addMember.do" method="post" onsubmit="return false;">	
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
					  <input type="text" name="_member_id"  id="_member_id"  size="20" />
					  <input type="hidden" name="member_id"  id="member_id" />
					  
					  <input type="button" class="btn"  id="btnOverlapped" value="중복체크" onClick="fn_overlapped()" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td><input name="member_pw" type="password" size="20" id="member_pwd"/></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td><input name="member_name" type="text" size="20" id="name1"/></td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">성별</td>
					<td><input type="radio" name="member_gender" value="102" />
						여성<span style="padding-left:120px"></span>
						 <input type="radio" name="member_gender" value="101" checked />남성
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">법정생년월일</td>
					<td>
					<select name="member_birth_y" id="member_birth_y">
					     <c:forEach var="year" begin="1" end="100">
					       <c:choose>
					         <c:when test="${year==80}">
							   <option value="${ 1920+year}" selected>${ 1920+year} </option>
							</c:when>
							<c:otherwise>
							  <option value="${ 1920+year}" >${ 1920+year} </option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach> 
							
					</select>년 
					 <select name="member_birth_m" id="member_birth_m" >
					   <c:forEach var="month" begin="1" end="12">
					       <c:choose>
					         <c:when test="${month==5 }">
							   <option value="${month }" selected>${month }</option>
							</c:when>
							<c:otherwise>
							  <option value="${month }">${month}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>월  
					<select name="member_birth_d" id="member_birth_d">
							<c:forEach var="day" begin="1" end="31">
					       <c:choose>
					         <c:when test="${day==10 }">
							   <option value="${day}" selected>${day}</option>
							</c:when>
							<c:otherwise>
							  <option value="${day}">${day}</option>
							</c:otherwise>
							</c:choose>
					   	</c:forEach>
					</select>일 <span style="padding-left:50px"></span>
					  <input type="radio" name="member_birth_gn" value="2" checked />양력
						 <span style="padding-left:50px"></span>
						<input type="radio"  name="member_birth_gn" value="1" />음력
				  </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">전화번호</td>
					<td><select  name="tel1" id="tel1">
							<option>없음</option>
							<option value="02">02</option>
							<option value="031">031</option>
							<option value="032">032</option>
							<option value="033">033</option>
							<option value="041">041</option>
							<option value="042">042</option>
							<option value="043">043</option>
							<option value="044">044</option>
							<option value="051">051</option>
							<option value="052">052</option>
							<option value="053">053</option>
							<option value="054">054</option>
							<option value="055">055</option>
							<option value="061">061</option>
							<option value="062">062</option>
							<option value="063">063</option>
							<option value="064">064</option>
							<option value="0502">0502</option>
							<option value="0503">0503</option>
							<option value="0505">0505</option>
							<option value="0506">0506</option>
							<option value="0507">0507</option>
							<option value="0508">0508</option>
							<option value="070">070</option>
					   </select> - <input  size="10px" type="text" name="tel2" id="tel2"> - <input size="10px"  type="text" name="tel3" id="tel3">
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td><select  name="hp1" id="hp1">
							<option>없음</option>
							<option selected value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
					</select> - <input size="10px"  type="text" name="hp2" id="hp2"> - <input size="10px"  type="text"name="hp3" id="hp3"><br> <br> 
					<input type="checkbox"	name="smssts_yn" value="Y" checked /> 쇼핑몰에서 발송하는 SMS 소식을 수신합니다.</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					
					<td><input size="10px" type="text" name="email1" id="email1"/> @ <input  size="10px"  type="text" name="email2" id="email2" />
					<br><br>
							<div id="checkKey">
							<div class="mail_check_wrap">
								<div class="mail_check_input_box" id="mail_check_input_box_false">
									<input class="mail_check_input" disabled="disabled" id="mail_check_input" >
								</div>
                    			<span id="mail_check_input_box_warn"></span>
								<br><br>
								<button class="mail_check_button" id="keySend" onclick="mailKey()">
									<span>인증번호 전송</span>
								</button>
								<button class="mail_check_button" id="keyCheck" onclick="onCheck()" >
									<span>인증번호 확인</span>
								</button>
								
							</div>
							</div>
							</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					   <input type="text" id="zipcode" name="zipcode" size="10"  > <button class="btn" onclick="javascript:execDaumPostcode()"> 우편번호검색</button>
					 <br><br>
					  <div> 
					   <input type="text" id="roadAddress"  name="roadAddress" size="50" placeholder="지번 주소" readonly="readonly" ><br><br>
					   <input type="text" id="jibunAddress" name="jibunAddress" size="50" placeholder="도로명 주소" readonly="readonly"><br><br>
					   <input type="text" id="namujiAddress" name="namujiAddress" size="50" placeholder="나머지 주소"  />
					 <!--   <span id="guide" style="color:#999"></span> -->
					   </div>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
		<div class="clear">
		<br><br>
	<div class="box_buttons">
        <input type="submit" id="insertButton" class="button_submit" value="회원가입" onclick="register()">
        <input type="reset"  class="button_cancel" onClick="location.href='${contextPath}/member/loginForm.do'" value="취소">
    </div>
	</div>
</form>	
    

</body>
</html>