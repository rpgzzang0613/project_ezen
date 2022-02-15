<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="admin_company_top.jsp" %>
<section>
	<article>
		<h3 align="center">기업리스트</h3>
			<form name="f" align="center" action="admin_company_list" method="POST">
				<!-- mode값 넘겨서 찾을때 설정하기 -->
				<input type="hidden" name="mode" value="find"/>
			<select name="search" size="1">
				<option value="c_name">회사명</option>
				<option value="c_email">이메일</option>
				<option value="c_ceo">대표자이름</option>
			</select>
			<input type="text" name="searchString">
			<input type="submit" value="검색" >
			<button onclick="location.href='admin_company_list'">전체보기</button>
	 	</form> 
	</article>
	<article style="margin-top:30px;">
		<table border="1" align="center">
			<tr>
				<th>No</th>
				<th>기업명</th>
				<th>이메일</th>
				<th>기업 대표</th>
				<th>연락처</th>
				<th>가입일</th>
				<th>Level</th>
				<th>주소</th>
				<th>삭제</th>
			</tr>
					<c:if test="${empty cList}">
						<tr>
							<td colspan="8"> 등록된 회원이 없습니다.</td>
						</tr>
					</c:if>
			<c:forEach var="cdto" items="${cList}">
			<tr>
				<td>${cdto.c_num}</td>
				<td>${cdto.c_name}</td>
				<td>${cdto.c_email}</td>
				<td>${cdto.c_ceo}</td>
				<td>${cdto.c_tel}</td>
				<td>${cdto.c_joindate}</td>
				<td>${cdto.a_level}</td>
				<td>${cdto.c_address}</td>
				<td><a href="deleteCompany?c_num=${cdto.c_num}">삭제</a></td>
			</tr>
			</c:forEach>
		</table>
	</article>
</section>
<%@ include file="../bottom.jsp" %>