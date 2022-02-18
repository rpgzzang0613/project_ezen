<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="company_myPage.jsp" %>
<!-- company_partner_req.jsp -->
<script type="text/javascript">
	function check() {
		if(f_partner_req.c_licenseimage.value=="") {
			alert("사업자 등록증을 업로드하셔야 합니다.")
			f_partner_req.c_licenseimage.focus()
			return
		}
		if(f_partner_req.c_bankname1.value=="") {
			alert("은행을 선택하셔야 합니다.")
			f_partner_req.c_bankname1.focus()
			return
		}
		if(f_partner_req.c_bankaccount1.value=="") {
			alert("계좌를 입력하셔야 합니다.")
			f_partner_req.c_bankaccount1.focus()
			return
		}
		if(f_partner_req.c_bankname2.value=="" && f_partner_req.c_bankaccount2.value!="") {
			alert("은행을 선택하셔야 합니다.")
			f_partner_req.c_bankname2.focus()
			return
		}
		if(f_partner_req.c_bankname2.value!="" && f_partner_req.c_bankaccount2.value=="") {
			alert("계좌를 입력하셔야 합니다.")
			f_partner_req.c_bankaccount2.focus()
			return
		}
		
		document.f_partner_req.submit()
	}
</script>
<form name="f_partner_req" method="POST" action="company_partner_req_ok" enctype="multipart/form-data">
<input type="hidden" name="c_num" value="${companyLoginOkBean.c_num}">
<table border="1" align="center" width="600">
	<tr>
		<td colspan="2" align="center">제휴 신청</td>
	</tr>
	<tr>
		<td>사업자 등록증</td>
		<td><input type="file" name="c_licenseimage"></td>
	</tr>
	<tr>
		<td>계좌번호 (필수)</td>
		<td style="padding:0; width:400">
			<select name="c_bankname1">
				<option value="" selected>은행 선택</option>
				<option value="신한">신한</option>
				<option value="국민">국민</option>
				<option value="우리">우리</option>
				<option value="하나">하나</option>
				<option value="농협">농협</option>
				<option value="카카오">카카오</option>
				<option value="토스">토스</option>
			</select>
			<input type="text" name="c_bankaccount1" 
			style="width:300px; margin:0 auto;" 
			onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">
		</td>
	</tr>
	<tr>
		<td>예비 계좌번호</td>
		<td style="padding:0; width:400">
			<select name="c_bankname2">
				<option value="" selected>은행 선택</option>
				<option value="신한">신한</option>
				<option value="국민">국민</option>
				<option value="우리">우리</option>
				<option value="하나">하나</option>
				<option value="농협">농협</option>
				<option value="카카오">카카오</option>
				<option value="토스">토스</option>
			</select>
			<input type="text" name="c_bankaccount2" 
			style="width:300px; margin:0 auto;" 
			onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9]/g,'');">
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<button type="button" onclick="check()">제휴신청</button>
			<button type="button" onclick="location.href='company_myPage'">돌아가기</button>
		</td>
	</tr>
</table>
</form>