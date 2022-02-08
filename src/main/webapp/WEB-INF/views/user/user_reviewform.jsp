<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_myPage.jsp" %>
	<div style="text-align:center;">
	<h3>리뷰게시판</h3>
	<form name="f" method="post" action="user_reviewOk" enctype="multipart/form-data" style="margin-left:145px;">
	<input input type="hidden" name="h_num" value="${h_num}">
	<input input type="hidden" name="room_type" value="${room_type}">
	<input input type="hidden" name="u_num" value="${u_num}">
	<input input type="hidden" name="book_num" value="${book_num}">
	<table border="0" >
		<tr>  
			<th>닉네임</th>
			<td>${review_nickname}
			<input type="hidden" name="review_nickname" value="${review_nickname}">
			</td>
			
		</tr>
		<tr>
			<th>방타입</th>
			<td>${room_type}
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
				<select name="star">
					<option value="1">★</option>
					<option value="2">★★</option>
					<option value="3">★★★</option>
					<option value="4">★★★★</option>
					<option value="5">★★★★★</option>
				</select>
			</td>
		</tr> 
		<tr>
			<th>리뷰작성</th>
			<td><textarea name="review_contents" rows="13" cols="55"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2"><input type="submit" value="작성완료" style="margin-left:30px; margin-top:13px;"></th>
		</tr>
		</table>
		</form>
		</div>
<%@ include file="../bottom.jsp" %>
		