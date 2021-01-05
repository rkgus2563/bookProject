package book;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;


public class BookDAO {
	private static BookDAO instance = new BookDAO();  //DAO 생성
	public ArrayList<BookVO> list = new ArrayList<BookVO>(); //ArrayList 생성
	
	private BookDAO() {
	} //  DAO 생성자 만들어주기

	public static BookDAO getInstance() {
		return instance;
	} // instance 반환하는 것
	
	
	public Connection getConnection() { // 오라클 커넥션 객체생성
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "system"; // db 사용자
		String password = "oracle"; // db 비밀번호
		Connection conn = null;
		try {
			// 오라클 접속에 성공하면
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, user, password);
			System.out.println("오라클 접속 성공"); //오라클 접속 성공 메시지 띄워주기
		} catch (Exception e) {
			// 오라클 접속에 실패하면
			e.printStackTrace();
			System.out.println("오라클 접속 실패"); //오라클 접속 실패 메시지 띄워주기
		}
		return conn; //conn 리턴
	}
	
	//selectBook에서 사용할 예정 (정보 출력 위해 사용)
	public void selectBooks() {
		list.clear(); //list.clear()를 해줘 똑같은 list가 계속 생기는 것을 방지함.
		try {
			Connection conn = getConnection(); // 오라클 연동
			String selectSql = "SELECT * FROM BOOK_TBL ORDER BY BCODE"; // select sql문 작성
			PreparedStatement pstmt = conn.prepareStatement(selectSql); // sql 실행시켜주는 것
			ResultSet rs = pstmt.executeQuery(); // 명령에 대한 반환
			while (rs.next()) { // ResultSet에 넘겨줌
				int bcode = rs.getInt("BCODE"); // int 형태로 bcode 가져옴
				String btitle = rs.getString("BTITLE"); // String 형태로 btitle 가져옴
				String bwriter = rs.getString("BWRITER"); // String 형태로 bwriter 가져옴
				int bpub = rs.getInt("BPUB"); // int 형태로 bpub 가져옴
				int bprice = rs.getInt("BPRICE"); // int 형태로 bprice 가져옴
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
				//SimpleDateFormat 을 여기서 왜 사용해주었을까?
				//밑에 있는 bdate는 원래 string 타입이 아니라 date 타입이다.
				//그렇기 때문에 위에있는 코드를 사용해주어야한다.
				String bdate = sdf.format(rs.getDate("BDATE")); // date 가져옴
				BookVO vo = new BookVO(bcode, btitle, bwriter, bpub,bprice, bdate); // 객체 정보 담아주기
				list.add(vo); //list에 vo 넣기!
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//insertBook에서 사용 예정 (새로운 정보 입력 위해 사용)
	public int insertBook(BookVO vo) {
		int cnt = 0; // 성공했는지 체크하기 위하여
		try {
			Connection conn = getConnection(); // 오라클 연동
			String insertSql = "INSERT INTO BOOK_TBL(bcode, btitle, bwriter, bpub, bprice, bdate) "
					+ " VALUES(?, ?, ?, ?, ?, ?)"; //insertSql 문 사용해줌.
			PreparedStatement pstmt = conn.prepareStatement(insertSql);
			Date date = Date.valueOf(vo.getBdate()); //형변환 하는것!
			//sql문 순서를 잘 맞추어 적어야합니다.
			pstmt.setInt(1, vo.getBcode());
			pstmt.setString(2, vo.getBtitle());
			pstmt.setString(3, vo.getBwriter());
			pstmt.setInt(4, vo.getBpub());
			pstmt.setInt(5, vo.getBprice());
			pstmt.setDate(6, date);
			cnt = pstmt.executeUpdate();
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt; // cnt 리턴
	}

	//updateBook에서 사용 예정 (있던 정보를 수정해주기 위해 사용)
	public int updateBook(BookVO vo) {
		int cnt = 0; //int cnt = 0 으로 설정
		try {
			Connection conn = getConnection(); // 오라클 연동
			String updateSql = "UPDATE BOOK_TBL SET BTITLE = ?, BWRITER = ?, BPUB = ?, BPRICE = ?, BDATE = ? WHERE BCODE = ?";
			//updateSql 문을 작성해줍니다.
			//UPDATE table SET ### = ? WHERE ### = ? 이런 식으로.
			PreparedStatement pstmt = conn.prepareStatement(updateSql);
			Date date = Date.valueOf(vo.getBdate()); //형변환 하는것!
			pstmt.setString(1, vo.getBtitle());
			pstmt.setString(2, vo.getBwriter());
			pstmt.setInt(3, vo.getBpub());
			pstmt.setInt(4, vo.getBprice());
			pstmt.setDate(5, date);
			pstmt.setInt(6, vo.getBcode());
			cnt = pstmt.executeUpdate();
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt; // cnt 리턴
	}

	//오름차순으로 목록을 정리하기 위해 사용해주는 것입니다.
	public int getMaxCode() {
		int bcode = 0; //int bcode = 0 으로 설정 
		try {
			String getNoSql = "SELECT MAX(BCODE) FROM BOOK_TBL"; // 최댓값 구하는 sql문 
									 //MAX() 는 최댓값을 구하는 것이다.
			Connection conn = getConnection();
			PreparedStatement pstmt = conn.prepareStatement(getNoSql);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				bcode = rs.getInt(1) + 1;  // bcode에 1 추가하기
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bcode; // bcode 리턴
	}
	
	public int deleteBook(int bcode) {
		int cnt = 0; //int cnt = 0 으로 설정
		try {
			Connection conn = getConnection(); // 오라클 연동
			//deleteSql문 작성을 한다.
			String deleteSql = "DELETE FROM BOOK_TBL WHERE BCODE = ?";
			PreparedStatement pstmt = conn.prepareStatement(deleteSql);
			pstmt.setInt(1, bcode); // 다른 것들 필요 없이 bcode만 가져와도 됩니다.
			cnt = pstmt.executeUpdate();
			close(null, pstmt, conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt; // cnt 리턴
	}

	
	
	// jdbc에 활용한 객체들을 역순으로 자원반환
	public void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if (rs != null)
			try {rs.close();} catch (Exception e) {	e.printStackTrace();}
		if (pstmt != null)
			try {pstmt.close();} catch (Exception e) { e.printStackTrace();
			}
		if (conn != null)
			try { conn.close(); } catch (Exception e) { e.printStackTrace();
			}
	}

}
