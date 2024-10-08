<%@page import="java.util.List"%>
<%@page import="com.entity.User"%>
<%@page import="com.entity.Cart"%>
<%@page import="com.DB.DBConnect"%>
<%@page import="com.DAO.CartDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart Page</title>
<%@include file="all_component/allCSS.jsp"%>
</head>
<body style="background-color: #f0f1f2;">
	<%@include file="all_component/navbar.jsp"%>

	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:if test="${not empty succMsg }">
		<div class="alert alert-success text-center" role="alert">${succMsg }</div>
		<c:remove var="succMsg" scope="session" />
	</c:if>

	<c:if test="${not empty failedMsg }">
		<div class="alert alert-danger text-center" role="alert">${failedMsg }</div>
		<c:remove var="failedMsg" scope="session" />
	</c:if>

	<div class="container">
		<div class="row p-3">
			<div class="col-md-6">
				<div class="card bg-white mb-3">
					<div class="card-body">
						<h3 class="text-center text-success mb-3">Your Selected Items</h3>
						<table class="table table-striped">
							<thead class="thead-dark">
								<tr>
									<th class="text-center" scope="col">Book Name</th>
									<th class="text-center" scope="col">Author</th>
									<th class="text-center" scope="col">Price</th>
									<th class="text-center" scope="col">Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								User u = (User) session.getAttribute("userobj");

								CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());
								List<Cart> cart = dao.getBookByUser(u.getId());
								Double totalPrice = 0.00;

								for (Cart c : cart) {
									totalPrice = c.getTotalPrice();
								%>

								<tr>
									<th class="text-center" scope="row"><%=c.getBookName()%></th>
									<td class="text-center"><%=c.getAuthor()%></td>
									<td class="text-center"><i class="fas fa-rupee-sign mr-1"
										style="display: inline;"></i><%=c.getPrice()%></td>
									<td class="text-center"><a
										href="remove_book?bid=<%=c.getBid()%>&&uid=<%=c.getUserId()%>&&cid=<%=c.getCid()%>"
										class="btn btn-sm btn-danger">Remove</a></td>
								</tr>

								<%
								}
								%>
							
							<tfoot>
								<tr>
									<td class="text-center">Total Price</td>
									<td class="text-center"></td>
									<td class="text-center"><i class="fas fa-rupee-sign mr-1"
										style="display: inline;"></i><%=totalPrice%></td>
									<td class="text-center"></td>
								</tr>
							</tfoot>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<div class="col-md-6">
				<div class="card">
					<div class="card-body">
						<h3 class="text-center text-success mb-3">Your Details for
							Order</h3>
						<form action="order" method="post">
							<input type="hidden" value="${userobj.id }" name="id">
							<input type="hidden" name="totalPrice" value="<%=totalPrice %>">
							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">Name *</label> <input type="text"
										name="username" class="form-control" id="inputEmail4"
										value="${userobj.name}" required>
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Email *</label> <input type="email"
										name="email" class="form-control" id="inputPassword4"
										value="${userobj.email }" required>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">Phone Number *</label> <input
										type="number" name="phno" class="form-control"
										id="inputEmail4" value="${userobj.phno}" required>
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Address*</label> <input type="text"
										name="address" class="form-control" id="inputPassword4"
										required>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">Landmark *</label> <input type="text"
										name="landmark" class="form-control" id="inputEmail4" required>
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">City *</label> <input type="text"
										name="city" class="form-control" id="inputPassword4" required>
								</div>
							</div>

							<div class="form-row">
								<div class="form-group col-md-6">
									<label for="inputEmail4">State *</label> <input type="text"
										name="state" class="form-control" id="inputEmail4" required>
								</div>
								<div class="form-group col-md-6">
									<label for="inputPassword4">Pin Code *</label> <input
										type="text" name="pincode" class="form-control"
										id="inputPassword4" required>
								</div>
							</div>
							<div class="form-group" id="paymentMode">
								<label>Payment Mode</label> <select class="form-control"
									name="payment">
									<option value="noselect">--Select--</option>
									<option value="COD">Cash on Delivery</option>
									<option value="UPI">Online Payment</option>
								</select>
							</div>

							<div class="text-center mt-5">
								<button class="btn btn-warning mr-2">Order Now</button>
								<a href="index.jsp" class="btn btn-success">Continue
									Shopping</a>
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="all_component/footer.jsp"%>
</body>
</html>