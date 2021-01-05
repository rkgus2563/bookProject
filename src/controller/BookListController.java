package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import book.BookDAO;

@WebServlet("/selectBook.do") //  selectBook 에 action 이름이 insertBook.do 로 되어있으니 이 코드를 적는다

public class BookListController extends HttpServlet{ //BookInsertController 와 같이 이 클래스도 서블릿을 사용하기에 
													 //extends HttpServlet 코드를 추가해준다

	@Override //doget 해주기: MVC2패턴
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doprocess(req,resp); //doProcess 에서 doGet() 서비스를 해주었기에 이 코드를 적어준다.
	}
	
	@Override //doPost 해주기: MVC2패턴
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doprocess(req,resp); //doProcess 에서 doPost() 서비스를 해주었기에 이 코드를 적어준다.
	}
	
	private void doprocess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BookDAO instance = BookDAO.getInstance(); // dao 생성자를 가져온다
		instance.selectBooks(); //instance(BookDAO)에서 selectBooks를 가져온다.
		req.setAttribute("list", instance.list); // instance.list를 list 라는 이름으로 받아줌
		RequestDispatcher rd = req.getRequestDispatcher("selectBook.jsp"); //연결 
//		여기서 RequestDispatcher 이란?
//		클라이언트로부터 최초에 들어온 요청을 JSP/Servlet 내에서 원하는 자원으로 요청을 넘기는(보내는) 역할을 수행하거나, 
//		특정 자원에 처리를 요청하고 처리 결과를 얻어오는 기능을 수행하는 클래스이다.
		rd.forward(req, resp); // 여기서 forward 란 ? 다른 Servlet에게 추가적인 처리를 맡기는 것
	}
}
