<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- hotel_booklist.jsp -->
<%@ include file="hotel_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center" width="750" height="690">
	<tr>  
		<td valign="top"> 
			<div align ="center">
				<hr color="green" width="300">
				예약 관리
				<hr color="green" width="300"><br>
				
				<table width ="80%" class="outline">
				<c:if test="${empty nBookList}">
					<tr bgcolor="skyblue">
						<td colspan="4">비회원으로 예약된 객실이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty nBookList}">
				<c:forEach var="bdto" items="${nBookList}">
					<tr bgcolor="pink">
						<td width="60" align="center">${bdto.book_num}</td>
						<td width="160" align="center">
							<img src="resources/images/room/${bdto.room_image1}" width="160" height="90">
							<br>객실ID : ${bdto.room_num}
						</td>
						<td width="430" style="padding-left:15px">
							호텔 및 객실명 : ${bdto.h_name} ${bdto.room_name}<br>
							예약자명 : ${bdto.book_name}<br>
							결제금액 : <fmt:formatNumber value="${bdto.book_totalprice}" pattern="###,###원"/>&nbsp;&nbsp; | 
							<c:if test="${bdto.book_status eq 'wait'}">
							&nbsp;&nbsp;<span style="color:green;font-weight:bold">예약대기</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'confirm'}">
							&nbsp;&nbsp;<span style="color:blue;font-weight:bold">예약승인</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'deny'}">
							&nbsp;&nbsp;<span style="color:red;font-weight:bold">예약취소</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'checkin'}">
							&nbsp;&nbsp;<span style="color:purple;font-weight:bold">체크인</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'checkout'}">
							&nbsp;&nbsp;<span style="color:pink;font-weight:bold">체크아웃</span>
							</c:if>
							<br>
							예약일 : ${bdto.book_indate} ~ ${bdto.book_outdate}&nbsp;&nbsp; | 
							&nbsp;&nbsp;총인원 : ${bdto.room_capacity+bdto.book_extra}인
						</td>
						<td align="center">
						<c:if test="${bdto.book_status eq 'wait'}">
							<form name="fn_confirmBooking" method="post" action="confirm_nbooking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="예약 승인">
							</form>
							<form name="fn_denyBooking" method="post" action="deny_nbooking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="예약 취소">
							</form>
						</c:if>
						<c:if test="${bdto.book_status eq 'deny'}">
							<span style="color:red;font-weight:bold">취소됨</span>
						</c:if>
						<c:if test="${bdto.book_status eq 'confirm'}">
							<form name="f_denyBooking2" method="post" action="deny_nbooking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="승인 취소">
							</form>
							<form name="f_checkinBooking" method="post" action="checkin_nbooking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="체크인">
							</form>
						</c:if>
						<c:if test="${bdto.book_status eq 'checkin'}">
							<form name="f_checkoutBooking" action="checkout_nbooking" method="post" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="체크아웃">
							</form>
						</c:if>
						<c:if test="${bdto.book_status eq 'checkout'}">
							<span style="color:darkblue;font-weight:bold">${bdto.book_outdate}</span>
						</c:if>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${empty bookList}">
					<tr bgcolor="skyblue">
						<td colspan="4">회원으로 예약된 객실이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty bookList}">
				<c:forEach var="bdto" items="${bookList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${bdto.book_num}</td>
						<td width="160" align="center">
							<img src="resources/images/room/${bdto.room_image1}" width="160" height="90">
							<br>객실ID : ${bdto.room_num}
						</td>
						<td width="430" style="padding-left:15px">
							호텔 및 객실명 : ${bdto.h_name} ${bdto.room_name}<br>
							예약자명 : ${bdto.book_name}<br>
							결제금액 : <fmt:formatNumber value="${bdto.book_totalprice}" pattern="###,###원"/>&nbsp;&nbsp; | 
							<c:if test="${bdto.book_status eq 'wait'}">
							&nbsp;&nbsp;<span style="color:green;font-weight:bold">예약대기</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'confirm'}">
							&nbsp;&nbsp;<span style="color:blue;font-weight:bold">예약승인</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'deny'}">
							&nbsp;&nbsp;<span style="color:red;font-weight:bold">예약취소</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'checkin'}">
							&nbsp;&nbsp;<span style="color:purple;font-weight:bold">체크인</span>
							</c:if>
							<c:if test="${bdto.book_status eq 'checkout'}">
							&nbsp;&nbsp;<span style="color:pink;font-weight:bold">체크아웃</span>
							</c:if>
							<br>
							예약일 : ${bdto.book_indate} ~ ${bdto.book_outdate}&nbsp;&nbsp; | 
							&nbsp;&nbsp;총인원 : ${bdto.room_capacity+bdto.book_extra}인
						</td>
						<td align="center">
						<c:if test="${bdto.book_status eq 'wait'}">
							<form name="f_confirmBooking" method="post" action="confirm_booking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="예약 승인">
							</form>
							<form name="f_denyBooking" method="post" action="deny_booking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="예약 취소">
							</form>
						</c:if>
						<c:if test="${bdto.book_status eq 'deny'}">
							<span style="color:red;font-weight:bold">취소됨</span>
						</c:if>
						<c:if test="${bdto.book_status eq 'confirm'}">
							<form name="f_denyBooking2" method="post" action="deny_booking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="승인 취소">
							</form>
							<form name="f_checkinBooking" method="post" action="checkin_booking" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="체크인">
							</form>
						</c:if>
						<c:if test="${bdto.book_status eq 'checkin'}">
							<form name="f_checkoutBooking" action="checkout_booking" method="post" style="margin:5px">
								<input type="hidden" name="book_num" value="${bdto.book_num}">
								<input type="hidden" name="room_num" value="${bdto.room_num}">
								<input type="hidden" name="h_num" value="${bdto.h_num}">
								<input type="submit" value="체크아웃">
							</form>
						</c:if>
						<c:if test="${bdto.book_status eq 'checkout'}">
							<span style="color:darkblue;font-weight:bold">${bdto.book_outdate}</span>
						</c:if>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				</table>
			</div>		
		</td>
	</tr>
</table>
</div>
</body>
</html>