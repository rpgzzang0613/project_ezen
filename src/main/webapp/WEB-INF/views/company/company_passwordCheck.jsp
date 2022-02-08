<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="company_myPage.jsp" %>
<form name="f_companypassword_edit" method="Post" action="company_password_edit_ok">
<input type="hidden" name="c_email" value="${companyLoginOkBean.c_email}">
	<table align="center" align="top" border="0">
		<caption style="line-height: 60px; font-size:25px;"><b>비밀번호 변경</b></caption>
		<tr>
			<td style="width: 120px;">현재 비밀번호</td>
			<td>
				<input style="width:180px;" type="password" name="raw_pre_password" placeholder="현재 비밀번호를 입력" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput = "setCustomValidity('')">
			</td>
		</tr>
		<tr>
			<td style="width: 120px;">새 비밀번호</td>
			<td>
				<input style="width:180px;" type="password" name="raw_new_password" placeholder="새 비밀번호를 입력" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput = "setCustomValidity('')">
			</td>
		</tr>
		<tr>
			<td style="width: 120px;">새 비밀번호2</td>
			<td>
				<input style="width:180px;" type="password" 
				name="raw_new_password2" placeholder="새 비밀번호를 다시 입력" 
				required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" 
				oninput = "setCustomValidity('')">
			</td>
		</tr>
		<tr> 
			<td colspan="2" align="center">
				<input type="button" value="확인" 
						style="height: 40px;
					    width: 200px;
					    border: 0;
					    border-radius: 3px;
					    background: #edf2ff;"
					    onclick = "check()"/> 
			</td> 
		</tr>
	</table>
</form> 
 
<script>
function check(){
	if (f_companypassword_edit.raw_new_password.value != f_companypassword_edit.raw_new_password2.value){
			alert("비밀번호를 동일하게 입력해주세요.")
			f_companypassword_edit.raw_new_password2.focus()
			return
		}
	  
	document.f_companypassword_edit.submit()
}
</script>