<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- program_list.jsp -->
<%@ include file="activity_maintop.jsp"%>
<div style="width: 750px; height:690px; overflow: auto;">
<table border="1" align="center" width="750" height="690">
	<tr>
		<td align="center" valign="top">
			<div align ="center">
				<hr color="green" width="300">
				프로그램 리스트
				<hr color="green" width="300"><br>
				
				<table width ="80%" class="outline">
					<tr>
						<td colspan="2">
						</td>
						<td align="right">
							<form name="f_programInput" method="post" action="program_input">
								<input type="hidden" name="a_num" value="${param.a_num}">
								<input type="submit" value="프로그램 추가">
							</form>
						</td>
					</tr>
				<c:if test="${empty programList}">
					<tr bgcolor="skyblue">
						<td colspan="4">등록된 프로그램이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty programList}">
				<c:forEach var="pdto" items="${programList}">
					<tr bgcolor="skyblue">
						<td width="60" align="center">${pdto.p_num}</td>
						<td style="padding-left:15px">
							프로그램명 : ${pdto.p_name}&nbsp;&nbsp; | 
							&nbsp;&nbsp;최대 인원 : ${pdto.p_maxbooker}명<br>
							프로그램 요금 : ${pdto.p_price}&nbsp;&nbsp;
						</td>
						<td>
							<form name="f_programEdit" method="post" action="program_edit" style="margin:5px">
								<input type="hidden" name="p_num" value="${pdto.p_num}">
								<input type="hidden" name="a_num" value="${param.a_num}">
								<input type="submit" value="프로그램 수정">
							</form>
						</td>
						<td>
							<form name="f_programDelete" method="post" action="program_delete_ok" style="margin:5px">
								<input type="hidden" name="p_num" value="${pdto.p_num}">
								<input type="hidden" name="a_num" value="${param.a_num}">
								<input type="submit" value="프로그램 삭제">
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