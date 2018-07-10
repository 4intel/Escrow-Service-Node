package fouri.com.cpwallet.service;

import java.io.Serializable;

@SuppressWarnings("serial")
public class EscrowTrans extends EscrowTransVO {

	int idx = 0;
	int boardNum = 0;
	String swid = "";
	String bwid = "";
	String swidnm = "";
	String bwidnm = "";
	String wallet_id = "";
	int tstate = 0;
	String regdate = "";
	String walletName2 = "";	// 입금지갑
	
	public String getSwidnm() {
		return swidnm;
	}
	public void setSwidnm(String swidnm) {
		this.swidnm = swidnm;
	}
	public String getBwidnm() {
		return bwidnm;
	}
	public void setBwidnm(String bwidnm) {
		this.bwidnm = bwidnm;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getWalletName2() {
		return walletName2;
	}
	public void setWalletName2(String walletName2) {
		this.walletName2 = walletName2;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSwid() {
		return swid;
	}
	public void setSwid(String swid) {
		this.swid = swid;
	}
	public String getWallet_id() {
		return wallet_id;
	}
	public void setWallet_id(String wallet_id) {
		this.wallet_id = wallet_id;
	}
	public String getBwid() {
		return bwid;
	}
	public void setBwid(String bwid) {
		this.bwid = bwid;
	}
	public int getTstate() {
		return tstate;
	}
	public void setTstate(int tstate) {
		this.tstate = tstate;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
}
