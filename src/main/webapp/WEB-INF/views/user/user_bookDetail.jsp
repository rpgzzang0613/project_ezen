<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="user_myPage.jsp" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<form name="f_bookDetail" method="post" action="user_bookCancel">
	<input type="hidden" name="book_num" value="${bdto.book_num}">
	<div style="width: 400px; margin: 0 auto;">
		<div class="row justify-center align-center border-bottom" style="height: 80px;">
			예약 상세 내역
		</div>
		<div class="column review border-bottom">
					<div class="row">
						<div class="flex column">
							<span>
										<!-- 경로수정필요 -->
							<label><img src="resources/images/hotel/${hdto.h_image1}" width="390"></label>
							<label>${hdto.h_name}</label>
							<label>${hdto.h_grade}</label>
							<label>${bdto.book_roomtype}</label>
							
							</span>
							<span>
							${fn:replace(hdto.h_address, '@', ' ')}
							</span>
						</div>
					</div>
				</div>
		<div>
			<div>
				<label>체크인</label>
				<label>${bdto.book_indate}</label>
			</div>			
			<div class="border-bottom">
				<label>체크아웃</label>
				<label>${bdto.book_outdate}</label>
			</div>
			<div>
				<label>예약번호</label>
				<label>${bdto.book_num}</label>
			</div>
			<div class="border-bottom">
				<label>예약자이름</label>
				<label>${bdto.book_name}</label>
			</div>
			<!-- null값이면 안나옴 -->
			<%-- <c:if test="${not empty bdto.book_extra}">
			<div class="border-bottom">
				<label>추가 인원</label>
				<label>${bdto.book_extra}</label>
			</div>
			</c:if> --%>
			
			<div class="border-bottom">
				<label>총결제금액</label>
				<label>${bdto.book_totalprice}</label>
			</div>
			<div>
				<label>전화문의</label>
				<label>${hdto.h_tel}</label>
			</div>
		<div class="row justify-center button-actions">
			<a href = "javascript:window.history.back();"><button type="button" style="background:#8797D4;">돌아가기</button></a>
			<c:if test="${bdto.book_status == 'wait' || bdto.book_status == 'confirm'}">
			<button type="submit" style="background:#F5D19C;">예약취소</button>
			</c:if>
		</div>
	</div>
	</div>
</form>
<%@ include file="../bottom.jsp" %>