<%@page import="book.BookDAO"%>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 수정</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8"); //utf-8
	int bcode = Integer.parseInt(request.getParameter("bcode")); // int 형태의 bcode 가져오기
	BookDAO instance = BookDAO.getInstance(); //DAO 생성자
	Connection conn = instance.getConnection(); // 커넥션
	String selectSql = "SELECT * FROM BOOK_TBL WHERE bcode = ?"; //selectSql문 사용한다.
	PreparedStatement pstmt = conn.prepareStatement(selectSql); 
	pstmt.setInt(1, bcode);
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()){
%>
<jsp:include page = "header.jsp"/><!--  header.jsp 가져오기 -->
<form method = "post" action = "updateBookPro.jsp"> <!-- updateBookPro.jsp 에 폼 데이터가 전송됨 -->
<table border = "1" style = "width:400"> <!-- table 생성 (border를 1로 설정 width:400으로 설정) -->
	<tr>
		<td colspan = "2" align = "center">
			<b>도서 정보 수정</b>
		</td>
	<tr>
		<th>도서코드</th>
		<td>
		<input type = "text" name = "bcode" value = "<%= rs.getInt("bcode")%>" readonly></td></tr> <!-- 도서코드  -->
<tr><th>도서제목</th><td><input type = "text" name = "btitle" value = <%= rs.getString("btitle") %>></td></tr> <!-- 도서 제목 수정 -->
<tr><th>도서저자</th><td><input type = "text" name = "bwriter" value = <%= rs.getString("bwriter") %>></td></tr> <!-- 도서 저자 수정 -->
<tr>
<th>출판사코드</th>
<td>
<select name="bpub" > <!-- select name bpub으로 설정 -->
<!-- 삼항 연산자   -->
<!-- 조건문 ? 참일 때 실행하는 문 : 아닐 때 실행하는 거 -->
<!-- 이것은 한슬이의 도움을 받았습니다. -->
  <option value = "1001" <%= rs.getInt("bpub") == 1001 ? "selected" : "" %>>양영디지털</option> <!-- 양영디지털로 수정  -->
  <option value = "1002" <%= rs.getInt("bpub") == 1002 ? "selected" : "" %>>북스미디어</option> <!-- 북스미디어로 수정 -->
  <option value = "1003" <%= rs.getInt("bpub") == 1003 ? "selected" : "" %>>한빛아카데미</option> <!-- 한빛아카데미로 수정 -->
  <option value = "1004" <%= rs.getInt("bpub") == 1004 ? "selected" : "" %>>이지스</option> <!-- 이지스로 수정 -->
</select>
</td>
</tr>
<tr>
	<th>가격</th>
	<td>
		<input type = "text" name = "bprice" value = <%= rs.getInt("bprice") %>> <!-- 가격 수정 -->
	</td>
	</tr>
	<tr>
		<th>출간날짜</th>
	<td>
		<input type = "text" name = "bdate" value = <%= rs.getDate("bdate") %>> <!-- 출간 날짜 수정 -->
	</td></tr>
<tr><td colspan = "2" align = "center">
	<input type = "submit" value = "수정"><input type = "reset" value = "취소" OnClick="javascript:history.back(-1)">
	<!-- 수정 버튼을 누르면 수정 완료 -->		
														<!-- 취소 버튼을 누르면 취소 완료 --> 
														 <!-- 수정이 취소가 되면서 history.back(-1) : 뒤로가기가 됨 -->
	</td>
	</tr>
</table>
</form>
<% } instance.close(null, pstmt, conn); %>
<%@ include file = "footer.jsp" %> <!-- footer.jsp 가져오기 -->
</body>
</html>