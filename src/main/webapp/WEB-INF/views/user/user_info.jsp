<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="user_myPage.jsp" %>
	<br>
	<h2>내 정보 관리</h2>
<table height="30%">
	<tr height="20%"> 
		<td align="center" class="box" style="background-color:#bbdefb;">이메일(ID)</td>  
		<td align="center" class="box">${loginOkBean.u_email}</td>
	</tr> 
	<tr height="20%">
		<td align="center" class="box" style="background-color:#bbdefb;">이름</td> 
		<td align="center" class="box">${loginOkBean.u_name}</td>
	</tr>
	<tr height="20%">
		<td align="center" class="box" style="background-color:#bbdefb;">닉네임</td> 
		<td align="center" class="box"><form class="form-box" name="info" method="post" action="user_nickChange">
				<input class="input-box" type="text" name="nickname" value="${loginOkBean.u_nickname}">
				<input class="input-button" type="submit" value="수정">
			</form>
		</td>
	</tr>
	<tr height="20%">
		<td align="center" class="box" style="background-color:#bbdefb;">휴대폰 번호</td>
		<td align="center" class="box"><form class="form-box" style="margin-top:-41px;" name="tel" method="post" action="user_telChange">
				<br><input class="input-box" type="text" name="u_tel" value="${loginOkBean.u_tel}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				<input class="input-button" type="submit" value="수정">   
			</form> 
		</td> 
	</tr>
	<tr height="20%">
		<td align="center" class="box" style="background-color:#bbdefb;">생년 월일</td>
		<td align="center" class="box">${loginOkBean.u_birth}</td>
	</tr>
</table>
<%@ include file="../bottom.jsp" %>
<style>
.box{
border: 1px solid #444444;
}
.form-box{
    height: 100%;
    width: 100%;
    border-width: 0;
    box-sizing: border-box;
    padding: 0;
    margin-block-end: 0;
}
.input-box {
  padding: 0;
    width: 70%;
    height: 100%;
} 
.input-button{
	width: 27%;
    margin-left: -2px;
    margin-top: 2px;
}
</style>