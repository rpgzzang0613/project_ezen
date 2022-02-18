<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="user_myPage.jsp" %>
	<br>
	<h2>내 정보 관리</h2>
<table height="30%">
	<tr height="20%">
		<td align="center">이메일(ID)</td> 
		<td align="center">${loginOkBean.u_email}</td>
	</tr>
	<tr height="20%">
		<td align="center">이름</td> 
		<td align="center">${loginOkBean.u_name}</td>
	</tr>
	<tr height="20%">
		<td align="center">닉네임</td> 
		<td align="center"><form name="info" method="post" action="user_nickChange">
				<input type="text" name="nickname" value="${loginOkBean.u_nickname}">
				<input type="submit" value="수정">
			</form>
		</td>
	</tr>
	<tr height="20%">
		<td align="center">휴대폰 번호</td>
		<td align="center"><form name="tel" method="post" action="user_telChange">
				<br><input type="text" name="u_tel" value="${loginOkBean.u_tel}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				<input type="submit" value="수정">
			</form>
		</td>
	</tr>
	<tr height="20%">
		<td align="center">생년 월일</td>
		<td align="center">${loginOkBean.u_birth}</td>
	</tr>
</table>
<%@ include file="../bottom.jsp" %>