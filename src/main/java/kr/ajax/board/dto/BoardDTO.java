package kr.ajax.board.dto;

import java.sql.Date;

public class BoardDTO {
	private int idx;
	private String user_name;
	private String subject;
	private String content;
	private int bHit;
	private Date reg_date;
	private int img_cnt;
	private String new_filename;
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getbHit() {
		return bHit;
	}
	public void setbHit(int bHit) {
		this.bHit = bHit;
	}
	
	
	//방법1
	/*
	 * public String getReg_date() { return reg_date.toString(); }
	 */
	
	public Date getReg_date() { 
		return reg_date; 
	}
	 
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getImg_cnt() {
		return img_cnt;
	}
	public void setImg_cnt(int img_cnt) {
		this.img_cnt = img_cnt;
	}
	public String getNew_filename() {
		return new_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	
}
