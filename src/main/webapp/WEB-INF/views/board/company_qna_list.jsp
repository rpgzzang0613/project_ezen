<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${companyLoginOkBean.a_level eq 3}">
	<%@ include file="../admin/admin_company_top.jsp" %>
</c:if>
<c:if test="${companyLoginOkBean.a_level ne 3}">
	<%@ include file="../company/company_myPage.jsp" %>
</c:if>
<!-- company_qna_list.jsp -->
<div align="center">
<table width="600">
	<c:if test="${companyLoginOkBean.a_level eq 3}">
	<caption>기업 Q&A 목록 (관리자)</caption>
	</c:if>
	<c:if test="${companyLoginOkBean.a_level ne 3}">
	<caption>기업 Q&A 목록</caption>
	<tr>
		<td colspan="6" align="right">
			<input type="button" value="글쓰기" onclick="window.location='write_companyQnA'">
		</td>
	</tr>
	</c:if>
	<tr bgcolor="lightgrey">
		<th width="10%">번호</th>
		<th width="60%">제목</th>
		<th width="15%">기업명</th>
		<th width="15%">작성일</th>
	</tr>

	<c:if test="${empty listCompanyQnA}">
	<tr>
		<td colspan="6">등록된 게시글이 없습니다.</td>
	</tr>		
	</c:if>
	<c:forEach var="cqadto" items="${listCompanyQnA}">
	<tr>
		<td align="center">${cqadto.cqa_num}</td>
		<td>
			<c:if test="${cqadto.cqa_re_level>0}">
			<img src="resources/images/level.gif" width="${cqadto.cqa_re_level*10}">
			<img src="resources/images/re.gif">
			</c:if>
		<a href="get_companyQnA?cqa_num=${cqadto.cqa_num}">
			${cqadto.cqa_subject}
		</a>
		</td>
		<td align="center">${cqadto.c_name}</td>
		<td align="center">${cqadto.cqa_joindate}</td>
	</tr>	
	</c:forEach>
</table>
<c:if test="${companyLoginOkBean.a_level eq 3}">
	<c:if test="${rowCount>0}">
		<c:if test="${startPage>linkSize}">
			<a href="list_companyQnA?pageNum=${startPage-linkSize}">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<a href="list_companyQnA?pageNum=${i}">[${i}]</a>
		</c:forEach>
		<c:if test="${endPage<pageCount}">
			<a href="list_companyQnA?pageNum=${startPage+linkSize}">[다음]</a>			
		</c:if>	
	</c:if>
</c:if>
</div>
<%@ include file="../bottom.jsp" %>