<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>loginAsk</title>
	</head>
<script type="text/javascript">
	function goToLogin() {
		if(loginAsk.u_email.value=="") {
			alert("이메일을 입력해주세요.")
			loginAsk.u_email.focus()
			return
		}
		if(loginAsk.u_password.value=="") {
			alert("비밀번호를 입력해주세요.")
			loginAsk.u_password.focus()
			return
		}
		document.loginAsk.submit()
	}
</script>
<body>
	<form name="loginAsk" method="post" action="user_login_ok_popup">
		<table>
			<tr>
				<!-- cookie로 아이디 기억하기 -->
				<td colspan="2">
					<c:if test = "${empty cookie.saveEmail.value}">
					<input type="text" name="u_email" placeholder="이메일을 입력해 주세요." tabindex="1" 
					style="width:350px;height:50px">
					</c:if>
					
					<c:if test = "${not empty cookie.saveEmail.value}">
					<input type="text" name="u_email" value= "${cookie.saveEmail.value}" placeholder="이메일을 입력해 주세요." tabindex="1" 
					style="width:350px;height:50px">
					</c:if>
				</td> 
			</tr>
			<tr>
				<td colspan="2">
					<input type="password" name="u_password" placeholder="비밀번호를 입력해 주세요." tabindex="2" 
					style="width:350px;height:50px">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="button" name="userAsk" onclick="goToLogin()" 
					style="width:350px;height:50px;background-color:black;color:white;border-color:black">로그인</button>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="saveEmail">이메일 기억
				</td>
				<td align="right">
					<!-- script에서 사용할 (mode)값 넘겨주기  -->
					<a href="javascript:searchUser('u_email')">이메일 찾기</a> | 
					<a href="javascript:searchUser('u_password')">비밀번호 찾기</a>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<b>비회원으로 계속하기</b>&nbsp;&nbsp;&nbsp;
					<button type="button" name="userJoin" onclick="location.href='nonUserInfo'" 
					style="width:80px;height:35px;background-color:black;color:white;border-color:black">진행</button>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
</body>
</html>