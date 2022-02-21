<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
	<head>
		<title>NonUserInfoCheck</title>
<script>
	function checkInfo() {
		if(nonUserInfo.tempUser_name.value=="") {
			alert("예약자 성함을 입력해주세요.")
			nonUserInfo.tempUser_name.focus()
			return
		}
		if(nonUserInfo.tempUser_tel.value=="") {
			alert("핸드폰번호를 입력해주세요.")
			nonUserInfo.tempUser_tel.focus()
			return
		}
		if(nonUserInfo.tempUser_bookNum.value=="") {
			alert("예약번호를 입력해주세요.")
			nonUserInfo.tempUser_bookNum.focus()
			return
		}
		document.nonUserInfo.submit()
	}
</script>
	</head>
	<body>
		<form name="nonUserInfo" method="POST" action="nonUserBookDetail">
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
						<input type="text" name="tempUser_bookNum" placeholder="예약번호를 입력해 주세요." tabindex="1" 
						style="width:350px;height:50px">
					</td> 
				</tr>
				<tr>
					<td colspan="2">
						<button type="button" name="userLogin" onclick="checkInfo()" 
						style="width:350px;height:50px;background-color:black;color:white;border-color:black">예약내용 확인하기</button>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
			</table>
		</form>
	</body>
</html>