<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${loginOkBean.a_level eq 3}">
	<%@ include file="../admin/admin_user_top.jsp" %>
</c:if>
<c:if test="${loginOkBean.a_level ne 3}">
	<%@ include file="../user/user_myPage.jsp" %>
</c:if>
<!-- user_qna_content.jsp -->
<div align="center">
<table border="1" width="600">
	<caption>회원 Q&A 상세 보기</caption>
	<tr>
		<td align="center" bgcolor="lightgrey">제목</td>
		<td colspan="3">${uqadto.uqa_subject}</td>
	</tr>
	<tr align="center">
		<td bgcolor="lightgrey">회원명</td>
		<td>${uqadto.u_nickname}</td>
		<td bgcolor="lightgrey">작성일</td>
		<td>${uqadto.uqa_joindate}</td>
	</tr>
	<tr>
		<td colspan="4"><div style="min-height:150px;">${uqadto.uqa_contents}</div></td>
	</tr>
	<tr align="center">
		<td colspan="4" align="right">
			<input type="button" value="답글" onclick="window.location='write_userQnA?uqa_num=${uqadto.uqa_num}&uqa_re_step=${uqadto.uqa_re_step}&uqa_re_level=${uqadto.uqa_re_level}&u_num_parent=${uqadto.u_num}'">&nbsp;&nbsp;
			<input type="button" value="글수정" onclick="window.location='update_userQnA?uqa_num=${uqadto.uqa_num}'">&nbsp;&nbsp;
			<input type="button" value="글삭제" onclick="window.location='delete_userQnA_ok?uqa_num=${uqadto.uqa_num}'">&nbsp;&nbsp;
			<input type="button" value="글목록" onclick="window.location='list_userQnA'">
		</td>
	</tr>
</table>
</div>
<%@ include file="../bottom.jsp" %>