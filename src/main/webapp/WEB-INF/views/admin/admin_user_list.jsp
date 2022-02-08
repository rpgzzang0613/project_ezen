<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!Doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
</head>
<body>
<%@ include file="admin_user_top.jsp" %>

<section>
<article> 
	<h3 align="center">회원리스트</h3>
		
		<form name="f" action="admin_user_list" method="POST">
			<div class="container" align="center">
			<div style="margin:2px">
				<!-- mode 값 넘겨서 find기능 실행 -->
				<input type="hidden" name="mode" value="find"/>
				<select name="search">
					<option value="u_email">이메일</option>
					<option value="u_name">이름</option>
					<option value="u_tel">전화번호</option>
				</select> 
			</div> 
			<div style="margin:2px">
				<input type="text" name="searchString">
			</div>
			<div style="margin:2px">
				<input type="submit" value="검색">
			</div>
			<div style="margin:2px">
				<button style="margin-right:20px; float:right;" onclick="location.href= 'admin_user_list';">전체보기</button>
			</div>
			</div>
		</form>
	<p> 
</article>
<article style="margin-top:50px;">
<table align="center" border="1"> 
	<c:if test="${empty uList}">
	<tr>
		<td colspan="8"> 등록된 회원이 없습니다.</td>
	</tr>
	</c:if> 
	<tr> 
		<th style="width:5%;">No</th>
		<th style="width:5%;">이름</th>
		<th style="width:10%;">이메일</th>
		<th style="width:7%;">닉네임</th>
		<th style="width:10%;">번호</th>
		<th style="width:7%;">생년월일</th>
		<th style="width:5%;">LEVEL</th>
		<th style="width:20%;">블랙리스트 사유</th>
		<th style="width:10%;">블랙리스트 등록</th>
		<th style="width:5%;">삭제</th>
	</tr>
	<c:forEach var="udto" items="${uList}">
	<tr>
		<td style="width:5%;" align="center">${udto.u_num}</td>
		<td style="width:5%;" align="center">${udto.u_name}</td>
		<td style="width:10%;" align="center">${udto.u_email}</td>
		<td style="width:7%;" align="center">${udto.u_nickname}</td>
		<td style="width:10%;" align="center">${udto.u_tel }</td>
		<td style="width:7%;" align="center">${udto.u_birth}</td>   
		<td style="width:5%;" align="center">Lv.${udto.a_level}</td>
		<form name="f_updateBlack" method="post" action="insertBlackUser">
		<td style="width:20%;">
			<input class="search-input" type="text" name="u_black" value="${udto.u_black}">
		</td>
		<td style="width: 10%; margin:0 auto;">   
		   	<input type="hidden" name="u_num" value="${udto.u_num}">
		    <input class="search-input" type="submit" value="블랙리스트 등록">	 	 		
		</td>
		</form>
		<td style="width:5%;">
			<button class="search-input" onclick="location.href='deleteUser?u_num=${udto.u_num}'">삭제</button>
		</td>
	</tr>  
	</c:forEach>
</table>
</article>
</section>
<%@ include file="../bottom.jsp" %>
</body> 
<style>
.container {
	display: flex;
	/* display: inline-flex; */
	flex-direction: row;
	flex-wrap: nowrap;
	justify-content: center;
}
.margin-right10px{
	margin-right:10px
}
.search-input {
  width: 100%;
  height: 100%;
  padding: 0;
  border-width: 0;
  box-sizing : border-box;
}
td{
	text-align: center;
}

</style>
</html>