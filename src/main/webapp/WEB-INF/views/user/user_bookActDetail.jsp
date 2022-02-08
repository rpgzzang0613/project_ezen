<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="user_myPage.jsp" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<form name="f_bookActDetail" method="post" action="user_bookActCancel">
	<input type="hidden" name="ba_num" value="${badto.ba_num}">
	<div style="width: 400px; margin: 0 auto;">
		<div class="row justify-center align-center border-bottom" style="height: 80px;">
			예약 상세 내역
		</div>
		<div class="column review border-bottom">
					<div class="row">
						<div class="flex column">
							<span>
							<label><img src="resources/images/activity/${adto.a_image1}" width="390"></label>
							<label>${adto.a_name}</label>
							</span>
							<span>
							${fn:replace(adto.a_address, '@', ' ')}
							</span>
						</div>
					</div>
				</div>
		<div>
			<div>
				<label>예약일</label>
				<label>${badto.ba_bookdate}</label>
			</div>
			<div>
				<label>예약번호</label>
				<label>${badto.ba_num}</label>
			</div>
			<div class="border-bottom">
				<label>예약자이름</label>
				<label>${badto.ba_name}</label>
			</div>
			<div class="border-bottom">
				<label>총결제금액</label>
				<label>${badto.ba_totalprice}</label>
			</div>
			<div>
				<label>전화문의</label>
				<label>${adto.a_tel}</label>
			</div>
		<div class="row justify-center button-actions">
			<a href = "javascript:window.history.back();"><button type="button" style="background:#8797D4;">돌아가기</button></a>
			<c:if test="${badto.ba_status == 'wait' || badto.ba_status == 'confirm'}">
			<button type="submit" style="background:#F5D19C;">예약취소</button>
			</c:if>
		</div>
	</div>
	</div>
</form>
<%@ include file="../bottom.jsp" %>