<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- closeWindow.jsp -->
<script type="text/javascript">
	var check = "${sessionScope.tempUser}";
	if(check != 'tempUser'){
		alert("${msg}")
		opener.parent.location.reload();
		self.close()
	}else {
		alert("객실 선택후 '예약하기' 버튼을 눌러 진행해 주세요.")
		opener.parent.location.reload();
		self.close()
	}
</script>