<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:if test="${row==1}">
	<script>
		alert("글 삭제 성공");
		opener.location.href="/Board/board_list?page=${page}"
	    self.close();
	</script>
</c:if>	

<c:if test="${row==0}">
	<script>
		alert("비밀번호가 달라서 삭제요청이 거절되었습니다");
		history.back();
	</script>
</c:if>	

</body>
</html>