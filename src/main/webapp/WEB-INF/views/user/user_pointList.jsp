<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>

<table align="center" valign="top"  width="90%" border="0">
	<caption><b>포인트 사용 내역</b></caption>
	<tr bgcolor="yellow" align="center">
		<td>상태</td>
		<td>적립포인트</td>
		<td>누적포인트</td>
		<td>내용</td>
		<td>날짜</td>
	</tr>
	
	<c:if test="${empty pointList}">
		<tr align = "center">
			<td colspan="5">포인트 기록이 없습니다</td>
		</tr>
	</c:if>
	
	<!-- 포인트 dto를 list형태로 아래의 양식에 맞춰 출력(예약일 기준 최근거를 위로)-->
	<c:if test="${not empty pointList}">
		<c:forEach var="pdto" items="${pointList}">
			<c:if test="${pdto.p_status eq '적립'}">
				<tr align="center">
					<td><font color = "blue">${pdto.p_status}</font></td>
					<td><font color = "blue">${pdto.p_point}</font></td><!-- 상태와 적립포인트는 상황에 따라 빨강,파랑으로 표시 -->
					<td>${pdto.p_remaining}</td>
					<td>${pdto.p_contents}</td>
					<td>${pdto.p_joindate}</td>
				</tr>
			</c:if>
			<c:if test="${pdto.p_status eq '사용'}">
				<tr align="center">
					<td><font color = "red">${pdto.p_status}</font></td>
					<td><font color = "red">${pdto.p_point}</font></td><!-- 상태와 적립포인트는 상황에 따라 빨강,파랑으로 표시 -->
					<td>${pdto.p_remaining}</td>
					<td>${pdto.p_contents}</td>
					<td>${pdto.p_joindate}</td>
				</tr>
			</c:if>
			<c:if test="${pdto.p_status eq '취소'}">
				<tr align="center">
					<td><font color = "green">${pdto.p_status}</font></td>
					<td><font color = "green">${pdto.p_point}</font></td><!-- 상태와 적립포인트는 상황에 따라 빨강,파랑으로 표시 -->
					<td>${pdto.p_remaining}</td>
					<td>${pdto.p_contents}</td>
					<td>${pdto.p_joindate}</td>
				</tr>
			</c:if>
		</c:forEach>
	</c:if>
</table>

<div align="center">
	<c:if test = "${rowCount > 0 }">
	
		<c:if test = "${startPage > pageBlock}">
			<a href="user_pointList?pageNum=${startPage - pageBlock}">[이전]</a>
		</c:if>
		
		<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
			<a href="user_pointList?pageNum=${i}">[${i}]</a>	
		</c:forEach>
		
		<c:if test = "${endPage < pageCount}">
			<a href="user_pointList?pageNum=${startPage + pageBlock}">[다음]</a>	
		</c:if>
	</c:if>
</div>
<%@ include file="../bottom.jsp" %>