package book;

public class BookVO {
	
	private int bcode;
	private String btitle;
	private String bwriter;
	private int bpub;
	private int bprice;
	private String bdate;
	
	public BookVO(int bcode, String btitle, String bwriter, int bpub, int bprice, String bdate) {
		this.bcode = bcode;
		this.btitle = btitle;
		this.bwriter = bwriter;
		this.bpub = bpub;
		this.bprice = bprice;
		this.bdate = bdate;
	}
	
	public int getBcode() {
		return bcode;
	}
	public void setBcode(int bcode) {
		this.bcode = bcode;
	}
	public String getBtitle() {
		return btitle;
	}
	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}
	public String getBwriter() {
		return bwriter;
	}
	public void setBwriter(String bwriter) {
		this.bwriter = bwriter;
	}
	public int getBpub() {
		return bpub;
	}
	public void setBpub(int bpub) {
		this.bpub = bpub;
	}
	public int getBprice() {
		return bprice;
	}
	public void setBprice(int bprice) {
		this.bprice = bprice;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;				
	}
	@Override
	public String toString() {
		return "BookVO [bcode=" + bcode + ", btitle=" + btitle + ", bwriter=" + bwriter + ", bpub=" + bpub + ", bprice="
				+ bprice + ", bdate=" + bdate + "]";
	}
}
