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
        $("#booker").change(function(){
           var booker = $(this).val();
           var booker2 = parseInt(booker);
           var p_price = $("#p_price").val();
           var p_price2 = parseInt(p_price);
           var total = p_price2 * booker2;
           $("#totalPrice").attr( 'value', total);
           $("#finalPrice").attr('value', total);
           
        });
        
        //한번 지연시키고 다시 보내보기
        $("#check_module").click(function(){
        	event.preventDefault();
        	var isSubmit = false;
        	var check;
        	if(f_bookactWriteform.ba_name.value!=""&&
        			f_bookactWriteform.ba_tel.value!=""){
        		check = confirm("결제 하시겠습니까?");
            	if(check) {
            		var u_name = $("#u_name").val();
            		var u_email = $("#u_email").val();
                	var p_name = $("#p_name").val();
            		var IMP = window.IMP; // 생략가능
            		var totalPrice = $("#totalPrice").val();
            		var ba_totalbooker = $("#ba_totalbooker").val();
            		
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
                    name: u_name+'['+p_name+']',
                    //결제창에서 보여질 이름
                    amount: totalPrice,
                    //가격
                    buyer_email: u_email,
                    buyer_name: u_name
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
        		if (f_bookactWriteform.ba_name.value==""){
        			alert("예약자 명을 입력하셔야 합니다.")
        			f_bookactWriteform.ba_name.focus() 
        			return false
        		} 
        		if (f_bookactWriteform.ba_tel.value==""){
        			alert("예약자 전화번호를 입력하셔야 합니다.")
        			f_bookactWriteform.ba_tel.focus()
        			return false
        		}
        	}
        });
     });
</script>

<meta charset="UTF-8">
<form name="f_bookactWriteform" id="bwform" method="post" action="user_bookActConfirm">
<input type="hidden" name="ba_payment" value="카카오페이">
<input type="hidden" name="a_num" value="${pdto.a_num}">
<input type="hidden" name="u_num" value="${loginOkBean.u_num}">
<input type="hidden" name="p_num" value="${pdto.p_num}">
<input type="hidden" name="ba_bookdate" value="${bookdate}">
<input type="hidden" id="p_price" name="p_price" value="${pdto.p_price}">
<input type="hidden" id="u_email" value="${loginOkBean.u_email}">
<input type="hidden" id="u_name" value="${loginOkBean.u_name}">
<input type="hidden" id="u_tel" value="${loginOkBean.u_tel}">
	<div style="width: 650px; margin: 0 auto;">
		<div class="row book-detail">
			<div class="first">
				<div class="section">
					<div class="row" style="font-weight: bold; font-size: 20px; padding-left: 35px;">예약자 정보</div>
					<div class="row" style ="line-height:20px;">
						<label>예약자이름</label>
						<label><input type="text" id="ba_name" name="ba_name" value="${loginOkBean.u_name}"style="width:150px;" />
						</label>
					</div>
					<div class="row" style ="line-height:20px;">
						<label>휴대폰번호</label>
						<label><input type="text" name="ba_tel" value="${loginOkBean.u_tel}"style="width:150px;"/></label>
					</div>
		<!-- 추가인원, 사용포인트, 총결제금액, 포인트적립칸 모두 jQuery로 수정할것 -->
		<div class="row" style ="line-height:20px;">
						<label>예약 인원</label>
						<label>
							<select name="ba_totalbooker" id="booker">
								<c:if test="${canBooker==1}">
								<option value="1">1명</option>
							</c:if>
							<c:if test="${canBooker==2}">
								<option value="1">1명</option>
								<option value="2">2명</option>
							</c:if>
							<c:if test="${canBooker==3}">
								<option value="1">1명</option>
								<option value="2">2명</option>
								<option value="3">3명</option>
							</c:if>
							<c:if test="${canBooker==4}">
								<option value="1">1명</option>
								<option value="2">2명</option>
								<option value="3">3명</option>
								<option value="4">4명</option>
							</c:if>
							<c:if test="${canBooker==5}">
								<option value="1">1명</option>
								<option value="2">2명</option>
								<option value="3">3명</option>
								<option value="4">4명</option>
								<option value="5">5명</option>
							</c:if>
							<c:if test="${canBooker>=6}">
								<option value="1">1명</option>
								<option value="2">2명</option>
								<option value="3">3명</option>
								<option value="4">4명</option>
								<option value="5">5명</option>
								<option value="6">6명</option>
							</c:if>
							</select>
						</label>
					</div>
				</div>
				<c:if test="${canBooker>=6}">
				<div style="font-weight: bold; font-size:15px; text-align:center; color : red;">
					*6명 이상시 업체에 
					<br> 전화로 문의해주세요
				</div>
				</c:if>
				<div class="section">
					<div class="row">
						<label>프로그램 가격</label>
						<!-- book_totalprice -->
						<label>
							<input type="text" name="p_price" id="p_price"
							 value="${pdto.p_price}" style="width:100px;" readonly>&emsp;원
						</label>
					</div>
					<div class="row">
						<label>총 결제금액</label>
						<label>
						<input type="text" name="ba_totalprice" id="totalPrice" 
						value="${pdto.p_price}" style="width:100px;" readOnly>&emsp;원
						</label>
					</div>
					
				</div>
			</div>
			
			<div class="second">
				<div class="section">
					<div class="column">
						<label>프로그램</label>
						<label>${pdto.p_name}</label>
						<input type="hidden" id="p_name" value="${pdto.p_name}">
					</div>
					<!-- indate, outdate session에서 받아오는걸로 처리해야할것같음 -->
					<div class="column">
						<label>예약일</label>
						<label>${bookdate}</label>
				
						<!-- 총 결제금액 수정 끝나면 use_bookCancel로 값 넘기기 -->
						<label>총 결제금액</label>
						<label><input type="text" id="finalPrice" 
							value="${pdto.p_price}" style="width:100px;" readonly>&emsp;원
						</label>
					</div>
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