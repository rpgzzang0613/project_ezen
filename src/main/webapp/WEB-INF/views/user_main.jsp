<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_top.jsp"%>
<%@ include file="user_searchbar.jsp"%>
<link rel="stylesheet" href="resources/LJWstyle.css"/>
<style>
.image-box {
	width: 50%; 
	height: 250px; 
	overflow: hidden; 
	position:relative;
}
.image-box img {
	height: 100%;
	width: 100%;
	object-fit: cover;
}
.image-text {
    position: absolute;
    line-height: 40px;
    top: 55%;
    left: 15%;
    color: white;
    text-shadow: 3px 3px 2px black;
    font-size: 25px;
}
</style>
<script type="text/javascript">
function goNext(location) {
	document.getElementById("location").value = location;
	document.f_searchOk.submit();
}
</script>		
<div style="width:1000px; margin:80px auto;" class="gutter-y-10">
	<div class="row" style="width:100%;">
		<div onclick="goNext('서울')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				서울<br/>
				<c:if test="${map['서울'] != null}">
				<c:out value="${map['서울']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['서울'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/seoul.jpg">
		</div>
		
		<div onclick="goNext('부산')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				부산<br/>
				<c:if test="${map['부산'] != null}">
				<c:out value="${map['부산']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['부산'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/busan.jpg">
		</div>
	</div>
	<div class="row" style="width:100%;">
		<div onclick="goNext('제주')" class="image-box" style="width: 34%; cursor: pointer;">
			<span class="image-text">
				제주<br/>
				<c:if test="${map['제주'] != null}">
				<c:out value="${map['제주']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['제주'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/jeju.jpg">
		</div>
		
		<div onclick="goNext('속초')" class="image-box" style="width: 34%; cursor: pointer;">
			<span class="image-text">
				속초<br/>
				<c:if test="${map['속초'] != null}">
				<c:out value="${map['속초']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['속초'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/sokcho.jpg">
		</div>
		<div onclick="goNext('강릉')" class="image-box" style="width: 34%; cursor: pointer;">
			<span class="image-text">
				강릉<br/>
				<c:if test="${map['강릉'] != null}">
				<c:out value="${map['강릉']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['강릉'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/gangneung.jpg">
		</div>
	</div>
	
	<div class="row" style="width:100%;">
		<div onclick="goNext('경주')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				경주<br/>
				<c:if test="${map['경주'] != null}">
				<c:out value="${map['경주']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['경주'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/gyeongju.jpg">
		</div>
		
		<div onclick="goNext('여수')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				여수<br/>
				<c:if test="${map['여수'] != null}">
				<c:out value="${map['여수']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['여수'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/yeosu.jpg">
		</div>
	</div>
	<div class="row" style="width:100%;">
		<div onclick="goNext('인천')" class="image-box" style="width: 34%; cursor: pointer;">
			<span class="image-text">
				인천<br/>
				<c:if test="${map['인천'] != null}">
				<c:out value="${map['인천']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['인천'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/incheon.jpg">
		</div>
		
		<div onclick="goNext('전주')" class="image-box" style="width: 34%; cursor: pointer;">
			<span class="image-text">
				전주<br/>
				<c:if test="${map['전주'] != null}">
				<c:out value="${map['전주']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['전주'] == null}">
				0 개의 숙소
				</c:if> 
			</span>
			<img src="resources/images/main/jeonju.jpg">
		</div>
		<div onclick="goNext('춘천')" class="image-box" style="width: 34%; cursor: pointer;">
			<span class="image-text">
				춘천<br/>
				<c:if test="${map['춘천'] != null}">
				<c:out value="${map['춘천']}"/> 개의 숙소
				</c:if>
				<c:if test="${map['춘천'] == null}">
				0 개의 숙소
				</c:if> 
			</span> 
			<img src="resources/images/main/chuncheon.jpg">
		</div>
	</div> 
</div> 
</body>
<%@ include file="bottom.jsp"%>
</html>