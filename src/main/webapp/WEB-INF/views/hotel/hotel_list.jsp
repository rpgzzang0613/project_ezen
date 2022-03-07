<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- hotel_list.jsp -->
<%@ include file="hotel_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center" width="750" height="690">
	<tr>  
		<td align="center" valign="top"> 
			<div align ="center">
				<hr color="green" width="300">
				호텔 리스트
				<hr color="green" width="300">
				<table width ="80%">
				<c:if test="${empty hotelList}">
					<tr bgcolor="skyblue">
						<td colspan="4">등록된 호텔이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty hotelList}">
				<c:forEach var="hdto" items="${hotelList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${hdto.h_num}</td>
						<td width="160">
							<img src="resources/images/hotel/${hdto.h_image1}" width="160" height="90">
						</td>
						<td style="padding-left:15px">
							호텔명 : ${hdto.h_name}<br>
							연락처 : ${hdto.h_tel}&nbsp;&nbsp; | 
							&nbsp;&nbsp;등급 : ${hdto.h_grade}성<br><br>
							&lt;주소&gt;<br>
							<c:set var="fullAddr" value="${fn:split(hdto.h_address,'@')}"/>
							${fullAddr[0]} ${fullAddr[1]} ${fullAddr[2]}<br>
							${fullAddr[3]}
						</td>
						<td align="center">
							<form name="f_roomList" method="post" action="room_group_list" style="margin:5px">
								<input type="hidden" name="h_num" value="${hdto.h_num}">
								<input type="submit" value="객실 목록">
							</form>
							<form name="f_hotelBooking" method="post" action="hotel_booklist" style="margin:5px">
								<input type="hidden" name="h_num" value="${hdto.h_num}">
								<input type="submit" value="예약 관리">
							</form>
							<form name="f_hotelEdit" method="post" action="hotel_edit" style="margin:5px">
								<input type="hidden" name="h_num" value="${hdto.h_num}">
								<input type="submit" value="호텔 수정">
							</form>
							<form name="f_hotelDelete" method="post" action="hotel_delete_ok" style="margin:5px">
								<input type="hidden" name="h_num" value="${hdto.h_num}">
								<input type="hidden" name="h_images" value="${hdto.h_image1}">
								<input type="hidden" name="h_images" value="${hdto.h_image2}">
								<input type="hidden" name="h_images" value="${hdto.h_image3}">
								<input type="hidden" name="h_images" value="${hdto.h_image4}">
								<input type="hidden" name="h_images" value="${hdto.h_image5}">
								<input type="submit" value="호텔 삭제">
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