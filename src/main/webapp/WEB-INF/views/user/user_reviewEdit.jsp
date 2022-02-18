<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_myPage.jsp" %>
<link rel="stylesheet" href="css/ReviewStar.css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
	<h3 align="center">리뷰수정하기</h3>
	<form name="f" method="post" action="user_reviewEditOk" enctype="multipart/form-data">
	<input input type="hidden" name="review_num" value="${rdto.review_num}">
	<table border="1" align="center">
		<tr>
			<th>닉네임</th>
			<td>${rdto.review_nickname}
			</td>
		</tr>
		<tr>
			<th>방타입</th>
			<td>${rdto.review_roomtype}
			</td>
		</tr>
		<tr>
			<th>사진추가</th>
			<td>
				<img src="resources/images/review/${rdto.review_image}" width="300" height="200">
				<input type="file" name="newImage">
				<input type="hidden" name="pastImage" value="${rdto.review_image}">
			</td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
			    <fieldset>
			    <c:forEach var="i" begin="1" end="5" step="1">
			    	<c:set var="num" value="${6-i}"/>
			    	<c:if test="${num eq rdto.review_star}">
			        	<input type="radio" name="star" value="${num}" id="rate${i}" checked><label for="rate${i}">⭐</label>
			        </c:if>
			        <c:if test="${num ne rdto.review_star}">
			        	<input type="radio" name="star" value="${num}" id="rate${i}"><label for="rate${i}">⭐</label>
			        </c:if>
			    </c:forEach>
			    </fieldset>
			</td>
		</tr>
		<tr>
			<th>리뷰작성</th>
			<td>
				<textarea name="review_contents" rows="13" cols="55">${rdto.review_contents}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="button" onclick="javascript:history.back()">돌아가기</button>
				<input type="submit" value="수정하기">
			</td>
		</tr>
		</table>
		</form>
<%@ include file="../bottom.jsp" %>