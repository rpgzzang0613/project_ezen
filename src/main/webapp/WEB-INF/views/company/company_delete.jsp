<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="company_myPage.jsp" %>
<script>
//비밀번호 확인후 삭제 
function check2(){
	if (f_companyDelete.raw_password.value != f_companyDelete.raw_password2.value ){
			alert("비밀번호를 동일하게 입력해주세요.")
			f_companyDelete.raw_password2.focus()
			return false
	} 
	if (f_companyDelete.raw_password.value == "" && f_companyDelete.raw_password2.value == ""){
			alert("공백 금지")
			f_companyDelete.raw_password2.focus()
			return false 
	}
	return true
}
</script>
<!-- cnum 값 넘겨줘서 아이디 삭제  -->
<form name="f_companyDelete" method="post" action="company_delete_ok" onsubmit="return check2()">
	<input type="hidden" name="c_num" value="${companyLoginOkBean.c_num}">
	<table align="center" align="top">
		<caption style="line-height: 60px; font-size:25px;"><b>회원탈퇴</b></caption>
		<tr>
			<td colspan="2">회원 탈퇴를 위해 비밀번호를 입력해 주세요.</td>
		</tr>
		<tr>
			<td style="width: 120px;">비밀번호</td>
			<td><input type="password" name="raw_password" placeholder="비밀번호를 입력해주세요." required></td>
		</tr>
		<tr>
			<td style="width: 120px;">비밀번호 확인</td>
			<td><input type="password" name="raw_password2" placeholder="비밀번호를 다시 입력해주세요." required></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" name="companydelete" value="회원탈퇴" 
				style="width:150px;height:50px;background-color:black;color:white;border-color:black">  
			</td> 
		</tr>
	</table>
</form>
