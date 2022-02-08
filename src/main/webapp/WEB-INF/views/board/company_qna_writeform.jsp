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
	function inputChk() {
		if(f_writeCompanyQnA.subject.value=="") {
			alert("제목을 입력해 주세요.")
			f_writeCompanyQnA.subject.focus()
			return false
		}
		if(f_writeCompanyQnA.content.value=="") {
			alert("내용을 입력해 주세요.")
			f_writeCompanyQnA.content.focus()
			return false
		}
		return true
	}
</script>
<div align="center">
<form name="f_writeCompanyQnA" action="write_companyQnA_ok" method="post" onsubmit="return inputChk()">
<input type="hidden" name="cqa_num" value="${param.cqa_num}">
<input type="hidden" name="cqa_re_step" value="${param.cqa_re_step}">
<input type="hidden" name="cqa_re_level" value="${param.cqa_re_level}">
<input type="hidden" name="c_num" value="${companyLoginOkBean.c_num}">
<input type="hidden" name="c_num_parent" value="${param.c_num_parent}">
<table border="1" width="600">
	<caption>기업 Q&A 글쓰기</caption>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">기업명</td>
		<td width="85%">${companyLoginOkBean.c_name}</td>
	</tr>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">제 목</td>
		<td width="85%"><input type="text" name="cqa_subject" size="65"></td>
	</tr>
	<tr>
		<td bgcolor="lightgrey" align="center" width="15%">내 용</td>
		<td width="85%">
			<textarea name="cqa_contents" cols="65" rows="12"></textarea>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="submit" value="글쓰기">
			<input type="button" value="목록보기" onclick="window.location='list_companyQnA'">
		</td>
	</tr>
</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>