<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- company_search_email.jsp -->
<%@ include file ="company_top.jsp" %>
<div align="center">
<form name="f_search" method="POST" action="">
<input type="hidden" name="mode" value="${param.mode}">
<c:if test="${param.mode.equals('c_email')}">
	<h3>이메일 찾기</h3>
</c:if>
<c:if test="${param.mode.equals('c_password')}">
	<h3>비밀번호 찾기</h3>
</c:if>
<table>
	<c:if test="${param.mode.equals('c_password')}">
	<tr>
		<td>
		<input type="text" name="c_email" placeholder="이메일을 입력해 주세요." 
		tabindex="1" style="width:350px;height:50px" 
		required oninvalid="this.setCustomValidity('이메일을 입력해주세요.')" 
		oninput="setCustomValidity('')" onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">
		</td>
	</tr>
	</c:if>
	<tr>
		<td>
			<input type="text" name="c_name" placeholder="회사명을 입력해 주세요." 
			tabindex="2" style="width:350px;height:50px" 
			required oninvalid="this.setCustomValidity('회사명을 입력해주세요.')" 
			oninput="setCustomValidity('')">
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" name="c_bnum" placeholder="사업자번호를 입력해 주세요." 
			tabindex="3" style="width:350px;height:50px" 
			required oninvalid="this.setCustomValidity('사업자번호를 입력해주세요.')" 
			oninput="setCustomValidity('')" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</td>
	</tr> 
	<tr>
		<td>
		<c:if test="${param.mode.equals('c_email')}">
			<button type="submit" formaction="company_search_email_ok"
			style="width:350px;height:50px;background-color:black;
			color:white;border-color:black">이메일찾기</button>
		</c:if>
		<c:if test="${param.mode.equals('c_password')}">
			<button type="submit" formaction="company_update_password"
			style="width:350px;height:50px;background-color:black;
			color:white;border-color:black">비밀번호 찾기</button>
		</c:if>
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>