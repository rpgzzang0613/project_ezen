<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../user_top.jsp" %>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<!-- ICon만들때 적어줘야함! -->
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
        $("#extra").change(function(){
           var extra = $(this).val();
           var extra2 = parseInt(extra);
           var room_price = $("#room_price").val();
           var room_price2 = parseInt(room_price);
           var room_extraprice = $("#room_extraprice").val();
           var room_extraprice2 = parseInt(room_extraprice);
           var total = room_price2 + room_extraprice2 * extra2;
           $("#room_price2").attr( 'value', total);
           
           var tempCheck = "${sessionScope.loginOkBean.u_num}";
           if(tempCheck > 0){
	           var usePoint = $("#usePoint").val();
	           var result2 = total - usePoint;
	           var savepoint = result2 * 0.1;
	           $("#totalPrice").attr('value', result2);
	           $("#finalPrice").attr('value', result2);
	           $("#savePoint").attr('value', savepoint);
           } else {
               $("#totalPrice").attr('value', total);
               $("#finalPrice").attr('value', total);
           }
           
        });
        $("#usePoint").change(function(){
            var usePoint = $(this).val();
            var room_price = $("#room_price2").val();
            var result2 = parseInt(room_price) - parseInt(usePoint);
            $("#totalPrice").attr('value', result2);
            $("#finalPrice").attr('value', result2);
            var savepoint = result2 * 0.1;
            $("#savePoint").attr('value', savepoint);
            
         });

        //한번 지연시키고 다시 보내보기
        $("#check_module").click(function(){
        	event.preventDefault();
        	var isSubmit = false;
        	var check;
        	var usePoint = $("#usePoint").val();
        	var userPoint = $("#userPoint").val();
        	if( parseInt(userPoint) >= parseInt(usePoint) ){
        		check = confirm("결제 하시겠습니까?");
            	if(check) {
            		var h_name = $("#h_name").val();
                	var room_type = $("#room_type").val();
            		var IMP = window.IMP; // 생략가능
            		var totalPrice = $("#totalPrice").val();
            		var u_email = $("#u_email").val();
            		var u_name = $("#u_name").val();
            		
                    IMP.init('imp24804575');
                    // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
                    // i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
                    IMP.request_pay({
                    pg: 'html5_inicis', // version 1.1.0부터 지원.
                    
                    pay_method: 'card',
                    
                    /* 
                    'samsung':삼성페이,
                    'card':신용카드,
                    'trans':실시간계좌이체,
                    'vbank':가상계좌,
                    'phone':휴대폰소액결제
                     */
                    merchant_uid: 'merchant_' + new Date().getTime(),
                    /*
                    merchant_uid에 경우
                    https://docs.iamport.kr/implementation/payment
                    위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
                    참고하세요.
                    나중에 포스팅 해볼게요.
                    */
                    name: h_name+'['+room_type+']',
                    //결제창에서 보여질 이름
                    amount: totalPrice,
                    //가격
                    buyer_email: u_email,
                    buyer_name: u_name,
                    /*
                    모바일 결제시,
                    결제가 끝나고 랜딩되는 URL을 지정
                    (카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
                    */
                    }, function (rsp) {
	                    console.log(rsp);
	                    if (rsp.success) {
	                        var msg = '결제가 완료되었습니다.';
	                        msg += '고유ID : ' + rsp.imp_uid;
	                        msg += '상점 거래ID : ' + rsp.merchant_uid;
	                        msg += '결제 금액 : ' + rsp.paid_amount;
	                        msg += '카드 승인번호 : ' + rsp.apply_num;
	                        alert(msg);
	                        $("#bwform").submit();
	                    } else {
	                        var msg = '결제에 실패하였습니다.';
	                        msg += '에러내용 : ' + rsp.error_msg;
	                        alert(msg);
	                    }
                    });
            	}
        	}else{
        		isSubmit = false;
        		alert("포인트가 부족합니다");
        	}
        });
        
        $("#bwform").submit(function(){
        	event.preventDefault();
        	var isSubmit = false;
        	var check;
        	var tempCheck = "${sessionScope.loginOkBean.u_num}";
            if(tempCheck > 0){
	        	var usePoint = $("#usePoint").val();
	        	var userPoint = $("#userPoint").val();
	        	if( parseInt(userPoint) >= parseInt(usePoint) ){
	        		check = confirm("결제 하시겠습니까?");
	            	if(check) {
	            		this.submit();
	            	}
	        	}else{
	        		isSubmit = false;
	        		alert("포인트가 부족합니다");
	        	}
            } else {
            	var check = confirm("결제 하시겠습니까?");
            	if(check) {
            		this.submit();
            	}
            }
        });
     });
	
</script>

<meta charset="UTF-8">
<form name="f_bookWriteform" id="bwform" method="post" action="user_bookConfirm">
<input type="hidden" name="book_payment" value="카카오페이">
<input type="hidden" name="h_num" value="${hdto.h_num}">
<input type="hidden" name="room_num" value="${rdto.room_num}">
<input type="hidden" name="room_code" value="${rdto.room_code}">
<input type="hidden" id="room_price" name="room_price" value="${rdto.room_price}">
<input type="hidden" id="room_extraprice" value="${rdto.room_extraprice}">

