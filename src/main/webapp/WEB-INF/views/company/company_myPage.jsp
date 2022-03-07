<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 마이페이지 리스트 include -->
<%@ include file="company_top.jsp"%>
<!-- 로그인 안하고 넘어가질때 있었는데 이를 방지 (추후삭제예정) -->
<c:if test = "${companyLoginOkBean==null}">
	<c:redirect url="company_main"/>
</c:if>
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
			Company My Page
		</td>
	</tr> 
	<tr>
		<td width="20%" style="background: #2E3F54;" class="mypageMenu">
			<ul> 
				<li onclick="onInfoListClicked()">
				<span style="display:inline-block; text-indent:0; width:100px;">정보 관리</span>
				<span class="arrowIcon">
					<i class="infoListIcon fas fa-chevron-down"></i>
					<i class="infoListIcon fas fa-chevron-up" style="display: none;"></i>
				</span>
				</li>
				<li class="infoListLi" style="display:none;">
					<ol class="infoList">
						<li onclick="location.href='company_edit?c_num=${companyLoginOkBean.c_num}'">정보 수정</li>
						<c:if test="${companyLoginOkBean.a_level eq 2}">
						<li onclick="location.href='company_bank_edit?c_num=${companyLoginOkBean.c_num}'">계좌 변경</li>
						</c:if>
						<li onclick="location.href='company_passwordCheck'">비밀번호 변경</li>
						<li onclick="location.href='company_delete'">회원탈퇴</li>
					</ol>
				</li>
				<c:if test="${companyLoginOkBean.a_level eq 2}">
				<li onclick="onContentListClicked()">
				<span style="display:inline-block; text-indent:0; width:100px;">컨텐츠 관리</span>
				<span class="arrowIcon">
					<i class="contentListIcon fas fa-chevron-down"></i>
					<i class="contentListIcon fas fa-chevron-up" style="display: none;"></i>
				</span>
				</li>
				<li class="contentListLi" style="display:none;">
					<ol class="contentList">
						<li onclick="location.href='hotel_main'">호텔 관리</li>
						<li onclick="location.href='activity_main'">액티비티 관리</li>
					</ol> 
				</li>  
				</c:if>
				<c:if test="${companyLoginOkBean.a_level eq 1}">
				<li onclick="location.href='company_partner_req_wait'">제휴 신청 현황</li>
				</c:if>
				<c:if test="${companyLoginOkBean.a_level eq 0}">
				<li onclick="location.href='company_partner_req'">제휴 신청</li>
				</c:if> 
				<li onclick="location.href='list_companyQnA'">Q&A</li>
			</ul>
		</td>
		<td width="80%" align="center" valign="top" style="padding:20px;"> 			
<script> 
function hotelmain(){
	window.open("hotel_main", "", "_blank");
}
</script>
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
			document.querySelectorAll('.infoListLi')[0].style.display = "block"
			document.querySelectorAll('.infoListIcon.fa-chevron-up')[0].style.display = "none"
			document.querySelectorAll('.infoListIcon.fa-chevron-down')[0].style.display = "block"
		}
	})
}

function onContentListClicked() {
	const contentList = document.querySelectorAll(".contentList")
	contentList.forEach(list => {
		if(list.style.display === 'none' || !list.style.display) {
			list.style.display = "block"
			document.querySelectorAll('.contentListLi')[0].style.display = "block"
			document.querySelectorAll('.contentListIcon.fa-chevron-up')[0].style.display = "block"
			document.querySelectorAll('.contentListIcon.fa-chevron-down')[0].style.display = "none"
		} else {
			list.style.display = "none"
			document.querySelectorAll('.contentListLi')[0].style.display = "block"
			document.querySelectorAll('.contentListIcon.fa-chevron-up')[0].style.display = "none"
			document.querySelectorAll('.contentListIcon.fa-chevron-down')[0].style.display = "block"
		}
	})
}
</script>