<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_myPage.jsp" %>    

<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="resources/ReviewList.css"/>
	
	<div style="font-weight:bold; font-size: 25px; margin-top: 10px;"> 
		작성한 액티비티 리뷰 목록
	</div> 
	
	<c:if test="${empty listReview}">
		<div style=" font-weight:bold; font-size: 20px; padding:7rem;">
			작성하신 리뷰가 없습니다.
		</div>
	</c:if> 
	<c:set var = "num" value = "${number}"/>
	<c:if test="${not empty listReview}">
	<c:forEach var="rdto" items="${listReview}">
	<div class="parent border" style="margin-top: 5px; ">
		<div class="title"  style="display: flex; justify-content: space-between;width: 100%; height: 15%"> 
			<div style="float:left;">
			No.${num}  ${rdto.review_programtype}	
			</div>
			<div style="float:right; ">
			${rdto.review_joindate} 
			</div>  
		</div>  
		<div class="justify-left " style="width:100%; height: 85%; position: relative;">
			<div style="width: 30%;">  
			  <c:if test="${not empty rdto.review_image}">
			  	<div class="product-img-div">
				  	<img class="picture" src="resources/images/review/${rdto.review_image}"/>
				</div>
			  </c:if>
			  <c:if test="${empty rdto.review_image}">
				  	<div class="product-img-div">
				  		<img class="picture" src="resources/images/hotel/default.jpg">
				  	</div>
			  </c:if>
			  <div style="display:flex; flex-wrap:wrap; height:40%;margin-top:5px;"> 
				<span>닉네임: ${rdto.review_nickname}</span>
				<span>별점 : <i class="fas fa-star"></i>${rdto.review_star} / 5점</span>
			  </div>  
			</div>
			<div style="width:70%;">
			<div style="text-align:left; height:15%">
			리뷰 내용 
			</div>
			<div style="text-align:left; overflow:auto; text-overflow : ellipsis; height:70%">
			${rdto.review_contents}
			</div>
			<div style="text-align:right; height:15%">
			<a href="deleteActReview?review_num=${rdto.review_num}"><span style="color:red;">삭제</span></a> |
			<a href="editActReview?review_num=${rdto.review_num}"><span style="color:blue;">수정</span></a>
			</div> 
			</div>
		</div>
	</div>
	<c:set var="num" value="${num-1}"/>
	</c:forEach>
	</c:if>

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