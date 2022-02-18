<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../activitymain/activity_top.jsp" %>
<%@ include file="../activitymain/activity_searchbar.jsp"%>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<script>
	function sleep(ms) {
	  const wakeUpTime = Date.now() + ms;
	  while (Date.now() < wakeUpTime) {}
	}
	function wishActCReleaseOK(a_num, u_num){
		var child = window.open("wishActCReleaseOK?a_num="+a_num+"&u_num="+u_num, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	function wishActCCheckOK(a_num, u_num){
		var child = window.open("wishActCCheckOK?a_num="+a_num+"&u_num="+u_num, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
</script>
	<div style="width: 1000; margin: 0 auto;">
		<div class="booking">
			<div class="selectedImage">
				<img src="resources/images/activity/${adto.a_image1}" id="selectedImage">
			</div>
			<div class="row justify-between images" id="bookingImages">
				<img src="resources/images/activity/${adto.a_image1}">
				<img src="resources/images/activity/${adto.a_image2}">
				<img src="resources/images/activity/${adto.a_image3}">
				<img src="resources/images/activity/${adto.a_image4}">
				<img src="resources/images/activity/${adto.a_image5}">
			</div>
		</div>
			<!-- 추가내용 -->
		<div class="row align-center" style="margin-top: 10px; justify-content:flex-end;">
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
						<a href="javascript:wishActCReleaseOK('${adto.a_num}','${loginOkBean.u_num}')"><i class="fas fa-heart"></i></a>
					</c:if>
					<c:if test="${adto.wishList eq '0'}">
						<a href="javascript:wishActCCheckOK('${adto.a_num}','${loginOkBean.u_num}')"><i class="far fa-heart"></i></a>
					</c:if>
				</c:if>						
			</span>		
		</div>
		<div class="border-bottom">
			<span class="spanLeft">
				<b>프로그램명: ${adto.a_name}</b>
			</span>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="spanLeft">
				<b>담당자: ${adto.a_manager}</b>
			</span>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span>
				<b>고객센터: ${adto.a_tel}</b>
			</span>
		</div>
		<div class="border-bottom">
			<span>
				<i class="far fa-star"></i>${avgReviewPoint} / 5
			</span>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span>
				후기(${reviewCount}개)
			</span>
		</div>
		<div>
			상세주소: ${adto.a_address}
		</div>
		<c:if test="${empty programList}">
			<h2 align="center">등록된 프로그램이 없습니다</h2>
		</c:if>
		<c:if test="${not empty programList}">
			<c:forEach var="pdto" items="${programList}">
			<c:if test="${empty loginOkBean}">	
			<form name="f" method="POST" action="user_needLogin">
			</c:if>
			<c:if test="${not empty loginOkBean}">	
			<form name="f_bookingAct" method="POST" action="user_bookActWriteForm">
			</c:if>
				<table align="center" width="1000" style="cursor:pointer;" 
				onmouseover="this.bgColor='#F9EDA5'" onmouseout="this.bgColor=''">
					<tr>
						<td rowspan="3" width="200">
							<img class="picture" src="resources/images/activity/${adto.a_image1}" width="160" height="90">
						</td>
						<td width="600">프로그램명 : ${pdto.p_name}</td>
						<td rowspan="3" align="center">
						<c:set var="left" value="${pdto.p_maxbooker - pdto.p_currentbooker}"/>
						<c:if test="${left <= 3}">
						<b><font color="red" size="4">매진임박!</font></b><br>남은자리: <b><font color="red" size="5">${left}</font></b>개<br>
						</c:if>
						<c:if test="${left > 3}">
						남은 자리: <b><font size="4">${left}</font></b>개<br>
						</c:if>
						<c:if test="${pdto.p_maxbooker - pdto.p_currentbooker > 0}">
							<input type="submit" value="예약하기">
							<input type="hidden" value="${pdto.p_num}" name="p_num">
							<input type="hidden" name="canBooker" value=" ${pdto.p_maxbooker - pdto.p_currentbooker}">
						</c:if>
						<c:if test="${pdto.p_maxbooker - pdto.p_currentbooker <= 0}">
							<input type="button" value="매진" onclick="#">
						</c:if>
						</td>
					</tr>
					<tr>
						<td>프로그램 가격 : ${pdto.p_price}원 / (1인)</td>
					</tr>
				</table>
			</form>
			</c:forEach>
		</c:if>
		<div class="booking border row">
			<b>프로그램 정보 : </b><br>${adto.a_info}
		</div>
		<div class="booking border row">
			<b>공지사항 : </b><br>${adto.a_notice}
		</div>
		<div class="booking border row">
			<b>프로그램 위치지도</b>
		</div>
		<input type="hidden" id="addr" value="${showAddr}">
		<input type="hidden" id="hotelN" value="${adto.a_name}">
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2f24176f9573eaaf0fc762f8cebc19f7&libraries=services"></script>
		<div id="map" style="width:1000px;height:500px;"></div>
		<div id="clickLatlng"></div>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨
		    };  
		
			var hotelName = $("#hotelN").val();
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			// 주소로 좌표를 검색합니다
			var addr = $("#addr").val();
			geocoder.addressSearch(addr, function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				var message = result[0].y + ', '+result[0].x;
				
				var resultDiv = document.getElementById('clickLatlng'); 
				//resultDiv.innerHTML = message;
				
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">' + hotelName + '</div>'
		        });
		        infowindow.open(map, marker);
		
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		  	  	} 
			});	
		</script>
		<table align="center" width="1000">
			<tr>
				<td align="left">후기(${reviewCount}개)</td>
				<td align="right"><a href="reviewAct?a_num=${adto.a_num}">전체보기</a></td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					<i class="far fa-star"></i>${avgReviewPoint} / 5 &nbsp;&nbsp;&nbsp;&nbsp;(최근 12개월 누적 평점)
				</td>
			</tr>
			
			<c:forEach var="review" items="${reviewList}" begin="0" end="1">
			<tr>
				<td colspan="2"><br></td>
			</tr>
			<tr>
				<td align="left" colspan="2"><i class="far fa-star"></i>${review.review_star} / 5 </td>
				
			</tr>
			<tr>
				<td align="left">${review.review_nickname} / ${review.review_programtype}</td>
				<td align="right">작성일&nbsp;${review.review_joindate}</td>
			</tr>
			<tr>
				<td align="left" colspan="2">${review.review_contents}</td>
			</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="2"><a href="reviewAct?a_num=${adto.a_num}">전체 후기 보기</a><br>(후기 ${reviewCount}개)</td>
			</tr>
		</table>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		let bookingImages = $('#bookingImages').children('img')
		$(bookingImages).each(function (index, el) {
			$(this).click(function() {
				let selectedSrc = $(el).attr('src')
				$('#selectedImage').attr('src', selectedSrc)
			})
		});
	});
</script>
<%@ include file="../bottom.jsp" %>