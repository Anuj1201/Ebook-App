package com.user.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookOrderDAOImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBConnect;
import com.entity.BookOrder;
import com.entity.Cart;

@SuppressWarnings("serial")
@WebServlet("/order")
public class OrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			HttpSession session = req.getSession();
			int id = Integer.parseInt(req.getParameter("id"));

			String name = req.getParameter("username");
			String email = req.getParameter("email");
			String phno = req.getParameter("phno");
			String address = req.getParameter("address");
			String landmark = req.getParameter("landmark");
			String city = req.getParameter("city");
			String state = req.getParameter("state");
			String pincode = req.getParameter("pincode");
			String paymentType = req.getParameter("payment");

			String fullAdd = address + ", " + landmark + ", " + city + ", " + state + ", " + pincode;
			
			String totalPrice = req.getParameter("totalPrice");
			
			CartDAOImpl dao = new CartDAOImpl(DBConnect.getConn());

			List<Cart> blist = dao.getBookByUser(id);

			if (blist.isEmpty()) {

				session.setAttribute("failedMsg", "Add items to order!!");
				resp.sendRedirect("checkout.jsp");

			} else {
				BookOrderDAOImpl dao2 = new BookOrderDAOImpl(DBConnect.getConn());

				BookOrder o = null;

				ArrayList<BookOrder> orderList = new ArrayList<BookOrder>();
				Random r = new Random();

				for (Cart c : blist) {

					o = new BookOrder();

					o.setOrderId("BOOK-ORD-00" + r.nextInt(1000));
					o.setUsername(name);
					o.setEmail(email);
					o.setPhno(phno);
					o.setFullAdd(fullAdd);
					o.setBookName(c.getBookName());
					o.setAuthor(c.getAuthor());
					o.setPrice(c.getPrice() + "");
					o.setPaymentType(paymentType);

					orderList.add(o);
				}

				if ("noselect".equals(paymentType)) {

					session.setAttribute("failedMsg", "Choose Payment Method !!");
					resp.sendRedirect("checkout.jsp");
				} else {
					boolean f = dao2.saveOrder(orderList);
					
					if ("UPI".equals(paymentType)) {
						
						req.setAttribute("totalPrice", totalPrice);
                        
						RequestDispatcher dispatcher = req.getRequestDispatcher("PaymentServlet");
						dispatcher.forward(req, resp);

					} else if ("COD".equals(paymentType)){
						if (f) {
							resp.sendRedirect("order_success.jsp");
						} else {
							session.setAttribute("failedMsg", "Order Failed");
							resp.sendRedirect("checkout.jsp");
						}
					} else {
						session.setAttribute("failedMsg", "Order Failed");
						resp.sendRedirect("checkout.jsp");
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
