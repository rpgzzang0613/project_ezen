<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../activitymain/activity_top.jsp" %>
<%@ include file="../activitymain/activity_searchbar.jsp"%>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<script>
	function sleep(ms) {
	  const wakeUpTime = Date.now() + ms;
	  while (Date.now() < wakeUpTime) {}
	}
	function wishActReleaseOK(a_num, u_num, location){
		var child = window.open("wishActReleaseOK?a_num="+a_num+"&u_num="+u_num+"&location="+location, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	function wishActCheckOK(a_num, u_num, location){
		var child = window.open("wishActCheckOK?a_num="+a_num+"&u_num="+u_num+"&location="+location, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	function goNext(code, search) {
		document.getElementById("code").value = code;
		document.getElementById("search").value = search;
		document.f_activitySearchOk.submit();
	}
</script>
<div class="align-center" style="width: 1000; margin: 0 auto;">
<div class="row justify-center align-center">
	<a href="javascript:goNext('sport','${param.search}')">
		<button type="button" style="background-color:black;color:white;border-color:black">스포츠</button>
	</a><br>
	<a href="javascript:goNext('study','${param.search}')">
		<button type="button" style="background-color:black;color:white;border-color:black">학업</button>
	</a><br>
	<a href="javascript:goNext('ent','${param.search}')">
		<button type="button" style="background-color:black;color:white;border-color:black">엔터테인먼트</button>
	</a><br>
	<a href="javascript:goNext('music','${param.search}')">
		<button type="button" style="background-color:black;color:white;border-color:black">음악</button>
	</a><br>
	<a href="javascript:goNext('cooking','${param.search}')">
		<button type="button" style="background-color:black;color:white;border-color:black">요리</button>
	</a><br>
	<a href="javascript:goNext('culture','${param.search}')">
		<button type="button" style="background-color:black;color:white;border-color:black">문화</button>
	</a><br>
</div>
	<c:forEach var="adto" items="${activityList}">
		<div class="column review border-bottom">	
			<div class="row">
				<a href="display_activityContent?a_num=${adto.a_num}"><img class="picture" src="resources/images/activity/${adto.a_image1}"/></a>
				<div class="flex column">
					<span>
						<label>
							<i class="fas fa-star"></i>
									${adto.avgReviewPoint}/5점
									후기 수(${adto.reviewCount})
						</label>
					</span>
					<span>
						<label>${adto.a_name}</label>
					</span>
					<span>
					<c:set var="fullAddr" value="${fn:split(adto.a_address,'@')}"/>
						${fullAddr[0]} ${fullAddr[1]} ${fullAddr[2]}
					</span>
				</div>
				<div>
					<span>
					<i class="fas fa-share-alt-square"></i>
						<!-- wishList가 체크된 방은 검은하트, 체크안된방은 빈 하트로 표시 -->
						<!-- 비회원 표시 -->
						<c:if test="${empty loginOkBean}">
							<!-- 로그인 화면으로 보내거나, 이전페이지로 보내면 될듯 -->
							<a href="user_needLogin"><i class="far fa-heart"></i></a>
						</c:if>
						<!-- 로그인 회원 표시 -->
						<!-- 누를때마다 이벤트 발생하게 해야함 -->
						<c:if test="${not empty loginOkBean}">
							<c:if test="${adto.wishList ne '0'}">
								<a href="javascript:wishActReleaseOK('${adto.a_num}','${loginOkBean.u_num}','${param.location}')"><i class="fas fa-heart"></i></a>
							</c:if>
							<c:if test="${adto.wishList eq '0'}">
								<a href="javascript:wishActCheckOK('${adto.a_num}','${loginOkBean.u_num}','${param.location}')"><i class="far fa-heart"></i></a>
							</c:if>
						</c:if>						
					</span>	
				</div>
			</div>
		</div>	
	</c:forEach>
</div>
<%@ include file="../bottom.jsp"%>