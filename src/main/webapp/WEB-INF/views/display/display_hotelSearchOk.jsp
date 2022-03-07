<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="../user_top.jsp" %>
<%@ include file="../user_searchbar.jsp"%>
<script type="text/javascript">
	function sleep(ms) {
	  const wakeUpTime = Date.now() + ms;
	  while (Date.now() < wakeUpTime) {}
	}
	function wishReleaseOK(h_num, u_num){
		var child = window.open("wishReleaseOK?h_num="+h_num+"&u_num="+u_num, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	function wishCheckOK(h_num, u_num){
		var child = window.open("wishCheckOK?h_num="+h_num+"&u_num="+u_num, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	function goHotelContent(h_num) {
		document.f_searchOk.action = "display_hotelContent?h_num="+h_num;
		document.f_searchOk.submit();
	}
	
	function goNextFilter(filter, condition) {
		document.f_searchOk.action = "display_hotelSearchOk?filter="+filter+"&condition="+condition;
		document.f_searchOk.submit();
	}
</script>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
	<div class="align-center" style="width: 1000; margin: 0 auto;" >
		<div class="row justify-center align-center" style="border:1px solid grey;">
			<a href="javascript:goNextFilter('maxReview','${condition}')">
				<button style= "background:#79B8D6">후기 많은 순</button>
			</a>
			<a href="javascript:goNextFilter('minReview','${condition}')">
				<button style= "background:#79B8D6">후기 적은 순</button>
			</a>
			<a href="javascript:goNextFilter('maxPrice','${condition}')">
				<button style= "background:#79B8D6">높은 가격 순</button>
			</a>
			<a href="javascript:goNextFilter('minPrice','${condition}')">
				<button style= "background:#79B8D6">낮은 가격 순</button>
			</a>
			<a href="javascript:goNextFilter('maxStar','${condition}')">
				<button style= "background:#79B8D6">평점 높은 순</button>
			</a>
		</div>
		<c:forEach var="hdto" items="${hotelList}">
		<div class="column review border-bottom">	
			<div class="row">
				<a href="javascript:goHotelContent('${hdto.h_num}')"><img class="picture" src="resources/images/hotel/${hdto.h_image1}"/></a>
				<div class="flex column">
					<span>
					<label>
						<i class="fas fa-star"></i>
								${hdto.reviewAvg}/5점
								후기 수(${hdto.reviewCount})
					</label>
					</span>
					<span>
						<label>${hdto.h_name}</label>
						<label>${hdto.h_grade}성급</label>
					</span>
					<span>
						${fn:replace(hdto.h_address, '@', ' ')}
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
						<c:if test="${hdto.wishList ne '0'}">
							<a href="javascript:wishReleaseOK('${hdto.h_num}','${loginOkBean.u_num}','${param.location}')"><i class="fas fa-heart"></i></a>
						</c:if>
						<c:if test="${hdto.wishList eq '0'}">
							<a href="javascript:wishCheckOK('${hdto.h_num}','${loginOkBean.u_num}','${param.location}')"><i class="far fa-heart"></i></a>
						</c:if>
					</c:if>
					
					</span>	
				</div> 
			</div>
		</div>	
		</c:forEach>
	</div>
<%@ include file="../bottom.jsp"%>