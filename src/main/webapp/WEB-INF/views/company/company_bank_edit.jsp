<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file ="company_myPage.jsp" %>
<!-- company_bank_edit.jsp -->
<script type="text/javascript">
	function check() {
		if(f_bank_edit.c_bankname1.value=="") {
			alert("은행을 선택하셔야 합니다.")
			f_bank_edit.c_bankname1.focus()
			return
		}
		if(f_bank_edit.c_bankaccount1.value=="") {
			alert("계좌를 입력하셔야 합니다.")
			f_bank_edit.c_bankaccount1.focus()
			return
		}
		if(f_bank_edit.c_bankname2.value=="" && f_bank_edit.c_bankaccount2.value!="") {
			alert("은행을 선택하셔야 합니다.")
			f_bank_edit.c_bankname2.focus()
			return
		}
		if(f_bank_edit.c_bankname2.value!="" && f_bank_edit.c_bankaccount2.value=="") {
			alert("계좌를 입력하셔야 합니다.")
			f_bank_edit.c_bankaccount2.focus()
			return
		}
		
		document.f_bank_edit.submit()
	}
</script>
<form name="f_bank_edit" method="POST" action="company_bank_edit_ok">
<input type="hidden" name="c_num" value="${cdto.c_num}">
<table border="1" align="center" width="600">
	<tr>
		<td colspan="2" align="center">계좌 수정</td>
	</tr>
	<tr>
		<td>계좌번호 (필수)</td>
		<td style="padding:0; width:400">
			<select name="c_bankname1">
			<c:forTokens var="banknames1" items="신한,국민,우리,하나,농협,카카오,토스" delims=",">
			<c:if test="${cdto.c_bankname1 eq banknames1}">
				<option value="${cdto.c_bankname1}" selected>${cdto.c_bankname1}</option>
			</c:if>
			<c:if test="${cdto.c_bankname1 ne banknames1}">
				<option value="${banknames1}">${banknames1}</option>
			</c:if>
			</c:forTokens>
			</select>
			<input type="text" name="c_bankaccount1" value="${cdto.c_bankaccount1}" 
			style="width:300px; margin:0 auto;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</td>
	</tr>
	<tr>
		<td>예비 계좌번호</td>
		<td style="padding:0; width:400">
			<select name="c_bankname2">
			<c:forTokens var="banknames2" items="은행 선택,신한,국민,우리,하나,농협,카카오,토스" delims=",">
			<c:if test="${cdto.c_bankname2 eq banknames2}">
				<option value="${cdto.c_bankname2}" selected>${cdto.c_bankname2}</option>
			</c:if>
			<c:if test="${cdto.c_bankname2 ne banknames2}">
				<c:if test="${banknames2 eq '은행 선택'}">
				<option value="">${banknames2}</option>
				</c:if>
				<c:if test="${banknames2 ne '은행 선택'}">
				<option value="${banknames2}">${banknames2}</option>
				</c:if>
			</c:if>
			</c:forTokens>
			</select>
			<input type="text" name="c_bankaccount2" value="${cdto.c_bankaccount2}" 
			style="width:300px; margin:0 auto;" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" onclick="check()">계좌 수정</button>
			<button type="button" onclick="location.href='company_myPage'">돌아가기</button>
		</td>
	</tr>
</table>
</form>
<%@ include file="../bottom.jsp" %>