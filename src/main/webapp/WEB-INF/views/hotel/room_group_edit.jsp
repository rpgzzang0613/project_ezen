<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- room_input.jsp -->
<html>
<head>
<meta charset="UTF-8">
<title>객실 정보 수정</title>
</head>
<script type="text/javascript">
	function check() {
		if(f_roomGroupEdit.room_name.value=="") {
			alert("객실명을 입력하셔야 합니다.")
			f_roomGroupEdit.room_name.focus()
			return
		}
		if(f_roomGroupEdit.room_price.value=="") {
			alert("객실 요금을 입력하셔야 합니다.")
			f_roomGroupEdit.room_price.focus()
			return
		}
		if(f_roomGroupEdit.room_capacity.value=="") {
			alert("최대 사용 인원을 입력하셔야 합니다.")
			f_roomGroupEdit.room_capacity.focus()
			return
		}
		if(f_roomGroupEdit.room_extraprice.value=="") {
			alert("초과 인원 요금을 입력하셔야 합니다.")
			f_roomGroupEdit.room_extraprice.focus()
			return
		}
		document.f_roomGroupEdit.submit()
	}
</script>
<body>
	<%@ include file="hotel_maintop.jsp"%>
	<form name="f_roomGroupEdit" method="post" action="room_group_edit_ok"  enctype="multipart/form-data" >
	<input type="hidden" name="room_code" value="${rdto.room_code}">
	<input type="hidden" name="h_num" value="${rdto.h_num}">
	<table style="border-collapse: collapse" align="center" width="750">
	<caption align="center">객실 정보 수정</caption> 
		<tr>
			<td class="title-box">객실 타입</td>
			<td>${rdto.room_type}</td>
			<td class="title-box">객실 이름</td>
			<td><input type="text" name="room_name" value="${rdto.room_name}"></td>
		</tr>
		<tr> 
			<td class="title-box">객실 요금</td>
			<td><input type="text" name="room_price" value="${rdto.room_price}">원</td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td class="title-box">최대 사용 인원</td>
			<td><input type="text" name="room_capacity"value="${rdto.room_capacity}">명</td>
			<td class="title-box">초과인원 요금<br>(기준 1인)</td>
			<td><input type="text" name="room_extraprice"value="${rdto.room_extraprice}"></td>
		</tr> 
		<tr style="border-top: 1px double black"> 
			<td rowspan="3" class="title-box">객실 이미지</td>
			<td> 
				<img src="resources/images/room/${rdto.room_image1}" width="200" height="120">
			</td> 
			<td colspan="2"  >
				<input type="file" name="room_images" multiple>
				<input type="hidden" name="pre_images" value="${rdto.room_image1}">
			</td>
		</tr>
		<tr>
			<td>
				<img src="resources/images/room/${rdto.room_image2}" width="200" height="120">
			</td>
			<td colspan="2"  >
				<input type="file" name="room_images" multiple>
				<input type="hidden" name="pre_images" value="${rdto.room_image2}">
			</td>
		</tr>
		<tr>
			<td>
				<img src="resources/images/room/${rdto.room_image3}" width="200" height="120">
			</td>
			<td colspan="2"  >
				<input type="file" name="room_images" multiple>
				<input type="hidden" name="pre_images" value="${rdto.room_image3}">
			</td>
		</tr>
		<tr> 
			<td colspan="3"></td>
			<td align="center">
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
}
</style>
</html>