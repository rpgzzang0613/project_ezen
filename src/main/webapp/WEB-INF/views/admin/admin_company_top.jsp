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
<title>관리자 페이지</title> 
</head>
<c:if test = "${companyLoginOkBean.a_level ne '3'}">
	<c:redirect url="company_main"/>
</c:if>
<body>
	<nav class="navbar">
		<div class="navbar_logo">
			<i class="fas fa-suitcase"></i>
			<a href="admin_company_list" style="color: #6c738a">Hotel Festival</a>
		</div>
		<ul class="navbar_menu">  
			<li><a href="admin_company_list" style="color: #6c738a">기업 리스트</a></li>
			<li><a href="admin_partner_req_list" style="color: #6c738a">제휴 신청 리스트</a></li>
			<li><a href="list_companyQnA?a_level=3" style="color: #6c738a">Q&A</a></li>
			<li><a href="main" style="color: #6c738a">메인페이지</a></li>
		</ul>   
	</nav>