<%-- <input type="hidden" name="room_price" value="${rdto.room_price}"> --%>
	<c:if test="${not empty loginOkBean}">
		<input type="hidden" name="u_num" value="${loginOkBean.u_num}">
		<input type="hidden" id="u_email" value="${loginOkBean.u_email}">
		<input type="hidden" id="u_name" value="${loginOkBean.u_name}">
		<input type="hidden" id="u_tel" value="${loginOkBean.u_tel}">
		<input type="hidden" id="userPoint" value="${udto.u_point}">
	</c:if>
	<div style="width: 650px; margin: 0 auto;">
		<div class="row book-detail">
			<div class="first">
				<div class="section">
					<div class="row" style="font-weight: bold; font-size:20px; padding-left: 35px;">예약자 정보</div>
					<div class="row">
							<label>예약자이름</label>
						<c:if test="${not empty loginOkBean}">
							<label><input type="text" id="book_name" name="book_name" value="${udto.u_name}"/></label>
						</c:if>
						<c:if test="${empty loginOkBean}">
							<label><input type="text" id="book_name" name="book_name" value="${tempUser_name}"/></label>
						</c:if>
					</div>
					<div class="row">
						<label>휴대폰번호</label>
						<c:if test="${not empty loginOkBean}">
							<label><input type="text" name="book_tel" value="${udto.u_tel}"/></label>
						</c:if>
						<c:if test="${empty loginOkBean}">
							<label><input type="text" id="book_tel" name="book_tel" value="${tempUser_tel}"/></label>
						</c:if>
					</div>
					<div class="row">
						<label>객실 인원</label>
						<label>${rdto.room_capacity}</label>
					</div>
		<!-- 추가인원, 사용포인트, 총결제금액, 포인트적립칸 모두 jQuery로 수정할것 -->
					<div class="row">
						<label>추가 인원</label>
						<label>
							<select name="book_extra" id="extra">
								<option value="0">추가인원</option>
								<option value="1">1</option>
								<option value="2">2</option>
							</select>
						</label>
					</div>
					<div class="row">
					추가인원이 선택지보다 많을경우 호텔에 문의바랍니다.
					</div>
				</div>
				<div class="section">
					<div class="row">
						<label>객실 가격</label>
						<!-- book_totalprice -->
						<label>
							<input type="text" name="room_price" id="room_price2"
							 value="${rdto.room_price}" readonly>원
						</label>
					</div>
					<c:if test="${not empty loginOkBean}">
					<div class="row">
						<label>가용 포인트</label>
						<label>${udto.u_point}포인트</label>
					</div>
					<div class="row">
						<!-- 사용포인트 controller에서 확인해서 가지고있는 포인트보다 높으면 결제못하게 돌려보내기 -->
						<label>사용 포인트</label>
						<label>
						<input name="inputPoint" value="0" id="usePoint">
						</label>
					</div>
					</c:if>
					<div class="row">
						<label>총 결제금액</label>
						<label>
						<input type="text" name="book_totalprice" id="totalPrice" value="${rdto.room_price}" readOnly>
						</label>
						<%-- <input type="hidden" name="book_totalprice" value="${(rdto.room_price + (rdto.room_extraprice * 1)) - udto.u_point}"> --%>
					</div>
					
				</div>
			</div>
			
			<div class="second">
				<div class="section">
					<div class="column">
						<label>호텔이름</label>
						<label>${hdto.h_name}</label>
						<input type="hidden" id="h_name" value="${hdto.h_name}">
					</div>
					<div class="column">
						<label>방타입</label>
						<label>${rdto.room_type}</label>
						<input id="room_type" type="hidden" name="book_roomtype" value="${rdto.room_type}">
					</div>
					<!-- indate, outdate session에서 받아오는걸로 처리해야할것같음 -->
					<div class="column">
						<label>체크인</label>
						<c:if test="${not empty indate}">
							<label>${indate}</label>
							<input type="hidden" name="indate" value="${indate}">
						</c:if>
						<c:if test="${empty indate}">
							<label><input type="date" name="indate"></label>
						</c:if>
						
					</div>
					<div class="column">
						<label>체크아웃</label>
						<c:if test="${not empty outdate}">
							<label>${outdate}</label>
							<input type="hidden" name="outdate" value="${outdate}">
						</c:if>
						<c:if test="${empty indate}">
							<label><input type="date" name="outdate"></label>
						</c:if>
					</div>
				</div>
				
				<div class="section payment" style="border-top: 0;">
					<div class="column">
						<!-- 총 결제금액 수정 끝나면 use_bookCancel로 값 넘기기 -->
						<label>총 결제금액</label>
						<label><input type="text" id="finalPrice" value="${rdto.room_price}" readonly></label>
					</div>
					<c:if test="${not empty loginOkBean}">
					<div class="column">
						<label>포인트적립</label>
						<label>
							<input type="text" id="savePoint" name="book_savepoint" value="${rdto.room_price * 0.1}" size="5" readonly>적립
						</label>
					</div>
					</c:if>
					<div class="row justify-center" style="padding: 15px;">
						<button id="check_module" type="button" style="background:#F58B7B; width: 100%;">결제하기</button>
						<button style="background:#F58B7B; width: 100%;">가짜결제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
<%@ include file="../bottom.jsp" %>