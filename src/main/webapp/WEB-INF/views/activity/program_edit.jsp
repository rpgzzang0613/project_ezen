<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- program_edit.jsp -->
<html>
<head>
<meta charset="UTF-8">
<title>프로그램 정보 수정</title>
</head>
<script type="text/javascript">
	function check() {
		if(f_programEdit.p_name1.value=="") {
			alert("프로그램명을 입력하셔야 합니다.")
			f_programEdit.p_name1.focus()
			return
		}
		if(f_programEdit.p_price.value=="") {
			alert("프로그램 요금을 입력하셔야 합니다.")
			f_programEdit.p_price.focus()
			return
		}
		if(f_programEdit.p_maxbooker.value=="") {
			alert("프로그램 예약 최대 인원을 입력하셔야 합니다.")
			f_programEdit.p_maxbooker.focus()
			return
		}
		if(f_programEdit.starttime2.value==""){
			alert("정확한 시작 시간을 선택해주세요")
			f_programEdit.starttime2.focus()
			return
		}
		if(f_programEdit.endtime2.value==""){
			alert("정확한 종료 시간을 선택해주세요")
			f_programEdit.endtime2.focus()
			return
		}
		var p_name = f_programEdit.p_name1.value+
			"["+f_programEdit.starttime.value+":"+f_programEdit.starttime2.value+"~"
			+f_programEdit.endtime.value+":"+f_programEdit.endtime2.value+"]"
	
		document.f_programEdit.p_name.value = p_name
		document.f_programEdit.submit()
	}
</script>
<body>
	<%@ include file="activity_maintop.jsp"%>
	<form name="f_programEdit" method="post" action="program_edit_ok">
	<input type="hidden" name="a_num" value="${pdto.a_num}">
	<input type="hidden" name="p_num" value="${pdto.p_num}">
	<input type="hidden" name="p_name" value="">
	<table align="center" width="500"> 
	<caption align="center">프로그램 정보 수정</caption>
		<tr>
			<td class="title-box">프로그램 이름</td>
			<td><input type="text" name="p_name1" value="${p_name1}"></td>
		</tr>
		<tr>
			<td class="title-box">프로그램 요금</td>
			<td><input type="text" name="p_price" value="${pdto.p_price}">원</td>	
		</tr>
		<tr>
			<td class="title-box">최대 예약 인원 </td>
			<td><input type="text" name="p_maxbooker" value="${pdto.p_maxbooker}">명</td>
		</tr>
		<tr>
		<td class="title-box">시작시간</td>
		<td>
			<select name="starttime" size="1">
				<option value="">시간을 선택해주세요</option>
				<c:forEach var="i" begin="1" end="12">
					<option value="AM${i}">오전:${i}시</option>
				</c:forEach>
				<c:forEach var="i" begin="1" end="12">
					<option value="PM${i}">오후:${i}시</option>
				</c:forEach>
			</select>
			<select name="starttime2" size="1">	
				<option value="">시간을 선택해주세요</option>
				<option value="00">00분</option>
				<option value="10">10분</option>
				<option value="20">20분</option>
				<option value="30">30분</option>
				<option value="40">40분</option>
				<option value="50">50분</option>
			</select>
			</td>
		</tr>
		<tr>
		<td class="title-box">종료시간</td>
		<td>
			<select name="endtime" size="1">
				<option value="">시간을 선택해주세요</option>
				<c:forEach var="i" begin="1" end="12">
					<option value="AM${i}">오전:${i}시</option>
				</c:forEach>
				<c:forEach var="i" begin="1" end="12">
					<option value="PM${i}">오후:${i}시</option>
				</c:forEach>
			</select>
			<select name="endtime2" size="1">	
				<option value="">시간을 선택해주세요</option>
				<option value="00">00분</option>
				<option value="10">10분</option>
				<option value="20">20분</option>
				<option value="30">30분</option>
				<option value="40">40분</option>
				<option value="50">50분</option>
			</select>
			</td> 
		</tr>
		<tr height="30px;">
		</tr>
		<tr>
			<td width="120"></td>
			<td width="200"> 
				<input type="button" value="돌아가기" onclick="history.back()">
				<input type="button" value="수정" onclick="check()">
			</td>
		</tr>		
	</table>
	</form>
</body> 
<style>
.title-box{
background-color: azure;
text-align: center;
width: 120px;
}
</style>
</html>