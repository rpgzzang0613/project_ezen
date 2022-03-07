<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- room_group_list.jsp -->
<%@ include file="hotel_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center">
	<tr>  
		<td>
			<div align ="center">
				<hr color="green" width="300">
				객실 그룹 리스트
				<hr color="green" width="300"><br>
				
				<table width ="80%" class="outline">
					<tr>
						<td colspan="3">
						</td>
						<td align="right">
							<form name="f_roomGroupInput" method="post" action="room_group_input">
								<input type="hidden" name="num" value="${param.h_num}">
								<input type="submit" value="객실 그룹 추가">
							</form>
						</td>
					</tr>
				<c:if test="${empty roomGroupList}">
					<tr bgcolor="skyblue">
						<td colspan="4">등록된 객실이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty roomGroupList}">
				<c:forEach var="rdto" items="${roomGroupList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${rdto.room_code}</td>
						<td width="160">
							<img src="resources/images/room/${rdto.room_image1}" width="160" height="90">
						</td>
						<td style="padding-left:15px">
							객실타입 : ${rdto.room_type}&nbsp;&nbsp; | 
							&nbsp;&nbsp;최대수용인원 : ${rdto.room_capacity}<br>
							객실명 : ${rdto.room_name}&nbsp;&nbsp;<br> 
							객실요금 : ${rdto.room_price}&nbsp;&nbsp; | 
							&nbsp;&nbsp;전체 객실수 : ${rdto.max_count}
							<br>
						</td>
						<td align="center">
							<form name="f_roomList" method="post" action="room_list" style="margin:5px">
								<input type="hidden" name="room_num" value="${rdto.room_num}">
								<input type="hidden" name="room_code" value="${rdto.room_code}">
								<input type="submit" value="상세 목록">
							</form>
							<form name="f_roomGroupDelete" method="post" action="room_group_delete_ok" style="margin:5px">
								<input type="hidden" name="room_code" value="${rdto.room_code}">
								<input type="hidden" name="h_num" value="${rdto.h_num}">
								<input type="hidden" name="room_images" value="${rdto.room_image1}">
								<input type="hidden" name="room_images" value="${rdto.room_image2}">
								<input type="hidden" name="room_images" value="${rdto.room_image3}">
								<input type="submit" value="그룹 삭제">
							</form>
							<form name="f_roomGroupEdit" method="post" action="room_group_edit" style="margin:5px">
								<input type="hidden" name="room_num" value="${rdto.room_num}">
								<input type="submit" value="그룹 수정">
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
</body>
</html>