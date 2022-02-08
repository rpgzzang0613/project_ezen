<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${loginOkBean.a_level eq 3}">
	<%@ include file="../admin/admin_user_top.jsp" %>
</c:if>
<c:if test="${loginOkBean.a_level ne 3}">
	<%@ include file="../user/user_myPage.jsp" %>
</c:if>
<!-- user_qna_writeForm.jsp -->
<script type="text/javascript">
	function updateChk() {
		if(f_updateUserQnA.subject.value=="") {
			alert("제목을 입력해 주세요.")
			f_updateUserQnA.subject.focus()
			return false
		}
		if(f_updateUserQnA.content.value=="") {
			alert("내용을 입력해 주세요.")
			f_updateUserQnA.content.focus()
			return false
		}
		return true
	}
</script>
<div align="center">
<form name="f_updateUserQnA" action="update_userQnA_ok" method="post" onsubmit="return updateChk()">
<input type="hidden" name="uqa_num" value="${param.uqa_num}">
<table border="1" width="600">
	<caption>회원 Q&A 글수정</caption>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">회원명</td>
		<td width="85%">${uqadto.u_nickname}</td>
	</tr>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">제 목</td>
		<td width="85%"><input type="text" name="uqa_subject" size="65" value="${uqadto.uqa_subject}"></td>
	</tr>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">내 용</td>
		<td width="85%"><textarea name="uqa_contents" cols="65" rows="12">${uqadto.uqa_contents}</textarea></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="수정하기">
			<input type="button" value="목록보기" onclick="window.location='list_userQnA'">
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>