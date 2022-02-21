<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>Insert nonUserInfo</title>
	</head>
<script>
	function checkLogin() {
		if(f_nonLogin.tempUser_name.value=="") {
			alert("예약자 성함을 입력해주세요.")
			f_nonLogin.tempUser_name.focus()
			return
		}
		if(f_nonLogin.tempUser_tel.value=="") {
			alert("핸드폰번호를 입력해주세요.")
			f_nonLogin.tempUser_tel.focus()
			return
		}
		document.f_nonLogin.submit()
	}
</script>
<body>
	<form name="f_nonLogin" method="POST" action="returnToRoomContent">
	<h3>비회원 예약 확인</h3>
	<table>
		<tr>
			<td colspan="2">
				<input type="text" name="tempUser_name" placeholder="예약자 성함을 입력해 주세요." tabindex="1" 
				style="width:350px;height:50px">
			</td> 
		</tr>
		<tr>
			<td colspan="2">
				<input type="text" name="tempUser_tel" placeholder="핸드폰번호를 입력해 주세요." tabindex="1" 
				style="width:350px;height:50px">
			</td> 
		</tr>
		<tr>
			<td colspan="2">
				<button type="button" name="userLogin" onclick="checkLogin()" 
				style="width:350px;height:50px;background-color:black;color:white;border-color:black">입력한 정보로 진행하기</button>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>
	</form>
</body>
</html>