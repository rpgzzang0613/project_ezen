<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>    

<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>

	<table border="1" align="center" width="90%">
		<caption><b>내가 쓴 리뷰 목록</b></caption>
	<c:if test="${empty listReview}">
		<tr>
			<td align="center">작성하신 리뷰가 없습니다.</td>
		</tr>
	</c:if>
	
	<c:set var = "num" value = "${number}"/>
	<c:if test="${not empty listReview}">
		<c:forEach var="rdto" items="${listReview}">
			<tr>
				<td colspan="5">No.${num}</td>
			</tr>
			<tr align="center">
				<td><font color="gray">닉네임: </font>${rdto.review_nickname}</td>
				<td><i class="fas fa-star"></i>${rdto.review_star} / 5점</td>
				<td><font color="gray">방 타입: </font>${rdto.review_roomtype}</td>
				<td><font color="gray">작성일: </font>${rdto.review_joindate}</td>
				<td><a href="editReview?review_num=${rdto.review_num}">수정</a></td>
			</tr>
			<tr>
				<td colspan="5" valign="top"><font color="gray">리뷰 내용: </font><br>${rdto.review_contents}</td>
			</tr>
			<c:if test="${not empty rdto.review_image}">
				<tr>
					<td colspan="5">
						<img class="picture" src="resources/images/review/${rdto.review_image}"/>
					</td>
				</tr>
			</c:if>
			<tr>
				<td colspan="5" align = "right"><a href="deleteReview?review_num=${rdto.review_num}">삭제</a></td>
			</tr>
			<c:set var="num" value="${num-1}"/>
			
		</c:forEach>
	</c:if>
	</table>
	
	<c:if test="${rowCount > 0 }">
	<div align="center">
		<c:if test="${startPage > pageBlock}">
			<a href="user_reviewList?pageNum=${startPage - pageBlock}">[이전]</a>
		</c:if>
		
		<c:forEach var = "i" begin = "${startPage}" end = "${endPage}">
			<a href="user_reviewList?pageNum=${i}">[${i}]</a>	
		</c:forEach>
		
		<c:if test = "${endPage < pageCount}">
			<a href="user_reviewList?pageNum=${startPage + pageBlock}">[다음]</a>	
		</c:if>
		</c:if>
	</div>
    
<%@ include file="../bottom.jsp" %>