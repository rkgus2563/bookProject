package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import book.BookDAO;
import book.BookVO;
@WebServlet("/insertBook.do") //  insertBook 에 action 이름이 insertBook.do 로 되어있으니 이 코드를 적는다

public class BookInsertController extends HttpServlet{  // public class BookInsertController { 에다가 
														// extends HttpServlet 이라는 코드를 추가한다!
	
	@Override //doget 해주기: MVC2패턴
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp); //doProcess 에서 doGet() 서비스를 해주었기에 적어준다.
	}
	
	@Override //dopost 해주기: MVC2패턴 
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp); //doProcess 에서 doPost() 서비스를 해주었기에 적어준다.
	}
	
		//doGet(), doPost() 서비스를 doProcess 에서 해주어요.
	   public void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		   req.setCharacterEncoding("utf-8");	 //utf-8로 인코딩 해줌.
		   resp.setContentType("text/html; charset=UTF-8"); //utf-8
		   PrintWriter pw = resp.getWriter(); //자바에서 웹으로 데이터를 출력하기 위해 printWriter를 사용한다.
		   
		   int bcode = Integer.parseInt(req.getParameter("bcode"));  //int 형태로 bcode 가져오기 (request를 위해서 req 라고 지정해주었기에 req라고 적는다!)
		   String btitle = req.getParameter("btitle"); //String 형태로 btitle 가져오기
		   String bwriter = req.getParameter("bwriter"); //String 형태로 bcode 가져오기
		   int bpub = Integer.parseInt(req.getParameter("bpub")); //int 형태로 bpub 가져오기
		   int bprice = Integer.parseInt(req.getParameter("bprice")); //int 형태로 bprice 가져오기
		   String bdate = req.getParameter("bdate"); //String 형태로 bdate 가져오기
		   
		   BookDAO instance = BookDAO.getInstance(); //dao 생성자	  
		   BookVO vo = new BookVO(bcode, btitle, bwriter, bpub, bprice, bdate); //BookVo
		   
		   int cnt =  instance.insertBook(vo); //instance(BookDAO)의 insertBook 에서 cnt를 가져옵니다.
		   if(cnt > 0) { //cnt 가 0보다 크면
			  pw.println("<script> alert('도서 등록 성공'); location.href = 'selectBook.do'; </script>");
			  //'도서 등록 성공' 알림창 띄워주고 selectBook.do 로 돌아감.
			  // 알림창 확인 버튼을 눌러주면 도서 목록이 띄워진다.
		   }else { //아니라면
			   pw.println("<script> alert('도서 등록 실패'); location.href = 'index.jsp'; </script>");
			   //'도서 등록 실패' 알림창 띄워주고 index.jsp 로 돌아감.
		   }
		   }
}
