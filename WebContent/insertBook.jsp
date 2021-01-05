<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>
</head>
<body>
<%
BookDAO instance = BookDAO.getInstance(); //dao 가져오기
%>
<jsp:include page = "header.jsp"/> <!-- header.jsp 가져오기 -->
<form method = "post" action = "insertBook.do" name = "insertBook"> <!-- BookInsertController 에서 만든 insertBook.do를 action에 넣어줌 --> 
<table border = "1" style = "width:400"> <!-- table 을 생성해줌 (border을 1로 설정해주고 width:400 해줌) -->
<tr><th>도서코드</th>
<td><input type = "text" name = "bcode" value = <%= instance.getMaxCode() %> readonly></td></tr> 
<tr><th>도서제목</th>							   		<!-- 도서코드는 자동생성 됨! 마지막번호 + 1 -->
												<!-- 읽기만 가능함 수정 불가능 -->
<td><input type = "text" name = "btitle" required></td></tr> <!-- 도서제목 입력하기 -->
<tr><th>도서저자</th>			
<td><input type = "text" name = "bwriter" required></td></tr> <!-- 도서저자 입력하기 -->
<tr><th>출판사코드</th>
<td><select name = "bpub"> <!-- 4가지 중 하나 고르기  -->
  <option value = "1001">양영디지털</option> <!-- 양영디지털을 선택하면 1001로 들어감 -->
  <option value = "1002">북스미디어</option> <!-- 북스미디어를 선택하면 1002로 들어감 -->
  <option value = "1003">한빛아카데미</option> <!-- 한빛아카데미를 선택하면 1003로 들어감 -->
  <option value = "1004">이지스</option> <!-- 이지스를 선택하면 1004로 들어감 -->
</select></td></tr>
<tr><th>가격</th><td><input type = "text" name = "bprice" required></td></tr>  <!-- 가격 입력하기 -->
<tr><th>출간날짜</th><td><input type = "text" name = "bdate" required></td></tr> <!-- 출간날짜 입력하기 -->
<tr><td colspan = "2" align = "center">							      <!-- ####-##-## 이런 식으로 입력해주어야함 -->
	<input type = "submit" value = "등록"><input type = "reset" value = "재작성">
				<!-- 등록 누르면 등록 -->					<!-- 재작성 누르면 초기화됨 -->
	</td>
	</tr>
</table>
</form>
<%@ include file = "footer.jsp" %> <!-- footer.jsp 가져오기 -->
</body>
</html>