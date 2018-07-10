package fouri.com.escrow.service;

@SuppressWarnings("serial")
public class DirectProduct extends DirectProductVO {

	int idx = 0;
	int unit = 0;
	String mname = "";
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getUnit() {
		return unit;
	}
	public void setUnit(int unit) {
		this.unit = unit;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	
}
