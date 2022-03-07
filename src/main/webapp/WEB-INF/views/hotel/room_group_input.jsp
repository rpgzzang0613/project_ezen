<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- room_group_input.jsp -->
<html>
<head>
<meta charset="UTF-8">
<title>객실 등록</title>
</head>
<script type="text/javascript">
	function check() {
		if(f_roomGroupInput.room_name.value=="") {
			alert("객실명을 입력하셔야 합니다.")
			f_roomGroupInput.room_name.focus()
			return
		}
		if(f_roomGroupInput.room_price.value=="") {
			alert("객실 요금을 입력하셔야 합니다.")
			f_roomGroupInput.room_price.focus()
			return
		}
		if(f_roomGroupInput.max_count.value=="") {
			alert("객실 수를 입력하셔야 합니다.")
			f_roomGroupInput.max_count.focus()
			return
		}
		if(f_roomGroupInput.room_capacity.value=="") {
			alert("최대 사용 인원을 입력하셔야 합니다.")
			f_roomGroupInput.room_capacity.focus()
			return
		}
		if(f_roomGroupInput.room_extraprice.value=="") {
			alert("초과 인원 요금을 입력하셔야 합니다.")
			f_roomGroupInput.room_extraprice.focus()
			return
		}
		document.f_roomGroupInput.submit()
	}
</script>
<body>
	<%@ include file="hotel_maintop.jsp"%>
	<div align="center" style="font-weight:bold; margin-bottom:20px;">
		호텔 정보 등록 후 객실 정보를 등록합니다. 
	</div>
	<form name="f_roomGroupInput" method="post" action="room_group_input_ok" enctype="multipart/form-data">
	<input type="hidden" name="h_num" value="${h_num}">
	<input type="hidden" name="c_num" value="${c_num}">
	<table align="center" width="750"> 
		<tr> 
			<td align="left">객실 타입</td>
			<td>
				<select name="room_type">
					<option value="TWIN">TWIN</option>
					<option value="DOUBLE">DOUBLE</option>
					<option value="DELUXE">DELUXE</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>객실 이름</td>
			<td><input type="text" name="room_name"></td>
			<td>객실 요금</td>
			<td><input type="text" name="room_price">원</td>
			
		</tr>
		<tr>
			<td>객실 수</td>
			<td><input type="text" name="max_count">개</td>
			<td>최대 사용 인원</td>
			<td><input type="text" name="room_capacity">명</td>
		</tr>
		<tr>
			<td>초과인원 요금<br>(기준 1인)</td>
			<td><input type="text" name="room_extraprice"></td>
			<td>객실 이미지</td>
			<td>
				<input type="file" name="room_images" multiple><br>
				<input type="file" name="room_images" multiple><br>
				<input type="file" name="room_images" multiple><br>
			</td>
		</tr>
		<tr>
			<td colspan="3"></td>
			<td align="center">
				<input type="button" value="돌아가기" onclick="history.back()">
				<input type="button" value="등록" onclick="check()">
			</td>
		</tr>		
	</table>
	</form>
</body>
</html>