<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- user_search_password_ok.jsp -->
<%@ include file="../user_top.jsp"%>
<script type="text/javascript">
function pwCheck() {
	if(f_update_password.raw_password.value=="") {
		alert("비밀번호를 입력해주세요.")
		f_update_password.raw_password.focus()
		return
	}
	if(f_update_password.raw_password2.value=="") {
		alert("비밀번호를 입력해주세요.")
		f_update_password.raw_password2.focus()
		return
	}
	if(f_update_password.raw_password.value != f_update_password.raw_password2.value) {
		alert("비밀번호를 동일하게 입력해 주세요.")
		return
	}
	document.f_update_password.submit()
}
</script>
<div align="center">
<form name="f_update_password" method="POST" action="user_update_password_ok">
<input type="hidden" name="u_email" value="${param.u_email}" >
<table border="0" width="280" align="center">
	<tr>
		<td colspan="2" align="center"><h3>새 비밀번호 설정</h3></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="password" name="raw_password" placeholder="새 비밀번호를 입력해 주세요." tabindex="1" style="width:350px;height:50px">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="password" name="raw_password2" placeholder="새 비밀번호를 한 번 더 입력해 주세요." tabindex="2" style="width:350px;height:50px">
		</td>
	</tr>
	<tr>
		<td>
			<button type="button" onclick="pwCheck()"
			style="width:175px;height:50px;background-color:black;color:white;border-color:black">비밀번호 설정</button>
		</td>
		<td>
			<button type="button" onclick="location.href='user_login'" 
			style="width:175px;height:50px;background-color:black;color:white;border-color:black">취소</button>
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>