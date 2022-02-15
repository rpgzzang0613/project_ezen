<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>
<table align="center" valign="top" border="0">
	<caption><b>내 정보 관리</b></caption>
	<tr>
		<td width="120">이메일</td>
		<td>
			${loginOkBean.u_email}<br>
		</td>
	<tr>
		<td>닉네임</td>
		<td>
			<form name="info" method="post" action="user_nickChange">
		 		<input type="text" name="nickname" value="${loginOkBean.u_nickname}">
				<input type="submit" value="수정">
			</form>
		</td>
	</tr>
	<tr>
		<td>휴대폰 번호</td>
		<td>
			<form name="tel" method="post" action="user_telChange">
				<input type="text" name="u_tel" value="${loginOkBean.u_tel}">
				<input type="submit" value="수정">
			</form> 
		</td>
	</tr>
</table>
	<%@ include file="../bottom.jsp" %>