<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file ="company_top.jsp" %>
<!-- company_ssn.jsp -->
<script type="text/javascript">
	function check() {
		if(f_check.c_name.value=="") {
			alert("기업명을 입력하셔야합니다.")
			f_check.c_name.focus()
			return
		}
		if(f_check.c_email.value=="") {
			alert("대표메일을 입력하셔야합니다.")
			f_check.c_email.focus()
			return
		}
		if (f_check.c_email.value.indexOf('@') == -1){
			alert("이메일 양식을 맞추셔야 합니다.")
			f.c_email.focus()
			return false
		}
		 
		if (f_check.c_email.value.indexOf('.') == -1){
			alert("이메일 양식을 맞추셔야 합니다.")
			f.c_email.focus()
			return false
		}
		if(f_check.c_bnum.value==""){
			alert("사업자 번호를 입력하셔야 합니다.")
			f_check.c_bnum.focus()
			return
		}
		document.f_check.submit()
	}
</script>
<div align="center">
	<h3>회 원 가 입 유 무</h3>
	<form name="f_check" action="company_check" method="post">
		<table>
			<tr>
				<th>기업명</th>
				<td>
					<input type="text" name="c_name" placeholder="회사명을 입력해 주세요." 
					tabindex="2" style="width:300px;height:50px" 
					required oninvalid="this.setCustomValidity('회사명을 입력해주세요.')" 
					oninput="setCustomValidity('')">
				</td>
			</tr>
			<tr>
				<th>대표메일</th>
				<td>
					<input type="email" name="c_email" placeholder="회사 메일을 입력해 주세요." 
					tabindex="2" style="width:300px;height:50px" 
					required oninvalid="this.setCustomValidity('회사 메일을 입력해주세요.')" 
					oninput="setCustomValidity('')" onKeyup="this.value=this.value.replace(/[^a-zA-Z0-9@.]/g,'');">
				</td>
			<tr>
				<th>사업자 번호</th>
				<td>
					<input type="text" name="c_bnum" placeholder="사업자 번호를 입력해 주세요." 
					tabindex="2" style="width:300px;height:50px" 
					required oninvalid="this.setCustomValidity('사업자 번호를 입력해주세요.')" 
					oninput="setCustomValidity('')" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
				</td>
			</tr>
			<tr>
				<th></th>
				<td colspan="2" align="center">
					<input type="button" onclick="check()" value="조회"
					style="width:147.5px;height:35px;background-color:black;color:white;border-color:black">
					<input type="reset" value="취소"
					style="width:147.5px;height:35px;background-color:black;color:white;border-color:black">
				</td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../bottom.jsp" %>