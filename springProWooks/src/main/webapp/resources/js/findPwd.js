var code = "";
let findButton = document.querySelector(".find-btn");
findButton.onclick = () => {
	if( inputCode == code ){
		id_search();
	} else {
		result_id.innerHTML = "인증번호를 다시 입력해주세요."
	}
	
}
let keySend = document.querySelector("#keySend");
keySend.onclick = (e) => {
	e.preventDefault();
	mailKey();
}
let ketCheck = document.querySelector("#keyCheck");
ketCheck.onclick = (e) => {
	e.preventDefault();
	onCheck();
}
let mailCheck = document.querySelector(".mail_check_input")
let name1 = document.querySelector('#name1');
let id = document.querySelector("#id");
let email1 = document.querySelector('#email1');
let email2 = document.querySelector('#email2');
let inputCode = mailCheck.value; 

function onCheck(){
		
		           
		 var checkResult = document.getElementById("mail_check_input_box_warn");
		 if(inputCode == code && inputCode!==""){                            
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
				if(email1.value === ""){
					alert("이메일을 입력해주세요.")
					return;
				}
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

function id_search() { 
	 	var fp = document.findPwd;
		 if (fp.id.value === "") {
			  alert("아이디를 입력해주세요.");
			  return;
		 }
		 if (fp.name1.value === "") {
			  alert("이름을 입력해주세요.");
			  return;
		 }
		 if (fp.email1.value === "") {
			  alert("이메일을 입력해주세요.");
			  return;
		 }
		 if (fp.email2.value === "") {
			  alert("이메일을 입력해주세요.");
			  return;
		 }
		 if (fp.inputCode === "") {
			  alert("이메일 인증을 해주세요.");
			  return;
		 }

		let param = {
				"name" : name1.value,
				"email1" : email1.value,
				"email2" : email2.value
			};
			
			fetch('/member/findPwd.do', {
				//option
				method : 'POST',
				headers: {
				    'Content-Type': 'application/json;charset=utf-8'
				},
				body: JSON.stringify(param)	
			})
			.then(response => response.json())
			.then(jsonResult => {
				//처리후 메시지 출력
				var result_id = document.querySelector("#result_Id");
				if (jsonResult.status == true) {
					result_id.innerHTML = jsonResult.message;
				} else {
					result_id.innerHTML = jsonResult.message;
				}
			});
	 }
	 

  
  
	 
	 
	 
	 
	 