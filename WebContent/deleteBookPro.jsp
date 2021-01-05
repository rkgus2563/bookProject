<%@page import="book.BookVO"%>
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
<%
	request.setCharacterEncoding("utf-8"); //utf-8로 인코딩
	BookDAO instance = BookDAO.getInstance(); //DAO 불러온다.
	int bcode = Integer.parseInt(request.getParameter("bcode")); // bcode를 불러와준다. 
																 // sql 문이 delete FROM DELETE FROM BOOK_TBL WHERE BCODE = ? 이다 
																 // 그러므로 bcode만 불러와도 된다.
	int cnt = instance.deleteBook(bcode); // dao에서 deleteBook을 만들어주었다.
										  // 그 dao의 cnt를 불러온다.
	String msg = ""; // String 형태의 msg 만들어주기
					 // 메시지를 띄울 때 사용해야함.
	if(cnt > 0) { // dao에서 불러온 cnt가 0이 아니라면 삭제가 완료가 된 것이다
		msg = "도서 삭제 완료"; // 그러므로 삭제완료 메시지 띄워주기
	}else{ // 그렇지 않다면 삭제가 완료되지 않은 것이다
		msg = "도서 삭제 실패"; // 그러므로 삭제실패 메시지 띄워주기
	}
%>
	<script type="text/javascript">
	/* 위의 if문에 따라 msg 알림창 띄워주기 */
	alert('<%= msg%>');
	location.href('selectBook.do');  /* selectBook.jsp로 돌아감 : 전페이지로 돌아가게됨*/
	</script>
</body>
</html>