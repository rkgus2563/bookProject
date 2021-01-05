<%@page import="java.text.DecimalFormat"%>
<%@page import="book.BookDAO"%>
<%@page import="book.BookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sql 목록 보여주기</title>
</head>
<body>
<jsp:include page = "header.jsp"/> <!-- header.jsp 가져오기 -->
<table border = "1"> <!-- table 만들어주기 (border=1) -->
<!-- 테이블 맨 위에 맨 위에 도서코드, 도서제목, 도서저자, 출판사, 가격, 출간날짜, 삭제 띄우기  -->
<th>도서코드</th><th>도서제목</th><th>도서저자 </th><th>출판사</th><th>가격</th><th>출간날짜</th><th>삭제</th>
	<%
	DecimalFormat format = new DecimalFormat("###,###"); // 가격을 출력할 때 세자리마다 콤마를 출력하게 한다.
	BookDAO instance = BookDAO.getInstance(); /* bookDAO 가져오기  */
	ArrayList<BookVO> list = (ArrayList<BookVO>)request.getAttribute("list"); 
	
	for(int i = 0; i < list.size(); i++){ //for문 돌리기 list.size만큼
		int bpub = list.get(i).getBpub(); //list.get(i).getBpub 가져오기
		String msg = null; //msg 생성 
		if(bpub == 1001) { //bpub이 1001이면
			msg = "양영디지털"; //양영디지털
		}else if(bpub == 1002){ //bpub 1002이면
			msg = "북스미디어"; //북스미디어
		}else if(bpub == 1003){ //bpub 1003이면
			msg = "한빛아카데미"; //한빛아카데미
		}else if(bpub == 1004){ //bpub 1004이면
			msg = "이지스"; //이지스
		}
		list.get(i).getBcode(); //Bcode 가져오기
		list.get(i).getBtitle(); //Btitle 가져오기
		list.get(i).getBwriter(); //Bwriter 가져오기
		list.get(i).getBpub(); //Bpub 가져오기
		list.get(i).getBprice(); //Bprice 가져오기
		list.get(i).getBdate(); //Bdate 가져오기
	
	%>
	<tr align = "center">
	<td width = "100"><a href = "updateBook.jsp?bcode=<%= list.get(i).getBcode() %>"><%= list.get(i).getBcode() %></a></td>
				 				<!-- 누르면 해당 정보 수정하러 updateBook.jsp로 넘어감 -->     <!-- Bcode 가져오기 -->
	<td width = "100"><%= list.get(i).getBtitle() %></td> <!-- Btitle 가져오기 -->
	<td width = "100"><%= list.get(i).getBwriter() %></td><!-- Bwriter 가져오기 -->
	<td width = "100"><%= msg %></td> <!-- 위에 포문 돌린 정보로 msg 가져오기 -->
	<td width = "100"><%= format.format(list.get(i).getBprice()) %></td> <!-- Bprice 가져오기 , 세자리마다 콤마를 찍어줌. -->
	<td width = "135"><%= list.get(i).getBdate() %></td> <!-- Bdate 가져오기 -->
	<td width = "100"><a href = "deleteBook.jsp?bcode=<%= list.get(i).getBcode() %>">삭제</a></td> <!-- 탈퇴 할 수 있는 기능 -->
							<!-- 누르면 해당 정보 삭제하러 deleteBook.jsp로 넘어감 -->
	</tr>
	<%
	}
	%>
	</table>
	<jsp:include page = "footer.jsp"/> <!-- footer.jsp 가져오기 -->
</body>
</html>