<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>
<c:if test="${empty bookList}">
	<h3 align="center" style="color:red">예약하신 호텔이 없습니다.</h3>
</c:if>	
<div style="text-align: center; font-size: xx-large; font-weight:bold;">호텔 예약 목록</div><br>
<c:set var = "num" value = "${number}"/>
<c:forEach var="bdto" items="${bookList}"> 
<table align="center" valign="top" width="90%" border="1">
	<tr> 
		<td>
			<c:if test="${bdto.book_status eq 'wait'}">
				<font color="green">[예약대기]</font>
			</c:if>
			<c:if test="${bdto.book_status eq 'confirm'}">
				<font color="blue">[예약확정]</font>
			</c:if>
			<c:if test="${bdto.book_status eq 'deny'}">
				<font color="red">[예약취소]</font>
			</c:if>
			<c:if test="${bdto.book_status eq 'checkin'}">
				<font color="skyblue">[체크인]</font>
			</c:if>
			<c:if test="${bdto.book_status eq 'checkout'}">
				<font color="pink">[체크아웃]</font>
			</c:if>
		</td>
		<td colspan="3">No.${num}</td>
		<c:set var="num" value = "${num-1}"/>
	</tr>
	<tr>
		<td rowspan="3" width="100">
			<img src="resources/images/hotel/${bdto.h_image1}" width="100%" height="100%" > 
		</td>
		<td>체크인: ${bdto.book_indate}</td>
		<td>체크아웃: ${bdto.book_outdate}</td>
		<td align="center" rowspan="3">
			<form name="detailButton" method="POST" action="user_bookDetail">
				<input type="hidden" name="h_num" value="${bdto.h_num}">
				<input type="hidden" name="room_num" value="${bdto.room_num}">
				<input type="hidden" name="book_num" value="${bdto.book_num}">
				<br>
				<input type="submit" value="예약상세" style="background: #edf2ff;">
			</form>
			<form name="reviewbutton" method="POST" action="user_reviewform">
				<input type="hidden" name="h_num" value="${bdto.h_num}">
				<input type="hidden" name="room_num" value="${bdto.room_num}">
				<input type="hidden" name="book_num" value="${bdto.book_num}">
				<c:if test="${bdto.book_status eq 'checkout'}">
					<c:if test="${bdto.book_review == 0}">
						<input type="submit" value="리뷰쓰기" style="background: #edf2ff;">
					</c:if>
					<c:if test="${bdto.book_review == 1}">
						<button type="button" style="background:white;border:0;">
						<font color="green"><b>작성완료</b></font></button>
					</c:if>
				</c:if>
				<c:if test="${bdto.book_status eq 'checkin'}">
					C/I DAY!
				</c:if>
			</form>
			<form name="cancelbutton" method="POST" action="user_bookCancel">
				<input type="hidden" name="h_num" value="${bdto.h_num}">
				<input type="hidden" name="room_num" value="${bdto.room_num}">
				<input type="hidden" name="book_num" value="${bdto.book_num}">
				<c:if test="${bdto.book_status == 'wait' || bdto.book_status == 'confirm'}">
					<input type="submit" value="예약취소" style="background: #edf2ff;">
				</c:if>
				<c:if test="${bdto.book_status == 'deny'}">
					<button type="button" style="background:white; border:0;">
					<font color="red">
					<b>취소완료</b></font></button>
				</c:if>
			</form>
		</td>
	</tr>
	<tr>
		<td>예약번호: ${bdto.book_num}</td>
		<td>예약 호텔: ${bdto.h_name}</td>
	</tr>
	<tr>
		<td>${bdto.day}</td>
		<td>결제일: ${bdto.book_joindate}</td>
	</tr>
</table>
<br>
</c:forEach>
<div align="center">
<c:if test = "${rowCount > 0 }">
	<c:if test = "${startPage > pageBlock}">
		<a href="user_bookList?pageNum=${startPage - pageBlock}">[이전]</a>
	</c:if>
	
	<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
		<a href="user_bookList?pageNum=${i}">[${i}]</a>	
	</c:forEach>
	
	<c:if test = "${endPage < pageCount}">
		<a href="user_bookList?pageNum=${startPage + pageBlock}">[다음]</a>	
	</c:if>
</c:if>
</div>
<%@ include file="../bottom.jsp" %>