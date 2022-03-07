<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- activity_booklist.jsp -->
<%@ include file="activity_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center" width="750" height="690">
	<tr>
		<td align="center" valign="top">
			<div align ="center">
				<hr color="green" width="300">
				예약 관리
				<hr color="green" width="300"><br>
				
				<table width ="80%" class="outline">
				<c:if test="${empty bookActList}">
					<tr bgcolor="skyblue">
						<td colspan="4">예약된 객실이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty bookActList}">
				<c:forEach var="badto" items="${bookActList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${badto.ba_num}</td>
						<td width="160" align="center">
							<img src="resources/images/activity/${badto.a_image1}" width="160" height="90">
							<br>프로그램ID : ${badto.p_num}
						</td>
						<td width="430" style="padding-left:15px">
							프로그램 이름 : ${badto.p_name}<br>
							예약자명 : ${badto.ba_name}<br>
							결제금액 : <fmt:formatNumber value="${badto.ba_totalprice}" pattern="###,###원"/>&nbsp;&nbsp; | 
							<c:if test="${badto.ba_status eq 'wait'}">
							&nbsp;&nbsp;<span style="color:green;font-weight:bold">예약대기</span>
							</c:if>
							<c:if test="${badto.ba_status eq 'confirm'}">
							&nbsp;&nbsp;<span style="color:blue;font-weight:bold">예약승인</span>
							</c:if>
							<c:if test="${badto.ba_status eq 'deny'}">
							&nbsp;&nbsp;<span style="color:red;font-weight:bold">예약취소</span>
							</c:if>
							<c:if test="${badto.ba_status eq 'checkout'}">
							&nbsp;&nbsp;<span style="color:pink;font-weight:bold">체크아웃</span>
							</c:if>
							<br>
							예약일 : ${badto.ba_bookdate}&nbsp;&nbsp; | 
							&nbsp;&nbsp;총인원 : ${badto.ba_totalbooker}인
						</td>
						<td align="center">
						<c:if test="${badto.ba_status eq 'wait'}">
							<form name="f_confirmBookingAct" method="post" action="confirm_bookingAct" style="margin:5px">
								<input type="hidden" name="ba_num" value="${badto.ba_num}">
								<input type="hidden" name="p_num" value="${badto.p_num}">
								<input type="hidden" name="a_num" value="${badto.a_num}">
								<input type="submit" value="예약 승인">
							</form>
							<form name="f_denyBookingAct" method="post" action="deny_bookingAct" style="margin:5px">
								<input type="hidden" name="ba_num" value="${badto.ba_num}">
								<input type="hidden" name="p_num" value="${badto.p_num}">
								<input type="hidden" name="a_num" value="${badto.a_num}">
								<input type="submit" value="예약 취소">
							</form>
						</c:if>
						<c:if test="${badto.ba_status eq 'deny'}">
							<span style="color:red;font-weight:bold">취소됨</span>
						</c:if>
						<c:if test="${badto.ba_status eq 'confirm'}">
							<form name="f_denyBookingAct2" method="post" action="deny_bookingAct" style="margin:5px">
								<input type="hidden" name="ba_num" value="${badto.ba_num}">
								<input type="hidden" name="p_num" value="${badto.p_num}">
								<input type="hidden" name="a_num" value="${badto.a_num}">
								<input type="submit" value="승인 취소">
							</form>
							<form name="f_checkoutBookingAct" action="checkout_bookingAct" method="post" style="margin:5px">
								<input type="hidden" name="ba_num" value="${badto.ba_num}">
								<input type="hidden" name="p_num" value="${badto.p_num}">
								<input type="hidden" name="a_num" value="${badto.a_num}">
								<input type="submit" value="체크아웃">
							</form>
						</c:if>
						<c:if test="${badto.ba_status eq 'checkout'}">
							<span style="color:darkblue;font-weight:bold">${badto.ba_bookdate}</span>
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