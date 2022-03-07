<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    <link rel="stylesheet" href="css/topstyle.css">
<%@ include file="../user_top.jsp"%>
<c:if test = "${loginOkBean==null}">
	<c:redirect url = "main"/>
</c:if> 
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<style>

.mypageMenu ul, ol {
 list-style:none;
 padding: 0;
 margin: 0;
 height: -webkit-fill-available;
}
.mypageMenu li {
 line-height: 50px;
 font-size: 17px;
 font-weight: bold;
 cursor: pointer;
 color: white;
 text-indent: 15px;
 border-top: 1px solid #435A76;
}
.mypageMenu ol {
 display: none;
}
.mypageMenu ol > li {
 font-size: 15px;
 font-weight: 400;
 border: 0;
 text-indent: 30px;
 background: #3D5470;
}
.mypageMenu li:hover {
 background: #68809F;
}
.mypageMenu ol>li:hover { 
 background: #9AB2D1
}
.arrowIcon {
 display: inline-block;
 margin-left: 20px;
}
.arrowIcon>i {
 display: inline;
}
.mypageTable{
 border-collapse: collapse;
 margin-top: 20px;
}
</style>
<div align="center">
	<table border="1" width="1000" height="850" class="mypageTable">
		<tr height="10%"> 
			<td align="center" colspan="2" style="background:#2E3F54;color:white; font-size:30px; font-weight:bold; text-align:center;">
				My Page
			</td>
		</tr> 
		<tr>
			<td width="20%" style="background: #2E3F54;" class="mypageMenu">
				<ul>
					<li onclick="onInfoListClicked()">
					<span style="display:inline-block; text-indent:0; width:100px;">내 정보관리</span>
					<span class="arrowIcon">
						<i class="infoListIcon fas fa-chevron-down"></i>
						<i class="infoListIcon fas fa-chevron-up" style="display: none;"></i>
					</span>
					</li> 
					<li class="infoListLi" style="display:none;">
						<ol class="infoList">
							<li onclick="location.href='user_info'">정보 수정</li>
							<li onclick="location.href='user_passwordCheck'">비밀번호 변경</li>
							<li onclick="location.href='user_delete'">회원 탈퇴</li>
						</ol>
					</li>
					<li onclick="onBookListClicked()">
					<span style="display:inline-block; text-indent:0; width:100px;">예약내역</span>
					<span class="arrowIcon">
						<i class="bookListIcon fas fa-chevron-down"></i>
						<i class="bookListIcon fas fa-chevron-up" style="display: none;"></i>
					</span>
					</li> 
					<li class="bookListLi" style="display:none;">
						<ol class="bookList">
								<li onclick="location.href='user_bookList'">호텔 예약내역</li>
								<li onclick="location.href='user_bookActList'">액티비티 예약내역</li>
						</ol>
					</li>
					<li onclick="onReviewListClicked()">
					<span style="display:inline-block; text-indent:0; width:100px;">내가쓴리뷰</span>
					<span class="arrowIcon">
						<i class="reviewListIcon fas fa-chevron-down"></i>
						<i class="reviewListIcon fas fa-chevron-up" style="display: none;"></i>
					</span>
					</li>
					
					<li class="reviewListLi" style="display:none;">
						<ol class="reviewList">
							<li onclick="location.href='user_reviewList'">호텔 리뷰</li>
							<li onclick="location.href='user_reviewListAct'">액티비티 리뷰</li>
						</ol>
					</li>
					<li onclick="location.href='user_pointList'">포인트</li>
					<li onclick="location.href='list_userQnA'">Q&A</li>
				</ul>
			</td> 
		<td width="80%" align="center" valign="top" style="padding:20px;"> 
<script>  
	function onInfoListClicked() {
		const infoList = document.querySelectorAll(".infoList")
		infoList.forEach(list => {
			if(list.style.display === 'none' || !list.style.display) {
				list.style.display = "block"
				document.querySelectorAll('.infoListLi')[0].style.display = "block"
				document.querySelectorAll('.infoListIcon.fa-chevron-up')[0].style.display = "block"
				document.querySelectorAll('.infoListIcon.fa-chevron-down')[0].style.display = "none"
			} else {
				list.style.display = "none"
					document.querySelectorAll('.infoListLi')[0].style.display = "none"
				document.querySelectorAll('.infoListIcon.fa-chevron-up')[0].style.display = "none"
				document.querySelectorAll('.infoListIcon.fa-chevron-down')[0].style.display = "block"
			}
		})
	}
	function onBookListClicked() {
		const bookList = document.querySelectorAll(".bookList")
		bookList.forEach(list => {
			if(list.style.display === 'none' || !list.style.display) {
				list.style.display = "block"
				document.querySelectorAll('.bookListLi')[0].style.display = "block"
				document.querySelectorAll('.bookListIcon.fa-chevron-up')[0].style.display = "block"
				document.querySelectorAll('.bookListIcon.fa-chevron-down')[0].style.display = "none"
			} else {
				list.style.display = "none"
					document.querySelectorAll('.bookListLi')[0].style.display = "none"
				document.querySelectorAll('.bookListIcon.fa-chevron-up')[0].style.display = "none"
				document.querySelectorAll('.bookListIcon.fa-chevron-down')[0].style.display = "block"
			}
		})
	}
	function onReviewListClicked() {
		const reviewList = document.querySelectorAll(".reviewList")
		reviewList.forEach(list => {
			if(list.style.display === 'none' || !list.style.display) {
				list.style.display = "block"
				document.querySelectorAll('.reviewListLi')[0].style.display = "block"
				document.querySelectorAll('.reviewListIcon.fa-chevron-up')[0].style.display = "block"
				document.querySelectorAll('.reviewListIcon.fa-chevron-down')[0].style.display = "none"
			} else {
				list.style.display = "none"
				document.querySelectorAll('.reviewListLi')[0].style.display = "block"
				document.querySelectorAll('.reviewListIcon.fa-chevron-up')[0].style.display = "none"
				document.querySelectorAll('.reviewListIcon.fa-chevron-down')[0].style.display = "block"
			}
		})
	}
</script>