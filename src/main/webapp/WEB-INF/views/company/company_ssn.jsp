<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file ="company_top.jsp" %>
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
		if(f_check.c_bnum.value==""){
			alert("사업자 번호를 입력하셔야 합니다.")
			f_check.c_bnum.focus()
			return
		}
		document.f_check.submit()
	}
</script>
<div align="center">
	<hr color="black" width="300">
	<h2>회 원 가 입 유 무</h2>
	<hr color="black" width="300">
	<form name="f_check" action="company_check" method="post">
		<table width="500" class="outline">
			<tr>
				<th>기업명</th>
				<td><input type="text" name="c_name"></td>
			</tr>
			<tr>
				<th>대표메일</th>
				<td><input type="text" name="c_email"></td>
			<tr>
				<th>사업자 번호</th>
				<td><input type="text" name="c_bnum"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" onclick="check()" value="조회"
					style="width:80px;height:35px;background-color:grey;color:white;border-color:grey">
					<input type="reset" value="취소"
					style="width:80px;height:35px;background-color:grey;color:white;border-color:grey">
				</td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../bottom.jsp" %>