<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${companyLoginOkBean.a_level eq 3}">
	<%@ include file="../admin/admin_company_top.jsp" %>
</c:if>
<c:if test="${companyLoginOkBean.a_level ne 3}">
	<%@ include file="../company/company_myPage.jsp" %>
</c:if>
<!-- company_qna_content.jsp -->
<div align="center">
<table border="1" width="600">
	<caption>기업 Q&A 상세 보기</caption>
	<tr>
		<td align="center" bgcolor="lightgrey">제목</td>
		<td colspan="3">${cqadto.cqa_subject}</td>
	</tr>
	<tr align="center">
		<td bgcolor="lightgrey">기업명</td>
		<td>${cqadto.c_name}</td>
		<td bgcolor="lightgrey">작성일</td>
		<td>${cqadto.cqa_joindate}</td>
	</tr>
	<tr>
		<td colspan="4"><div style="min-height:150px;">${cqadto.cqa_contents}</div></td>
	</tr>
	<tr align="center">
		<td colspan="4" align="right">
			<input type="button" value="답글" onclick="window.location='write_companyQnA?cqa_num=${cqadto.cqa_num}&cqa_re_step=${cqadto.cqa_re_step}&cqa_re_level=${cqadto.cqa_re_level}&c_num_parent=${cqadto.c_num}'">&nbsp;&nbsp;
			<input type="button" value="글수정" onclick="window.location='update_companyQnA?cqa_num=${cqadto.cqa_num}'">&nbsp;&nbsp;
			<input type="button" value="글삭제" onclick="window.location='delete_companyQnA_ok?cqa_num=${cqadto.cqa_num}'">&nbsp;&nbsp;
			<input type="button" value="글목록" onclick="window.location='list_companyQnA'">
		</td>
	</tr>
</table>
</div>
<%@ include file="../bottom.jsp" %>