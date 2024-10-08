package com.entity;

public class BookOrder {
	private int id;
	private String orderId;
	private String username;
	private String email;
	private String phno;
	private String fullAdd;
	private String bookName;
	private String author;
	private String price;
	private String paymentType;
	
	public BookOrder() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String i) {
		this.orderId = i;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhno() {
		return phno;
	}

	public void setPhno(String phno) {
		this.phno = phno;
	}

	public String getFullAdd() {
		return fullAdd;
	}

	public void setFullAdd(String fullAdd) {
		this.fullAdd = fullAdd;
	}

	public String getPaymentType() {
		return paymentType;
	}

	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}
	
	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "BookOrder [id=" + id + ", username=" + username + ", email=" + email + ", phno=" + phno + ", fullAdd="
				+ fullAdd + ", paymentType=" + paymentType + "]";
	}
	
}
