<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- company_search_email_ok.jsp -->
<%@ include file ="company_top.jsp" %>
<div align="center">
	<form name="f_search_email_ok" method="POST">
		<table width="280" align="center">
			<tr>
				<td colspan="2" align="center"><h3>이메일 찾기 결과</h3></td>
			</tr>
			<tr> 
				<td colspan="2">
					회원님의 아이디는 ${c_email} 입니다.
					<input type="hidden" name="c_email" value="${c_email}">
				</td>
			</tr>
			<tr>
				<td>
					<button type="submit" formaction="company_search?mode=c_password"
					style="width:175px;height:50px;background-color:black;color:white;border-color:black">비밀번호 찾기</button>
				</td>
				<td>
					<button type="submit" formaction="company_login" 
					style="width:175px;height:50px;background-color:black;color:white;border-color:black">로그인</button>
				</td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../bottom.jsp" %>