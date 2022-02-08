<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${companyLoginOkBean.a_level eq 3}">
	<%@ include file="../admin/admin_company_top.jsp" %>
</c:if>
<c:if test="${companyLoginOkBean.a_level ne 3}">
	<%@ include file="../company/company_myPage.jsp" %>
</c:if>
<!-- company_qna_writeForm.jsp -->
<script type="text/javascript">
	function updateChk() {
		if(f_updateCompanyQnA.subject.value=="") {
			alert("제목을 입력해 주세요.")
			f_updateCompanyQnA.subject.focus()
			return false
		}
		if(f_updateCompanyQnA.content.value=="") {
			alert("내용을 입력해 주세요.")
			f_updateCompanyQnA.content.focus()
			return false
		}
		return true
	}
</script>
<div align="center">
<form name="f_updateCompanyQnA" action="update_companyQnA_ok" method="post" onsubmit="return updateChk()">
<input type="hidden" name="cqa_num" value="${param.cqa_num}">
<table border="1" width="600">
	<caption>기업 Q&A 글수정</caption>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">기업명</td>
		<td width="85%">${cqadto.c_name}</td>
	</tr>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">제 목</td>
		<td width="85%"><input type="text" name="cqa_subject" size="65" value="${cqadto.cqa_subject}"></td>
	</tr>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">내 용</td>
		<td width="85%"><textarea name="cqa_contents" cols="65" rows="12">${cqadto.cqa_contents}</textarea></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="수정하기">
			<input type="button" value="목록보기" onclick="window.location='list_companyQnA'">
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>