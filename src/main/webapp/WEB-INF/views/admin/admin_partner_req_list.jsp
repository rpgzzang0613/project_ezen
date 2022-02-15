<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_company_top.jsp" %>
<!-- admin_partner_req_list.jsp -->
<section>
	<article>
		<h3 align="center">제휴 신청 현황</h3>
		<table border="1" align="center" width="800">
			<tr>
				<th width="10%">No</th>
				<th width="35%">기업명</th>
				<th width="15%">기업 대표</th>
				<th width="20%">연락처</th>
				<th width="20%">가입일</th>
			</tr>
			<c:if test="${empty reqList}">
			<tr>
				<td colspan="5">제휴 신청 기업이 없습니다.</td>
			</tr>
			</c:if>
			<c:forEach var="cdto" items="${reqList}">
			<tr>
				<td align="center">${cdto.c_num}</td>
				<td><a href="admin_partner_req_detail?c_num=${cdto.c_num}">${cdto.c_name}</a></td>
				<td>${cdto.c_ceo}</td>
				<td>${cdto.c_tel}</td>
				<td>${cdto.c_joindate}</td>
			</tr>
			</c:forEach>
		</table>
	</article>
</section>
<%@ include file="../bottom.jsp" %>