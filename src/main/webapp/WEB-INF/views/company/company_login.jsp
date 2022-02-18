<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- company_login.jsp -->
<%@ include file ="company_top.jsp" %>
<div align="center">
<script type="text/javascript">
	<!--모드 보내주기 --> 
	function searchCompany(mode){
		location.href = "company_search?mode=" + mode
	}
	function checkLogin() {
		if(f_companyLogin.c_email.value=="") {
			alert("이메일을 입력해주세요.")
			f_login.c_email.focus()
			return
		}
		if(f_companyLogin.c_password.value=="") {
			alert("비밀번호를 입력해주세요.")
			f_login.c_password.focus()
			return
		}
		document.f_companyLogin.submit()
	}
</script>
<form name="f_companyLogin" method="POST" action="company_login_ok">
	<h3>기업 로그인</h3>
	<table width="280" align="center">
		<tr>
			<!-- 쿠키에 담아서 아이디 기억하기  -->
			<td colspan="2">
				<c:if test = "${empty cookie.saveEmail.value}">
				<input type="text" name="c_email" placeholder="이메일을 입력해 주세요." tabindex="1" 
				style="width:350px;height:50px" onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9@.,'');">
				</c:if>
				<c:if test = "${not empty cookie.saveEmail.value}">
				<input type="text" name="c_email" value="${cookie.saveEmail.value}" 
				placeholder="이메일을 입력해 주세요." tabindex="1" 
				style="width:350px;height:50px" onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9@.]/g,'');">
				</c:if>
			</td> 
		</tr>
		<tr>
			<td colspan="2">
				<input type="password" name="c_password" placeholder="비밀번호를 입력해 주세요." tabindex="2" 
				style="width:350px;height:50px">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="button" name="companyLogin" onclick="checkLogin()"
				style="width:350px;height:50px;background-color:black;
				color:white;border-color:black">로그인</button>
			</td>
		</tr>
		<tr>
			<td>
			<c:if test="${empty cookie.saveEmail.value}">
				<input type="checkbox" name="saveEmail">
			</c:if>
			<c:if test="${not empty cookie.saveEmail.value}">
				<input type="checkbox" name="saveEmail" checked>
			</c:if>	
				<font face="굴림" size="2">이메일 기억하기</font>
			</td>
			<td align="right">
				<a href="javascript:searchCompany('c_email')">이메일 찾기</a>
				<a href="javascript:searchCompany('c_password')">비밀번호 찾기</a>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<b>아직 회원이 아니신가요?</b>&nbsp;&nbsp;&nbsp;
				<button type="button" name="companyRegister" onclick="location.href='company_ssn'" 
				style="width:80px;height:35px;background-color:black;
				color:white;border-color:black">회원 가입</button>
			</td>
		</tr>
	</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>