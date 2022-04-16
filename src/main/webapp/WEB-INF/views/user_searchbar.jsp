<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" /> 
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#plus").click(function(){
			var inwon = $("#inwon").val();
			var inwon2 = parseInt(inwon) + 1;
			if(inwon2>6){
				alert("6명 이상은 입력할 수 없습니다.");
				e.stopPropagation();
				e.preventDefault();
			}else{
				$("#inwon").attr('value',inwon2);
			}
		});
		$("#minus").click(function(e){
			var inwon = $("#inwon").val();
			var inwon2 = parseInt(inwon) - 1;
			
			if(inwon2<2){
				alert("2명 이하는 입력할 수 없습니다.");
				e.stopPropagation();
				e.preventDefault();
			}else{
				$("#inwon").attr('value',inwon2);
			}
		});

	});
	/* 캘린더 */ 
	$( function() {
  
	    var dateFormat = "yy-mm-dd",
	      from = $( "#from" )
	        .datepicker({
	          changeYear: true,
	          changeMonth: true,//달 변경 지정
	          dateFormat:"yy-mm-dd",//날짜 포맷
	          prevText: '이전 달',
		      nextText: '다음 달',
			  currentText: '오늘 날짜',
			  closeText: '닫기',
			  monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			  monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			  dayNames: ['일','월','화','수','목','금','토'],
			  dayNamesMin: ['일','월','화','수','목','금','토'],
	          	
	        })
	        .on( "change", function() {
	          to.datepicker( "option", "minDate", getDate(this) );//종료일의 minDate 지정
	        }),
	      to = $( "#to" ).datepicker({
	  	    changeYear: true,
	        changeMonth: true,
	        dateFormat:"yy-mm-dd",
	        prevText: '이전 달',
			nextText: '다음 달',
			currentText: '오늘 날짜',
			closeText: '닫기',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
	        minDate:'+1D' //내일부터 선택가능, 지정형식 예(+1D +1M +1Y)
	      })
	      .on( "change", function() {
	        from.datepicker( "option", "maxDate", getDate(this) );//시작일의 maxDate 지정
	      });
	 
	    function getDate(element) {
	      var date;
	      try {
	        date = $.datepicker.parseDate( dateFormat, element.value );
	        if(element.id == 'from'){
	         date.setDate(date.getDate()+1);//종료일은 시작보다 하루 이후부터 지정할 수 있도록 설정
	        }else{
	         date.setDate(date.getDate()-1);//시작일은 종료일보다 하루 전부터 지정할 수 있도록 설정
	        }
	      } catch( error ) {
	        date = null;
	      }
	      return date;
	    }
	} );
</script>
<style>
.search-box {
	width: fit-content;
    background-color: #ffffff;
    border-radius: 8px;
    padding: 25px;
    box-shadow: 0 2px 8px rgb(0 0 0 / 20%);
    box-sizing: border-box;
    margin: 0 auto;
}
.search-box input {
	border-radius: 5px;
	border: 1px solid #1f244d;
	line-height: 40px;
}
.search-box input[type="text"], .search-box input[type="date"] {
	text-indent: 5px;
}
.search-box > div {
	margin-right: 10px;
	font-size: 13px;
}
</style>
<form name="f_searchOk" action="display_hotelSearchOk" method="post" id="mForm">
<div style="width: 100%; padding:70px 0; background:#f5f9ff;">
	<div class="row search-box">
		<div>
			지역 혹은 숙소 입력<br/>
			<input type="text" name="condition" list="options" id="location" placeholder="전체 검색" style="width: 300px;">
			<datalist id="options">
				<c:forEach var="option" items="${sessionScope.allOptions}">
					<option value="${option}">
				</c:forEach>
			</datalist>
		</div>
		<div>
			체크인 <br/>
			<%-- <input type="date" id="indate1" name="indate" value="${indate}"> --%>
			<input type="date" id="from" name="indate" value="${indate}" autocomplete="off" readonly>
		</div>
		<div>
			체크아웃<br/>
			<%-- <input type="date" id="outdate1" name="outdate" value="${outdate}"> --%>
			<input type="date" id="to" name="outdate" value="${outdate}" autocomplete="off" readonly>
		</div>
		<div style="width: 80px;">
			인원<br>
			<c:if test="${empty sessionScope.inwon}">
			<input type="text" name="inwon" id="inwon" value="2" size="1" readonly>
			</c:if>
			<c:if test="${not empty sessionScope.inwon}">
			<input type="text" name="inwon" id="inwon" size="1" value="${sessionScope.inwon}" readonly>
			</c:if>
			<span style="width: 20px; position: absolute; display:inline-block; margin-left:3px;">
				<input type="button" name="plus" id="plus" value="+" style="width: 20px; line-height: 15px; margin-bottom: 5px;">
				<input type="button" name="minus" id="minus" value="-" style="width: 20px; line-height: 15px;">
			</span>
		</div>
		<div>
			<br>
			<input type="submit" value="검색" style="cursor: pointer; width: 120px; border-radius: 50vh; border:0; background: #252e7b; color:white;">
		</div>
	</div>
</div>
</form>