<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_myPage.jsp" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<!-- ICon만들때 적어줘야함! -->
<link rel="stylesheet" href="resources/style.css"/>
<form name="f_bookDetail" method="post" action="user_bookCancel_ok">
	<input type="hidden" name="book_num" value="${bdto.book_num}">
	<input type="hidden" name="room_price" value="${room_price}">
	<div style="width: 400px; margin: 0 auto;">
		<div class="row justify-center align-center border-bottom" style="height: 80px;">
			결제 상세 내역
		</div>
		
		<div class="payment-info">
			<div>
				<label><img src="resources/images/hotel/${h_image1}"></label>
			</div>
			
			<div>
				<label>결제일시(예약날짜)${bdto.book_num}</label>
				<label>${bdto.book_joindate}</label>
			</div>
			
			
			<div>
				<label>상품가격</label>
				<label>${room_price}</label>
			</div>
			
			<div>
				<label>결제시 사용포인트</label>
				<label>${bdto.book_usepoint}</label>
			</div>
			
			<div>
				<label>총 결제금액</label>
				<label>${bdto.book_totalprice}</label>
			</div>
			
			<div>
				<label>포인트환금(사용포인트-적립포인트)</label>
				<label>${bdto.book_usepoint - bdto.book_savepoint}</label>
			</div>
			
			<div class="border-bottom">
				<label>최종환불금액</label>
				<label>${bdto.book_totalprice}</label>
			</div>
		</div>
		<div class="row justify-center button-actions">
			<!-- 마이페이지 예약현황으로 이동시키기 -->
			<a href="user_bookList"><button type="button" style="background:#8797D4;">돌아가기</button></a>
			<a href="user_bookCancel_ok?book_num=${bdto.book_num}"><button type="submit" style="background:#F5D19C;">예약취소</button></a>
		</div>
	</div>
</form>
<%@ include file="../bottom.jsp" %>