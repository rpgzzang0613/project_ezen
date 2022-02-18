<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file ="company_myPage.jsp" %>
<meta charset="UTF-8">
<script type="text/javascript">
	function checkall(){
		document.f.addr1.value = document.getElementById('sample4_postcode').value
		document.f.addr2.value = document.getElementById('sample4_roadAddress').value 
		document.f.addr4.value = document.getElementById("sample4_detailAddress").value
		
		if (f.c_name.value==""){
			alert("기업이름을 입력하셔야 합니다.")
			f.c_name.focus()
			return false
		}
		if (f.c_tel.value==""){
			alert("대표번호를 입력하셔야 합니다.")
			f.c_tel.focus()
			return false
		}
		if (f.addr1.value==""){
			alert("주소를 모두 입력하셔야 합니다.")
			f.addr1.focus()
			return false
		}
		if (f.addr2.value==""){
			alert("주소를 모두 입력하셔야 합니다.")
			f.addr2.focus()
			return false
		}
		if (f.addr3.value==""){
			alert("주소를 모두 입력하셔야 합니다.")
			f.addr3.focus()
			return false
		}
		if (f.addr4.value==""){
			alert("주소를 모두 입력하셔야 합니다.")
			f.addr4.focus()
			return false
		}  

		document.f.submit()
	} 
</script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	            if(fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }
	 
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('sample4_roadAddress').value = fullRoadAddr;
	            document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
				
	            // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample4_detailAddress").focus();

	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	             if(data.autoRoadAddress) {
                   //예상되는 도로명 주소에 조합형 주소를 추가한다.
                   var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                   
                   document.getElementById('sample4_jibunAddress').value = expRoadAddr
                   document.f.addr3.value = expRoadAddr;
               } else if(data.autoJibunAddress) {
                   var expJibunAddr = data.autoJibunAddress;
                   
                   document.getElementById('sample4_jibunAddress').value = expJibunAddr
                   document.f.addr3.value = expJibunAddr;
               } else {
                   document.getElementById('guide').innerHTML = '';
                   document.f.addr3.value = document.getElementById('sample4_jibunAddress').value;
               }
	        }
	    }).open();  
	}
</script>
<form action="company_edit_ok" method="POST" name="f" enctype="multipart/form-data">
	<table border="1" align="center" width="600" height="500">
		<tr>
			<td colspan="3">기업 정보</td>
		</tr>
		<tr>
			<td>기업 로고</td>
			<td><img src="resources/images/company/${cdto.c_image}" width="80" height="80">
			<input type="hidden" name="pre_image" value="${cdto.c_image}"/>
			</td> 
			<td><input type="file" name="c_image">
		</tr>
		<tr>
			<td width="50">기업 이름</td>
			<td colspan="2">
				<input type="text" name="c_name" value="${cdto.c_name}">
			</td>
		</tr>
		<tr>
			<td width="50">기업 대표번호</td>
			<td colspan="2">
				<input type="text" name="c_tel" value ="${cdto.c_tel}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
			</td>
		</tr>
		<tr>
			<td width="50">본사 주소</td>
			<td colspan="2">
			<c:set var="fullAddr" value="${fn:split(cdto.c_address,'@')}"/>
				<input type="text" id="sample4_postcode" name="sample4_postcode" placeholder="우편번호" value="${fullAddr[0]}" readOnly>
				<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="sample4_roadAddress" name ="sample4_roadAddress" placeholder="도로명주소" value="${fullAddr[1]}" readOnly>
				<input type="text" id="sample4_jibunAddress" name ="sample4_jibunAddress" placeholder="지번주소" value="${fullAddr[2]}" readOnly>
				<input type="text" id="sample4_detailAddress" name ="sample4_detailAddress" placeholder="상세주소" value="${fullAddr[3]}">
				<span id="guide" style="color:#999"></span>
			</td>
		</tr>  
		<tr>
			<td width="50">대표 이메일</td>
			<td colspan="2">
				<input type="text" name="c_email" value="${cdto.c_email}" readonly>
			</td>
		</tr>
		<tr>
			<td width="50">사업자 번호</td>
			<td colspan="2">
				<input type="text" name="c_bnum" value="${cdto.c_bnum}" readonly>
			</td>
		</tr>
		<tr> 
			<td colspan="3" align="center">
				<c:set var="fullAddr" value="${fn:split(cdto.c_address,'@')}"/>
				<input type="hidden" name="addr1" value="${fullAddr[0]}"> <!-- db넣을때 addr1,2,3 합쳐서 c_address로 넣기 -->
				<input type="hidden" name="addr2" value="${fullAddr[1]}">
				<input type="hidden" name="addr3" value="${fullAddr[2]}">
				<input type="hidden" name="addr4" value="${fullAddr[3]}">
				<button type="button" onclick="checkall()">수정</button>
			</td>
		</tr>
	</table>
</form>	
<%@ include file="../bottom.jsp" %>