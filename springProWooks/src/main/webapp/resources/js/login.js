let id = document.getElementById('id');
let pwd = document.getElementById('pwd');

let login = document.querySelector("#login");
login.onclick = (e) => {
	login1(e);
	
}

 function login1(e) {
	e.preventDefault();
	let param = {
				"id" : id.value,
				"pwd" : pwd.value
			};
			fetch("/member/login.do", {
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
				
				if (jsonResult.status == '1' || jsonResult.status == '2') {
					//성공시 이동할 페이지로 이동한다  
					alert(jsonResult.message);
					location.href = jsonResult.url;
				} else {
					alert(jsonResult.message);
				}
			});
	return false;
}
