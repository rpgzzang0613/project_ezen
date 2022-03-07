<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_myPage.jsp" %>
<link rel="stylesheet" href="css/ReviewStar.css">
	<div style="text-align:center; margin-top: 10px;" >  
	<h3>리뷰 작성</h3>  
	<form name="form_review" method="post" action="user_reviewOk" enctype="multipart/form-data" style="margin-left:145px;">
	<input type="hidden" name="h_num" value="${h_num}">
	<input type="hidden" name="room_type" value="${room_type}">
	<input type="hidden" name="u_num" value="${u_num}">
	<input type="hidden" name="book_num" value="${book_num}">
	<table border="0"> 
		<tr>
			<th>닉네임</th>
			<td>
				${review_nickname}
				<input type="hidden" name="review_nickname" value="${review_nickname}">
			</td>
		</tr>
		<tr>
			<th>방타입</th>
			<td>
				${room_type}
				<input type="hidden" name="room_type" value="${room_type}">
			</td>
		</tr>
		<tr>
			<th>사진추가</th>
			<td><input type="file" name="review_image"></td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
			    <fieldset>
			        <input type="radio" name="star" value="5" id="rate1"><label for="rate1">⭐</label>
			        <input type="radio" name="star" value="4" id="rate2"><label for="rate2">⭐</label>
			        <input type="radio" name="star" value="3" id="rate3"><label for="rate3">⭐</label>
			        <input type="radio" name="star" value="2" id="rate4"><label for="rate4">⭐</label>
			        <input type="radio" name="star" value="1" id="rate5"><label for="rate5">⭐</label>
			    </fieldset>
			</td>
		</tr>
		<tr>
			<th>리뷰작성</th>
			<td>
				<textarea maxlength="200" style="resize:none; height:100%; width:100%;" name="review_contents" rows="13" cols="55"></textarea>
			</td> 
		</tr>
		<tr align="right">    
			<th colspan="2">
				<input type="button" value="뒤로가기" onClick="history.go(-1)">
				<input type="submit" value="글 등록" style="margin-left:3px; margin-top:15px;">
			</th>
		</tr> 
		</table>
		</form>
		</div>
<%@ include file="../bottom.jsp" %>
		