<%@page import="kr.co.movmov.mapper.ShopItemMapper"%>
<%@page import="java.util.ArrayList"%>
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
  String paymentMethodParam = request.getParameter("order-payment-method");

  if (paymentMethodParam == null || paymentMethodParam.trim().isEmpty()) {
%>
    <script>
      alert("결제 방식을 선택해주세요.");
      history.back();
    </script>
    <%
      return; // 더 이상 JSP 실행하지 않음
  }
%>
<%
	String paymentMethodStr = request.getParameter("order-payment-method");
	
	//request parameters
	int payStatusID = 1; // payment complete(1)
	User user = (User) session.getAttribute("LOGIN_USER");
	int pointUsage = Integer.parseInt(request.getParameter("order-point-usage"));
	int pointEarn = 0;
	int addressID = Integer.parseInt(request.getParameter("order-address-id"));
	int paymentMethodID = Integer.parseInt(request.getParameter("order-payment-method"));
	String customerRequest = request.getParameter("customer-request");
	String[] idStrings = request.getParameterValues("cartItemIds");
	
	//mapper
	ShopCartItemMapper shopCartItemMapper = MybatisUtils.getMapper(ShopCartItemMapper.class);
	AddressMapper addressMapper = MybatisUtils.getMapper(AddressMapper.class);
	PaymentMapper paymentMapper = MybatisUtils.getMapper(PaymentMapper.class);
	PointMapper pointMapper = MybatisUtils.getMapper(PointMapper.class);
	ShopItemMapper shopItemMapper = MybatisUtils.getMapper(ShopItemMapper.class);
	
	//get cart info	
	List<ShopCartItem> cartItems = new ArrayList<>();
	
	if(idStrings != null) {
		for(String idStr : idStrings) {
			int id = Integer.parseInt(idStr);
			ShopCartItem item = shopCartItemMapper.getCartItemsByCartNo(id);
			if(item != null)
	        	cartItems.add(item);
			item.setItem(shopItemMapper.getShopItemByItemNo(item.getItem().getNo()));
		}
	}
	
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
		
		pointEarn = (int)(payment.getItem().getPrice() * payment.getItemQuantity() * 0.05);
		//set point Object for purchase reward point
		point.setPointChangeAmount(pointEarn);
		point.setTypeId(101);
		point.setPayment(lastPayment);
		int userPoint = pointMapper.getUserPoint(user) + pointEarn;
		point.setTotalPoint(userPoint);
		point.setUser(user);
		
		pointMapper.insertPoint(point);
		pointMapper.updateUserPoint(user, userPoint);
		
		shopCartItemMapper.deleteCartItemByCartNo(cartItem.getNo());
	}
	
	//set point Object for point usage
	Payment lastPayment = paymentMapper.getRecentPayment(user);
	if(pointUsage != 0) {
		point.setPointChangeAmount(-pointUsage);
		point.setTypeId(100);//포인트 사용
		point.setPayment(lastPayment);
		int userPoint = pointMapper.getUserPoint(user) - pointUsage;
		point.setTotalPoint(userPoint);
		point.setUser(user);
		
		pointMapper.insertPoint(point);
		pointMapper.updateUserPoint(user, userPoint);
	}
	
	
	
	response.sendRedirect("payment-success.jsp");
	return;
%>