
let findButton = document.querySelector(".find-btn");
findButton.onclick = () => {
	id_search();
}

let name1 = document.querySelector('#name1');

let email1 = document.querySelector('#email1');
let email2 = document.querySelector('#email2');


function id_search() { 
	 	var fp = document.findPwd;

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

		let param = {
				"name" : name1.value,
				"email1" : email1.value,
				"email2" : email2.value
			};
			
			fetch('/member/findId.do', {
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
	 
	
	 
	 
	 
	 