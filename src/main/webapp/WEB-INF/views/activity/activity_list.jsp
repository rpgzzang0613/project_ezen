<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- activity_list.jsp -->
<%@ include file="activity_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center" width="750" height="690">
	<tr>  
		<td align="center" valign="top">
			<div align ="center">
				<hr color="darkgrey" width="300">
				액티비티 리스트
				<hr color="darkgrey" width="300">
				<table width ="80%">
				<c:if test="${empty activityList}">
					<tr bgcolor="skyblue">
						<td colspan="4">등록된 액티비티가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty activityList}">
				<c:forEach var="adto" items="${activityList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${adto.a_num}</td>
						<td width="160">
							<img src="resources/images/activity/${adto.a_image1}" width="160" height="90">
						</td>
						<td style="padding-left:15px">
							프로그램명 : ${adto.a_name}<br>
							연락처 : ${adto.a_tel}<br>
							&lt;주소&gt;<br>
							<c:set var="fullAddr" value="${fn:split(adto.a_address,'@')}"/>
							${fullAddr[0]} ${fullAddr[1]} ${fullAddr[2]}<br>
							${fullAddr[3]}
						</td>
						<td align="center">
							<form name="f_programList" method="post" action="program_list" style="margin:5px">
								<input type="hidden" name="a_num" value="${adto.a_num}">
								<input type="submit" value="프로그램 목록">
							</form>
							<form name="f_activityBooking" method="post" action="activity_booklist" style="margin:5px">
								<input type="hidden" name="a_num" value="${adto.a_num}">
								<input type="submit" value="예  약    관  리">
							</form>
							<form name="f_activityEdit" method="post" action="activity_edit" style="margin:5px">
								<input type="hidden" name="a_num" value="${adto.a_num}">
								<input type="submit" value="액티비티 수정">
							</form>
							<form name="f_activityDelete" method="post" action="activity_delete_ok" style="margin:5px">
								<input type="hidden" name="a_num" value="${adto.a_num}">
								<input type="hidden" name="a_images" value="${adto.a_image1}">
								<input type="hidden" name="a_images" value="${adto.a_image2}">
								<input type="hidden" name="a_images" value="${adto.a_image3}">
								<input type="hidden" name="a_images" value="${adto.a_image4}">
								<input type="hidden" name="a_images" value="${adto.a_image5}">
								<input type="submit" value="액티비티 삭제">
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