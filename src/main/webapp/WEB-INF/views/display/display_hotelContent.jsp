<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 <script type="text/javascript">
 	function sleep(ms) {
	  const wakeUpTime = Date.now() + ms;
	  while (Date.now() < wakeUpTime) {}
	}
 	function wishReleaseHC(h_num, u_num, location, inwon){
		var child = window.open("wishReleaseHC?h_num="+h_num+"&u_num="+u_num+"&location="+location+"&inwon="+inwon, "search","width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	function wishCheckHC(h_num, u_num, location, inwon){
		var child = window.open("wishCheckHC?h_num="+h_num+"&u_num="+u_num+"&location="+location+"&inwon="+inwon, "search", "width=10, height=10");
		window.parent.location.reload();
		sleep(300);
		child.close();
	}
	
 	$(document).ready(function(){
 		$("#mForm").submit(function(){
 			var indate2 = $("#indate1").val();
 			var outdate2 = $("#outdate1").val();
 			var date1 = indate2.split('-');
			var in_date = new Date(indate2);
 			var date2 = outdate2.split('-');
 			var out_date = new Date(outdate2);
 			
    		var date = new Date();
    		if(indate2 != ''){
        		if(outdate2 != ''){
		    		if(date.getDay() <= in_date.getDay()){
		    			if(in_date.getDay() > out_date.getDay()){
		     				alert("체크인아웃 날짜보다 체크인 날짜가 먼저여야 합니다");
		     				return false;
		     			}
		    		} else {
		    			alert("지난 날짜는 선택 할 수 없습니다.");
		    			return false;
		    		}
        		}else{
        			alert('체크아웃 날짜를 지정해주세요');
        			return false;
        		}
        	}else{
        		alert('체크인 날짜를 지정해주세요');
        		return false;
        	}
 		});
 	});
 </script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<%@ include file="../user_top.jsp" %>
<%@ include file="../user_searchbar.jsp" %>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
	<div style="width: 1000; margin: 0 auto;">
		<div class="booking">
			<div class="selectedImage">
				<img src="resources/images/hotel/${hdto.h_image1}" id="selectedImage">
			</div>
			<div style="margin-top:2px;" class="row justify-between images" id="bookingImages">
				<img style="width:19.5%;"src="resources/images/hotel/${hdto.h_image1}">
				<img style="width:19.5%;"src="resources/images/hotel/${hdto.h_image2}">
				<img style="width:19.5%;"src="resources/images/hotel/${hdto.h_image3}">
				<img style="width:19.5%;"src="resources/images/hotel/${hdto.h_image4}">
				<img style="width:19.5%;"src="resources/images/hotel/${hdto.h_image5}">
			</div>
		</div>
			<!-- 추가내용 -->
		<div class="row align-center" style="margin-top: 10px; justify-content:flex-end;">
			<span>
			<i class="fas fa-share-alt-square"></i>
				<!-- 비회원 표시 -->
				<c:if test="${empty loginOkBean}">
					<!-- 로그인 화면으로 보내거나, 이전페이지로 보내면 될듯 -->
					<a href="user_needLogin"><i class="far fa-heart"></i></a>
				</c:if>
				<!-- 로그인 회원 표시 -->
				<c:if test="${not empty loginOkBean}">
					<c:if test="${hdto.wishList eq '1'}">
						<a href="javascript:wishReleaseHC('${hdto.h_num}','${loginOkBean.u_num}','${param.location}','${sessionScope.inwon}')"><i class="fas fa-heart"></i></a>
					</c:if>
					<c:if test="${hdto.wishList eq '0'}">
						<a href="javascript:wishCheckHC('${hdto.h_num}','${loginOkBean.u_num}','${param.location}','${sessionScope.inwon}')"><i class="far fa-heart"></i></a>
					</c:if>
				</c:if>
			</span>
		</div>
		<div class="border-bottom">
			<span class="spanLeft">
				${hdto.h_name}
			</span>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span class="spanLeft">
				${hdto.h_grade}성급
			</span>
			<br>
			<span>
				<i class="far fa-star"></i>${starAverage} / 5
			</span>
			&nbsp;&nbsp;&nbsp;&nbsp;
			<span>
				${reviewCount}
			</span>
		</div> 
		<div>
			${fn:replace(hdto.h_address, '@', ' ')}
		</div>
		<c:if test="${not empty twinRoom}">
		<div style="text-align: center; font-weight:bold;">TWIN ROOM</div>
			<c:forEach var="tRoom" items="${twinRoom}">
				<c:if test="${tRoom.room_capacity+2 >= sessionScope.inwon}">
				<table class="roomTable" align="center" style="cursor:pointer;" 
				onmouseover="this.bgColor='#F9EDA5'" onmouseout="this.bgColor=''"
				onclick="location.href='display_roomContent?room_code=${tRoom.room_code}&h_num=${hdto.h_num}' " width="800">
					<tr>
						<td width="25%" rowspan="4">
							<img class="picture" src="resources/images/room/${tRoom.room_image1}" width="160" height="90"/>
						</td>
						<td width="50%">${tRoom.room_type}&nbsp;[${tRoom.room_name}]</td>
						<td></td>
					</tr>
					<tr>
						<td>Late&nbsp;Check-in&nbsp;18시</td>
						<td align="right">판매가</td>
					</tr>
					<tr>
						<td>기준&nbsp;${tRoom.room_capacity}명&nbsp;/&nbsp;최대&nbsp;${tRoom.room_capacity + 2}명</td>
						<td align="right">${tRoom.room_price}원</td>					
					</tr>
					<tr>
						<td>숙박&nbsp;18:00&nbsp;부터</td>
						<td></td>
					</tr>
				</table>
				</c:if>
			</c:forEach>
			<br>
		</c:if>
		<c:if test="${not empty doubleRoom}">
			<div style="text-align: center; font-weight:bold;">DOUBLE ROOM</div>
			<c:forEach var="dbRoom" items="${doubleRoom}">
				<c:if test="${dbRoom.room_capacity+2 >= sessionScope.inwon}">
				<table class="roomTable" align="center" style="cursor:pointer;" 
				onmouseover="this.bgColor='#F9EDA5'" onmouseout="this.bgColor=''"
				onclick="location.href='display_roomContent?room_code=${dbRoom.room_code}&h_num=${hdto.h_num}' " width="800">
					<tr>
						<td width="25%" rowspan="4">
							<img class="picture" src="resources/images/room/${dbRoom.room_image1}" width="160" height="90"/>
						</td>
						<td width="50%">${dbRoom.room_type}&nbsp;[${dbRoom.room_name}]</td>
						<td></td>
					</tr>
					<tr>
						<td>Late&nbsp;Check-in&nbsp;18시</td>
						<td align="right">판매가</td>
					</tr>
					<tr>
						<td>기준&nbsp;${dbRoom.room_capacity}명&nbsp;/&nbsp;최대&nbsp;${dbRoom.room_capacity + 2}명</td>
						<td align="right">${dbRoom.room_price}원</td>					
					</tr>
					<tr>
						<td>숙박&nbsp;18:00&nbsp;부터</td>
						<td></td>
					</tr>
				</table>
				</c:if>
			</c:forEach>
			<br>
		</c:if>
		<c:if test="${not empty deluxeRoom}">
		<div style="text-align: center; font-weight:bold;">DELUXE ROOM</div>
			<c:forEach var="dxRoom" items="${deluxeRoom}">
				<c:if test="${dxRoom.room_capacity+2 >= sessionScope.inwon}">
				<table class="roomTable" align="center" style="cursor:pointer;" 
				onmouseover="this.bgColor='#F9EDA5'" onmouseout="this.bgColor=''"
				onclick="location.href='display_roomContent?room_code=${dxRoom.room_code}&h_num=${hdto.h_num}' " width="800">
					<tr>
						<td width="25%" rowspan="4">
							<img class="picture" src="resources/images/room/${dxRoom.room_image1}" width="160" height="90"/>
						</td>
						<td width="50%">${dxRoom.room_type}&nbsp;[${dxRoom.room_name}]</td>
						<td></td>
					</tr>
					<tr>
						<td>Late&nbsp;Check-in&nbsp;18시</td>
						<td align="right">판매가</td>
					</tr>
					<tr>
						<td>기준&nbsp;${dxRoom.room_capacity}명&nbsp;/&nbsp;최대&nbsp;${dxRoom.room_capacity + 2}명</td>
						<td align="right">${dxRoom.room_price}원</td>					
					</tr>
					<tr>
						<td>숙박&nbsp;18:00&nbsp;부터</td>
						<td></td>
					</tr>
				</table>
				</c:if>
			</c:forEach>
			<br>
		</c:if>
	<input type="hidden" id="addr" value="${map_addr}">
	<input type="hidden" id="hotelN" value="${hdto.h_name}">
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe10c33359dd79a3e93e06cb153c4c9a&libraries=services"></script>
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
		function wishCheck1(h_num, u_num, location){
			var child = window.open("wishRelease2?h_num="+h_num+"&u_num="+u_num+"&location="+location, "search","width=10, height=10");
			window.parent.location.reload();
			child.close();
		}
		function wishCheck2(h_num, u_num, location){
			var child = window.open("wishCheck2?h_num="+h_num+"&u_num="+u_num+"&location="+location, "search", "width=10, height=10");
			window.parent.location.reload();
			child.close();
		}
	</script>
		
	<div class="booking border row" width="1000">
		<span align="center">
			<c:if test="${hdto.h_park eq 'y'}">
				<img src="resources/images/hotel/service/parking.png" width="100" height="80"><br>
				주차가능
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_meal eq 'y'}">
				<img src="resources/images/hotel/service/breakfast.png" width="100" height="80"><br>
				조식
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_wifi eq 'y'}">
				<img src="resources/images/hotel/service/wifi.png" width="100" height="80"><br>
				와이파이
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_disabled eq 'y'}">
				<img src="resources/images/hotel/service/disabled.png" width="100" height="80"><br>
				장애인 시설
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_ott eq 'y'}">
				<img src="resources/images/hotel/service/ott.png" width="100" height="80"><br>
				OTT서비스
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_pool eq 'y'}">
				<img src="resources/images/hotel/service/pool.png" width="100" height="80"><br>
				수영장
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_kids eq 'y'}">
				<img src="resources/images/hotel/service/kidszone.png" width="100" height="80"><br>
				키즈존
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_bus eq 'y'}">
				<img src="resources/images/hotel/service/shuttlebus.png" width="100" height="80"><br>
				셔틀버스
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_smoke eq 'y'}">
				<img src="resources/images/hotel/service/smoke.png" width="100" height="80"><br>
				흡연구역
			</c:if>
		</span>
		<span align="center">
			<c:if test="${hdto.h_front24 eq 'y'}">
				<img src="resources/images/hotel/service/24front.png" width="100" height="80"><br>
				24/7 프론트
			</c:if>
		</span>
	</div>
		<table align="center" width="1000">
			<tr>
				<td align="left">후기(${reviewCount}개)</td>
				<td align="right"><a href="review?h_num=${hdto.h_num}">전체보기</a></td>
			</tr>
			<tr>
				<td align="left" colspan="2">
					<i class="far fa-star"></i>${starAverage} / 5 &nbsp;&nbsp;&nbsp;&nbsp;(최근 12개월 누적 평점)
				</td>
			</tr>
			
			<c:forEach var="review" items="${reviewList}" begin="0" end="1">
			<tr>
				<td colspan="2"><br></td>
			</tr>
			<tr>
				<td align="left" colspan="2"><i class="far fa-star"></i>${review.review_star}</td>
				
			</tr>
			<tr>
				<td align="left">${review.review_nickname} / ${review.review_roomtype}</td>
				<td align="right">작성일&nbsp;${review.review_joindate}</td>
			</tr>
			<tr>
				<td align="left" colspan="2">${review.review_contents}</td>
			</tr>
			</c:forEach>
			<tr>
				<td align="center" colspan="2"><a href="review?h_num=${hdto.h_num}">전체 후기 보기</a><br>(후기 ${reviewCount}개)</td>
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