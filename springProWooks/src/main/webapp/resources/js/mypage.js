window.onload =()=>{
	
let pwd = document.querySelector('#pwd-edit');
let name1 = document.querySelector('#name1-edit');
let phone = document.querySelector('#phone-edit');
let email1 = document.querySelector('#email1');
let email2 = document.querySelector('#email2');

let edit = document.querySelector('.submit-edit');
edit.onclick = () => {
	Edit ()
};
function Edit () {
			let param = {
				"pwd" : pwd.value,
				"name1" : name1.value,
				"phone" : phone.value,
				"email1" : email1.value,
				"email2" : email2.value
			};	
			fetch('/member/editUser.do', {
				//option
				method : 'POST',
				headers: {
				    'Content-Type': 'application/json;charset=utf-8'
				},
				body: JSON.stringify(param)
			})
			.then(response => response.json())
			.then(jsonResult => {
				alert(jsonResult.message);
			});
		}
		
		
let userPwd = document.querySelector('#pwd-delete');
let deleteUser = document.querySelector('.delete-user');
deleteUser.onclick = () => {
	Delete()
};
	async function Delete () {
		let param = {
			"userPwd" : userPwd.value
		};
		
		const response = await fetch('/member/deleteUser.do', {
			//option
			method : 'POST',
			headers: {
			    'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify(param)//{"uid":"user10","pwd":"123", "name":"홍길동"}			
		});
		const json = await response.json();
		if (json.status) {
			confirm(json.message);	
			alert(json.message1);
			location.href = json.url;
		} else {
			alert(json.message);
		}
	}
	
}