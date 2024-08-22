<%@page import="com.entity.BookDetails"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.BookDAOImpl"%>
<%@page import="com.DAO.BookDAO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Details</title>
<%@include file="all_component/allCSS.jsp"%>
</head>
<body style="background-color: #f0f1f2">
	<%@include file="all_component/navbar.jsp"%>

	<%
	int bid = Integer.parseInt(request.getParameter("bid"));
	BookDAO dao = new BookDAOImpl(DBConnect.getConn());
	BookDetails b = dao.getBookById(bid);
	%>

	<div class="container p-4">
		<div class="row">
			<div class="col-md-6 text-center p-5 border bg-white">
				<img src="book/<%=b.getPhotoName()%>" style="height: 200px; width: 150px">
				<br>
				<h4 class="mt-3">
					Book Name: <span class="text-success"><%=b.getBookName()%></span>
				</h4>
				<h4>
					Author Name: <span class="text-success"><%=b.getAuthor()%></span>
				</h4>
				<h4>
					Category: <span class="text-success"><%=b.getBookCategory()%></span>
				</h4>
			</div>

			<div class="col-md-6 text-center p-5 border bg-white">
				<h2><%=b.getBookName()%></h2>

				<%
				if ("Old".equals(b.getBookCategory())) {
				%>
				<h5 class="text-primary">Contact to Seller</h5>
				<h5 class="text-primary">
					<i class="fas fa-envelope mr-1"></i>Email:
					<%=b.getEmail()%></h5>
				<%
				}
				%>
				<div class="row">
					<div class="col-md-4 text-danger mt-2 text-center p-2">
						<i class="fas fa-money-bill-wave fa-2x"></i>
						<p>Cash On Delivery</p>
					</div>
					<div class="col-md-4 text-danger mt-2 text-center p-2">
						<i class="fas fa-undo-alt fa-2x"></i>
						<p>Return Available</p>
					</div>
					<div class="col-md-4 text-danger mt-2 text-center p-2">
						<i class="fas fa-truck-moving fa-2x"></i>
						<p>Free Shipping</p>
					</div>
				</div>

				<%
				if ("Old".equals(b.getBookCategory())) {
				%>
				<div class="text center p-4">
					<a href="index.jsp" class="btn btn-success mr-2"><i
						class="fas fa-cart-plus mr-1"></i>Continue Shopping</a> <a href=""
						class="btn btn-danger"><i class="fas fa-rupee-sign mr-1"></i>200</a>
				</div>
				<%
				} else {
				%>
				<div class="text center p-4">
					<a href="" class="btn btn-primary mr-2"><i
						class="fas fa-cart-plus mr-1"></i>Add to cart</a> <a href=""
						class="btn btn-danger"><i class="fas fa-rupee-sign mr-1"></i>200</a>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
</body>
</html>