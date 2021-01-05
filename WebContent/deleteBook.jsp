<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
</head>
<body>
<% int bcode = Integer.parseInt(request.getParameter("bcode")); // bcode를 받아온다. 삭제하기 위해서 받아와야 한다. %>
<script> 
		//confirm 이라는 함수를 사용한다.
		// confirm 이란 ? 확인 , 취소 둘 중 하나를 선택하게 해주는 선택창을 만들어주는 함수이다.
		// == true (확인 눌렀을 때 실행) , else (취소 버튼을 눌렀을 때 실행)
		if(confirm("정말 삭제하겠습니까?")==true) location.href = "deleteBookPro.jsp?bcode=<%= bcode %>";  
		<!-- 확인 버튼(true)을 누른다면 deleteBookPro로 넘어가게된다. -->
	else location.href = "index.jsp"; <!-- 취소 버튼을 누른다면 index.jsp 로 넘어간다. -->
</script>
</body>
</html>