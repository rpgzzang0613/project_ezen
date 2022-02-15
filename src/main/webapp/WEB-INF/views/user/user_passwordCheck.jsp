<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_myPage.jsp" %>

<form name="f_userpassword_edit" method="Post" action="user_password_edit_ok">
<input type="hidden" name="u_email" value="${loginOkBean.u_email}">
	<br><h2>비밀번호 변경</h2>
	<table>
		<tr>
			<td align="center" style="width: 120px;height:50px;">현재 비밀번호</td>
			<td>
				<input style="width:180px;" type="password" name="raw_pre_password" placeholder="현재 비밀번호를 입력" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput = "setCustomValidity('')">
			</td>
		</tr>
		<tr>
			<td align="center" style="width: 120px;height:50px;">새 비밀번호</td>
			<td>
				<input style="width:180px;" type="password" name="raw_new_password" placeholder="새 비밀번호를 입력" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput = "setCustomValidity('')">
			</td>
		</tr>
		<tr>
			<td align="center" style="width: 120px;height:50px;">새 배밀번호<br>다시 입력</td>
			<td>
				<input style="width:180px;" type="password" name="raw_new_password2" placeholder="새 비밀번호를 다시 입력" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput = "setCustomValidity('')">
			</td>
		</tr>
		<tr style="height: 50px;">
		</tr>
		<tr> 
			<td colspan="2" align="center">
			<input type="button" value="확인" 
					style="height: 40px;
				    width: 150px;
				    border: 0;
				    border-radius: 3px;
				    background: #edf2ff;"
				    onclick = "check()" 
			    /> 
			</td> 
		</tr>
	</table>
</form> 
 
<script>
function check(){
	if (f_userpassword_edit.raw_new_password.value != f_userpassword_edit.raw_new_password2.value){
			alert("비밀번호를 동일하게 입력해주세요.")
			f_userpassword_edit.raw_new_password2.focus()
			return
		}
	  
	document.f_userpassword_edit.submit()
}
</script>