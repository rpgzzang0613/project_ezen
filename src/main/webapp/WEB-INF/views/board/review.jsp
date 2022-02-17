<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../user_top.jsp" %>
<%@ include file="../user_searchbar.jsp"%>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<script> 
	$(document).ready(function() { 
	$("input:checkbox").on('click', function() { 
		if ( $(this).prop('checked') ) { 
			$(this).parent().addClass("selected"); 
		} else { 
			$(this).parent().removeClass("selected"); 
		} 
		}); 
	}); </script>

<div align="center"><font size="6"><b>리뷰 게시판</b></font></div><br>	
<div class="row align-center justify-between border-bottom" style="width:1000px; height: 80px; margin-right:auto; margin-left:auto;">
	<div class="row align-center">
		<i class="fas fa-star fa-2x" style="margin-right: 5px;"></i><font size="5"><b>${starAverage}</b></font><font size="4"><b>/5</b></font>
	</div>
	<span><font size="5"><b>총리뷰건수(${reviewCount}개)</b></font></span>
</div>
<div>
	<c:forEach var="review" items="${reviewList}">
	<!-- 리뷰 하나 시작 -->
	<div class="column review border-bottom" style="width: 800px; margin-left: 450px;">
		<span>
			<i class="fas fa-star"></i><font size="4"><b>${review.review_star}</b></font>/5
			<!-- review.review_nickname수정 -->
			<label><b>${review.review_nickname}님</b></label>
			<!-- review,review_roomtype수정 -->
			<label><b>객실 타입:${review.review_roomtype}</b></label>
			<label align="right"><b>작성일:${review.review_joindate}</b></label>
		</span>
		<div class="row">
			<div class="flex">
				${review.review_contents}<br>
				<c:if test="${not empty review.review_image}">
					<img class="picture" src="resources/images/review/${review.review_image}"/>
				</c:if>
			</div>
		</div>
	</div>	
	</c:forEach>
</div>
</div>				
<%@ include file="../bottom.jsp" %>