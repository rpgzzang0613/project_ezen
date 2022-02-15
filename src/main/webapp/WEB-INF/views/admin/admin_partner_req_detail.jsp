<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="admin_company_top.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- admin_partner_req_detail.jsp -->
<form name="f_partner_req_detail" method="POST" action="admin_partner_req_ok">
<input type="hidden" name="c_num" value="${cdto.c_num}">
<table border="1" align="center" width="600">
	<tr>
		<td colspan="2" align="center">기업 정보</td>
	</tr>
	<tr> 
		<td>기업 로고</td>
		<td>
			<img src="resources/images/company/${cdto.c_image}" width="180" height="160">
		</td>
	</tr>
	<tr>
		<td width="50">기업명</td>
		<td>${cdto.c_name}</td>
	</tr>
	<tr>
		<td width="50">대표번호</td>
		<td>${cdto.c_tel}</td>
	</tr>
	<tr> 
		<td width="50">본사 주소</td>
		<td>
			<c:set var="fullAddr" value="${fn:split(cdto.c_address,'@')}"/>
			${fullAddr[0]}<br>
			${fullAddr[1]}<br>
			<%-- ${fullAddr[2]} (지번)<br> --%>
			${fullAddr[3]}
		</td>
	</tr>
	<tr>
		<td width="50">대표메일</td>
		<td>${cdto.c_email}</td> 
	</tr> 
	<tr>
		<td width="50">CEO</td> 
		<td>${cdto.c_ceo}</td>
	</tr>
	<tr> 
		<td width="50">사업자 번호</td>
		<td>${cdto.c_bnum}</td>
	</tr>
	<tr>
		<td width="150">사업자 등록증</td>
		<td><a href="resources/images/company/license/${cdto.c_licenseimage}">PDF 보기</a></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="승인">
		</td>
	</tr>
</table>
</form>
<%@ include file="../bottom.jsp" %>