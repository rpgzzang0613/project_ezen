<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- activity_input.jsp -->
<html>
<head>
	<meta charset="UTF-8">
	<title>액티비티 등록</title>
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
				document.getElementById("a_extraAddress").value = extraAddr;
			}else { // 사용자가 지번 주소를 선택했을 경우(J)
				addr = data.jibunAddress;
			
				document.getElementById("a_extraAddress").value = '';
			}
			
			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			document.getElementById("a_postcode").value = data.zonecode;
			document.getElementById("a_address_1").value = addr;
			
			// 커서를 상세주소 필드로 이동한다.
			document.getElementById("a_address_2").focus();
		}
	}).open();
}
</script>
<script type="text/javascript">
	function check() {
		if(f_activityInput.a_name.value=="") {
			alert("상품명을 입력하셔야 합니다.")
			f_activityInput.a_name.focus()
			return
		}
		if(f_activityInput.a_manager.value=="") {
			alert("담당자를 입력하셔야 합니다.")
			f_activityInput.a_manager.focus()
			return
		}
		if(f_activityInput.a_code.value=="") {
			alert("타입을 선택하셔야합니다")
			f_activityInput.a_code.focus()
			return
		}
		if(f_activityInput.a_tel.value=="") {
			alert("대표번호를 입력하셔야 합니다.")
			f_activityInput.a_tel.focus()
			return
		}
		if(f_activityInput.a_postcode.value=="") {
			alert("주소를 완전히 입력하셔야 합니다.")
			f_activityInput.a_postcodeBtn.focus()
			return
		}
		if(f_activityInput.a_address_1.value=="") {
			alert("주소를 완전히 입력하셔야 합니다.")
			f_activityInput.a_postcodeBtn.focus()
			return
		}
		if(f_activityInput.a_address_2.value=="") {
			alert("주소를 완전히 입력하셔야 합니다.")
			f_activityInput.a_address_2.focus()
			return
		}
		if(f_activityInput.a_info.value=="") {
			alert("기본 정보를 입력하셔야 합니다.")
			f_activityInput.a_info.focus()
			return
		}
		if(f_activityInput.a_notice.value=="") {
			alert("예약 규정을 입력하셔야 합니다.")
			f_activityInput.a_notice.focus()
			return
		}
		
		var a_address = f_activityInput.a_address_1.value+'@'+
		f_activityInput.a_extraAddress.value+'@'+
		f_activityInput.a_address_2.value+'@'+
		f_activityInput.a_postcode.value
		
		document.f_activityInput.a_address.value = a_address
		document.f_activityInput.submit()
	}
</script>
<body>
	<%@ include file="activity_maintop.jsp"%> 
	<div align="center" style="font-weight:bold; margin-top:10px;">
		액티비티 정보 등록 후 프로그램 정보를 등록합니다. 
	</div>
	<form name="f_activityInput" method="post" action="activity_input_ok" enctype="multipart/form-data" >
	<input type="hidden" name="c_num" value="${c_num}">
	<input type="hidden" name="a_address" value="">
	<table border="1" align="center" width="600" height="500">
		<tr> 
			<td class="title-box">액티비티 이미지</td>
			<td>
				<input type="file" name="a_images" multiple><br>
				<input type="file" name="a_images" multiple><br>
				<input type="file" name="a_images" multiple><br>
				<input type="file" name="a_images" multiple><br>
				<input type="file" name="a_images" multiple><br>
			</td>
		</tr>
		<tr>
			<td class="title-box" width="120">프로그램 이름</td>
			<td><input type="text" name="a_name"></td>
		</tr>
		<tr>
			<td class="title-box" width="120">프로그램 타입</td>
			<td>
				<select name="a_code" size="1">
					<option value="">필수선택</option>
					<option value="sport">스포츠</option>
					<option value="ent">엔터테인먼트</option>
					<option value="music">음악</option>
					<option value="cooking">요리</option>
					<option value="culture">문화</option>
					<option value="study">학업</option>
				</select> 
			</td>
		<tr>
			<td class="title-box" width="120">프로그램<br>타입추가<br>
			<td> 
				<select name="a_extracode" size="1">
					<option value="none">추가 선택</option>
					<option value="sport">스포츠</option>
					<option value="ent">엔터테인먼트</option>
					<option value="music">음악</option>
					<option value="cooking">요리</option>
					<option value="culture">문화</option>
					<option value="study">학업</option>
				</select> 
			</td>
		</tr>
		<tr>
			<td class="title-box" width="120">액티비티<br>담당자명</td>
			<td><input type="text" name="a_manager"></td>
		</tr>
		<tr>
			<td class="title-box" width="120">액티비티<br>전화번호</td>
			<td><input type="text" name="a_tel"></td>
		</tr>
		<tr>
			<td class="title-box">주소</td>
			<td>
				<input type="text" id="a_postcode" placeholder="우편번호" readOnly>
				<input type="button" id="a_postcodeBtn" onclick="getPostcode()" value="검색"><br>
				<input type="text" id="a_address_1" placeholder="주소 (우편번호를 검색해 주세요)" style="width:360px" readOnly><br>
				<input type="text" id="a_address_2" placeholder="상세 주소 (직접 입력)">
				<input type="text" id="a_extraAddress" placeholder="참고항목" readOnly>
			</td>
		</tr>
		<tr>
			<td class="title-box">기본 정보</td>
			<td><textarea style="resize:none;" maxlength="600" rows="5" cols="63" name="a_info"></textarea></td>
		</tr>
		<tr>
			<td class="title-box">예약 규정</td>
			<td><textarea style="resize:none;" maxlength="600" rows="5" cols="63" name="a_notice"></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="돌아가기" onclick="history.back()">
				<input type="button" value="액티비티 등록" onclick="check()">
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