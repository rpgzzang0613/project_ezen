<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/htm; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/companytopstyle.css">
<!-- 글꼴 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<!-- 아이콘 -->
<script src="https://kit.fontawesome.com/66da7a4b92.js" crossorigin="anonymous"> 
</script>
<title>기업 페이지</title> 
</head>
<body>  
	<nav class="navbar"><!-- 제일큰박스 -->
		<div class="navbar_logo">
			<i class="fas fa-suitcase"></i>
			<a href="company_main" style="color: #6c738a">Hotel Festival</a>
		</div>
		  
		<c:if test="${empty companyLoginOkBean}">
		<div class="partner"><a href="company_ssn" style="color: #609AE9;">이미 파트너로 등록 하셨나요?</a></div>
		<ul class="navbar_menu" >
			<li><a href="company_main" style="color: #6c738a">Home</a></li> 
			<li><a href="company_login" style="color: #6c738a">로그인</a></li>
			<li><a href="company_ssn" style="color: #6c738a">회원가입</a></li>
		</ul>
		 
		</c:if>
		<c:if test="${not empty companyLoginOkBean}">
		<ul class="navbar_menu" style="color: #6c738a">
			<li><a href="main" style="color: #6c738a">Home</a></li>
			<li><a href="company_myPage" style="color: #6c738a">기업관리</a></li>
			<li><a href="company_logout" style="color: #6c738a">로그아웃</a></li>
		<c:if test="${companyLoginOkBean.a_level == '3' }">
			<li><a href="admin_company_list" style="color: #6c738a">관리자 페이지로 이동</a></li>
		</c:if>
		</ul>  
		</c:if>		 
</nav>