<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta charset="UTF-8">
<title>블랙리스트 페이지</title>
</head> 
<body>
<%@ include file="admin_user_top.jsp" %>
<section> 
<article> 
	<h3 align="center">블랙리스트</h3>
	<form align="center" action="admin_user_blacklist" method="POST">
<div class="container" align="center">
			<div style="margin-auto:2px">
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
				<button style="margin-right:20px; float:right;" onclick="location.href='admin_user_blacklist';">전체보기</button>
			</div>
			</div>
	</form>
	<p>
</article>
<article style="margin-top:50px;">
	<form name="f_updateBlack" method="post" action="saveBlackContent">
	<table align="center" border="1" width="500px">
		<tr>
			<th style="width:10%;">이메일</th>
			<th style="width:5%;">이름</th>
			<th style="width:20%;">블랙리스트 사유</th>
			<th style="width:7%;">수정</th>
			<th style="width:7%;">해제</th>
		</tr>	
		<c:if test="${empty buList}">
		<tr> 
			<td colspan="8"> 등록된 회원이 없습니다.</td>
		</tr>
		</c:if>	
		<c:forEach var="budto" items="${buList}"> 
		<tr>	 
			<td style="width:10%;">${budto.u_email}</td> 
			<td style="width:5%;">${budto.u_name}</td>  
			<td style="width:20%;">
				<input class="search-input" type="text" name="u_black" value="${budto.u_black}">
			</td>
			<td style="width:7%;">
		   		<input class="search-input" type="hidden" name="u_num" value="${budto.u_num}">
		   		<input class="search-input" type="submit" value="수정">
			</td>
			<td style="width:7%;">
				<button type="button" class="search-input" onclick="location.href='deleteBlackUser?u_num=${budto.u_num}'">해제</button> 
			</td>
		</tr>  
		</c:forEach>
	</table>
	</form>
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