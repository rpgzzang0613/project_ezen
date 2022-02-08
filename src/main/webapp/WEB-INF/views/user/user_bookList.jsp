<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>
<script>
$.ajax({
	type : "post",
	url : "/user_bookList",
	success : function(result){
	    $("#result").html(
	            "상품명:"+result.name+",가격:"+result.price);
	    }
});
</script>

<c:if test="${empty bookList}">
	<h3 align="center" style="color:red">예약하신 호텔이 없습니다.</h3>
</c:if>	
<div style="text-align: center; font-weight:bold;">호텔 예약 목록</div><br>
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
		<td rowspan="4" width="100">
			<img src="resources/images/hotel/${bdto.h_image1}" width="100%" height="100%" > 
		</td>
		<td>체크인: ${bdto.book_indate}</td>
		<td>체크아웃: ${bdto.book_outdate}</td>
		<td align="right" valign="bottom">
			<form name="detailButton" method="POST" action="user_bookDetail">
				<input type="hidden" name="h_num" value="${bdto.h_num}">
				<input type="hidden" name="room_num" value="${bdto.room_num}">
				<input type="hidden" name="book_num" value="${bdto.book_num}">
				<input type="submit" value="예약상세">
			</form>
		</td>
	</tr>
	<tr>
		<td>예약번호: ${bdto.book_num}</td>
		<td>예약 호텔: ${bdto.h_name}</td>
		<td align = "right" valign="bottom">
			<form name="reviewbutton" method="POST" action="user_reviewform">
				<input type="hidden" name="h_num" value="${bdto.h_num}">
				<input type="hidden" name="room_num" value="${bdto.room_num}">
				<input type="hidden" name="book_num" value="${bdto.book_num}">
				<c:if test="${bdto.book_status eq 'checkout'}">
					<c:if test="${bdto.book_review == 0}">
						<input type="submit" value="리뷰쓰기">
					</c:if>
					<c:if test="${bdto.book_review == 1}">
						<button type="button">작성완료</button>
					</c:if>
				</c:if>
				<c:if test="${bdto.book_status eq 'checkin'}">
					C/I DAY!
				</c:if>
			</form>
		</td>
	</tr>
	<tr>
		<td>${bdto.day}</td>
		<td>결제일: ${bdto.book_joindate}</td>
		<td align = "right" valign="bottom">
			<form name="cancelbutton" method="POST" action="user_bookCancel">
				<input type="hidden" name="h_num" value="${bdto.h_num}">
				<input type="hidden" name="room_num" value="${bdto.room_num}">
				<input type="hidden" name="book_num" value="${bdto.book_num}">
				<c:if test="${bdto.book_status == 'wait' || bdto.book_status == 'confirm'}">
					<input type="submit" value="예약취소">
				</c:if>
				<c:if test="${bdto.book_status == 'deny'}">
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