<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- hotel_edit.jsp -->
<html>
<head>
	<meta charset="UTF-8">
	<title>액티비티 정보 수정</title>
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
					document.getElementById("a_extraAddress").value = extraAddr;
				}else {
					// 사용자가 지번 주소를 선택했을 경우(J)
					
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
		if(f_activityEdit.a_name.value=="") {
			alert("프로그램명을 입력하셔야 합니다.")
			f_activityEdit.h_name.focus()
			return
		}
		if(f_activityEdit.a_manager.value=="") {
			alert("담당자를 입력하셔야 합니다.")
			f_activityEdit.h_manager.focus()
			return
		}
		if(f_activityEdit.a_tel.value=="") {
			alert("대표번호를 입력하셔야 합니다.")
			f_activityEdit.a_tel.focus()
			return
		}
		if(f_activityEdit.a_postcode.value=="") {
			alert("주소를 완전히 입력하셔야 합니다.")
			f_activityEdit.a_postcodeBtn.focus()
			return
		}
		if(f_activityEdit.a_address_1.value=="") {
			alert("주소를 완전히 입력하셔야 합니다.")
			f_activityEdit.a_postcodeBtn.focus()
			return
		}
		if(f_activityEdit.a_address_2.value=="") {
			alert("주소를 완전히 입력하셔야 합니다.")
			f_activityEdit.a_address_2.focus()
			return
		}
		if(f_activityEdit.a_info.value=="") {
			alert("기본 정보를 입력하셔야 합니다.")
			f_activityEdit.a_info.focus()
			return
		}
		if(f_activityEdit.a_notice.value=="") {
			alert("예약 규정을 입력하셔야 합니다.")
			f_activityEdit.a_notice.focus()
			return
		}
		var a_address = f_activityEdit.a_address_1.value+'@'+
		f_activityEdit.a_extraAddress.value+'@'+
		f_activityEdit.a_address_2.value+'@'+
		f_activityEdit.a_postcode.value
		
		document.f_activityEdit.a_address.value = a_address
		document.f_activityEdit.submit()
	}
</script>
<body>
	<%@ include file="activity_maintop.jsp"%>
	<form action="activity_edit_ok" method="post" name="f_activityEdit" enctype="multipart/form-data" >
	<input type="hidden" name="a_num" value="${param.a_num}">
	<input type="hidden" name="a_address" value="">
	<table border="1" align="center" width="600" height="500">
	<caption align="center">프로그램 정보 수정</caption>
		<tr>
			<td class="text-box">프로그램 <br> 이미지</td>
			<td>
				<table align="center">
					<tr>
						<td>
							<img src="resources/images/activity/${adto.a_image1}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="a_images" multiple>
							<input type="hidden" name="pre_images" value="${adto.a_image1}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/activity/${adto.a_image2}" width="160" height="90">
						</td>
					
						<td>
							<input type="file" name="a_images" multiple>
							<input type="hidden" name="pre_images" value="${adto.a_image2}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/activity/${adto.a_image3}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="a_images" multiple>
							<input type="hidden" name="pre_images" value="${adto.a_image3}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/activity/${adto.a_image4}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="a_images" multiple>
							<input type="hidden" name="pre_images" value="${adto.a_image4}">
						</td>
					</tr>
					<tr>
						<td>
							<img src="resources/images/activity/${adto.a_image5}" width="160" height="90">
						</td>
						<td>
							<input type="file" name="a_images" multiple><br>
							<input type="hidden" name="pre_images" value="${adto.a_image5}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="text-box" width="120">프로그램 <br>이름</td>
			<td><input type="text" name="a_name" value="${adto.a_name}"></td>
		</tr>
		<tr>
			<td class="text-box" width="120">액티비티 타입</td>
			<td>
				<select name="a_code" size="1">
				<c:set var="a_codelist" value="스포츠,엔터테인먼트,음악,요리,문화,학업" />
				<c:set var="a_codelist2" value="${fn:split(a_codelist, ',')}" />
				<c:forTokens var="a_codes" items="sport,ent,music,cooking,culture,study" delims=","  varStatus="n">
				<c:if test="${adto.a_code == a_codes}">
					<option value="${a_codes}" selected>${a_codelist2[n.index]}</option>
				</c:if>
				<c:if test="${adto.a_code != a_codes}">
					<option value="${a_codes}">${a_codelist2[n.index]}</option>
				</c:if>
				</c:forTokens>
				</select> 
			</td>
		<tr>
			<td class="text-box" width="120">액티비티 <br>타입추가<br>
			<td> 
			<select name="a_extracode" size="1">
				<c:set var="a_extracodeslist" value="추가선택,스포츠,엔터테인먼트,음악,요리,문화,학업" />
				<c:set var="a_extracodeslist2" value="${fn:split(a_extracodeslist, ',')}" />
				<c:forTokens var="a_extracodes" items="none,sport,ent,music,cooking,culture,study" delims="," varStatus="n">
				<c:if test="${adto.a_extracode == a_extracodes}">
					<option value="${a_extracodes}" selected>${a_extracodeslist2[n.index]}</option>
				</c:if>
				<c:if test="${adto.a_extracode != a_extracodes}">
					<option value="${a_extracodes}">${a_extracodeslist2[n.index]}</option>
				</c:if>
				</c:forTokens>
				</select> 
			</td>
		</tr>
		<tr>
			<td class="text-box" width="120">담당자명</td>
			<td><input type="text" name="a_manager" value="${adto.a_manager}"></td>
		</tr>
		<tr>
			<td class="text-box" width="120">전화번호</td>
			<td><input type="text" name="a_tel" value="${adto.a_tel}"></td>
		</tr>
		<tr>
			<td class="text-box">주소</td>
			<td>
				<c:set var="fullAddr" value="${fn:split(adto.a_address,'@')}"/>
				<input type="text" id="a_postcode" placeholder="우편번호" value="${fullAddr[3]}" readOnly>
				<input type="button" id="a_postcodeBtn" onclick="getPostcode()" value="검색"><br>
				<input type="text" id="a_address_1" placeholder="주소 (우편번호를 검색해 주세요)" value="${fullAddr[0]}" style="width:360px" readOnly><br>
				<input type="text" id="a_address_2" placeholder="상세 주소 (직접 입력)" value="${fullAddr[2]}">
				<input type="text" id="a_extraAddress" placeholder="참고항목" value="${fullAddr[1]}" readOnly>
			</td>
		</tr>
		<tr>
			<td class="text-box">기본 정보</td>
			<td><textarea rows="5" cols="63" name="a_info">${adto.a_info}</textarea></td>
		</tr>
		<tr>
			<td class="text-box">예약 규정</td>
			<td><textarea rows="5" cols="63" name="a_notice">${adto.a_notice}</textarea></td>
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
<style>
.text-box{
	background-color: azure;
	text-align:center;
}
</style>
</html>