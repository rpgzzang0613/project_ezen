<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!-- user_login.jsp -->
<%@ include file="../user_top.jsp"%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
//카카오로그인
Kakao.init('fd470f1b6a887556abbbaafff7719fff');
console.log(Kakao.isInitialized());
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
		    	document.f.kakaoEmail.value = kakaoEmail 
		    	document.f.kakaonickname.value = kakaonickname
		    	document.f.kakaoname.value = kakaoname
		    	document.f.kakaobirth.value = kakaobirth	  
		    	document.f.kakaobirthyear.value = kakaobirthyear
		    	document.f.submit() 
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
</script> 
<form name="f" method="POST" action="user_login_ok">
<input type="hidden" name="kakaoEmail">
<input type="hidden" name="kakaonickname">
<input type="hidden" name="kakaoname"> 
<input type="hidden" name="kakaobirth">
<input type="hidden" name="kakaobirthyear">
<table align="center" border="0" width="280">
<tr height = "100px"> 
</tr>
<tr align = "center">
	<td colspan="2" align="center">
		<b>아직 회원이 아니신가요?</b>&nbsp;&nbsp;&nbsp;
	</td>
	<tr height="20px"> 
	</tr>
<tr>
	<td>
		<button type="button" name="userJoin" onclick="location.href='user_join'" 
		style="width:400px;height:47.51px; background-color:grey;color:white;border-color:grey">이메일로 회원 가입</button>
	</td> 
</tr>
<tr> 
	<td colspan="2" align="center">
	<a id="custom-login-btn" href="javascript:loginWithKakao()">
  <img 
    src="resources/images/Kakao.jpg"
    width=400px
    alt="카카오 회원가입 버튼"
  /> 
</a>  
	</td>
</tr>
</table>
</form>