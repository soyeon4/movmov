<%@page import="kr.co.movmov.vo.Point"%>
<%@page import="kr.co.movmov.mapper.PointMapper"%>
<%@page import="kr.co.movmov.mapper.PaymentMapper"%>
<%@page import="kr.co.movmov.vo.Address"%>
<%@page import="kr.co.movmov.mapper.AddressMapper"%>
<%@page import="kr.co.movmov.vo.Payment"%>
<%@page import="kr.co.movmov.dto.CartDto"%>
<%@page import="kr.co.movmov.vo.ShopCartItem"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.movmov.utils.MybatisUtils"%>
<%@page import="kr.co.movmov.mapper.ShopCartItemMapper"%>
<%@page import="kr.co.movmov.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//request parameters
	int payStatusID = 1; // payment complete(1)
	User user = (User) session.getAttribute("LOGIN_USER");
	int pointUsage = Integer.parseInt(request.getParameter("order-point-usage"));
	int pointEarn = Integer.parseInt(request.getParameter("order-point-earn"));
	int addressID = Integer.parseInt(request.getParameter("order-address-id"));
	int paymentMethodID = Integer.parseInt(request.getParameter("order-payment-method"));
	String customerRequest = request.getParameter("customer-request");
	
	//mapper
	ShopCartItemMapper shopCartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	PaymentMapper paymentMapper = MybatisUtils.getMapper(PaymentMapper.class);
	PointMapper pointMapper = MybatisUtils.getMapper(PointMapper.class);
	
	//get cart info
	List<ShopCartItem> cartItems = shopCartItemMapper.getCartItemsByUserId(user.getId());
	CartDto cartDto = new CartDto(cartItems);
	Address address = addressMapper.getAddressById(addressID);
	Payment payment = new Payment();
	Point point	= new Point();
	
	//set Payment object
	payment.setPayStatusId(payStatusID);
	payment.setUser(user);
	payment.setPtUseAmount(pointUsage);
	payment.setPtEarnAmount(pointEarn);
	payment.setAddress(address);
	payment.setPayMethodId(paymentMethodID);
	payment.setRequest(customerRequest);
	
	//insert order per every product
	for (ShopCartItem cartItem : cartItems) {
		//set Payment object properties about item
		payment.setItem(cartItem.getItem());
		payment.setOption(cartItem.getOption());
		payment.setPayAmount(cartItem.getOrderPrice());
		payment.setItemQuantity(cartItem.getQuantity());
		
		paymentMapper.insertPayment(payment);
		
		Payment lastPayment = paymentMapper.getRecentPayment(user);
		
		//set point Object for purchase reward point
		point.setPointChangeAmount(pointEarn);
		point.setTypeId(101);
		point.setPayment(lastPayment);
		int userPoint = pointMapper.getUserPoint(user) + pointEarn;
		point.setTotalPoint(userPoint);
		point.setUser(user);
		
		pointMapper.insertPoint(point);
		pointMapper.updateUserPoint(user, userPoint);
	}
	
	//set point Object for point usage
	Payment lastPayment = paymentMapper.getRecentPayment(user);
	point.setPointChangeAmount(-pointUsage);
	point.setTypeId(100);
	point.setPayment(lastPayment);
	int userPoint = pointMapper.getUserPoint(user) - pointUsage;
	point.setTotalPoint(userPoint);
	point.setUser(user);
	
	pointMapper.insertPoint(point);
	pointMapper.updateUserPoint(user, userPoint);
	
	response.sendRedirect("payment-success.jsp");
	return;
%>