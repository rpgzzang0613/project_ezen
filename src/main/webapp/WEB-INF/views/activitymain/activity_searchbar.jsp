<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />   
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
	/* 캘린더 */ 
	$(function() {
		$("#cal").datepicker({
			changeMonth: true,
			changeYear: true, 
			prevText: '이전 달',
			nextText: '다음 달',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			dateFormat: "yy-mm-dd", 
			yearRange: "c-99:c+99", 
			minDate: "+0d;", 
			maxDate: "+2y;"
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
<form name="f_activitySearchOk" action="display_activitySearchOk" method="post" id="mForm">
	<div style="width: 100%; padding:70px 0; background:#f5f9ff;">
		<div class="row search-box">
			<div>
				지역 혹은 액티비티 입력<br/>
				<input type="text" name="search" id="search" placeholder="활동&지역 검색" list="actOptions" style="width: 300px;">
				<input type="hidden" name="code" id="code" value="">
				<datalist id="actOptions">
					<c:forEach var="actOptions" items="${sessionScope.allActOptions}">
						<option value="${actOptions}">
					</c:forEach>
				</datalist>
			</div>
			<div>
				날짜 선택<br/>
				<input type="date" id="cal" name="bookdate" value="${bookdate}" autocomplete="off" readonly>
			</div>
			<div>
				<br>
				<input type="submit" value="검색" style="cursor: pointer; width: 120px; border-radius: 50vh; border:0; background: #252e7b; color:white;">
			</div>
		</div> 
	</div>
</form>
</form>