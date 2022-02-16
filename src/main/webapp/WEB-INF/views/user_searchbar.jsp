<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#plus").click(function(){
			var inwon = $("#inwon").val();
			var inwon2 = parseInt(inwon) + 1;
			if(inwon2>6){
				alert("6명 이상은 입력할 수 없습니다.");
				e.stopPropagation();
				e.preventDefault();
			}else{
				$("#inwon").attr('value',inwon2);
			}
		});
		$("#minus").click(function(e){
			var inwon = $("#inwon").val();
			var inwon2 = parseInt(inwon) - 1;
			
			if(inwon2<2){
				alert("2명 이하는 입력할 수 없습니다.");
				e.stopPropagation();
				e.preventDefault();
			}else{
				$("#inwon").attr('value',inwon2);
			}
		});
		$("#mForm").submit(function(){
			var indate = $("#indate").val();
			var outdate = $("#outdate").val();
			var today = new Date(+new Date() + 3240 * 10000).toISOString().split("T")[0];
			
			if(indate >= outdate) {
				alert('체크아웃 날짜를 확인해주세요.');
				return false;
			}
			if(indate < today) {
				alert('지난 날짜는 선택할 수 없습니다.');
				return false;
			}
		});
	});
</script>
<style>
.search-box {
	width: fit-content;
    background-color: #ffffff;
    border-radius: 8px;
    padding: 25px;
    box-shadow: 0 2px 8px rgb(0 0 0 / 20%);
    box-sizing: border-box;
    margin: 0 auto;
}
.search-box input {
	border-radius: 5px;
	border: 1px solid #1f244d;
	line-height: 40px;
}
.search-box input[type="text"], .search-box input[type="date"] {
	text-indent: 5px;
}
.search-box > div {
	margin-right: 10px;
	font-size: 13px;
}
</style>
<form name="f_searchOk" action="display_hotelSearchOk" method="post" id="mForm">
<div style="width: 100%; padding:70px 0; background:#f5f9ff;">
	<div class="row search-box">
		<div>
			지역 혹은 숙소 입력<br/>
			<input type="text" name="condition" id="location" placeholder="전체 검색" list="options" style="width: 300px;">
			<datalist id="options">
				<c:forEach var="option" items="${sessionScope.allOptions}">
					<option value="${option}">
				</c:forEach>
			</datalist>
		</div>
		<div>
			체크인 <br/>
			<input type="date" id="indate" name="indate" value="${indate}">
		</div>
		<div>
			체크아웃<br/>
			<input type="date" id="outdate" name="outdate" value="${outdate}">
		</div>
		<div style="width: 80px;">
			인원<br>
			<c:if test="${empty sessionScope.inwon}">
			<input type="text" name="inwon" id="inwon" value="2" size="1" readonly>
			</c:if>
			<c:if test="${not empty sessionScope.inwon}">
			<input type="text" name="inwon" id="inwon" size="1" value="${sessionScope.inwon}" readonly>
			</c:if>
			<span style="width: 20px; position: absolute; display:inline-block; margin-left:3px;">
				<input type="button" name="plus" id="plus" value="+" style="width: 20px; line-height: 15px; margin-bottom: 5px;">
				<input type="button" name="minus" id="minus" value="-" style="width: 20px; line-height: 15px;">
			</span>
		</div>
		<div>
			<br>
			<input type="submit" value="검색" style="cursor: pointer; width: 120px; border-radius: 50vh; border:0; background: #252e7b; color:white;">
		</div>
	</div>
</div>
</form>