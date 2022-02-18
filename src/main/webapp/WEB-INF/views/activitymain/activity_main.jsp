<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="activity_top.jsp" %>
<%@ include file="activity_searchbar.jsp"%>
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
function goNext(code) {
	document.getElementById("code").value = code;
	document.f_activitySearchOk.submit();
}
</script>		
<div style="width:1000px; margin:80px auto;" class="gutter-y-10">
	<div class="row" style="width:100%;">
		<div onclick="goNext('sport')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				스포츠<br/>
				<c:if test="${sport != null}">
				<c:out value="${sport}"/> 개의 활동
				</c:if>
				<c:if test="${sport == null}">
				0 개의 활동
				</c:if> 
			</span> 
			<img src="resources/images/main/sports.jpg">
		</div>
		
		<div onclick="goNext('study')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				학업<br/>
				<c:if test="${study != null}">
				<c:out value="${study}"/> 개의 활동
				</c:if>
				<c:if test="${study == null}">
				0 개의 활동
				</c:if> 
			</span>
			<img src="resources/images/main/study.jpg">
		</div>
	</div>
	
		<div class="row" style="width:100%;">
		<div onclick="goNext('culture')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				문화<br/>
				<c:if test="${culture != null}">
				<c:out value="${culture}"/> 개의 활동
				</c:if>
				<c:if test="${culture == null}">
				0 개의 활동
				</c:if> 
			</span>
			<img src="resources/images/main/culture.jpg">
		</div>
		
		<div onclick="goNext('ent')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				엔터테인먼트<br/>
				<c:if test="${ent != null}">
				<c:out value="${ent}"/> 개의 활동
				</c:if>
				<c:if test="${ent == null}">
				0 개의 활동
				</c:if> 
			</span> 
			<img src="resources/images/main/entertainment.jpg">
		</div>
	</div>
	
	<div class="row" style="width:100%;">
		<div onclick="goNext('music')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				음악<br/>
				<c:if test="${music != null}">
				<c:out value="${music}"/> 개의 활동
				</c:if>
				<c:if test="${music == null}">
				0 개의 활동
				</c:if> 
			</span>
			<img src="resources/images/main/music.jpg">
		</div>
		
		<div onclick="goNext('cooking')" class="image-box" style="cursor: pointer;">
			<span class="image-text">
				요리<br/>
				<c:if test="${cooking != null}">
				<c:out value="${cooking}"/> 개의 활동
				</c:if>
				<c:if test="${cooking == null}">
				0 개의 활동
				</c:if> 
			</span>
			<img src="resources/images/main/cook.jpg">
		</div>
	</div>
	</div>
</body>
<%@ include file="../bottom.jsp"%>