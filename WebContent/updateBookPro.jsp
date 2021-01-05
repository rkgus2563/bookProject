<%@page import="book.BookVO"%>
<%@page import="book.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서정보 수정</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8"); //utf-8
BookDAO instance = BookDAO.getInstance();   //BookDAO 생성자
int bcode = Integer.parseInt(request.getParameter("bcode")); // Int 형태의 bcode 가져오기
String btitle = request.getParameter("btitle"); // String 형태의 btitle 가져오기
String bwriter = request.getParameter("bwriter"); // String 형태의 bwriter 가져오기
int bpub = Integer.parseInt(request.getParameter("bpub")); // int 형태의 bpub 가져오기
int bprice = Integer.parseInt(request.getParameter("bprice")); // int 형태의 bprice 가져오기
String bdate = request.getParameter("bdate"); // string 형태의 bdate 가져오기
BookVO vo = new BookVO(bcode, btitle, bwriter, bpub, bprice, bdate); //vo
String msg = null; //msg 만들어주기
int cnt = instance.updateBook(vo);// cnt 의 updateBook에서 cnt 가져옵니다.
if(cnt > 0){ //cnt 가 0이 넘는다면 (수정에 성공한다면)
	msg = "도서 정보 수정 성공"; // 수정 성공 메세지 띄워주기!
}else{ //그것이 아니라면 (수정에 실패한다면)
	msg = "도서 정보 수정 실패"; // 수정 실패 메세지 띄워주기!
}
%>
	<script type="text/javascript">
		/* 위의 if문에 따라 msg 알림창 띄워주기 */
		alert('<%= msg%>');
		location.href('selectBook.do');  /* selectBook.jsp로 돌아감 */
	</script>
</body>
</html>