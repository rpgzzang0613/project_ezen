<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- home_input.jsp -->
<html>
<head>
	<meta charset="UTF-8">
	<title>호텔 등록</title>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function getPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {	// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 각 주소의 노출 규칙에 따라 주소를 조합한다.
			var addr = ''; // 주소 변수
			var extraAddr = ''; // 참고항목 변수
            
			if (data.userSelectedType === 'R') {	// 사용자가 도로명 주소를 선택했을 경우
				addr = data.roadAddress;
				
				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
					extraAddr += data.bname;
				}
				
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if(data.buildingName !== '' && data.apartment === 'Y'){
					extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				}
				
				// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if(extraAddr !== ''){
					extraAddr = ' (' + extraAddr + ')';
				}
				
				// 조합된 참고항목을 해당 필드에 넣는다.
				document.getElementById("h_extraAddress").value = extraAddr;
			}else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			
				document.getElementById("h_extraAddress").value = '';
			}
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("h_postcode").value = data.zonecode;
			document.getElementById("h_address_1").value = addr;
			
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("h_address_2").focus();
		}
	}).open();
}
</script>
<script type="text/javascript">
	function check() {
		if(f_hotelInput.h_name.value=="") {
			alert("호텔명을 입력하셔야 합니다.")
			f_hotelInput.h_name.focus()
			return
		}
		if(f_hotelInput.h_manager.value=="") {
			alert("담당자를 입력하셔야 합니다.")
			f_hotelInput.h_manager.focus()
			return
		}
		if(f_hotelInput.h_tel.value=="") {
			alert("대표번호를 입력하셔야 합니다.")
			f_hotelInput.h_tel.focus()
			return
		}
		if(f_hotelInput.h_postcode.value=="") {
			alert("호텔 주소를 완전히 입력하셔야 합니다.")
			f_hotelInput.h_postcodeBtn.focus()
			return
		}
		if(f_hotelInput.h_address_1.value=="") {
			alert("호텔 주소를 완전히 입력하셔야 합니다.")
			f_hotelInput.h_postcodeBtn.focus()
			return
		}
		if(f_hotelInput.h_address_2.value=="") {
			alert("호텔 주소를 완전히 입력하셔야 합니다.")
			f_hotelInput.h_address_2.focus()
			return
		}
		if(f_hotelInput.h_info.value=="") {
			alert("기본 정보를 입력하셔야 합니다.")
			f_hotelInput.h_info.focus()
			return
		}
		if(f_hotelInput.h_notice.value=="") {
			alert("예약 규정을 입력하셔야 합니다.")
			f_hotelInput.h_notice.focus()
			return
		}
		
		var h_address = f_hotelInput.h_address_1.value+'@'+
		f_hotelInput.h_extraAddress.value+'@'+
		f_hotelInput.h_address_2.value+'@'+
		f_hotelInput.h_postcode.value
		
		document.f_hotelInput.h_address.value = h_address
		document.f_hotelInput.submit()
	}
</script>
<body>
	<%@ include file="hotel_maintop.jsp"%>
	<div align="center" style="font-weight:bold; margin-bottom:20px;">
		호텔 정보 등록 후 객실 정보를 등록합니다. 
	</div> 
	<form name="f_hotelInput" method="post" action="hotel_input_ok" enctype="multipart/form-data" >
	<input type="hidden" name="c_num" value="${c_num}">
	<input type="hidden" name="h_address" value="">
	<table border="1" align="center" width="600" height="500">
		<tr>
			<td class="title-box">호텔 이미지</td>
			<td>
				<input type="file" name="h_images" multiple><br>
				<input type="file" name="h_images" multiple><br>
				<input type="file" name="h_images" multiple><br>
				<input type="file" name="h_images" multiple><br>
				<input type="file" name="h_images" multiple><br>
			</td>
		</tr>
		<tr>
			<td class="title-box" width="120">호텔 이름</td>
			<td><input type="text" name="h_name"></td>
		</tr>
		<tr>
			<td class="title-box" width="120">호텔 등급</td>
			<td>
				<select name="h_grade" size="1">
					<option value="3">3성</option>
					<option value="4">4성</option>
					<option value="5">5성</option>
				</select> 
			</td>
		</tr>
		<tr>
			<td class="title-box" width="120">호텔 담당자명</td>
			<td><input type="text" name="h_manager"></td>
		</tr>
		<tr>
			<td class="title-box" width="120">호텔 전화번호</td>
			<td><input type="text" name="h_tel"></td>
		</tr>
		<tr>
			<td class="title-box">호텔 주소</td>
			<td>
				<input type="text" id="h_postcode" placeholder="우편번호" readOnly>
				<input type="button" id="h_postcodeBtn" onclick="getPostcode()" value="검색"><br>
				<input type="text" id="h_address_1" placeholder="주소 (우편번호를 검색해 주세요)" style="width:360px" readOnly><br>
				<input type="text" id="h_address_2" placeholder="상세 주소 (직접 입력)">
				<input type="text" id="h_extraAddress" placeholder="참고항목" readOnly>
			</td>
		</tr>
		<tr>
			<td class="title-box">기본 정보</td>
			<td><textarea style="resize:none;" maxlength="600" rows="5" cols="63" name="h_info"></textarea></td>
		</tr>
		<tr>
			<td class="title-box">예약 규정</td>
			<td><textarea style="resize:none;" maxlength="600" rows="5" cols="63" name="h_notice"></textarea></td>
		</tr>
		<tr>	 
			<td class="title-box">호텔 지원서비스</td>
			<td>
				<input type="checkbox" name="h_park" value="y">주차공간
				<input type="checkbox" name="h_meal" value="y">조식
				<input type="checkbox" name="h_wifi" value="y">무료-WIFI
				<input type="checkbox" name="h_ott" value="y">OTT 서비스<br>
				<input type="checkbox" name="h_pool" value="y">수영장
				<input type="checkbox" name="h_kids" value="y">키즈존
				<input type="checkbox" name="h_bus" value="y">셔틀버스운행
				<input type="checkbox" name="h_smoke" value="y">흡연구역<br>
				<input type="checkbox" name="h_disabled" value="y">장애인편의시설
				<input type="checkbox" name="h_front24" value="y">24시간프론트운영
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="돌아가기" onclick="history.back()">
				<input type="button" value="객실등록으로 이동" onclick="check()">
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