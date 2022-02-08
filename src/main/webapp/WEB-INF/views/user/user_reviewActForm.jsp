<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="user_myPage.jsp" %>
	<div align="center"><h3>엑티비티 리뷰 게시판</h3></div>
	<form name="f" method="post" action="user_reviewActOk" enctype="multipart/form-data">
	<input input type="hidden" name="a_num" value="${a_num}">
	<input input type="hidden" name="program_type" value="${program_type}">
	<input input type="hidden" name="u_num" value="${u_num}">
	<input input type="hidden" name="ba_num" value="${ba_num}">
	<table border="0" align="center">
		<tr>
			<th>닉네임</th>
			<td>${review_nickname}
			<input type="hidden" name="review_nickname" value="${review_nickname}">
			</td>
			
		</tr>
		<tr>
			<th>프로그램명</th>
			<td>${program_type}
			<input type="hidden" name="program_type" value="${program_type}">
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
		<tr >
			<th colspan="2"><input type="submit" value="작성완료"></th>
		</tr>
		</table>
		</form>
<%@ include file="../bottom.jsp" %>