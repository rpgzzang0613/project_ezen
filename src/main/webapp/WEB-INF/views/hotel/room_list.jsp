<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- room_list.jsp -->
<%@ include file="hotel_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center" style="width:750px; height:690px;table-layout: fixed">
	<tr>
		<td>
			<div align ="center">
				<hr color="green" width="300">
				객실 리스트
				<hr color="green" width="300"><br>
				
				<table width ="80%" class="outline">
					<tr>
						<td colspan="2">
						</td>
						<td align="right">
							<form name="f_roomInput" method="post" action="room_input_ok">
								<input type="hidden" name="room_num" value="${param.room_num}">
								<input type="hidden" name="room_code" value="${param.room_code}">
								<input type="submit" value="객실 추가">
							</form>
						</td>
					</tr>
				<c:if test="${empty roomList}">
					<tr bgcolor="skyblue">
						<td colspan="4">등록된 객실이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty roomList}">
				<c:forEach var="rdto" items="${roomList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${rdto.room_num}</td>
						<td style="padding-left:15px">
							객실타입 : ${rdto.room_type}&nbsp;&nbsp; | 
							&nbsp;&nbsp;최대수용인원 : ${rdto.room_capacity}<br>
							객실명 : ${rdto.room_name}<br> 
							객실요금 : ${rdto.room_price}&nbsp;&nbsp; | 
							<c:if test="${rdto.room_enable eq 'y'}">
								&nbsp;&nbsp;<span style="color:blue;font-weight:bold">활성화</span>
							</c:if>
							<c:if test="${rdto.room_enable eq 'n'}">
								&nbsp;&nbsp;<span style="color:red;font-weight:bold">비활성화</span>
							</c:if>
							<br>
						</td>
						<td align="center">
							<c:if test="${rdto.room_enable eq 'y'}">
							<form name="f_roomDisable" method="post" action="room_disable" style="margin:5px">
								<input type="hidden" name="room_num" value="${rdto.room_num}">
								<input type="hidden" name="room_code" value="${rdto.room_code}">
								<input type="submit" value="객실 비활성화">
							</form>
							</c:if>
							<c:if test="${rdto.room_enable eq 'n'}">
							<form name="f_roomEnable" method="post" action="room_enable" style="margin:5px">
								<input type="hidden" name="room_num" value="${rdto.room_num}">
								<input type="hidden" name="room_code" value="${rdto.room_code}">
								<input type="submit" value="객실 활성화">
							</form>
							</c:if>
							<form name="f_roomDelete" method="post" action="room_delete_ok" style="margin:5px">
								<input type="hidden" name="room_num" value="${rdto.room_num}">
								<input type="hidden" name="room_code" value="${rdto.room_code}">
								<input type="submit" value="객실 삭제">
							</form>
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
</b1ody>
</html>