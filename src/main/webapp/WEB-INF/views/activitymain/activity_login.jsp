<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- activity__login.jsp -->
<%@ include file="activity_top.jsp"%>
<div align="center">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
//카카오로그인 
Kakao.init('fd470f1b6a887556abbbaafff7719fff');
Kakao.isInitialized()
console.log();
  function loginWithKakao() {
    Kakao.Auth.loginForm({
      success: function(authObj) {
	   	Kakao.API.request({
		    url: '/v2/user/me',  
		    data: {    
		        property_keys: ["kakao_account.email", "properties.nickname", "kakao_account.name", "kakao_account.birthday", "kakao_account.birthyear"]
		    },  
		    success: function(response) {
		    	const kakaoEmail = response.kakao_account.email
		    	const kakaonickname = response.properties.nickname 
		    	const kakaoname = response.kakao_account.name
		    	const kakaobirth = response.kakao_account.birthday
		    	const kakaobirthyear = response.kakao_account.birthyear 
		    	document.f_activitylogin.kakaoEmail.value = kakaoEmail  
		    	document.f_activitylogin.kakaonickname.value = kakaonickname
		    	document.f_activitylogin.kakaoname.value = kakaoname
		    	document.f_activitylogin.kakaobirth.value = kakaobirth	
		    	document.f_activitylogin.kakaobirthyear.value = kakaobirthyear
		    	document.f_activitylogin.submit()
		    },
		    fail: function(error) {
		        console.log(error);
		    }
		});
      },
      fail: function(err) {
        alert(JSON.stringify(err))
      },
    })
  }

//mode값으로 Email찾기인지 비밀번호 찾기인지 알려줌 
function searchUser(mode){
	location.href = "user_search?mode=" + mode
}
//입력 검사 
function checkLogin() {
	if(f_activitylogin.u_email.value=="") {
		alert("이메일을 입력해주세요.")
		f_activitylogin.u_email.focus()
		return
	}
	if(f_activitylogin.u_password.value=="") {
		alert("비밀번호를 입력해주세요.")
		f_activitylogin.u_password.focus()
		return
	}
	document.f_activitylogin.submit()
}
</script>
<form name="f_activitylogin" method="POST" action="activity_login_ok">
<input type="hidden" name="kakaoEmail">
<input type="hidden" name="kakaonickname">
<input type="hidden" name="kakaoname"> 
<input type="hidden" name="kakaobirth">
<input type="hidden" name="kakaobirthyear">
<table border="0" width="280" align="center">
<tr>
	<td colspan="2" align="center"><h3>회원 로그인</h3></td>
</tr>
<tr>
	<!-- cookie로 아이디 기억하기 -->
	<td colspan="2">
		<c:if test = "${empty cookie.saveEmail.value}">
		<input type="text" name="u_email" placeholder="이메일을 입력해 주세요." tabindex="1" 
		style="width:350px;height:50px">
		</c:if>
		
		<c:if test = "${not empty cookie.saveEmail.value}">
		<input type="text" name="u_email" value= "${cookie.saveEmail.value}" placeholder="이메일을 입력해 주세요." tabindex="1" 
		style="width:350px;height:50px">
		</c:if>
	</td> 
</tr>
<tr>
	<td colspan="2">
		<input type="password" name="u_password" placeholder="비밀번호를 입력해 주세요." tabindex="2" 
		style="width:350px;height:50px">
	</td>
</tr>
<tr>
	<td colspan="2">
		<button type="button" name="userLogin" onclick="checkLogin()" 
		style="width:350px;height:50px;background-color:black;color:white;border-color:black">로그인</button>
	</td>
</tr>
<tr>
	<td>
		<input type="checkbox" name="saveEmail">이메일 기억
	</td>
	<td align="right">
		<!-- script에서 사용할 (mode)값 넘겨주기  -->
		<a href="javascript:searchUser('u_email')">이메일 찾기</a> | 
		<a href="javascript:searchUser('u_password')">비밀번호 찾기</a>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>

<tr>
	<td colspan="2" align="center">
		<b>아직 회원이 아니신가요?</b>&nbsp;&nbsp;&nbsp;
		<button type="button" name="userJoin" onclick="location.href='user_join'" 
		style="width:80px;height:35px;background-color:grey;color:white;border-color:grey">회원 가입</button>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
	<a id="custom-login-btn" href="javascript:loginWithKakao()">
  <img
    src="//k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
    width=280
    alt="카카오 로그인 버튼"
  /> 
</a>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
</table>
</form>
</div>
<%@ include file="../bottom.jsp" %>