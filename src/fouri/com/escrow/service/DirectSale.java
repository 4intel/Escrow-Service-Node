package fouri.com.escrow.service;

@SuppressWarnings("serial")
public class DirectSale extends DirectProductVO {

	// direct_sale
	int sidx = 0;
	int sstate = 0;// 상태값
	String swid = "";//판매자 지갑id
	String bwid = "";// 구매자 지갑id
	String bwid_nm = "";
	int totalpay = 0;// 합계금액
	int send_coin = 0;
	String regdate = "";
	
	
	// direct_sale_plist
	int pidx = 0;
	String sname = "";//상춤명
	int sunit = 0;// 단가
	int scnt = 0;// 단가
	int ssum = 0;// 금액
	
	
	public int getSend_coin() {
		return send_coin;
	}
	public void setSend_coin(int send_coin) {
		this.send_coin = send_coin;
	}
	public String getBwid_nm() {
		return bwid_nm;
	}
	public void setBwid_nm(String bwid_nm) {
		this.bwid_nm = bwid_nm;
	}
	public int getScnt() {
		return scnt;
	}
	public void setScnt(int scnt) {
		this.scnt = scnt;
	}
	public int getSidx() {
		return sidx;
	}
	public void setSidx(int sidx) {
		this.sidx = sidx;
	}
	public int getSstate() {
		return sstate;
	}
	public void setSstate(int sstate) {
		this.sstate = sstate;
	}
	public String getSwid() {
		return swid;
	}
	public void setSwid(String swid) {
		this.swid = swid;
	}
	public String getBwid() {
		return bwid;
	}
	public void setBwid(String bwid) {
		this.bwid = bwid;
	}
	public int getTotalpay() {
		return totalpay;
	}
	public void setTotalpay(int totalpay) {
		this.totalpay = totalpay;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getPidx() {
		return pidx;
	}
	public void setPidx(int pidx) {
		this.pidx = pidx;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public int getSunit() {
		return sunit;
	}
	public void setSunit(int sunit) {
		this.sunit = sunit;
	}
	public int getSsum() {
		return ssum;
	}
	public void setSsum(int ssum) {
		this.ssum = ssum;
	}
	
	
	
		
}
