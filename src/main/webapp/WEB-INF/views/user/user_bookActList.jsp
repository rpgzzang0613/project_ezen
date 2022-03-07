<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>
<c:if test="${empty bookActList}">
	<h3 align="center" style="color:red">예약하신 액티비티가 없습니다.</h3>
</c:if>	
<div style="text-align: center; font-size: xx-large; font-weight:bold;">엑티비티 예약 목록</div><br>
<c:set var = "num" value = "${number}"/>
<c:forEach var="badto" items="${bookActList}">
<table align="center" valign="top" width="90%" border="1">
	<tr>
		<td>
			<c:if test="${badto.ba_status eq 'wait'}">
				<font color="green">[예약대기]</font>
			</c:if>
			<c:if test="${badto.ba_status eq 'confirm'}">
				<font color="blue">[예약확정]</font>
			</c:if>
			<c:if test="${badto.ba_status eq 'deny'}">
				<font color="red">[예약취소]</font>
			</c:if>
			<c:if test="${badto.ba_status eq 'checkout'}">
				<font color="skyblue">[체크아웃]</font>
			</c:if>
		</td>
		<td colspan="3">No.${num}</td>
		<c:set var="num" value = "${num-1}"/>
	</tr>
	<tr>
		<td rowspan="3" width="100">
			<img src="resources/images/activity/${badto.a_image1}" width="100%" height="100%" > 
		</td>
		<td colspan="2">예약일: ${badto.ba_bookdate}</td>
		<td align="right" valign="bottom">
			<form name="detailButton" method="POST" action="user_bookActDetail">
				<input type="hidden" name="a_num" value="${badto.a_num}">
				<input type="hidden" name="ba_num" value="${badto.ba_num}">
				<input type="submit" value="예약상세">
			</form>
		</td>
	</tr>
	<tr>
		<td>예약번호: ${badto.ba_num}</td>
		<td>액티비티: ${badto.a_name}</td>
		<td align = "right" valign="bottom">
			<form name="reviewbutton" method="POST" action="user_reviewActform">
				<input type="hidden" name="a_num" value="${badto.a_num}">
				<input type="hidden" name="p_num" value="${badto.p_num}">
				<input type="hidden" name="ba_num" value="${badto.ba_num}">
				<c:if test="${badto.ba_status eq 'checkout'}">
 					<c:if test="${badto.ba_review == 0}">
						<input type="submit" value="리뷰쓰기">
					</c:if>
					<c:if test="${badto.ba_review == 1}">
						<button type="button">작성완료</button>
					</c:if>
				</c:if>
			</form>
		</td>
	</tr>
	<tr>
		<td colspan="2">결제일: ${badto.ba_joindate}</td>
		<td align = "right" valign="bottom">
			<form name="cancelbutton" method="POST" action="user_bookActCancel">
				<input type="hidden" name="a_num" value="${badto.a_num}">
				<input type="hidden" name="ba_num" value="${badto.ba_num}">
				<c:if test="${badto.ba_status == 'wait' || badto.ba_status == 'confirm'}">
					<input type="submit" value="예약취소">
				</c:if>
				<c:if test="${badto.ba_status == 'deny'}">
					<button type="button">취소완료</button>
				</c:if>
			</form>
		</td>
	</tr>
	</table>
	<br>
</c:forEach>
<div align="center">
<c:if test = "${rowCount > 0 }">
	<c:if test = "${startPage > pageBlock}">
		<a href="user_bookActList?pageNum=${startPage - pageBlock}">[이전]</a>
	</c:if>
	
	<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
		<a href="user_bookActList?pageNum=${i}">[${i}]</a>	
	</c:forEach>
	
	<c:if test = "${endPage < pageCount}">
		<a href="user_bookActList?pageNum=${startPage + pageBlock}">[다음]</a>	
	</c:if>
</c:if>
</div>
<%@ include file="../bottom.jsp" %>