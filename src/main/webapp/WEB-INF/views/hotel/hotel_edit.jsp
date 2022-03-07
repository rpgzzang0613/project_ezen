<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- hotel_edit.jsp -->
<html>
<head>
	<meta charset="UTF-8">
	<title>호텔 정보 수정</title>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function getPostcode() {
		new daum.Postcode({
			oncomplete: function(data) {
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
	            
				if (data.userSelectedType === 'R') {
					// 사용자가 도로명 주소를 선택했을 경우
					
					addr = data.roadAddress;
					
					// 법정동명이 있을 경우 추가 (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝남
					if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
						extraAddr += data.bname;
					}
					
					// 건물명이 있고, 공동주택일 경우 추가
					if(data.buildingName !== '' && data.apartment === 'Y'){
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if(extraAddr !== ''){
						extraAddr = ' (' + extraAddr + ')';
					}
					
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("h_extraAddress").value = extraAddr;
				}else {
					// 사용자가 지번 주소를 선택했을 경우(J)
					
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
		if(f_hotelEdit.h_name.value=="") {
			alert("호텔명을 입력하셔야 합니다.")
			f_hotelEdit.h_name.focus()
			return
		}
		if(f_hotelEdit.h_manager.value=="") {
			alert("담당자를 입력하셔야 합니다.")
			f_hotelEdit.h_manager.focus()
			return
		}
		if(f_hotelEdit.h_tel.value=="") {
			alert("대표번호를 입력하셔야 합니다.")
			f_hotelEdit.h_tel.focus()
			return
		}
		if(f_hotelEdit.h_postcode.value=="") {
			alert("호텔 주소를 완전히 입력하셔야 합니다.")
			f_hotelEdit.h_postcodeBtn.focus()
			return
		}
		if(f_hotelEdit.h_address_1.value=="") {
			alert("호텔 주소를 완전히 입력하셔야 합니다.")
			f_hotelEdit.h_postcodeBtn.focus()
			return
		}
		if(f_hotelEdit.h_address_2.value=="") {
			alert("호텔 주소를 완전히 입력하셔야 합니다.")
			f_hotelEdit.h_address_2.focus()
			return
		}
		if(f_hotelEdit.h_info.value=="") {
			alert("기본 정보를 입력하셔야 합니다.")
			f_hotelEdit.h_info.focus()
			return
		}
		if(f_hotelEdit.h_notice.value=="") {
			alert("예약 규정을 입력하셔야 합니다.")
			f_hotelEdit.h_notice.focus()
			return
		}
		
		var h_address = f_hotelEdit.h_address_1.value+'@'+
		f_hotelEdit.h_extraAddress.value+'@'+
		f_hotelEdit.h_address_2.value+'@'+
		f_hotelEdit.h_postcode.value
		
		document.f_hotelEdit.h_address.value = h_address
		document.f_hotelEdit.submit()
	}
</script>
<body>
	<%@ include file="hotel_maintop.jsp"%>
	<form action="hotel_edit_ok" method="post" name="f_hotelEdit" enctype="multipart/form-data" >
	<input type="hidden" name="h_num" value="${param.h_num}">
	<input type="hidden" name="h_address" value="">
	<table border="1" align="center" width="600" height="500">
	<caption align="center">호텔 정보 수정</caption>
		<tr>
			<td align="center" style="background-color: azure;">호텔 이미지</td>
			<td>
				<table align="center">
					<tr>
						<td>
							<img src="resources/images/hotel/${hdto.h_image1}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="h_images" multiple>
							<input type="hidden" name="pre_images" value="${hdto.h_image1}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/hotel/${hdto.h_image2}" width="160" height="90">
						</td>
					
						<td>
							<input type="file" name="h_images" multiple>
							<input type="hidden" name="pre_images" value="${hdto.h_image2}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/hotel/${hdto.h_image3}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="h_images" multiple>
							<input type="hidden" name="pre_images" value="${hdto.h_image3}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/hotel/${hdto.h_image4}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="h_images" multiple>
							<input type="hidden" name="pre_images" value="${hdto.h_image4}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/hotel/${hdto.h_image5}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="h_images" multiple><br>
							<input type="hidden" name="pre_images" value="${hdto.h_image5}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" style="background-color: azure;">호텔 이름</td>
			<td><input type="text" name="h_name" value="${hdto.h_name}"></td>
		</tr>
		<tr>
			<td align="center" style="background-color: azure;">호텔 등급</td>
			<td>
				<select name="h_grade" size="1">
				<c:forTokens var="h_grades" items="3,4,5" delims=",">
				<c:if test="${hdto.h_grade == h_grades}">
					<option value="${h_grades}" selected>${h_grades}성</option>
				</c:if>
				<c:if test="${hdto.h_grade != h_grades}">
					<option value="${h_grades}">${h_grades}성</option>
				</c:if>
				</c:forTokens>
				</select>
			</td>
		</tr>
		<tr>
			<td align="center" style="background-color: azure;">호텔 담당자명</td>
			<td><input type="text" name="h_manager" value="${hdto.h_manager}"></td>
		</tr>
		<tr>
			<td align="center" style="background-color: azure;">호텔 전화번호</td>
			<td><input type="text" name="h_tel" value="${hdto.h_tel}"></td>
		</tr>
		<tr>
			<td align="center" style="background-color: azure;">호텔 주소</td>
			<td>
				<c:set var="fullAddr" value="${fn:split(hdto.h_address,'@')}"/>
				<input type="text" id="h_postcode" placeholder="우편번호" value="${fullAddr[3]}" readOnly>
				<input type="button" id="h_postcodeBtn" onclick="getPostcode()" value="검색"><br>
				<input type="text" id="h_address_1" placeholder="주소 (우편번호를 검색해 주세요)" value="${fullAddr[0]}" style="width:360px" readOnly><br>
				<input type="text" id="h_address_2" placeholder="상세 주소 (직접 입력)" value="${fullAddr[2]}">
				<input type="text" id="h_extraAddress" placeholder="참고항목" value="${fullAddr[1]}" readOnly>
			</td>
		</tr>
		<tr>
			<td align="center" style="background-color: azure;">기본 정보</td>
			<td><textarea style="resize:none;" maxlength="600" rows="5" cols="63" name="h_info">${hdto.h_info}</textarea></td>
		</tr> 
		<tr> 
			<td align="center" style="background-color: azure;">예약 규정</td>
			<td><textarea style="resize:none;" maxlength="600" rows="5" cols="63" name="h_notice">${hdto.h_notice}</textarea></td>
		</tr>
		<tr>	
			<td align="center" style="background-color: azure;">호텔 지원서비스</td>
			<td>
			<c:if test="${hdto.h_park=='y'}">
				<input type="checkbox" name="h_park" value="y" checked>주차공간
			</c:if>
			<c:if test="${hdto.h_park=='n'}">
				<input type="checkbox" name="h_park" value="y">주차공간
			</c:if>
			<c:if test="${hdto.h_meal=='y'}">
				<input type="checkbox" name="h_meal" value="y" checked>조식
			</c:if>
			<c:if test="${hdto.h_meal=='n'}">
				<input type="checkbox" name="h_meal" value="y">조식
			</c:if>
			<c:if test="${hdto.h_wifi=='y'}">
				<input type="checkbox" name="h_wifi" value="y" checked>무료-WIFI
			</c:if>
			<c:if test="${hdto.h_wifi=='n'}">
				<input type="checkbox" name="h_wifi" value="y">무료-WIFI
			</c:if>
			<c:if test="${hdto.h_ott=='y'}">
				<input type="checkbox" name="h_ott" value="y" checked>OTT 서비스<br>
			</c:if>
			<c:if test="${hdto.h_ott=='n'}">
				<input type="checkbox" name="h_ott" value="y">OTT 서비스<br>
			</c:if>
			<c:if test="${hdto.h_pool=='y'}">
				<input type="checkbox" name="h_pool" value="y" checked>수영장
			</c:if>
			<c:if test="${hdto.h_pool=='n'}">
				<input type="checkbox" name="h_pool" value="y">수영장
			</c:if>
			<c:if test="${hdto.h_kids=='y'}">
				<input type="checkbox" name="h_kids" value="y" checked>키즈존
			</c:if>
			<c:if test="${hdto.h_kids=='n'}">
				<input type="checkbox" name="h_kids" value="y">키즈존
			</c:if>
			<c:if test="${hdto.h_bus=='y'}">
				<input type="checkbox" name="h_bus" value="y" checked>셔틀버스운행
			</c:if>
			<c:if test="${hdto.h_bus=='n'}">
				<input type="checkbox" name="h_bus" value="y">셔틀버스운행
			</c:if>
			<c:if test="${hdto.h_smoke=='y'}">
				<input type="checkbox" name="h_smoke" value="y" checked>흡연구역<br>
			</c:if>
			<c:if test="${hdto.h_smoke=='n'}">
				<input type="checkbox" name="h_smoke" value="y">흡연구역<br>
			</c:if>
			<c:if test="${hdto.h_disabled=='y'}">
				<input type="checkbox" name="h_disabled" value="y" checked>장애인편의시설
			</c:if>
			<c:if test="${hdto.h_disabled=='n'}">
				<input type="checkbox" name="h_disabled" value="y">장애인편의시설
			</c:if>
			<c:if test="${hdto.h_front24=='y'}">
				<input type="checkbox" name="h_front24" value="y" checked>24시간프론트운영<br>
			</c:if>
			<c:if test="${hdto.h_front24=='n'}">
				<input type="checkbox" name="h_front24" value="y">24시간프론트운영<br>
			</c:if>
			</td>
		</tr> 
		<tr> 
			<td colspan="2" align="center">
				<input type="button" value="돌아가기" onclick="history.back()">
				<input type="button" value="수정" onclick="check()">
			</td>
		</tr>
	</table>
	</form>
	</body>
</html>